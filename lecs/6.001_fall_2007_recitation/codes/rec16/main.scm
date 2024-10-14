;; sol is more elegant
(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "3_54.scm")
(define ints integers)
(define facts-from-one
  (cons-stream 1
    (mul-streams (stream-cdr ints) facts-from-one)))
;; almost same as Exercise 3.54
(define facts
  (cons-stream 1
    facts-from-one))
(stream-head facts 10)

;; Exercise 3.59 is based on (e^x)'=e^x instead of directly summing up.
;; e-to-the-x-coeffs trivial by div-streams.

;; sum-stream structure is similar to facts.
;; same as http://community.schemewiki.org/?sicp-ex-3.55
;; Here it is based on (s0+s1, s0+s1+s2, s0+s1+s2+s3, ...) = (s0, s0+s1, s0+s1+s2, ...) + (s1, s2, ...).
(define (sum-stream s)
  (define partial-sum
    (cons-stream 
      (stream-car s)
      (add-streams
        (stream-cdr s)
        partial-sum
        )))
  partial-sum
  )
;; sol is based on (s0+s1, s0+s1+s2, s0+s1+s2+s3, ...) = (s0, s0, s0, ...) + (s1, s1+s2, s1+s2+s3, ...).