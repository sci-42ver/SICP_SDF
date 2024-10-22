(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lib.scm")
(load "../lib.scm")

;; wing's seems to be helpful for user due to "no need to send an error message".
;; And wing's is just also iter'ing but with unnecessary about 2 times space.
;; mazj's is more readable but iters 4 times as mazj says.

;; also see meteorgan's using iter to delete by `set-car!`.
(define (remove-binding-from-frame! var val frame)
  (set-car! frame (delq var (car frame)))
  (set-cdr! frame (delq val (cdr frame)))
  )

(define (unbound-variable-general! var env whether-global . helper-msg)
  (define (env-loop env whether-have-unbound)
    ;; modified to ensure only one evaluation of `first-frame`.
    (let ((frame
            (if (eq? env the-empty-environment)
              ;; changed
              'finish-unbound
              (first-frame env))))
      (define (scan vars vals)
        (cond ((null? vars)
                ;; changed
                (if whether-global
                  (env-loop (enclosing-environment env) #f)
                  (displayln helper-msg)))
              ((eq? var (car vars))
                ;; changed
                (remove-binding-from-frame! var (car vals) frame)
                (if whether-global
                  (env-loop (enclosing-environment env) #t)))
              (else (scan (cdr vars) (cdr vals)))))
      (if (eq? frame 'finish-unbound)
        (if (not whether-have-unbound)
          (displayln helper-msg))
        (scan (frame-variables frame)
              (frame-values frame))))
    )
  (env-loop env #f))

(define (unbound-variable-global! var env)
  (unbound-variable-general! var env #t "variable is not in the global environment -- MAKE-UNBOUND!"))
;; still follow set-variable-value! since we may one env arg as the-empty-environment.
(define (unbound-variable-only-local! var env)
  (unbound-variable-general! var env #f "variable is not in the local environment -- MAKE-UNBOUND!"))

(define (test unbound-proc-global unbound-proc-local)
  (define variables-1 '(a b c))
  (define values-1 (iota 3))
  (define variables-2 '(b c d))
  (define values-2 '(3 4 5))
  ;; test with env
  (define test-env
    (extend-environment variables-2 values-2 
      (extend-environment variables-1 values-1 the-empty-environment)))
  (define enclosing-env (enclosing-environment test-env)) ; may share elements with test-env.
  
  (unbound-proc-local 'e test-env)
  (unbound-proc-global 'e test-env)

  (unbound-proc-local 'b test-env)
  (displayln (list "test-env" test-env))
  (displayln (list "enclosing-env" enclosing-env))
  (unbound-proc-global 'b test-env)
  (displayln (list "test-env" test-env))
  (displayln (list "enclosing-env" enclosing-env))
  )
(test unbound-variable-global! unbound-variable-only-local!)
; (variable is not in the local environment -- MAKE-UNBOUND!)
; (variable is not in the global environment -- MAKE-UNBOUND!)
; (test-env (((c d) 4 5) ((a b c) 0 1 2)))
; (enclosing-env (((a b c) 0 1 2)))
; (test-env (((c d) 4 5) ((a c) 0 2)))
; (enclosing-env (((a c) 0 2)))