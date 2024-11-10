;; copy these after (driver-loop)
(define (require p)
  (if (not p) (amb)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; optional
;; from book
(define (distinct? items) 
  (cond ((null? items) true) 
        ((null? (cdr items)) true) 
        ((member (car items) (cdr items)) false) 
        (else (distinct? (cdr items)))))
;; from 4.35.
(define (an-integer-between low high)  
  (require (<= low high))  
  (amb low (an-integer-between (+ low 1) high)))

;; from book chapter 2
;; See 4_26: general map in evaluator is complex due to using apply inside.
(define nil '())
(define unary-map
  (lambda (proc items)
    (if (null? items)
      nil
      (cons (proc (car items))
            (unary-map proc (cdr items))))))

(define binary-map
  (lambda (proc items1 items2)
    (define (iter proc items1 items2)
      (if (null? items1)
        nil
        (cons (proc (car items1) (car items2))
              (binary-map proc (cdr items1) (cdr items2)))))
    (if (not (= (length items1) (length items2)))
      (error (list "wrong arg" items1 items2))
      (iter proc items1 items2))
    ))