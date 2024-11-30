(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-ambeval.scm")
(load "ch4-query.scm")

(define (conjoin? exp)
  (tagged-list? exp 'and))
(define (disjoin? exp)
  (tagged-list? exp 'or))
(define (negate? exp)
  (tagged-list? exp 'not))
(define (lisp-value? exp)
  (tagged-list? exp 'lisp-value))
(define (always-true? exp)
  (equal? exp '(always-true)))

(define (analyze exp)
  (cond 
        ;; TODO why when this is put first, `scheme --interactive --eval '(load "4_78.scm")'` and then typing inputs is different from `scheme < 4_78.scm`.
        ; ((assertion? exp) (analyze-assertion exp))
        ((rule? exp) (analyze-rule exp))
        ((conjoin? exp) (analyze-conjoin exp))
        ((disjoin? exp) (analyze-disjoin exp))
        ((negate? exp) (analyze-negate exp))
        ((lisp-value? exp) (analyze-lisp-value exp))
        ((always-true? exp) (analyze-always-true exp))
        ;; tagged-list? first
        ((assertion? exp) (analyze-assertion exp))
        (else
          (analyze-simple-query exp)
          ;  (error "Unknown expression type -- ANALYZE" exp)
          )))

(define (assertion? exp)
  (and (not (rule? exp)) (null? (filter var? exp))))

(define (check-an-assertion assertion query-pat query-frame)
  (let ((match-result
         (pattern-match query-pat assertion query-frame)))
    (if (eq? match-result 'failed)
        '()
        match-result)))

(define (analyze-assertion assertion)
  ;; 0. wait to pass in query-pat which can't be got by analyze-assertion.
  ;; See conjoin, if we just pass frame, then we can't update query-pat.
  ;; As "if" does, we need pass query-pat in the returned value, but that is not elegant.
  (lambda (frame succeed fail)
    (lambda (pat) 
      (let ((res (check-an-assertion assertion pat frame)))
        ;; although here uses stream, we can do small changes to check-an-assertion returned values to not use stream.
        (if (null? res)
          (fail)
          ;; return one frame
          (succeed res fail))))
    ))

(define (apply-a-rule rule query-pattern query-frame)
  (let ((clean-rule (rename-variables-in rule)))
    (let ((unify-result
           (unify-match query-pattern
                        (conclusion clean-rule)
                        query-frame)))
      (if (eq? unify-result 'failed)
          '() ; modified
          (let ((body (analyze (rule-body clean-rule))))
            (proc-frame body unify-result))))))

(define (proc-frame body unify-result)
  (list body unify-result))
(define (get-proc proc-frame)
  (car proc-frame))
(define (get-frame proc-frame)
  (cadr proc-frame))

;; similar to analyze-assertion
(define (analyze-rule rule)
  (lambda (frame succeed fail)
    (lambda (pat) 
      (let ((proc-frame (apply-a-rule rule pat frame)))
        ;; although here uses stream, we can do small changes to check-an-assertion returned values to not use stream.
        (if (null? proc-frame)
          (fail)
          ;; return one frame
          ((get-proc proc-frame) (get-frame proc-frame) succeed fail))))
    ))

(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "ch4-query-using-cons.scm")

(define (analyze-simple-query query-pattern)
  (let ((assertions (map analyze (fetch-assertions query-pattern 'ignore)))
        (rules (map analyze (fetch-rules query-pattern 'ignore))))
    (lambda (frame succeed fail)
      (define (try-next-assertion assertions)
        (if (null? assertions)
          (try-next-rule rules)
          (((car assertions) frame
                             succeed
                             (lambda ()
                               (try-next-assertion (cdr assertions))))
            query-pattern)))
      (define (try-next-rule rules)
        (if (null? rules)
          (fail)
          (((car rules) frame
                             succeed
                             (lambda ()
                               (try-next-rule (cdr rules))))
            query-pattern)))
      (try-next-assertion assertions)
      ))
  )

(define (analyze-assertion! exp)
  (lambda (frame succeed fail)
    ;; added
    (add-rule-or-assertion! (add-assertion-body exp))
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
  
  (let ((conjuncts (map analyze (contents exp))))
    (lambda (frame succeed fail)
      (if (null? conjuncts)
        ;; same as conjoin to return "frame-stream".
        (succeed frame fail))
      ((loop (car conjuncts) (cdr conjuncts))
        frame succeed fail)
      )))

;;; IGNORE: I don't how to implement interleave using amb
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
            (if next-fail
              (next-fail)
              ;; first-proc fails with no frame.
              ((interleave (car rest-procs) (cdr rest-procs))
                frame succeed fail)
              )
            )))
      ))
  
  (let ((disjuncts (map analyze (contents exp))))
    (lambda (frame succeed fail)
      ;; similar to amb
      (if (null? disjuncts)
        ;; the-empty-stream implies nothing to output, similar to amb exhaustion.
        (fail))
      ((interleave (car disjuncts) (cdr disjuncts))
        frame succeed fail)
      )))

(define (analyze-negate exp)
  (let ((negated-query (analyze (car (contents exp)))))
    (lambda (frame succeed fail)
      (negated-query frame
        (lambda (a-frame fail2)
          (fail)
          )
        (lambda ()
          ;; This fail may try the next assertion before.
          (succeed frame fail)
          )
        )
      )))

(define (analyze-lisp-value exp)
  (let ((call (contents exp)))
    (lambda (frame succeed fail)
      (if (execute
            (instantiate
              call
              frame
              ;; As (and (salary ?person ?amount) (lisp-value > ?amount 30000)) example shows,
              ;; We need to know ?amount which is got from the former.
              ;; Otherwise we can't get what ?amount means.
              (lambda (v f)
                (error "Unknown pat var -- LISP-VALUE" v))))
         (succeed frame fail)
         ;; > the-empty-stream
         (fail))
      ))
  )

(define (analyze-always-true ignore) 
  (lambda (frame succeed fail)
    (succeed frame fail)
    ))

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
          (cond
            ;; As query-driver-loop, not dispatch to eval.
            ((assertion-to-be-added? input)
              (add-rule-or-assertion! (add-assertion-body input))
              (newline)
              (display "Assertion added to data base.")
              (internal-loop try-again) ; modified
              )
            (else 
              (ambeval input
                   ;; modified
                   '()
                   ;; ambeval success
                   (lambda (frame next-alternative)
                     (announce-output output-prompt)
                     ;; modified
                     (user-print 
                      (instantiate input
                            frame
                            (lambda (v f)
                              (contract-question-mark v))))
                     (internal-loop next-alternative))
                   ;; ambeval failure
                   (lambda ()
                     (announce-output
                       ";;; There are no more values of")
                     (user-print input)
                     (driver-loop)))
              ))
          ))))
  (internal-loop
    (lambda ()
      (newline)
      (display ";;; There is no current problem")
      (driver-loop))))

; (trace ambeval)
; (trace analyze)
; (trace analyze-disjoin)
; (trace analyze-assertion)
; (trace instantiate)
(driver-loop)

(assert! (killed They Kenny))
(assert! (killed Randy Pooh))
(assert! (rule (killed ?x ?y) (killed ?y ?x)))
;; always-true
(assert! (rule (ignore ?x ?y)))
(or (killed Kenny ?who1)
    (killed Pooh ?who2)
    )
try-again
try-again
try-again
(or (ignore Foo ?x)
    ;; and, not
    (lives-near ?y (Bitdiddle Ben))
    ;; lisp-value
    (and (salary ?person ?amount)
     (lisp-value > ?amount 30000))
    )
try-again
try-again