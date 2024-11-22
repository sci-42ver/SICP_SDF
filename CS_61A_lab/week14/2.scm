(define (square x cont)
(cont (* x x)))

(square 5 (lambda (x) x))
(square 5 (lambda (x) (+ x 2)))
(square 5 (lambda (x) (square x (lambda (x) x))))
(square 5 display)
(define foo 3)
(square 5 (lambda (x) (set! foo x)))
foo

(define (reciprocal x yes no)
(if (= x 0)
(no x)
(yes (/ 1 x))))

(define se cons)

(reciprocal 3 (lambda (x) x) (lambda (x) (se x '(cannot reciprocate))))
(reciprocal 0 (lambda (x) x) (lambda (x) (se x '(cannot reciprocate))))
