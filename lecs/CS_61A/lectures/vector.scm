(define (shuffle1 lst)
  ;; This at the end puts (list-ref in n) at the head, and then shuffle the rest where out is the list before (list-ref in n).
  ;; Let (length lst) be k+1, then the worst time complexity based on calls of loop will be k+k-1+...+1, i.e. O(k^2).
  (define (loop in out n)
    (if (= n 0)
      (cons (car in) (shuffle1 (append (cdr in) out)))
      (loop (cdr in) (cons (car in) out) (- n 1))))
  (if (null? lst)
    '()
    (loop lst '() (random (length lst)))))
