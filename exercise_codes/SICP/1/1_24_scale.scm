;;; Θ(sqrt(n))
;;; This sometimes may fail like `10000000019`
(define (fast-prime? n times)
  (define (fermat-test n)
    (define (try-it a)
      ; (newline)
      ; (display "try ")
      ; (display a)
      (= (expmod a n n) a))
    ; (trace try-it)
    ; (newline)
    ; (display "n: ")
    ; (display n)
    ; https://www.reddit.com/r/scheme/comments/rhevqk/comment/horeqre/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
    (try-it (+ 1 (inexact->exact (round (random (- n 1))))))) ; to ensure integer
  (define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder (square (expmod base (/ exp 2) m))
                      m))
          (else
            (remainder (* base (expmod base (- exp 1) m))
                       m))))  
  ; (trace expmod)      
  (cond ((= times 0) true)
        ((fermat-test (inexact->exact n)) ; enforce using integer
         (fast-prime? (inexact->exact n) (- times 1)))
        (else false)))

; (trace fast-prime?)
; (fast-prime? 10000000019 1)

(define (timed-prime-test n)
  ; (newline)
  ; (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (define times 100)
  (if (fast-prime? n times)
    (begin
      (report-prime n (- (runtime) start-time)) ; follow wiki to avoid unnecessary outputs
      #t)
    #f))
(define (report-prime n elapsed-time)
  (newline)
  (display n)
  (display " *** ")
  ; (newline)
  (display elapsed-time))

(define (search-for-primes start cnt)
  (define exact_start (inexact->exact start))
  (cond ((= cnt 0) 0) ; break. better use "COMPUTATION COMPLETE" as wiki does.
        ;; different from this repo which abstracts `count` into `report-prime`.
        ((even? exact_start) (search-for-primes (+ exact_start 1) cnt))
        (else (if (timed-prime-test exact_start)
                (search-for-primes (+ exact_start 2) (- cnt 1))
                (search-for-primes (+ exact_start 2) cnt)))))

;;; as wiki says
;;; > As of 2008, computers have become too fast to appreciate the time 
; (trace search-for-primes)

(search-for-primes 1e10 3) ; Here it may input floating if not `inexact->exact`
(search-for-primes 1e11 3)
(search-for-primes 1e12 3)
(search-for-primes 1e13 3)
; (search-for-primes 1e14 3)
; (search-for-primes 1e15 3)
; (search-for-primes 1e16 3) ; Here 1e16+1=1e16
(search-for-primes 1e20 3)
(search-for-primes 1e40 3)
(search-for-primes 1e60 3)
(search-for-primes 1e100 3)
#|
Here after `times` scaling, we can sometimes observe the correct ratio

(search-for-primes 1e20 3)
100000000000000000039 *** 1.0000000000000009e-2
100000000000000000129 *** 9.999999999999995e-3
100000000000000000151 *** 9.999999999999995e-3
;Value: 0

1 ]=> (search-for-primes 1e40 3)
10000000000000000303786028427003666890753 *** 2.0000000000000018e-2
10000000000000000303786028427003666891041 *** .01999999999999999
10000000000000000303786028427003666891101 *** .01999999999999999
;Value: 0

1 ]=> (search-for-primes 1e60 3)
999999999999999949387135297074018866963645011013410073083927 *** .03
999999999999999949387135297074018866963645011013410073083949 *** 3.0000000000000027e-2
999999999999999949387135297074018866963645011013410073084149 *** 3.0000000000000027e-2
;Value: 0
|#
