(load "1_37.scm")
(define (tan-cf x k)
  (cont-frac (lambda (i) (if (= i 1)
                           x
                           (- (* x x))))
             (lambda (i) (- (* 2 i) 1))
             k))
(define pi 3.141592653589793)
(- (tan-cf (/ pi 4) 100) 1)
