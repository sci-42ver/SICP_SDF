(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lib.scm")
(load "analyze-lib.scm")

(trace analyze)
(define test-exp
  '((define (factorial n)
      (if (= n 1)
          1
          (* (factorial (- n 1)) n)))))
; (analyze test-exp)

;; > This saves work because analyze will be called only once on an expression, while the execution procedure may be called many times.
;; For example in the book (factorial 4),
;; Then `execute-application` call on analyzed proc.
;; Then the recursive factorial *won't call analyze* due to having been analyzed.
;;; Also see CS61A notes p88.
;; So "saves work".
;; i.e.
;; > n 4.1.1. Execute-application differs from apply in that the procedure body for a compound procedure has already been analyzed, so there is *no need to do further analysis*.
(eval test-exp 
  (extend-environment (list 'a)
                      (list 0)
                      the-empty-environment))