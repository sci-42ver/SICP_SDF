; (import (scheme small))

(define (sum term a next b)
  (if (> a b)
    0
    (+ (term a)
       (sum term (next a) next b))))
(define (Simpson_Rule_approximation f a b n)
  ; (define (sum_no_factor f a b n)
  ;   (if (even? n)
  ;     (if (= a b)
  ;       0
  ;       (+ (term a) (sum_no_factor f (next a) b n)))
  ;     "error"))

  ; (define h (exact->inexact (/ (- b a) n))) ; This is too inexact
  (define h (/ (- b a) n))
  (define (next a)
    (+ a (* 2 h)))
  (define (term a)
    (+ (f a) (* 4 (f (+ a h))) (f (next a))))
  (if (even? n)
    (* (/ h 3) (- (sum term a next b) (term b)))
    "error"))

(define (cube x) (* x x x))
(define a 0)
(define b 1)
(define N1 100)
(define N2 1000)
(Simpson_Rule_approximation cube a b N1)
(Simpson_Rule_approximation cube a b N2)
(- (Simpson_Rule_approximation cube a b N1) (/ 1 4))
(- (Simpson_Rule_approximation cube a b N2) (/ 1 4))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  ;; Same as the above using fraction
  (* (sum f (+ a (/ dx 2)) add-dx b)
     dx))

(- (integral cube a b (/ 1 N1)) (/ 1 4))
(- (integral cube a b (/ 1 N2)) (/ 1 4))

;;; See wiki `(sum term a next (- b (* 2 h)))` avoids unnecessary calculation `(- (sum term a next b) (term b))`.

;;; check the error for the simple "Simpson's 1/3 rule" which should be 0 by
;;; > proportional to the fourth derivative of the function to integrate
(- (Simpson_Rule_approximation cube a b 2) (/ 1 4))
