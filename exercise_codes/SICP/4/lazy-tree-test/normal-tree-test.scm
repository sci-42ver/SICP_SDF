(define (prune max-depth tree)
  (define (iter depth subtree)
    (if (= depth max-depth)
      '() ; no children
      (cons (car subtree) (flatmap-only-nil (lambda (child) (iter (+ 1 depth) child)) (cdr subtree)))))
  (iter 0 tree)
  )

;; from book
(define (flatmap-only-nil proc seq)
  (fold-right 
    (lambda (elm lst) 
      (if (null? elm)
        ; (append elm lst)
        lst
        (cons elm lst)
        )) 
    '()
    (map proc seq)))

(define (demo-tree)
  (cons 0 
        (list 
          (cons 1   
                (list 
                  (cons 3 
                        (list 
                          (cons 5 (list (cons 7 '()) (cons 8 '()))) 
                          (cons 6 '()))) 
                  (cons 4 '()))) 
          (cons 2 '()))))
(prune 3 (demo-tree))