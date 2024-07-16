#lang racket
;;; from lec
(define (primes-in-range min_value max)
  (let ((other-primes (primes-in-range (+ 1 min_value) max)))
    (cond ((> min_value max) '())
      ((prime? min_value) (cons min_value other-primes))
      (else other-primes))))

(define (prime? n)
  (define (find-divisor d)
    (cond ((>= d n) #t)
      ((divides? d n) #f)
      (else (find-divisor (+ d 1)))))
  (find-divisor 2))

(define (divides? d n)
  (= (remainder n d) 0))

;; out of memory
; (primes-in-range 0 10)

;; from 6.001
; (require racket/trace)
; (trace primes-in-range prime?)
; (primes-in-range 0 10)

;; Out of memory; test from user
; (primes-in-range 0 10)
;; Ditto; so 0 not at fault
(primes-in-range 9 10)
;; Simpler upper bound
(primes-in-range 0 1)
