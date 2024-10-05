(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "book-stream-lib.scm")

(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define factorials (cons-stream 1 (mul-streams integers factorials)))

(define (test)
  (assert (= 2 (stream-ref factorials 1))))
(test)

(define factorials (cons-stream 1 (mul-streams (add-streams ones integers) factorials)))
(test)

(define factorials 
  (cons-stream 1 
               (mul-streams factorials (stream-cdr integers))))
(test)

(define (partial-sums S)
  (cons-stream (stream-car S) (add-streams (stream-cdr S) (partial-sums S))))