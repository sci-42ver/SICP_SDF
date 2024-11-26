;; add this code in analyze
; ((unless? expr) (eval (unless->if expr) env)) 

(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lib.scm")
(load "lib/analyze/analyze-lib.scm")
(load "test-lib.scm")

(define (analyze exp)
  (cond ((self-evaluating? exp) 
         (analyze-self-evaluating exp))
        ((quoted? exp) (analyze-quoted exp))
        ((variable? exp) (analyze-variable exp))
        ((assignment? exp) (analyze-assignment exp))
        ((definition? exp) (analyze-definition exp))
        ((if? exp) (analyze-if exp))
        ((lambda? exp) (analyze-lambda exp))
        ((begin? exp) (analyze-sequence (begin-actions exp)))
        ((cond? exp) (analyze (cond->if exp)))
        ;; added
        ((unless? exp) (analyze (unless->if exp)))
        ((application? exp) (analyze-application exp))
        (else
         (error "Unknown expression type -- ANALYZE" exp))))

;; unless expression is very similar to if expression. 

(define (unless? expr) (tagged-list? expr 'unless)) 
(define (unless-predicate expr) (cadr expr)) 
(define (unless-consequence expr) 
  (if (not (null? (cdddr expr))) 
      (cadddr expr) 
      'false)) 
(define (unless-alternative expr) (caddr expr)) 

(define (unless->if expr) 
  (make-if (unless-predicate expr) (unless-consequence expr) (unless-alternative expr)))

;; added
(define test-exp 
  '((define (factorial n)
      (unless (= n 1)
              (* n (factorial (- n 1)))
              1))
    (display (factorial 5))))

;; As (driver-loop) implies, no auto display for eval. 
(run-program-list test-exp the-global-environment)

;;; from wiki SophiaG
(define test-exp-2
  '((define nil '())
    (define map
      (lambda (proc items)
        (if (null? items)
            nil
            (cons (proc (car items))
                  (map proc (cdr items))))))
    (define select-y '(#t #f #t #t))
    (define xs '(1 3 5 7))
    (define ys '(2 4 6 8))
    ;; for simplicity, only think of unary map.
    (define selected (map (lambda (pred) (unless pred 'yes 'no)) select-y))
    (display selected)
    ))
(run-program-list test-exp-2 the-global-environment)

