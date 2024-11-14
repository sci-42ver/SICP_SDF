(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "amb-lib.scm")

;;; have the same output as the following.
; (driver-loop)
; (define (require p)
;   (if (not p) (amb)))

; (define (echo x)
;   (require (amb true false))
;   x
;   )
; (echo 1)
; try-again
; try-again

(define (require? exp) (tagged-list? exp 'require))

(define (require-predicate exp) (cadr exp))

(define orig-analyze analyze)
(define (analyze exp)
  (cond 
    ((require? exp) (analyze-require exp))
    (else (orig-analyze exp))))

(define (analyze-require exp)
  (let ((pproc (analyze (require-predicate exp))))
    (lambda (env succeed fail)
      (pproc env
             (lambda (pred-value fail2)
               (if (not (true? pred-value))
                   (fail2)
                   (succeed 'ok fail2)))
             fail))))

(driver-loop)

(define (echo x)
  (require (amb true false))
  x
  )
(echo 1) ; 1
try-again ; There are no more values of ...
try-again
