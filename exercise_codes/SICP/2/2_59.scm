;; almost same as wiki expect with 2 null?
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((element-of-set? (car set1) set2)        
         (union-set (cdr set1) set2))
        (else (union-set (cdr set1) (cons (car set1) set2)))))