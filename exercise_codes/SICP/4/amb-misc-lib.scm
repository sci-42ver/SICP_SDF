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
(define (an-element-of items)
  (require (not (null? items)))
  (amb (car items) (an-element-of (cdr items))))
;; from 1_24_scale.scm
(define (fast-prime? n times)
  (define (fermat-test n)
    (define (try-it a)
      (= (expmod a n n) a))
    (try-it (+ 1 (inexact->exact (round (random (- n 1))))))) ; to ensure integer
  (define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder (square (expmod base (/ exp 2) m))
                      m))
          (else
            (remainder (* base (expmod base (- exp 1) m))
                       m))))    
  (cond ((= times 0) true)
        ((fermat-test (inexact->exact n)) ; enforce using integer
         (fast-prime? (inexact->exact n) (- times 1)))
        (else false)))
(define times 100)
(define (prime-sum-pair list1 list2)
  (let ((a (an-element-of list1))
        (b (an-element-of list2)))
    ;; modified
    (require (fast-prime? (+ a b) times))
    (list a b)))

;; from 4.35.
(define (an-integer-between low high)  
  (require (<= low high))  
  (amb low (an-integer-between (+ low 1) high)))

;; from book chapter 2
;; See 4_26: general map in evaluator is complex due to using apply inside.
; (define nil '())
(define unary-map
  (lambda (proc items)
    (if (null? items)
      '()
      (cons (proc (car items))
            (unary-map proc (cdr items))))))

(define binary-map
  (lambda (proc items1 items2)
    (define (iter proc items1 items2)
      (if (null? items1)
        '()
        (cons (proc (car items1) (car items2))
              (binary-map proc (cdr items1) (cdr items2)))))
    (if (not (= (length items1) (length items2)))
      (error (list "wrong arg" items1 items2))
      (iter proc items1 items2))
    ))

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))
