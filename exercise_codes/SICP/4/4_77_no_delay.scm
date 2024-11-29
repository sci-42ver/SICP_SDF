(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

;; 0.a. lisp-value needs operator, operands. 
;; Some operand can be frame-stream, ~~but then operator should be procedure using specical form.~~
;; but frame-stream should be used with operands etc which has more meaning.
;; 0.b. So only and can pass frame-stream which can have nested or etc.

;; this promise should check all binding in the frame just as not does.
(define (orig-negate-for-frame operands frame)
  ;; unchanged
  ; (display "call orig-negate-for-frame")
  (if (stream-null? (qeval (negated-query operands)
                           (singleton-stream frame)))
    (singleton-stream frame)
    the-empty-stream))
(define (negate operands frame-stream)
  (stream-flatmap
    (lambda (frame)
      (let ((operand-vars (vars (car operands)))
            (orig-proc 
              (lambda (frame) (orig-negate-for-frame operands frame))))
        (if (all-vars-has-bindings operand-vars frame)
          (orig-proc frame)
          ;; added
          (begin
            ; (display (append frame (list (cons operand-vars (delay orig-proc)))))
            (singleton-stream 
              ;; append to ensure force ordering for try-run-lambda.
              (append frame (list (cons operand-vars orig-proc)))
              ))
          )))
    frame-stream))

;; similar to exercise_codes/SICP/4/4_76_donald_mod.scm
(define (vars exp)
  (filter-map 
    (lambda (op) 
      (and (var? op) op))
    exp
    ))

(define (var-bound-to-val var frame)
  (if (var? var)
    (let ((binding (assoc var frame)))
      (and binding (var-bound-to-val (cdr binding) frame)))
    #t))

(define (all-vars-has-bindings vars frame)
  (fold 
    (lambda (a res) (and res (var-bound-to-val a frame))) ; res put before to ensure short circuit
    #t 
    vars))

;; binding is passed by reference.
(define (find-pair-with-lambda frame)
  (let ((res 
          (filter-map 
            (lambda (binding) 
              (let ((proc (cdr binding)))
                (and (procedure? proc) binding))
              ) 
            frame)))
    (and 
      (not (null? res))
      res
      ))
  )

;; 0. promise needs the frame with needed bindings to evaluate the result.
;; 1. Since partial operand results are not sufficient to do the operation, so wait until all are offered.
(define (try-run-lambda frame)
  (let* ((pair-with-lambda (find-pair-with-lambda frame)))
    (if (and pair-with-lambda (all-vars-has-bindings (caar pair-with-lambda) frame))
      ;; 0. pass one lambda, then no need for promise at all.
      ;; 1. here maybe there multiple pair-with-lambda's.
      (begin
        ; (display (list (pp (force (cdar pair-with-lambda))) pair-with-lambda (cdar pair-with-lambda) frame))
        (let (
              ; (used-binding (assoc (caar pair-with-lambda) frame))
              (proc (cdar pair-with-lambda)))
          ;; no need to delete since this bindind has list car instead of var.
          (set-cdr! (car pair-with-lambda) 'used)
          (stream-flatmap
            try-run-lambda
            ;; return frame-stream
            (proc frame)))
        )
      (singleton-stream frame)
      )))

; https://stackoverflow.com/a/20802742/21294350
;; only work for pair.
;; See link for the general.
(define (full-copy pair)
  (if (pair? pair) 
    (cons (full-copy (car pair)) (full-copy (cdr pair)))
    pair))

(define (use-separate-not-mark-binding frame)
  (map 
    (lambda (binding) 
      (let ((promise (cdr binding)))
        (let ((proc (cdr binding)))
          (if (procedure? proc) 
            (full-copy binding)
            binding
            ))
        ))
    frame
    )
  )

;; all "Compound queries" will at last call simple-query.
(define (simple-query query-pattern frame-stream)
  (stream-flatmap
    (lambda (frame)
      ;; we should try immediately after new frame-stream is constructed. 
      (stream-flatmap ; keep the order 
        (lambda (frame)
          (try-run-lambda (use-separate-not-mark-binding frame))
          )
        (stream-append-delayed
          ;; TODO must deep copy...
          (find-assertions query-pattern frame)
          (delay (apply-rules query-pattern frame))))
      )
    frame-stream))

; (trace vars)
; (trace all-vars-has-bindings)

; (trace try-run-lambda)
; (trace conjoin)
; (trace find-pair-with-lambda)

; (trace orig-negate-for-frame)
; {({((? x)) ...}) ...}

(put 'not 'qeval negate)
(query-driver-loop)

;; book test same as SHIMADA's
(and (supervisor ?x ?y)
     (not (job ?x (computer programmer))))
; (and (supervisor (aull dewitt) (warbucks oliver)) (not (job (aull dewitt) (computer programmer))))
; (and (supervisor (cratchet robert) (scrooge eben)) (not (job (cratchet robert) (computer programmer))))
; (and (supervisor (scrooge eben) (warbucks oliver)) (not (job (scrooge eben) (computer programmer))))
; (and (supervisor (bitdiddle ben) (warbucks oliver)) (not (job (bitdiddle ben) (computer programmer))))
; (and (supervisor (reasoner louis) (hacker alyssa p)) (not (job (reasoner louis) (computer programmer))))
; (and (supervisor (tweakit lem e) (bitdiddle ben)) (not (job (tweakit lem e) (computer programmer))))

(and (not (job ?x (computer programmer)))
     (supervisor ?x ?y))

; (define promise (delay (lambda (x) x)))
; (promise? (force promise))

; ;; wiki revc
; (define (normalize clauses)
;   (let ((filters (filter filter? clauses))
;         (compounds (filter compound? clauses))
;         (rest (filter (lambda (x) (and (not (filter? x)) (not (compound? x)))) clauses)))
;     (append rest compounds filters)))

;;; compared with wiki baby's
;; 1. I don't instantiate as many as possible, but just instantiate them all if all var's have corresponding bindings.
;; 1.a. baby's promise manipulates with operands. Mine is just the lambda.
;; 2. It is based on check-an-assertion returns singleton-stream. handle-promises can be alternatively done in simple-query.
;; 2.a. handle-promises only need to be done for simple-query as the above says.
;; rule just offers unify-match (may make filter valid but may be later rejected by the body).
;; rule body are just the rest types or also rule. So no need to check handle-promises for rule when unify-match.
;; 3. 

;; It needs adding
;; 1. modified binding-in-frame for the new frame structure.

;; lisp-value just do as the original if no invalid-check, otherwise "delay" it.

;;; compared with SHIMADA's
;; 1. It uses THE-FILTERS to store what to do.
;;; Possible errors:
;; 1. Why check enough-bindings? by counting frame number in frame-stream?
;; 2. `(stream-null? (stream-car frame-stream))` is weird since stream-flatmap won't add the-empty-stream element.

;; test from SHIMADA and book
(not (baseball-fan (Bitdiddle Ben)))
;; I don't know what this is to do
(job (Bitdiddle Ben) (computer wizard))

;;; from repo
;; 1: 4.56
;; I just checked the count and the result compatibility with the original exercise source (i.e. the middle one).
(and (supervisor ?x ?boss)
     (job ?boss ?boss-position)
     (not (job ?boss (computer . ?position)))
     )

(and (supervisor ?x ?boss)
     (not (job ?boss (computer . ?position)))
     (job ?boss ?boss-position))
;; (and (supervisor (aull dewitt) (warbucks oliver)) (not (job (warbucks oliver) (computer . ?position))) (job (warbucks oliver) (administration big wheel)))
;; (and (supervisor (cratchet robert) (scrooge eben)) (not (job (scrooge eben) (computer . ?position))) (job (scrooge eben) (accounting chief accountant)))
;; (and (supervisor (scrooge eben) (warbucks oliver)) (not (job (warbucks oliver) (computer . ?position))) (job (warbucks oliver) (administration big wheel)))
;; (and (supervisor (bitdiddle ben) (warbucks oliver)) (not (job (warbucks oliver) (computer . ?position))) (job (warbucks oliver) (administration big wheel)))


(and (not (job ?boss (computer . ?position)))
     (supervisor ?x ?boss)
     (job ?boss ?boss-position))

;; 2: 4.57
(assert! (rule (same ?x ?x)))
(assert! (rule (replace ?person-1 ?person-2)
               (and (not (same ?person-1 ?person-2))
                    (job ?person-1 ?person-1-job)
                    (job ?person-2 ?person-2-job)
                    (or (same ?person-1-job ?person-2-job)
                        (can-do-job ?person-1-job ?person-2-job)))))
(assert! (rule (replace-orig ?person-1 ?person-2)
               (and (job ?person-1 ?person-1-job)
                    (job ?person-2 ?person-2-job)
                    (or (same ?person-1-job ?person-2-job)
                        (can-do-job ?person-1-job ?person-2-job))
                    (not (same ?person-1 ?person-2)))))
;; a:
(replace ?x (Fect Cy D))
;; Due to the above stream-flatmap used with try-run-lambda, the order may be different from the following.
;; Anyway, not at last will manipulate with all frame-stream, the order doesn't matter.
; (replace (hacker alyssa p) (fect cy d))
; (replace (bitdiddle ben) (fect cy d))
; (replace (hacker alyssa p) (fect cy d))

(replace-orig ?x (Fect Cy D))
; (replace-orig (bitdiddle ben) (fect cy d))
; (replace-orig (hacker alyssa p) (fect cy d))
; (replace-orig (hacker alyssa p) (fect cy d))
