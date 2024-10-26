(load "quote.scm")
(display "PROCEDURE-DEFINE.SCM ...") (newline)

; One of the nice things in normal Scheme is sugared define+lambda syntax
;    (define (my-proc param1 param2 ... paramn) body)
; Let's allow for this syntax in our Scheme* interpreter too.  To do this,
; we'll directly handle this form; we won't desugar it.

; Handles procedure defines and variable defines
(define (eval-define exp env)
  (if (procedure-define? exp)
    (eval-procedure-define exp env)
    (eval-variable-define  exp env)))

; Tests if the expression is a sugared define+lambda, e.g.
;   (define (foo p1 p2) ...)
(define (procedure-define? exp)
  (and (define? exp)
       (pair? (second exp))))

; This is just a renamed version of the old eval-define
(define (eval-variable-define exp env)
  (let ((name (cadr exp))
        (defined-to-be (caddr exp)))
    (table-put! (car env) name (eval defined-to-be env))
    'undefined))

; Handles evaluation of defines like:
;   (define (foo p1 p2) ...)
(define (eval-procedure-define exp env)
  (let ((name   (first (second exp)))
        (params (cdr   (second exp)))
        (body   (third exp)))
    (table-put! (car env) name (make-compound params body env))
    'undefined))

(eval '(define* x* 10) GE)                              ; -> undefined
(eval '(define* double* (lambda* (x) (plus* x x))) GE)  ; -> undefined
(eval '(double* x*) GE)                                 ; -> 20
(eval '(define* (double2* x) (plus* x x)) GE)           ; -> undefined
(eval '(double2* x*) GE)                                ; -> 20

