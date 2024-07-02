#lang racket/base

; https://stackoverflow.com/a/34756648/21294350
(provide compose)
(provide square)
(define (compose f g)
  (lambda (x) (f (g x))))
(define (inc x)
  (+ x 1))
(define (square x)
  (* x x))
((compose square inc) 6)