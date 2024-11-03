;; > Modify the driver loop for the evaluator so
; that lazy pairs and lists will print in some reasonable way.
; (What are you going to do about infinite lists?)
;; IMHO just actual-value for car and cadr and output ... for the rest as scheme does.
;; OR just car.

;; See wiki
;; The footnote 40 should mean "install these definitions in the lazy evaluator simply by typing them at the driver loop".
;; That is more reasonable.

;; See wiki Felix021's
;; 1. changing cons definition is more reasonable.
;; 2. user-cdr just give the underlying scheme cdr-proc.

;; > modify the representation of lazy pairs so that the evaluator can identify them in order to print them.
;; Add tag
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp) 
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ;; modified
        ((application? exp)
          (let* ((op (operator exp))
                  (val 
                    (apply (actual-value op env)
                      (operands exp)
                      env)))
            (if (eq? 'cons op)
              (list 'lazy-pair val) ; then all operations about list need to be changed.
              val)))
        (else
         (error "Unknown expression type -- EVAL" exp))))

;; (cons 1 2) will actual-value 1,2 and return one underlying lamdba tagged with 'lazy-pair.

(define (user-print object)
  (cond 
    ((tagged-list? object 'lazy-pair) 
      (let ((pair (cadr object))
            ;; assume all car,cons etc are primitive.
            (car-proc (actual-value 'car the-global-environment)))
        ;; the env is implied in pair due to primitive.
        (display (list ((primitive-implementation car-proc) pair) '...)))
      )
    ((compound-procedure? object)
      (display (list 'compound-procedure
                     (procedure-parameters object)
                     (procedure-body object)
                     '<procedure-env>)))
    (else (display object))))
