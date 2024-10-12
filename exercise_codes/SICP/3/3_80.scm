;; same as meteorgan but not using `merge-stream`.
(define (RLC R L C dt)
  (lambda (vC0 iL0) 
    (define vc (integral (delay dvc) vC0 dt))
    (define il (integral (delay dil) iL0 dt))
    (define dvc (scale-stream il (- (/ 1 C))))
    (define dil 
      (add-streams
        (scale-stream (- (/ R L)) il)
        (scale-stream (/ 1 L) vc)
        ))
    (cons vc il)))