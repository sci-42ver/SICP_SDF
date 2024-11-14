(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "amb-lib.scm")
(define (analyze-permanent-assignment exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze (assignment-value exp))))
    (lambda (env succeed fail)
      (vproc env
             (lambda (val fail2)        ; *1*
               (let ((old-value
                      (lookup-variable-value var env))) 
                 (set-variable-value! var val env)
                 (succeed 'ok
                          (lambda ()    ; *2*
                            ;; modified
                            (fail2)))))
             fail))))
(define (permanent-assignment? exp)
  (tagged-list? exp 'permanent-set!))

(define orig-analyze analyze)
(define (analyze exp)
  (cond 
    ((permanent-assignment? exp) (analyze-permanent-assignment exp))
    ;; application? is still second to the last.
    (else (orig-analyze exp))))

(driver-loop)
(define (require p)
  (if (not p) (amb)))
(define (an-element-of items)
  (require (not (null? items)))
  (amb (car items) (an-element-of (cdr items))))

(define count 0)
(let ((x (an-element-of '(a b c)))
      (y (an-element-of '(a b c))))
  (permanent-set! count (+ count 1))
  (require (not (eq? x y)))
  (list x y count))

;; based on the former 2, next for y one time gets the valid result.
try-again