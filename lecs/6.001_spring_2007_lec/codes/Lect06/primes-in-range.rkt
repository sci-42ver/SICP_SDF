#lang racket
; (define first car)
; (define rest cdr)
(define adjoin cons)

(define (primes-in-range min_value max)
  ;; These will be called first by all `primes-in-range`, so the infinite loop.
  ; (let ((other-primes (primes-in-range (+ 1 min_value) max)))
  ; (define other-primes (primes-in-range (+ 1 min_value) max))

  (cond ((> min_value max) '())
    ; ((prime? min_value) (adjoin min_value other-primes))
    ; (else other-primes)))
    ((prime? min_value) (adjoin min_value (primes-in-range (+ 1 min_value) max)))
    (else (primes-in-range (+ 1 min_value) max))))

(define (prime? n)
  ;; I can't use this in Intermediate Student with Lambda https://stackoverflow.com/a/14327032/21294350
  ;; I won't dig into this language "Intermediate Student with Lambda".
  (begin
    (define (find-divisor d)
      (cond ((>= d (sqrt n)) #t)
        ((divides? d n) #f)
        (else (find-divisor (+ d 1)))))
    (find-divisor 2)))
(define (divides? d n)
  (= (remainder n d) 0))

(require racket/trace)
; (trace primes-in-range prime? find-divisor)
(trace primes-in-range prime?)

(primes-in-range 0 10)

; representation ((2 3) (5 1)) (sorted order)

(define (get-multiplicity pf p)
  (cond ((null? pf) 0)
    ((= (caar pf) p) (cadar pf))
    ((> (caar pf) p) 0)
    (else (get-multiplicity (cdr pf) p)))
)
(define test_pf '((2 3) (5 1)))
(get-multiplicity test_pf 2)
(get-multiplicity test_pf 5)
(get-multiplicity test_pf 1)