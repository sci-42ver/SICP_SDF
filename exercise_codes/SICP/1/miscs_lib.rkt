#lang racket/base

(provide displayln)
(provide average)
(define (displayln x)
  (display x)
  (newline))

(define (average x y)
  (/ (+ x y) 2))