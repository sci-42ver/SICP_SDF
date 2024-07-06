#lang racket
(require (planet dyoo/simply-scheme))

;;; 4
(define (type-check func type_func arg)
  (if (type_func arg) ; See sol where we better use the naming ending with ?
    (func arg)
    #f))

(type-check sqrt number? 'hello)
(type-check sqrt number? 4)

;;; 5
(define (make-safe func pred?)
  (lambda (x) (type-check func pred? x)))
(define safe-sqrt (make-safe sqrt number?))
(safe-sqrt 'hello)
(safe-sqrt 4)