(define (average x y)
  (/ (+ x y) 2))
(define (displayln x)
  (newline)
  (display x))
(define nil '())

(define (assert-predicate pred x y)
  (assert (pred x y)))