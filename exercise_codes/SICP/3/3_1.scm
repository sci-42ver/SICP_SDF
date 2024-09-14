;; schemewiki and repo just mimic new-withdraw
;; Here I follows make-account.
(define (make-accumulator sum)
  (define (add amount)
    (begin (set! sum (+ sum amount))
           sum))
  add)

(define A (make-accumulator 5))
(assert (= 15 (A 10)))
(assert (= 25 (A 10)))
