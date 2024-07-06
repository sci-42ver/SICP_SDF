; (define g (lambda (x) (+ x 2)))
(define (g) (lambda (x) (+ x 2)))
((g) 1)