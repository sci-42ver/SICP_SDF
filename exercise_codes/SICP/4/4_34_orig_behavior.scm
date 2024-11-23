(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "Lazy_Evaluation_lib.scm")

(driver-loop)

(define (return-inner-thunk x y)
  (cons x y))

;; See lecs/6.001_spring_2007_recitation/codes/rec22/source22/streams-with-thunks.scm for how to have inner-thunk which needs evaluator support.
(return-inner-thunk 1 2)
