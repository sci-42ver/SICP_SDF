(define (tag-check e sym) (and (pair? e) (eq? (car e) sym)))
(define (sum? e) (tag-check e 'plus*))
(define (eval-sum exp)
  (+ (eval (cadr exp)) (eval (caddr exp))))

(define (greater? exp) (tag-check exp 'greater*))
(define (if? exp) (tag-check exp 'if*))
; (define (eval exp)
;   (cond 
;     ((number? exp) exp)
;     ((sum? exp) (eval-sum exp))
;     ((greater? exp) (eval-greater exp))
;     ((if? exp) (eval-if exp))
;     (else (error "unknown expression " exp))))
(define (eval-greater exp)
  (> (eval (cadr exp)) (eval (caddr exp))))
(define (eval-if exp)
  (let ((predicate (cadr exp))
        (consequent (caddr exp))
        (alternative (cadddr exp)))
    (let ((test (eval predicate)))
      (cond
        ((eq? test #t) (eval consequent))
        ((eq? test #f) (eval alternative))
        (else (error "predicate not boolean: "
                     predicate))))))

(define (eval exp env)
  (cond
    ((number? exp) exp)
    ((symbol? exp) (lookup exp env))
    ((define? exp) (eval-define exp env))
    ((if? exp) (eval-if exp env))
    ((application? exp) (apply (eval (car exp) env)
                               (map (lambda (e) (eval e env))
                                    (cdr exp))))
    (else (error "unknown expression " exp))))

(define (apply operator operands)
  (cond ((primitive? operator)
         (scheme-apply (get-scheme-procedure operator) operands))
        ((compound? operator)
         (eval (body operator)
               (extend-env-with-new-frame
                 (parameters operator)
                 operands
                 (env operator))))
        (else (error "operator not a procedure: " operator))))

; Environment = list<table>
(define (extend-env-with-new-frame names values env)
  (let ((new-frame (make-table)))
    (make-bindings! names values new-frame)
    (cons new-frame env)))
(define (make-bindings! names values table)
  (for-each
    (lambda (name value) (table-put! table name value))
    names values))
; the initial global environment
(define GE
  (extend-env-with-new-frame
    (list 'plus* 'greater*)
    (list (make-primitive +) (make-primitive >))
    nil))
; lookup searches the list of frames for the first match
(define (lookup name env)
  (if (null? env)
    (error "unbound variable: " name)
    (let ((binding (table-get (car env) name)))
      (if (null? binding)
        (lookup name (cdr env))
        (binding-value binding)))))
