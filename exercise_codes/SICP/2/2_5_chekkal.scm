(load "../lib.scm")
;; Constructor 
(define (cons a b) (* (expt 2 a) (expt 3 b))) 
;; Enables us to calculate the log of n in base b 
(define (logb b n) (round (/ (log n) (log b))))
; (define (logb b n) (ceiling (/ (log n) (log b))))
(define (expt-exact base exp)
  (inexact->exact (expt base exp)))
;; Selectors 
(define (car x) (logb 2 (/ x (gcd x (expt-exact 3 (logb 3 x))))))
(define (cdr x) 
  (displayln (logb 2 x))
  (displayln (expt 2 (logb 2 x)))
  (displayln (gcd x (expt 2 (logb 2 x))))
  (displayln (gcd x (expt-exact 2 (logb 2 x))))
  (displayln x)
  (displayln (/ x (gcd x (expt 2 (logb 2 x)))))
  (displayln (/ x (gcd x (expt-exact 2 (logb 2 x)))))
  (logb 3 (/ x (gcd x (expt-exact 2 (logb 2 x))))))

(cdr (cons 11 17))