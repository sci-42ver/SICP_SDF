#lang racket/base

(require "1_42.rkt")
(provide repeated)
;;; As CS 61A notes, it is unnecessary to explicitly use 
;;; > you should generally use the simpler linear-recursive structure and not try for the more complicated iterative structure
(define (repeated f n)
  (define (helper n result)
    (if (= n 1)
      result
      (helper (- n 1) (compose f result))))
  (helper n f))
((repeated square 2) 5)

;;; wiki
(define (repeated2-iter f n) 
  (define (double f)
    (compose f f))
    (define (iter n current) 
        (cond ((= 1 n) current) 
              ((even? n) (double (iter (/ n 2) current))) 
              ; (else (compose f (iter (- n 1) (compose f current)))) 
              (else (compose f (iter (- n 1) current))) 
        ) 
    ) 
    (iter n f)     
) 
((repeated2-iter square 3) 5)