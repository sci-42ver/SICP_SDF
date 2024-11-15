(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "table-lib.scm")
(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "Lazy_Evaluation_lib.scm")

(define (memoize f)
  (let ((table (make-table)))
    (lambda (x)
      (let ((previously-computed-result (lookup x table)))
        (or previously-computed-result
            (let ((result (f x)))
              (write-line (list "recalculate for" x))
              (insert! x result table)
              result))))))
(define val (list 0))
(define (inc val)
  (set-car! val (+ (car val) 1)) 
  val)
(inc val)
(inc val)
;; IMHO as lec says, if f is one mutation procedure, we should not use this.
;; But IMHO this won't cause the problem in lazy-eval since for (inc val) it either wraps inc or val in thunk, but not (inc 1) as a whole.
;; That is implied by `(actual-value (operator exp) env)` and `(actual-value (first-operand exps) env)`.
(define memo-inc (memoize inc))
(memo-inc val) ; (3)
(memo-inc val) ; (3)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; > because other names or data structures may point to this thunk! 
;; WRONG: IMHO this means `(lookup-variable-value exp env)` may return one thunk. But we always use `actual-value`->`force-it` to get val, so table is also fine although not space-efficient.

;; original
(define table (make-table)) ; so not modular.
(define (force-it obj)
  ; (let ((table (make-table))) ; should be global
    (let ((previously-computed-result (lookup obj table)))
      (or previously-computed-result
          (cond ((thunk? obj)
            (let* 
              ((exp (thunk-exp obj))
                (result (actual-value
                            exp
                            (thunk-env obj))))
              (write-line (list "recalculate for" exp))
              (insert! obj result table)
              result))
            (else obj))
          )
      )
      ; )
  )

(driver-loop)
;; test from normal-demo.scm
;; Here name x points to thunk.
(define (foo x)
  (write-line "inside foo")
  (+ x x))
(foo (begin (write-line "eval arg") 222))
