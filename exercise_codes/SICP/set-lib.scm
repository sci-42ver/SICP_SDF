;; SICP p206 2.3.3
(define (element-of-set? x set)
(cond ((null? set) false)
((equal? x (car set)) true)
(else (element-of-set? x (cdr set)))))

(define (element-of-set-eq? x set)
(cond ((null? set) false)
((eq? x (car set)) true)
(else (element-of-set? x (cdr set)))))