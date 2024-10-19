;; https://stackoverflow.com/a/78586373/21294350

(define H
  (lambda (x) 
    (lambda (y)
      (lambda args (apply (x (y y)) args)))))

;; i.e. Y
(define X (lambda (g) ((H g) (H g))))

(X square)
;; if not use (lambda args ...)
;; (H square) (H square) -> (square ((H square) (H square))) ...
;; if using
;; just return one lambda.

(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "4_8_Y_combinator.scm")

((X fib-body) 8)