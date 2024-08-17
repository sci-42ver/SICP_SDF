(define (element-of-unordered-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-unordered-set? x (cdr set)))))

(define (adjoin-unordered-set x set)
  (if (element-of-unordered-set? x set)
      set
      (cons x set)))

(define (intersection-unordered-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-unordered-set? (car set1) set2)        
         (cons (car set1)
               (intersection-unordered-set (cdr set1) set2)))
        (else (intersection-unordered-set (cdr set1) set2))))

;; 2.59
(define (union-unordered-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((element-of-unordered-set? (car set1) set2)        
         (union-unordered-set (cdr set1) set2))
        (else (union-unordered-set (cdr set1) (cons (car set1) set2)))))