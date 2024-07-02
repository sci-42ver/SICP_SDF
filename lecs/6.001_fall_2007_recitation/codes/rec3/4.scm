; Since my method for 3 is calculated in one iteration, here I am based on the instructor's solution for 3.
(load "2.scm")
(define (find-e result count n)
  (if (> count n)
    result
    (find-e (+ result (/ 1.0 (fact count))) (+ count 1) n)))
(find-e 0 0 10)
; The solution by the instructor uses one less argument and 1.0 implies (= i 0).
(define (find-e-instructor n)
  (define (helper sum i)
    (if (= i 0)
      sum
      (helper (+ (/ (fact i)) sum) (- i 1))))
  (helper 1.0 n))
(find-e-instructor 10)
