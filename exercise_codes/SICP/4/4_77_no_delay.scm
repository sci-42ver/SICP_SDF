(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

;; 0.a. lisp-value needs operator, operands. 
;; Some operand can be frame-stream, ~~but then operator should be procedure using specical form.~~
;; but frame-stream should be used with operands etc which has more meaning.
;; 0.b. So only and can pass frame-stream which can have nested or etc.

;; this promise should check all binding in the frame just as not does.
(define (orig-negate-for-frame operands frame)
  ;; unchanged
  (display "call orig-negate-for-frame")
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
            (display (append frame (list (cons operand-vars (delay orig-proc)))))
            (singleton-stream 
              ;; append to ensure force ordering for try-force-promise.
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

(define (find-pair-with-promise frame)
  (let ((res 
          (filter-map 
            (lambda (binding) 
              (let ((promise (cdr binding)))
                ;; TODO why (promise? (force (delay (lambda (x) x)))) returns #f
                ;; but here it will return #t.
                (and (promise? promise) (not (promise-forced? promise)) binding))
              ) 
            frame)))
    (and 
      (not (null? res))
      res
      ))
  )

(define (all-vars-has-bindings vars frame)
  (fold 
    (lambda (a res) (and res (assoc a frame))) ; res put before to ensure short circuit
    #t 
    vars))

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
(define (try-force-promise frame)
  (let ((pair-with-promise (find-pair-with-lambda frame)))
    (if (and pair-with-promise (all-vars-has-bindings (caar pair-with-promise) frame))
      ;; 0. pass one lambda, then no need for promise at all.
      ;; 1. here maybe there multiple pair-with-promise's.
      (begin
        ; (display (list (pp (force (cdar pair-with-promise))) pair-with-promise (cdar pair-with-promise) frame))
        (let ((used-binding (assoc (caar pair-with-promise) frame))
              (proc (cdar pair-with-promise)))
          (set-cdr! used-binding 'used) ; no need to delete since this bindind has list car instead of var.
          (stream-flatmap
            try-force-promise
            ;; return frame-stream
            (proc frame)))
        )
      (singleton-stream frame)
      )))

;; 
(define (find-pair-with-promise frame)
  (let ((res 
          (filter-map 
            (lambda (binding) 
              (let ((promise (cdr binding)))
                ;; TODO why (promise? (force (delay (lambda (x) x)))) returns #f
                ;; but here it will return #t.
                (and (promise? promise) (not (promise-forced? promise)) binding))
              ) 
            frame)))
    (and 
      (not (null? res))
      res
      ))
  )
; https://stackoverflow.com/a/20802742/21294350
(define (full-copy pair)
  (if (pair? pair) 
      (cons (full-copy (car pair)) (full-copy (cdr pair)))
      pair))
(define full-copy list-copy)

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
(define (use-separate-not-mark-binding frame)
  (map 
    (lambda (binding) 
      (let ((promise (cdr binding)))
        ; (if (and (promise? promise) (not (promise-forced? promise))) 
        ;   (full-copy binding)
        ;   binding
        ;   )
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
        (try-force-promise (use-separate-not-mark-binding frame))
        )
      (stream-append-delayed
        ;; TODO must deep copy...
        (find-assertions query-pattern frame)
        (delay (apply-rules query-pattern frame))))
    )
   frame-stream))

; (trace vars)
; (trace all-vars-has-bindings)

; (trace try-force-promise)
; (trace conjoin)
; (trace find-pair-with-promise)

; (trace orig-negate-for-frame)
; {({((? x)) ...}) ...}

(put 'not 'qeval negate)
(query-driver-loop)

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
