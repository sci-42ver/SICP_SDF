(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lib/amb/amb-lib.scm")
(driver-loop)

(define (demo)
  (define x (amb 1 2))
  (define y (amb 3 4))
  (write-line (cons x y)))
(demo)
try-again
try-again
try-again
try-again

(define (y-fail-then-x-fail)
  (define x (amb 1 2))
  (define y (amb 3 4))
  (write-line (cons x y))
  (amb)
  )
(y-fail-then-x-fail)