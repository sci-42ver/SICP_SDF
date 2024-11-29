(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

;; IMHO compound will do the last operation for the last conj etc, so no need apply-filter in query-driver-loop.
;; OP may mean always run not even if insufficient bindings like the mere (not (... ?x ...)).
(define (qeval query frame-stream) 
  (let* ((qproc (get (type query) 'qeval)) 
        (q-val 
          (if qproc 
            (qproc (contents query) frame-stream) 
            (simple-query query frame-stream)))) 
    (if (enough-bindings? q-val) 
      (apply-filter q-val) 
      q-val))) 

(define THE-FILTERS the-empty-stream) 
(define (filter-initial) (set! THE-FILTERS the-empty-stream)) 
(define (empty-frame? frame) (null? frame)) 
(define (empty-filter? exps) (null? exps)) 
(define (first-filter exps) (stream-car exps)) 
(define (rest-filter exps) (stream-cdr exps)) 
(define (apply-filter frame-stream) 
  (define (run filters frame-stream) 
    (cond 
      ((empty-filter? filters) frame-stream) 
      ((stream-null? (stream-car frame-stream)) '()) ; don't apply filter 
      (else 
        (run (rest-filter filters) ((first-filter filters) frame-stream))))) 
  (let ((filters THE-FILTERS)) 
    (filter-initial) 
    (run filters frame-stream))) 
(define enough-bindings-max 5) 

;;added
(define inc
  (lambda (x) (+ 1 x)))

(define (enough-bindings? frame-stream) 
  (define (iter count frame) 
    (cond 
      ((>= count enough-bindings-max) #t) 
      ((stream-null? frame) #f) 
      (else (iter (inc count) (stream-cdr frame))))) 
  (iter 0 frame-stream))

(define (negate operands dummy-frame-stream) 
  (define (negate-filter frame-stream) 
    (stream-flatmap 
      (lambda (frame) 
        (if (stream-null? 
            (qeval (negated-query operands) 
              (singleton-stream frame))) 
          (singleton-stream frame) 
          the-empty-stream)) 
      frame-stream)) 
  (let ((old-filters THE-FILTERS)) 
    (set! THE-FILTERS 
      (cons-stream 
        (lambda (frame-stream) 
          (negate-filter frame-stream)) old-filters)) 
  dummy-frame-stream)) 
(put 'not 'qeval negate) 

(initialize-data-base 
  '((job (Aull DeWitt) (administration secretary))
    (supervisor (Aull DeWitt) (Warbucks Oliver))))
(write-line THE-ASSERTIONS)
(write-line (stream-length THE-ASSERTIONS))
(write-line THE-RULES)

; (trace enough-bindings?)

(query-driver-loop)
(not (baseball-fan (Bitdiddle Ben)))
(and (not (job ?x (computer programmer))) 
                  (supervisor ?x ?y))
;; wrong
(and (not (job ?x (administration secretary))) 
                  (supervisor ?x ?y)) 
