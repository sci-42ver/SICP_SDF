;; Run `scheme --eval '(load "calc.scm")' "(calc)"`.
(load "../compatibility-lib.scm")
;; Scheme calculator -- evaluate simple expressions

; The read-eval-print loop:

(define (calc)
  (display "calc: ")
  (flush) ; https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Output-Procedures.html#index-flush_002doutput
  (print (calc-eval (read)))
  (calc))

; Evaluate an expression:
;; See https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Environment-Operations.html#index-eval
(define (calc-eval exp)
  (cond 
    ((number? exp) exp)
    ((list? exp) (calc-apply (car exp) (map calc-eval (cdr exp))))
    (else (error "Calc: bad expression:" exp))))

; Apply a function to arguments:

(define (calc-apply fn args)
  (cond 
    ((eq? fn '+) (accumulate + 0 args))
    ((eq? fn '-) (cond ((null? args) (error "Calc: no args to -"))
                       ((= (length args) 1) (- (car args)))
                       (else (- (car args) (accumulate + 0 (cdr args))))))
    ((eq? fn '*) (accumulate * 1 args))
    ((eq? fn '/) (cond ((null? args) (error "Calc: no args to /"))
                       ((= (length args) 1) (/ (car args)))
                       (else (/ (car args) (accumulate * 1 (cdr args))))))
    (else (error "Calc: bad operator:" fn))))
