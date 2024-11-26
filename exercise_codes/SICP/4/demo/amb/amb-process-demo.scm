;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Emm.... Although step-by-step tracing helps understanding the logic.
;; It is better to understand based on induction and assumption got by that. This is just how the amb-lib is written.
(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lib/amb/amb-lib.scm")

(trace analyze)

(driver-loop)
(define (require p)
  (if (not p) (amb)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; example1
;; (fproc env ... fail0) where fail0 is the fail of `internal-loop`.
;; -> (succeed (lookup-variable-value exp env) fail0): This passes the operator *value*.
;; -> (get-args aprocs ... fail0)
;; -> ((car aprocs) env (lambda (arg fail2) ...) fail0) 
;; -> ((car choices) env succeed fail00) where fail00 does try-next for (amb 2 3).
;; -> (succeed 1 fail00), i.e. ((lambda (arg fail2) ...) 1 fail00)
;; -(pass arg 1)> (get-args (cdr aprocs) env succeed00 fail00) (This implies DFS where only latter args failure will cause the 1st arg failure which causes the latter backtracking)
;; -> ...
;; -> (get-args (cddr aprocs) env succeed000 fail000)
;; -> (succeed000 '() fail000)
;; -> (succeed00 (cons arg args) fail000) (again implies DFS)
;; -> (succeed0 (cons 1 (cons 'a '())) fail000)
;; -> (execute-application proc (cons 1 (cons 'a '())) succeed-main fail000) where succeed-main is in `internal-loop`.
;; -> (succeed (apply-primitive-procedure proc args) fail000)
;; Here next-alternative is fail000 which does try-next for (amb 'b)
(list (amb 1 2 3) (amb 'a 'b))

;; does fail000
;; i.e. ((car choices) env succeed fail000') (notice fail000' does try-next for (amb) after consuming 'b)
;; Then (succeed 'b fail000')
;; Then the rest should be similar since succeed is just to take the arg value and do the rest thing based on that value.
;; So the succeed itself doesn't change (i.e. we still use the amb-lib.scm codes...)
try-again

;; fail000' will call fail in analyze-amb which doesn't change when calling try-next.
;; i.e. call fail00.
;; Then the rest is similar.
try-again

;; Based on induction, when all candidates are traversed, fail0 will be called.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; example2
(define global-x '(0))
(define (test y)
  (define (demo-set! x)
    (set! global-x (cons x global-x))
    global-x)
  (demo-set! y))
(test 1)
(test 2)

(define global-x '(0))
;; when (execute-application test-proc ... fail-y)
;; first do define which calls (succeed 'ok fail2), i.e. (b env succeed fail2)
;; where fail2 is fail passed by vproc, i.e. fail-y passed in execute-application->analyze-sequence->sequentially.
;; Then call demo-set!,
;; in analyze-application, fail(i.e. fail-y as the above says)-(passed since no amb)>fail2-...>fail3
;; Then again (execute-application test-proc ... fail-y) 
  ;; (Here I didn't give one detailed trace. But based on the program logic, if this fail, then we should choose another y, so fail-y.)
;; when sequentially, trivially (a env ... fail-y)
;; analyze-assignment's 
;; (vproc ... fail-y)-...> (succeed 'ok (lambda () (set-variable-value! ...) fail-y))
;; -(a-value is 'ok)> (b env succeed (*2*))
;; -> (succeed (lookup-variable-value exp env) (*2*))
;; succeed is passed directly in analyze-sequence: execute-application-(test y)->execute-application-(demo-set! y)
;; So (succeed-main (lookup-variable-value exp env) (*2*))
(test (amb 1 2))

;; As the above shows, (lambda () (set-variable-value! ...) fail-y) is called
;; where restore is done before trying the next alternative.
try-again


