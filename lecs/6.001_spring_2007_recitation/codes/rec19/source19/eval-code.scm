;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;  Table implementation
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; make-table void -> table
; table-get table, symbol -> (binding | null)
; table-put! table, symbol, anytype -> undef
; binding-value binding -> anytype

;;; Table implementation using alists
;;; A table is (table data), where data is a list of bindings
;;; A binding is a two-element list (symbol anytype)

(define table-tag 'table)

;;; table -> data
(define get-table-data cadr)

;;; table, data -> undef
(define set-table-data!
  (lambda (table new-data)
    (set-car! (cdr table) new-data)))

;;; void -> table
(define make-table 
  (lambda () (list table-tag '())))

;;; table, symbol -> (binding | null)
;; in MIT/GNU Scheme return #f.
(define table-get 
  (lambda (table name)
    (assq name (get-table-data table))))

;;; table, symbol, anytype -> undef
(define table-put! 
  (lambda (table name value)
    (set-table-data! table (cons (list name value) 
                                 (get-table-data table)))))

;;; binding -> anytype
(define binding-value cadr)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;  Environments
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; Environment = list<table> 

(define (extend-env-with-new-frame names values env)
  (let ((new-frame (make-table)))
    (make-bindings! names values new-frame)
    (cons new-frame env)))

(define (make-bindings! names values table)
  (for-each 
    (lambda (name value) (table-put! table name value))
    names values))

; lookup searches the list of frames for the first match
(define (lookup name env)
  (if (null? env)
    (error "unbound variable: " name)
    (let ((binding (table-get (car env) name)))
      (if binding
        (binding-value binding)
        (lookup name (cdr env))))))

; define changes the first frame in the environment
(define (eval-define exp env)
  (let ((name (cadr exp))
        (defined-to-be (caddr exp)))
    (table-put! (car env) name (eval defined-to-be env))
    'undefined))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;  Primitive procedure ADT
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define prim-tag 'primitive)
(define (make-primitive scheme-proc)(list prim-tag scheme-proc))
(define (primitive? e) (tag-check e prim-tag))
(define get-scheme-procedure cadr)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;  "Double-bubble" ADT
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define compound-tag 'compound)
(define (make-compound parameters body env)
  (list compound-tag parameters body env))
(define (compound? exp) (tag-check exp compound-tag))
(define parameters cadr)
(define body caddr)
(define env cadddr)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;  Utility procedures
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (tag-check e sym) 
  (and (pair? e) (eq? (car e) sym)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;  Eval helpers
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (define? exp) 
  (tag-check exp 'define*))

(define (eval-define exp env)
  (let ((name (cadr exp))
        (defined-to-be (caddr exp)))
    (table-put! (car env) name (eval defined-to-be env))
    'undefined))

(define (if? exp) (tag-check exp 'if*))

(define (eval-if exp env)
  (let ((predicate (cadr exp))
        (consequent (caddr exp))
        (alternative (cadddr exp)))
    (let ((test (eval predicate env)))
      (cond
        ((eq? test #t) (eval consequent env))
        ((eq? test #f) (eval alternative env))
        (else (error "predicate not a conditional: "
                     predicate))))))

(define (lambda? e) (tag-check e 'lambda*))

(define (eval-lambda exp env)
  (let ((args (cadr exp))
        (body (caddr exp)))
    (make-compound args body env)))

(define (application? e) (pair? e))

(define (let? e) (tag-check e '*let))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;  Eval, Apply, and the GE
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; LPK:  I changed apply to apply* to avoid problems with reloading this
;;; file.  So now apply refers to the original scheme apply, and apply*
;;; refers to our new one.

; the initial global environment
(define GE
  (extend-env-with-new-frame
    (list 'plus* 'greater*)
    (list (make-primitive +) (make-primitive >))
    '()))

(define (eval exp env)
  (cond
    ((number? exp) exp)
    ((symbol? exp) (lookup exp env))
    ((define? exp) (eval-define exp env))
    ((if? exp) (eval-if exp env))
    ((lambda? exp) (eval-lambda exp env))
    ((let? exp) (eval-let exp env))
    ((application? exp) (apply* (eval (car exp) env)
                                (map (lambda (e) (eval e env))
                                     (cdr exp))))
    (else
      (error "unknown expression " exp))))

(define (apply* operator operands)
  (cond ((primitive? operator)
         (apply (get-scheme-procedure operator)
                operands))
        ((compound? operator)
         (eval (body operator)
               (extend-env-with-new-frame
                 (parameters operator)
                 operands
                 (env operator))))
        (else
          (error "operator not a procedure: " operator))))
