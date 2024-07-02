(define (prod term a next b)
  (if (> a b)
      1
      (* (term a)
         (prod term (next a) next b))))

;; only consider n>0
(define (inc x)
  (+ x 1))
(define (factorial n)
  (define (identity x) x)
  (if (= n 0)
    1
    (prod identity 1 inc n)))

;; n>0
(define (pi_divided_4 n)
  (define (term n)
    (if (even? n)
      (/ (+ n 2) (+ n 1))
      (/ (+ n 1) (+ n 2))))
  (exact->inexact (prod term 1 inc n)))

(define n 100)
(factorial n)
(- (pi_divided_4 n) 0.7853981633974483)

;;; b
(define (prod term a next b)
  (define (iter result)
    (if (> a b)
      result
      (iter (* result (term a)))))
  (iter 1))
;;; See wiki the above is wrong since `a` will also change.