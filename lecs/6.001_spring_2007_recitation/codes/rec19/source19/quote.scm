(load "eval-code.scm")
(display "QUOTE.SCM ...") (newline)

; Added quote* special form
(define (eval exp env)
  (cond
    ((number?      exp) exp)
    ((symbol?      exp) (lookup exp env))
    ((define?      exp) (eval-define exp env))
    ((if?          exp) (eval-if exp env))
    ((lambda?      exp) (eval-lambda exp env))
    ((let?         exp) (eval-let exp env))
    ((quote?       exp) (eval-quote exp env))
    ((application? exp) (apply* (eval (car exp) env)
                                (map (lambda (e) (eval e env))
                                     (cdr exp))))
    (else
      (error "unknown expression " exp))))

; Here we'll do a tag check for quote* and quote.  This way
; we can take advantage of Scheme's complex parsing of quotes
; using apostrophe.
(define (quote? exp)
  (or (tag-check exp 'quote*)
      (tag-check exp 'quote)))

; Handles expressions like (quote* (1 2 3))
(define (eval-quote exp env)
  (second exp))

; Quick tests
(eval '(quote* x)       GE) ; -> x
(eval ''x               GE) ; -> x
(eval '(quote* (x y z)) GE) ; -> (x y z)
