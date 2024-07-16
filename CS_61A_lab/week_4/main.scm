;; 1 trivial
(define x (cons 4 5))
(car x)
(cdr x)
(define y (cons 'hello 'goodbye))
(define z (cons x y))
(car (cdr z))
(cdr (cdr z))

;; 2
(cdr (car z))
(car (cons 8 3))
(car z)
(car 3)

;; 3,4 are covered by the book

;; 7
(define x '(a (b c) d))
(car x)
(cdr x)
(car (cdr x))