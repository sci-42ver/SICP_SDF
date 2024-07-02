(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (if (and (= (remainder (square (expmod base (/ exp 2) m))
                                m) 1)
                  ;; borrowed from wiki. This is needed otherwise we will probably output #f.
                  (not (= (expmod base (/ exp 2) m) 1))
                  (not (= (expmod base (/ exp 2) m) (- m 1))))
           0 ; since exp (i.e. n) is prime, so a^n can't have factor n.
           (remainder (square (expmod base (/ exp 2) m))
                      m)))
        (else
          (remainder (* base (expmod base (- exp 1) m))
                     m))))

#|
By wikipedia we should use n-1=2^s*d
Then (even? exp) -> 2^{s-1}
or we get the d.

"iterate the reasoning" means we continue to find -1 for "some" r.

I skip "if n is a prime, then the only square roots of 1 modulo n are 1 and −1."
|#
(define (fermat-test n)
  (define (try-it a)
    ;; it passes the test because of two facts: in wikipedia https://en.wikipedia.org/wiki/Miller%E2%80%93Rabin_primality_test#Strong_probable_primes
    (define result (expmod a n n))
    (and (not (= result 0)) (= result a)))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define n 10)
;;; #f
(fast-prime? 4 n)
(fast-prime? 6601 n)
;;; #t
;; https://bigprimes.org/
; (fast-prime? 873328472160056375143924268611 n) ; too big
; (fast-prime? 8313153077 n)
; (trace expmod)
(fast-prime? 8221 n)
;; See drewhess. 2 may not work.
(fast-prime? 2 n)

;;; wiki

;; ex 1.28 

(define (square x) (* x x)) 

(define (miller-rabin-expmod base exp m) 
  (define (squaremod-with-check x) 
    (define (check-nontrivial-sqrt1 x square) 
      (if (and (= square 1) 
               (not (= x 1)) 
               (not (= x (- m 1)))) 
        0 
        square)) 
    (check-nontrivial-sqrt1 x (remainder (square x) m))) 
  (cond ((= exp 0) 1)
        ; only change this
        ((even? exp) (squaremod-with-check 
                       (miller-rabin-expmod base (/ exp 2) m))) 
        (else 
          (remainder (* base (miller-rabin-expmod base (- exp 1) m)) 
                     m)))) 

(define (miller-rabin-test n) 
  (define (try-it a) 
    (define (check-it x)
      ; original code checks a^n so `(= (expmod a n n) a)` instead of `(= (expmod a n n) 1)`.
      (and (not (= x 0)) (= x 1))) 
    (check-it (miller-rabin-expmod a (- n 1) n))) 
  (try-it (+ 1 (random (- n 1))))) 

(define (fast-prime? n times) 
  (cond ((= times 0) true) 
        ((miller-rabin-test n) (fast-prime? n (- times 1))) 
        (else false))) 

(define (prime? n)  
  ; Perform the test how many times?  
  ; Use 100 as an arbitrary value.  
  (fast-prime? n 100))  

(define (report-prime n expected)  
  (define (report-result n result expected)  
    (newline)  
    (display n)  
    (display ": ")  
    (display result)  
    (display ": ")  
    (display (if (eq? result expected) "OK" "FOOLED")))  
  (report-result n (prime? n) expected))  

(report-prime 2 true)  
(report-prime 7 true)  
(report-prime 13 true)  
(report-prime 15 false) 
(report-prime 37 true)  
(report-prime 39 false) 

(report-prime 561 false)  ; Carmichael number  
(report-prime 1105 false) ; Carmichael number  
(report-prime 1729 false) ; Carmichael number  
(report-prime 2465 false) ; Carmichael number  
(report-prime 2821 false) ; Carmichael number  
(report-prime 6601 false) ; Carmichael number 
(report-prime 8221 true)

;;; > Another solution that avoids nested functions
#|
1. > avoids nested functions
i.e. `(squaremod-with-check (miller-rabin-expmod ...`
                                                 2. > Only works for n>0
                                                 same for the original code.
                                                 |#
                                                 (define (miller-rabin n) 
                                                   (miller-rabin-test (- n 1) n)) 

                                                 ;; here iterates over all  1~n-1 instead of random.
                                                 (define (miller-rabin-test a n) 
                                                   (cond ((= a 0) true) 
                                                         ; expmod is congruent to 1 modulo n 
                                                         ((= (expmod a (- n 1) n) 1) (miller-rabin-test (- a 1) n)) 
                                                         (else false))) 

                                                 (define (expmod base exp m) 
                                                   (cond ((= exp 0) 1) 
                                                         ((even? exp)
                                                          ;; here is more readable but the basic idea is same.
                                                          (let ((x (expmod base (/ exp 2) m))) 
                                                            (if (non-trivial-sqrt? x m) 0 (remainder (square x) m)))) 
                                                         (else 
                                                           (remainder (* base (expmod base (- exp 1) m)) 
                                                                      m)))) 

                                                 (define (non-trivial-sqrt? n m) 
                                                   (cond ((= n 1) false) 
                                                         ((= n (- m 1)) false) 
                                                         ; book reads: whose square is equal to 1 modulo n 
                                                         ;; See mcs here the book probably is based on modulus ring.
                                                         ; however, what was meant is square is congruent 1 modulo n 
                                                         (else (= (remainder (square n) m) 1))))
