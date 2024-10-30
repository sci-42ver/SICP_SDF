(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lib.scm")
(load "analyze-lib.scm")
(load "test-lib.scm")

(define (unless condition usual-value exceptional-value)
  (if condition exceptional-value usual-value))

(eval '(map unless '(#t #f #t) '(1 2 3) '(4 5 6)) the-global-environment)