#lang racket/base
;;;;;; This is only to check whether `average-damp` functions well.
;;; from wiki
(define (average-damp f) 
    (lambda (x) (/ (+ x (f x)) 2))) 
(define (repeated f n) 
  (define (compose f g) 
    (lambda (x) (f (g x)))) 
  (if (= n 1) 
    f 
    (compose f (repeated f (- n 1)))))

(define n2 50)
(define x (expt 3 n2))
;;; https://www.zhihu.com/question/28838814 almost equal to x/(2^m*y^{n-1}).
;;; i.e. x/2^m=1.5^n2=637621500.2140496 here. 
(((repeated average-damp n2)
    (lambda (y) (/ x (expt y (- n2 1))))) 1.0)
; (((repeated average-damp 1)
;     (lambda (y) (/ x (expt y (- n2 1))))) 1.0)
; ((average-damp
;     (lambda (y) (/ x (expt y (- n2 1))))) 1.0)