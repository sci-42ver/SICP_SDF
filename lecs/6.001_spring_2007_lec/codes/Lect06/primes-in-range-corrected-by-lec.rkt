#lang racket
; (define first car)
; (define rest cdr)
(define adjoin cons)

(define (primes-in-range min max)
  (if (> min max)
    '()
    (let ((other-primes (primes-in-range (+ 1 min) max)))
      (if (prime? min)
        (adjoin min other-primes)
        other-primes))))

(define (prime? n)
  ;; I can't use this in Intermediate Student with Lambda https://stackoverflow.com/a/14327032/21294350
  ;; I won't dig into this language "Intermediate Student with Lambda".
  (begin
    (define (find-divisor d)
      ; (cond ((>= d (sqrt n)) #t)
      ;; from lec "Using types in your program"
      (if (integer? n)
        ;; correction hinted by "now let's test it again".
        (cond ((< n 2) #f)
          ((> d (sqrt n)) #t)
          ((divides? d n) #f)
          (else (find-divisor (+ d 1))))
        (error "prime? requires integer >= 2, given " n)))
    (find-divisor 2)))
(define (divides? d n)
  (= (remainder n d) 0))

(require racket/trace)
; (trace primes-in-range prime? find-divisor)
(trace primes-in-range prime?)

(primes-in-range 0 10)
