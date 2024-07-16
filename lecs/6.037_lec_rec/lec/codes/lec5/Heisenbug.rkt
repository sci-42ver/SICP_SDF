#lang racket
(define foo 0)
(define (new-foo) (set! foo (add1 foo)) foo)
(define sum 0)
; (display ; This is not used by racket.
(displayln
 (let loop ()
   (if (< foo 10)
     (begin
      ;  (display (new-foo))(newline)
       (set! sum (+ sum (new-foo)))
       (loop))
     sum)))
