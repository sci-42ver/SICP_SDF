(cd "~/SICP_SDF/lecs/6.001_spring_2007_recitation/codes/rec19/source19")
(load "procedure-define.scm") ; as sol does

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

;; from book
(define (definition-variable exp)
  (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))

;; just list some for demo
;; see sol. '(a b) same as (list 'a 'b)
(define reserved-word-list (list 'quote 'if 'define))

(define (eval-define exp env)
  (if (memq (definition-variable exp) reserved-word-list)
    'reserved-word-error ; added
    (if (procedure-define? exp)
      (eval-procedure-define exp env)
      (eval-variable-define  exp env))))

;; Sol lacks the following case.
(define quote
  (lambda (x) 10))