(load "eval-code.scm")
(display "SET.SCM ...") (newline)

; Added support for set!* special form
(define (eval exp env)
  (cond
    ((number?      exp) exp)
    ((symbol?      exp) (lookup exp env))
    ((define?      exp) (eval-define exp env))
    ((if?          exp) (eval-if exp env))
    ((lambda?      exp) (eval-lambda exp env))
    ((let?         exp) (eval-let exp env))
    ((set!?        exp) (eval-set exp env))
    ((application? exp) (apply* (eval (car exp) env)
                                (map (lambda (e) (eval e env))
                                     (cdr exp))))
    (else
      (error "unknown expression " exp))))

; Need to be able to check for the set!* special form...
(define (set!? exp)
  (tag-check exp 'set!*))

; Handles (set!* var val-expr)
(define (eval-set exp env)
  (let* ((var      (second exp))
         (val-expr (third  exp))
         (binding  (lookup-binding var env))
         (old-val  (second binding)))
    (set-binding-value! binding (eval val-expr env))
    old-val))

; Does the same thing as lookup, but returns the full binding instead of just the value.
(define (lookup-binding name env)
  (if (null? env)
    (error "unbound variable: " name)
    (let ((binding (table-get (car env) name)))
      (if (pair? binding)
        binding
        (lookup name (cdr env))))))

(define (set-binding-value! binding new-value)
  (set-car! (cdr binding) new-value))

; Quick test
(eval '(define* x 10) GE) ; -> undefined
(eval '(set!* x 20)   GE) ; -> 10
(eval 'x              GE) ; -> 20
