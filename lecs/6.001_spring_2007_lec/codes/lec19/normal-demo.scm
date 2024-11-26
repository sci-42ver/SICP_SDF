(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lib/lazy/Lazy_Evaluation_lib.scm")

;; output "eval arg" once
; (driver-loop)
; (define (foo x)
;   (write-line "inside foo")
;   (+ x x))
; (foo (begin (write-line "eval arg") 222))

(define (force-it obj)
  (if (thunk? obj)
    (actual-value (thunk-exp obj) (thunk-env obj))
    obj))

;; output "eval arg" twice
(driver-loop)
(define (foo x)
  (write-line "inside foo")
  (+ x x))
(foo (begin (write-line "eval arg") 222))