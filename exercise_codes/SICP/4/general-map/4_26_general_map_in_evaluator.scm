;;; 4_31_dot_list_for_4_26.scm with unnecessary things removed

;; Notice not to load lib.scm more than once, otherwise apply-in-underlying-scheme will not be underlying apply.
(load "4_4.scm")
;; to be compatible with the following apply.
(load "Lazy_Evaluation_lib.scm")
(define or-predicates and-predicates)
(define (or? exp)
  (tagged-list? exp 'or))
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
        ;; added
        ((and? exp) (eval (expand-and-predicates (and-predicates exp) env) env))
        ((or? exp) (eval (expand-or-predicates (or-predicates exp) env) env))
        ;; for #f compatibility
        ; ((true? exp) true)
        ; ((false? exp) false)
        ((eq? '#t exp) true)
        ((eq? '#f exp) false)
        ;; modified
        ((application? exp)
         (apply (actual-value (operator exp) env)
                (operands exp)
                env))
        (else
          (error "Unknown expression type -- EVAL" exp)
         )))

;; To load run-program-list definition. See http://community.schemewiki.org/?sicp-ex-4.30
(load "test-lib.scm")

(define test-exp-2
  '((define nil '())
    ;; See general-map.scm for why we must need this here.
    (define unary-map
      (lambda (proc items)
        (if (null? items)
            nil
            (cons (proc (car items))
                  (unary-map proc (cdr items))))))
    (define map
      (lambda (proc having-ensured-equal-len #!rest items)
        ;; based on env model, we use the env of map here for map body.
        (if (or having-ensured-equal-len (direct-apply = (unary-map length items) (cadddr map)))
            (if (null? (car items))
              nil
              (begin
                (cons (direct-apply proc (unary-map car items) (cadddr map))
                    ;; 1. follow the apply structure in evaluator
                    ;; 2. apply will eval `(cons ...)` by list-of-arg-values due to primitive, then 
                    ;; it has "(unary-map cdr items)" being one evaled list.
                    ;; Then when apply-primitive-procedure apply, it will call the same apply again...
                    ;; So we have (apply (procedure ...) ((procedure ...) true ...) env)
                    ;; TODO Then ((procedure ...) true ...) will be reevaluated...
                    ;; 2.1 So we use direct-apply.
                    ;; 2.2 Here explicitly set items to one list.
                    ;; Otherwise, items (proc #f ((#t #f #t #t))) -> (proc #t (#f #t #t))
                    (direct-apply map (cons proc (cons #t (list (unary-map cdr items)))) (cadddr map))
                    ))
              )
            'arg-error)))
    (define select-y '(#t #f #t #t))
    (define xs '(1 3 5 7))
    (define ys '(2 4 6 8))
    ;; added
    (define (unless condition usual-value exceptional-value)
      (if condition exceptional-value usual-value))
    (define selected (map (lambda (pred x y) (unless pred x y)) #f select-y xs ys))
    selected
    ))

(define (apply procedure arguments env)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure
          procedure
          (list-of-arg-values arguments env)))
        ((compound-procedure? procedure)
         (eval-sequence
          (procedure-body procedure)
          ;; changed
          (let ((parameters (procedure-parameters procedure)))
            (extend-environment
              (parameter-names parameters)
              (interpret-vars-for-vals parameters arguments env #f)
              (procedure-environment procedure)))))
        (else
         (error
          "Unknown procedure type -- APPLY" procedure))))

;; assume arguments have been evaled
(define (direct-apply procedure arguments env)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure
          procedure
          arguments))
        ((compound-procedure? procedure)
         (eval-sequence
          (procedure-body procedure)
          ;; changed
          (let ((parameters (procedure-parameters procedure)))
            (extend-environment
              (parameter-names parameters)
              arguments
              (procedure-environment procedure)))))
        (else
         (error
          "Unknown procedure type -- APPLY" procedure))))

(define (parameter-names parameters)
  (remove (lambda (param) (eq? param '#!rest)) parameters))

;; not think about the complex list parsing https://stackoverflow.com/q/78800750/21294350.
;; So use #!rest which doesn't allow nested arguments.
; ((lambda (a . (b . c))
;   (display (list a b c))) 1 2 3 4 5)
; ((lambda (a #!rest (b #!rest c))
;   (display (list a b c))) 1 2 3 4 5)

(define (interpret-vars-for-vals vars vals env check-vals-cnt)
  (if (or check-vals-cnt (>= (length vals) (- (length vars) 1)))
    (if (null? vars)
      '()
      (let ((var (car vars))
            (val (car vals))
            )
        (cond 
          ((eq? '#!rest var)
            (if (= 2 (length vars))
              (cons (list-of-arg-values vals env) '())
              (error "#!rest should be followed by only one var")))
          (else
            (cons 
              (interpret-var-for-val var val env)
              (interpret-vars-for-vals (cdr vars) (cdr vals) env #t))))))
    (error "vals too less")
    ))

(define (interpret-var-for-val var val env)
  (actual-value val env))

;; Use direct-apply above
(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        (list 'square (lambda (x) (* x x)))
        (list 'square-twice (lambda (x) (square (square x))))
        (list 'first car)
        ;; 4.24
        (list '= =)
        (list '- -)
        (list '* *)
        (list '<= <=)
        (list '+ +)
        (list 'display display)
        ;; 4.26. See 4.14 for why we don't define here.
        ; (list 'map map)
        ; (list 'nil '())
        (list 'length length)
        (list 'direct-apply direct-apply)
        (list 'cadddr cadddr)
        
        ;; 4.29
        (list 'remainder remainder)
        (list '/ /)
        ;; 4.30
        (list 'list list)
        (list 'newline newline)
        ))
(define the-global-environment (setup-environment))

(run-program-list test-exp-2 the-global-environment)
; ok
; ... (many ok's)
; (2 3 6 8)