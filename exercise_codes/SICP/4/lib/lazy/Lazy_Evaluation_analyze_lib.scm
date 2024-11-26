(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lib/lazy/Lazy_Evaluation_lib.scm")
(load "lib/analyze/analyze-lib.scm")

;; actual-value only for operator, args of primitive, driver-loop output and if predicate.

;; modified since eval has been changed
;; Here proc is like the original exp.
(define (actual-value proc env)
  (force-it (proc env)))
(define (delay-it proc env)
  (list 'thunk proc env))

(define (analyze-application exp)
  (let ((fproc (analyze (operator exp)))
        (aprocs (map analyze (operands exp))))
    (lambda (env)
      ;; also pass env as apply in Lazy_Evaluation_lib.scm
      (execute-application (actual-value fproc env)
                           ;; modified
                           aprocs
                           env))))

(define (execute-application proc aprocs env) ; modified
  (cond ((primitive-procedure? proc)
         (apply-primitive-procedure proc (map (lambda (aproc) (actual-value aproc env)) aprocs)))
        ((compound-procedure? proc)
         ;; > so there is no need to do further analysis.
         ;; As done in (analyze-lambda exp), so no need for eval which does analyse first.
         ;; Just skip that analyse and so apply to env.
         ((procedure-body proc)
          (extend-environment (procedure-parameters proc)
                              (map (lambda (aproc) (delay-it aproc env)) aprocs)
                              (procedure-environment proc))))
        (else
         (error
          "Unknown procedure type -- EXECUTE-APPLICATION"
          proc))))

(define (analyze-if exp)
  (let ((pproc (analyze (if-predicate exp)))
        (cproc (analyze (if-consequent exp)))
        (aproc (analyze (if-alternative exp))))
    (lambda (env)
      ;; modified
      (if (true? (actual-value pproc env))
          (cproc env)
          (aproc env)))))

;; divergence occurs
(define (orig-actual-value exp env)
  (force-it (eval exp env)))
;; just copy from Lazy_Evaluation_lib.scm
(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output
          ;; modified
           (orig-actual-value input the-global-environment)))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; demo
(driver-loop)
;;; L-Eval input:
(define (try a b)
  (if (= a 0) 1 b))
;;; L-Eval value:
; ok
;;; L-Eval input:
(try 0 (/ 1 0))
;;; L-Eval value:
; 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; explanation
;; 0. Since all pass proc, so analyze advantage to avoid duplicate analyze can still be achieved.
;; 1. Here (try 0 (/ 1 0)) will bind a to (delay-it aproc env) where aproc does (lambda (env) 0) (similar for b).
;; Then (= a 0) will do for a: use (actual-value aproc env) where (aproc env) gets the bound value of a (i.e. (delay-it aproc env)).
;; Then (force-it (delay-it aproc env)) -> (actual-value aproc env) -> (force ((lambda (env) 0) env)) -> (force 0) -> 0.
;; So b is kept as one thunk since (= a 0) is #t.
;;; After all, the basic idea by encapsulating args in thunk is same. But here we do analyze beforehand.
;; So just 
;; 0. change accessor actual-value and constructor delay-it
;; 1. do delay for args when necessary.
;; 2. do actual-value when necessary.
;; are enough. Abstraction really helps!!!