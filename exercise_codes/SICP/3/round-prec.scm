(define (round-prec num denom prec)
  (let ((scalar (expt 10 prec)))
    (list 'RATIO
          (round (/ (* num scalar) denom))
          scalar))
        )

(define test-num (round-prec 10000 3 10))
;; https://stackoverflow.com/questions/78597962/1-01e-100-1-in-mit-scheme/78626541#comment138619637_78597962
;; > We thus always preserve only n decimal digits after each simple operation.
;; not strictly right.
;; >  integers - of course round by using only integer operations, never using floats.
;; See (round 7/2) https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Numerical-operations.html#index-round
(display (string-length (number->string (cadr test-num))))
(display (string-length (number->string (caddr test-num))))