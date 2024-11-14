(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "amb-lib.scm")
;; if-fail is similar to if.
;; based on analyze-if
(define if-fail-consequent if-predicate)
(define if-fail-alternative if-consequent)
;; same as wiki woofy
(define (analyze-if-fail exp)
  (let ((cproc (analyze (if-fail-consequent exp)))
        (aproc (analyze (if-fail-alternative exp))))
    (lambda (env succeed fail)
      (cproc env
             ;; success continuation for evaluating the predicate
             ;; to obtain pred-value
             ;;; fail2 may be modified by cproc and constructed based on fail the latter.
             (lambda (consequent-value fail2)
               ;; > *returns* as usual if the evaluation succeeds
               ;; pass fail2 to allow backtracking.
               (succeed consequent-value fail2)
               )
             ;; failure continuation for evaluating the predicate
             (lambda () 
              ;; just pass "succeed fail" directly.
              (aproc env succeed fail))))))
(define (if-fail? exp)
  (tagged-list? exp 'if-fail))

(define orig-analyze analyze)
(define (analyze exp)
  (cond 
    ((if-fail? exp) (analyze-if-fail exp))
    ;; application? is still second to the last.
    (else (orig-analyze exp))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; test
(driver-loop)
(define (require p)
  (if (not p) (amb)))
(define (an-element-of items)
  (require (not (null? items)))
  (amb (car items) (an-element-of (cdr items))))

(if-fail (let ((x (an-element-of '(1 3 5))))
           (require (even? x))
           x)
         'all-odd)

(if-fail (let ((x (an-element-of '(1 3 5 8))))
           (require (even? x))
           x)
         'all-odd)