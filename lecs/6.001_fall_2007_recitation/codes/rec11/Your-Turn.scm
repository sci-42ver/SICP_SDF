(define x (list 3 4))
(define y (list 1 2))
(set-car! x y)
x
(set-cdr! y (cdr x))
x