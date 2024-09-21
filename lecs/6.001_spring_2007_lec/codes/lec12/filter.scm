(define (reverse! lst)
  (define (iter last current)
    (if (null? current)
      last
      (let ((next (cdr current)))
        (set-cdr! current last)
        (iter current next))))
  (iter '() lst))

(define (filter f lst)
  (define (iter lst ans)
    (cond ((null? lst) (reverse! ans))
          ((f (car lst)) (iter (cdr lst) (cons (car lst) ans)))
          (else (iter (cdr lst) ans))))
  (iter lst '()))

(filter even? '(1 2 3))
