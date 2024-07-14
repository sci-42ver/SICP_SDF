;;; transformed from list-ref
(define (length items)
  (define (helper idx)
    (if (= n 0)
      (car items)
      (length (cdr items) (- n 1)))))
(define squares (list 1 4 9 16 25))