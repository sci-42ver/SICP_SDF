(define (averager a b c)
  (let ((sum (make-connector))
        (half (make-connector)))
    ;; see wiki better to use 2 for elegance.
    ;; same as repo.
    (constant (/ 1 2) half)
    (adder a b sum)
    (multiplier sum half c)
    ))