;;; Copied from 1.22 with changes as the exercise requests
;;; Θ(sqrt(n))
(define (prime? n)
  (define (smallest-divisor n)
    (find-divisor n 2))
  (define (find-divisor n test-divisor)
    (define (next num)
      (if (= num 2)
        3
        (+ num 2)))
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (next test-divisor)))))
  (define (divides? a b)
    (= (remainder b a) 0))
  (= n (smallest-divisor n)))

(define (timed-prime-test n)
  ; (newline)
  ; (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
    (begin
      (report-prime n (- (runtime) start-time)) ; follow wiki to avoid unnecessary outputs
      #t)
    #f))
(define (report-prime n elapsed-time)
  (newline)
  (display n)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes start cnt)
  (cond ((= cnt 0) 0) ; break. better use "COMPUTATION COMPLETE" as wiki does.
        ;; different from this repo which abstracts `count` into `report-prime`.
        ((even? start) (search-for-primes (+ start 1) cnt))
        (else (if (timed-prime-test start)
                (search-for-primes (+ start 2) (- cnt 1))
                (search-for-primes (+ start 2) cnt)))))

;;; as wiki says
;;; > As of 2008, computers have become too fast to appreciate the time 
; (search-for-primes 1e10 3)
; (search-for-primes 1e11 3)
; (search-for-primes 1e12 3)
; (search-for-primes 1e13 3)
#|
Use diff to compare with 1.22:
(search-for-primes 1e10 3)
10000000019. *** .07
10000000033. *** .06999999999999999
10000000061. *** .07
;Value: 0

1 ]=> (search-for-primes 1e11 3)
100000000003. *** .21999999999999997
100000000019. *** .21999999999999997
100000000057. *** .21999999999999997
;Value: 0

1 ]=> (search-for-primes 1e12 3)
1000000000039. *** .6799999999999999
1000000000061. *** .6700000000000002
1000000000063. *** .69
;Value: 0

1 ]=> (search-for-primes 1e13 3)
10000000000037. *** 2.18
10000000000051. *** 2.25
10000000000099. *** 2.210000000000001
;Value: 0

> If not, what is
the observed ratio of the speeds of the two algorithms, and
how do you explain the fact that it is different from 2

the ratio should be (2*sqrt(n)-1)/(sqrt(n))
|#
(/ .11 .07)
(/ .3500000000000001 .21999999999999997)
(/ 1.1300000000000001 .6799999999999999)
(/ 3.5900000000000007 2.18)

(/ (/ .35 .11) (sqrt 10))
(/ (/ 1.13 .35) (sqrt 10))
(/ (/ 3.58 1.13) (sqrt 10))
#|
(/ (/ .35 .11) (sqrt 10))
;Value: 1.0061792555081206

1 ]=> (/ (/ 1.13 .35) (sqrt 10))
;Value: 1.0209639302829339

1 ]=> (/ (/ 3.58 1.13) (sqrt 10))
;Value: 1.00185433835423

> Is your result compatible with the notion that programs on your machine run in time proportional to the number of steps required for the computation?
I don't inspect the machine code, but Θ(sqrt(n)) already implies that.
|#

;;; wiki
;;; 1. > This exercise requires a Scheme implementations which provides a runtime primitive, such as MIT/GNU Scheme or lang sicp for DrRacket.
;;; Or see this repo use `current-inexact-milliseconds` which is same as
;;; > Another implementation also easy to understand:
;;; 2. > the inner procedure can be rewritten without repeating the if test:
;;; the original uses cond which allows multiple statements in one condition