(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "amb-lib.scm")

(define (prime-sum-pair list1 list2)
  (let ((a (an-element-of list1))
        (b (an-element-of list2)))
    (require (prime? (+ a b)))
    (list a b)))

(driver-loop)
(define (require p)
  (if (not p) (amb)))
(define (an-integer-starting-from n)
  (amb n (an-integer-starting-from (+ n 1))))
(define (an-integer-between low high)  
  (require (<= low high))  
  (amb low (an-integer-between (+ low 1) high)))
(define (fast-prime? n times)
  (define (fermat-test n)
    (define (try-it a)
      (= (expmod a n n) a))
    (try-it (+ 1 (inexact->exact (round (random (- n 1))))))) ; to ensure integer
  (define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder (square (expmod base (/ exp 2) m))
                      m))
          (else
            (remainder (* base (expmod base (- exp 1) m))
                       m))))    
  (cond ((= times 0) true)
        ((fermat-test (inexact->exact n)) ; enforce using integer
         (fast-prime? (inexact->exact n) (- times 1)))
        (else false)))
(define times 100)
(define (prime? n)
  (fast-prime? n times))

;; similar to Exercise 4.36, we should bound the latter lets range based on the 1st.
(define (prime-sum-pairs)
  ;; lower triangular matrix pattern as 2.2.3.
  (let ((a (an-integer-starting-from 1)))
    (let ((b (an-integer-between 1 a)))
      (require (prime? (+ a b)))
      (list a b))))
(prime-sum-pairs)
try-again
try-again
try-again