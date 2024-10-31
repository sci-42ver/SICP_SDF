(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "Lazy_Evaluation_lib.scm")

(let ((env the-global-environment))
  (eval '(define count 0) env)
  (eval 
    '(define (id x)
      (set! count (+ count 1))
      x)
    env)
  (eval '(define w (id (id 10))) env) 
  (assert (= 1 (eval 'count env))) 
  ; (assert (= 10 (actual-value 'w env))) 
  ; (display (eval 'w env)) ; circular list
  (eval 'w env) ; one delayed object
  ; (assert (= 2 (eval 'count env)))
  (eval 'count env)
  )