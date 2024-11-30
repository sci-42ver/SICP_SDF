(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-ambeval.scm")

(define (analyze exp)
  (cond ((assertion-to-be-added? exp) 
         (analyze-assertion! exp))
        ((assertion? exp) (analyze-assertion exp))
        ((variable? exp) (analyze-variable exp))
        ((assignment? exp) (analyze-assignment exp))
        ((definition? exp) (analyze-definition exp))
        ((if? exp) (analyze-if exp))
        ((lambda? exp) (analyze-lambda exp))
        ((begin? exp) (analyze-sequence (begin-actions exp)))
        ((cond? exp) (analyze (cond->if exp)))
        ((let? exp) (analyze (let->combination exp))) ;**
        ((amb? exp) (analyze-amb exp))                ;**
        ((application? exp) (analyze-application exp))
        (else
          (analyze-simple-query exp)
          ;  (error "Unknown expression type -- ANALYZE" exp)
          )))

(define (assertion? exp)
  (and (not (rule? exp)) (null? (filter var? exp))))

(define (analyze-assertion assertion)
  ;; 0. wait to pass in query-pat which can't be got by analyze-assertion.
  ;; See conjoin, if we just pass frame, then we can't update query-pat.
  ;; As "if" does, we need pass query-pat in the returned value, but that is not elegant.
  (lambda (frame succeed fail)
    (lambda (pat) 
      (let ((res (check-an-assertion assertion pat frame)))
        ;; although here uses stream, we can do small changes to check-an-assertion returned values to not use stream.
        (if (stream-null? res)
          (fail)
          ;; return one frame
          (succeed (stream-car res) fail))))
    ))

(define (analyze-rule rule)
  (lambda (frame succeed fail)
    ;; TODO
    (let ((res (check-an-rule rule frame)))
      (if (stream-null? res)
        (fail)
        ;; return one frame
        (succeed (stream-car res) fail)))
    ))

(define (analyze-simple-query query-pattern)
  (let ((assertions (map analyze (fetch-assertions pattern frame)))
        (rules (fetch-rules pattern frame)))
    (lambda (frame succeed fail)
      (define (try-next-assertion assertions)
        (if (null? assertions)
          (try-next-rule rules)
          (((car assertions) frame
                             query-pat
                             succeed
                             (lambda ()
                               (try-next-assertion (cdr assertions))))
            query-pattern)))
      (try-next assertions)
      ))
  )

(define (analyze-assertion! exp)
  (lambda (frame succeed fail)
    ;; added
    (add-rule-or-assertion! (add-assertion-body q))
    (newline)
    (display "Assertion added to data base.")

    (succeed exp fail)))

;; similar to sequence but like if to use former values.
(define (analyze-conjoin exp)
  (define (sequentially a b)
    (lambda (frame succeed fail)
      (a frame
         ;; success continuation for calling a
         (lambda (a-frame fail2)
           (b a-frame succeed fail2)) ; changed
         ;; failure continuation for calling a
         fail)))
  ;; unchanged
  (define (loop first-proc rest-procs)
    (if (null? rest-procs)
      first-proc
      (loop (sequentially first-proc (car rest-procs))
            (cdr rest-procs))))
  
  (let ((conjuncts (map analyze (contents query))))
    (lambda (frame succeed fail)
      (if (null? conjuncts)
        ;; same as conjoin to return "frame-stream".
        (succeed frame fail))
      (loop (car conjuncts) (cdr conjuncts))
      )))

;;; I don't how to implement interleave using amb
;; 1. revc
;; `((analyze-or (cdr disjuncts)) frame succeed fail)` by induction it will try by sequence instead of interleave
;; And it also checks all cands for each or disjunction before trying the next disjunction.
;; 1.a. "(succeed frame fail)" should be null.
;; 2. woofy's even returns one frame-stream instead of frame.
;; apply-succeed just (amb stream).
;; 3. poly's https://github.com/cxphoe/SICP-solutions/blob/d35bb688db0320f6efb3b3bde1a14ce21da319bd/Chapter%204-Metalinguistic%20Abstraction/4.Logical%20Programing/4.78/evaluator.rkt#L176-L185
;; is similar to revc.

;; Here what is "subsumed"'s meaning?
(define (analyze-disjoin exp)
  (define (sequentially a b)
    (lambda (frame succeed fail)
      (a frame
         ;; success continuation for calling a
         (lambda (a-frame fail2)
           (b a-frame succeed fail2)) ; changed
         ;; failure continuation for calling a
         fail)))
  ;; Since not all conditional branch will call (interleave first-proc rest-procs), we won't pass next-fail there.
  (define next-fail #f)
  (define (interleave first-proc rest-procs)
    (if (null? rest-procs)
      (lambda (frame succeed fail)
        ;; see interleave-delayed
        ;; whether `(force delayed-s2)` succeeds or fails, we should always try interleave-fail
        (first-proc frame
          (lambda (a-frame fail2)
            (succeed 
              a-frame 
              (lambda () 
                (if next-fail
                  (let ((next next-fail))
                    (set! next-fail fail2)
                    (next)
                    )
                  ;; only one proc
                  (fail2)
                  )
                ; (or 
                ;   next-fail
                ;   ((interleave (car rest-procs) (cdr rest-procs) fail2)
                ;     frame succeed fail))
                ))) 
          (lambda () 
            (if next-fail
              (next-fail)
              ;; only one proc
              (fail)
              )
            )))
      (lambda (frame succeed fail)
        (first-proc frame
          ;; success continuation for calling a
          (lambda (a-frame fail2)
            (succeed 
              a-frame 
              (lambda () 
                ;; > (interleave-delayed (force delayed-s2) ...)
                ;; 0. fail2 is to interleave try
                ;; 1. disjoin all uses the same frame.
                (if next-fail
                  ;; implement the interleave.
                  (let ((next next-fail))
                    (set! next-fail fail2)
                    (next)
                    )
                  (begin
                    (set! next-fail fail2)
                    ((interleave (car rest-procs) (cdr rest-procs))
                      frame succeed fail)
                    ))
                ))) ; changed
          ;; (stream-null? s1)
          (lambda ()
            ((interleave (car rest-procs) (cdr rest-procs))
              frame succeed fail)
            )))
      ))
  
  (let ((disjuncts (map analyze (contents query))))
    (lambda (frame succeed fail)
      ;; similar to amb
      (if (null? disjuncts)
        ;; the-empty-stream implies nothing to output, similar to amb exhaustion.
        (fail))
      ((interleave (car disjuncts) (cdr disjuncts))
        frame succeed fail)
      )))

(define (ambeval exp frame succeed fail)
  ((analyze exp) frame succeed fail))

(define (driver-loop)
  (define (internal-loop try-again)
    (prompt-for-input input-prompt)
    (let ((input (query-syntax-process (read)))) ; modified
      (if (eq? input 'try-again)
        (try-again)
        (begin
          (newline)
          (display ";;; Starting a new problem ")
          (ambeval input
                   ;; modified
                   (singleton-stream '())
                   input
                   ;; ambeval success
                   (lambda (val next-alternative)
                     (announce-output output-prompt)
                     (user-print val)
                     (internal-loop next-alternative))
                   ;; ambeval failure
                   (lambda ()
                     (announce-output
                       ";;; There are no more values of")
                     (user-print input)
                     (driver-loop)))))))
  (internal-loop
    (lambda ()
      (newline)
      (display ";;; There is no current problem")
      (driver-loop))))
