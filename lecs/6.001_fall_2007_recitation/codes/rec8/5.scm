;; from book
(define (variable? exp)
  (symbol? exp))
(define (make-variable var)
  var)
(define (variable-name exp)
  exp)
(define (or? exp)
  (and (pair? exp) (eq? (car exp) 'or)))
(define (make-or exp1 exp2)
  (list 'or exp1 exp2))
(define (or-first exp)
  (cadr exp))
(define (or-second exp)
  (caddr exp))
(define (and? exp)
  (and (pair? exp) (eq? (car exp) 'and)))
(define (make-and exp1 exp2)
  (list 'and exp1 exp2))
(define (and-first exp)
  (cadr exp))
(define (and-second exp)
  (caddr exp))

;; 4
(define (not? exp)
  (and (pair? exp) (eq? (car exp) 'not)))
(define (make-not exp)
  (list 'not exp))
(define (not-operand exp)
  (cadr exp))

;; 5
;; See sol which assumes no and, or, etc. primitives.
(define (eval-boolean exp env)
  (cond ((variable? exp) (variable-value (variable-name exp) env))
        ((and? exp) (and (eval-boolean (and-first exp) env) (eval-boolean (and-first exp) env)))
        ((or? exp) (or (eval-boolean (or-first exp) env) (eval-boolean (or-first exp) env)))
        ((not? exp) (not (eval-boolean (not-operand exp) env)))
        (else (error "invalid exp"))))
