;; implied by `(prime-sum-pair '(1 3 5 8) '(20 35 110))` results.
;; "an-element-of" has one implicit ordering, so prime-sum-pair also ensures iterating through all cases.
;; IGNORE: Although I don't how when `(require (prime? (+ a b)))` aborts
;; Maybe due to 2 "an-element-of"s can list all possible cases, so that `(require (prime? (+ a b)))` can ensure checking all cases.
;; but then "simply replacing an-integer-between by an-integer-starting-from" also lists *all* triples. Then it should work...
;;; See wiki LisScheSic's for the actual problem for an-integer-starting-from
(define (triple-starting-from low)
  (let ((i (an-integer-starting-from low)))
    (let ((j (an-integer-starting-from i)))
      (let ((k (an-integer-starting-from j)))
        (list i j k)))))

(define (a-pythagorean-triple-starting-from low)
  (let ((triple (triple-starting-from low)))
    (require (= (+ (* i i) (* j j)) (* k k)))
    (list i j k)))