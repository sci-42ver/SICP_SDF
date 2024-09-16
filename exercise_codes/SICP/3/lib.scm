;; from exercise 3.12
(define (last-pair x)
  (if (null? (cdr x))
    x
    (last-pair (cdr x))))

;; Exercise 3.13
(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)
