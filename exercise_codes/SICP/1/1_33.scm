;;; I don't know why 
;;; > e resulting filtered-accumulate abstraction takes the same arguments as accumulate
;;; It is trivially more convenient to take the `predicate` as the parameter.

(define (filtered-accumulate predicate combiner null-value term a next b)
  (if (predicate a) ; since we care about "the prime numbers" instead of primity of the square.
    ;; borrowed from 1.32
    (if (> a b)
      null-value
      (combiner (term a) (filtered-accumulate predicate combiner null-value term (next a) next b)))
    ;; Wiki uses `(combiner null-value` which should be same as here due to `null-value` definition.
    ;; This is also implied by `(iter (next a) result)`.
    ;; Also see poly's comment
    (filtered-accumulate predicate combiner null-value term (next a) next b)))

(define (sq n)
  (* n n))
(define (inc n)
  (+ 1 n))

;;; The following borrowed from wiki
(define (smallest-div n) 
  (define (divides? a b) 
    (= 0 (remainder b a))) 
  (define (find-div n test) 
      (cond ((> (sq test) n) n) ((divides? test n) test) 
            (else (find-div n (+ test 1))))) 
  (find-div n 2)) 

(define (prime? n) 
    (if (= n 1) false (= n (smallest-div n)))) 

;; with small changes to cater to here.
(define (sum-of-prime-squares a b) (filtered-accumulate prime? + 0 sq a inc b))
(sum-of-prime-squares 1 5)

;;; I skipped b since the basic idea is same.

;;; Ignore this: This from wiki is wrong because it only calles `filter` once.
;;; Here `filtered-term` is one function, so `filter` will be called for each term.
(define (accumulate combiner null-value term a next b)
  (if (> a b)
    null-value
    (combiner (term a) (accumulate combiner null-value term (next a) next b))))
(define (filtered-accumulate filter comb null-val term a next b) 
  (define (filtered-term k) 
    (if (filter k) (term k) null-val)) 
  (accumulate comb null-val filtered-term a next b))
(define (sum-of-prime-squares a b) (filtered-accumulate prime? + 0 sq a inc b))
(sum-of-prime-squares 1 5)