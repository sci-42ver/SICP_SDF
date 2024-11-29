(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

;; 0.a. lisp-value needs operator, operands. 
;; Some operand may be frame-stream, ~~but then operator should be procedure using specical form.~~
;; but frame-stream should be used with operands etc which has more meaning.
;; So we can assume operand to be either var or val.
;; 0.b. So only and can pass frame-stream between operands (i.e. conj's) which can have nested or etc.

(define (negate operands frame-stream)
  ;; this promise should check all bindings in the frame just as not does.
  (define (orig-negate-for-frame operands frame)
    ;; unchanged
    (if (stream-null? (qeval (negated-query operands)
                            (singleton-stream frame)))
      (singleton-stream frame)
      the-empty-stream))
  (stream-flatmap
    (lambda (frame)
      (let ((operand-vars (vars (car operands)))
            (orig-proc 
              (lambda (frame) (orig-negate-for-frame operands frame))))
        (if (all-vars-has-bindings operand-vars frame)
          (orig-proc frame)
          ;; added
          (singleton-stream 
            ;; append to ensure force ordering for try-run-lambda.
            (append frame (list (cons operand-vars orig-proc)))
            )
          )))
    frame-stream))

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
  (let ((pair-with-lambda (find-pair-with-lambda frame)))
    (if (and pair-with-lambda (all-vars-has-bindings (caar pair-with-lambda) frame))
      ;; 0. pass one lambda, then no need for force at all.
      ;; 1. here maybe there multiple pair-with-lambda's.
      (let ((proc (cdar pair-with-lambda)))
          ;; no need to delete since this bindind has list car instead of var.
          (set-cdr! (car pair-with-lambda) 'used)
          (stream-flatmap
            try-run-lambda
            ;; return frame-stream
            (proc frame)))
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
      (stream-flatmap
        (lambda (frame)
          (try-run-lambda (use-separate-not-mark-binding frame))
          )
        (stream-append-delayed
          (find-assertions query-pattern frame)
          (delay (apply-rules query-pattern frame))))
      )
    frame-stream))

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

;;; These return merely
;; test from SHIMADA and book
(not (baseball-fan (Bitdiddle Ben)))
;; I don't know what this is to do
(job (Bitdiddle Ben) (computer wizard))