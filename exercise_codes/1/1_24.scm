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
  ; (define times 1)
  (if (fast-prime? n 1)
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
; (search-for-primes 1e300 3) ; Still 0.1 time
; (search-for-primes 1e400 3) ; +inf
; (search-for-primes 1e600 3)
; (search-for-primes 1e1000 3)
#|
weirdly here the last 0.1 -> 0. which can be verified by `(search-for-primes 1e10 1)` (check `display`. This is due to one unexpected `display`)

(search-for-primes 1e10 3)1
10000000019. *** 0.1
10000000033. *** 0.1
10000000061. *** 0.
;Value: 0

1 ]=> ; Here it may input floating if not `inexact->exact`
(search-for-primes 1e11 3)1
100000000003. *** 0.1
100000000019. *** 0.1
100000000057. *** 0.
;Value: 0

1 ]=> (search-for-primes 1e12 3)1
1000000000039. *** 0.1
1000000000061. *** 0.1
1000000000063. *** 0.
;Value: 0

1 ]=> (search-for-primes 1e13 3)1
10000000000037. *** 0.1
10000000000051. *** 0.1
10000000000099. *** 0.
;Value: 0

(search-for-primes 1e20 3)1
100000000000000000039 *** 0.1
100000000000000000129 *** 0.1
100000000000000000151 *** 0.
;Value: 0
|#