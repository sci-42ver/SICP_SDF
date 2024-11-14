(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "amb-lib.scm")
;; from 4.51
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

;; from 4.52
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
    ;; combined
    ((permanent-assignment? exp) (analyze-permanent-assignment exp))
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
(define (fast-prime? n times)
  (define (fermat-test n)
    (define (try-it a)
      (= (expmod a n n) a))
    (try-it (+ 1 (inexact->exact (round (random (- n 1))))))) ; to ensure integer
  (define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder (square (expmod base (/ exp 2) m))
                      m))
          (else
            (remainder (* base (expmod base (- exp 1) m))
                       m))))    
  (cond ((= times 0) true)
        ((fermat-test (inexact->exact n)) ; enforce using integer
         (fast-prime? (inexact->exact n) (- times 1)))
        (else false)))
(define times 100)
(define (prime-sum-pair list1 list2)
  (let ((a (an-element-of list1))
        (b (an-element-of list2)))
    ;; modified
    (require (fast-prime? (+ a b) times))
    (list a b)))

(let ((pairs '()))
  (if-fail (let ((p (prime-sum-pair '(1 3 5 8) '(20 35 110))))
             (permanent-set! pairs (cons p pairs))
             (amb))
           pairs))