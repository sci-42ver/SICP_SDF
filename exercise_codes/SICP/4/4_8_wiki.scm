;; just abstract related things from 4_8_pure_lambda.scm.
(cd "~/SICP_SDF/exercise_codes/SICP/4")
(define old-apply apply)
(load "lib.scm")
(define apply old-apply)

;; wiki
(define (named-let? expr) (and (let? expr) (symbol? (cadr expr))))
(define (named-let-func-name expr) (cadr expr)) 
;; from http://community.schemewiki.org/?sicp-ex-4.6 to be compatible with named-let.
(define (let? exp) (tagged-list? exp 'let))
(define (let-bindings exp)  
  (if (named-let? exp)
    (caddr exp)
    (cadr exp)))

(define (let-vars expr) (map car (let-bindings expr))) 
(define (let-inits expr) (map cadr (let-bindings expr)))

(define (let-body exp)
  (if (named-let? exp)
    (cdddr exp)
    (cddr exp)))

(define (let->combination expr) 
  (let ((main-body 
          (make-lambda (let-vars expr) 
              (let-body expr))))
    (cons 
      (if (named-let? expr) 
        ;; modified
        (let 
          ((Z '(lambda (r)
                ((lambda (f) (f f))
                  (lambda (y)
                    ;  (r (lambda (x) ((y y) x)))
                    (r (lambda args (apply (y y) args)))
                    )))))
          (list Z 
            (make-lambda 
              (list (named-let-func-name expr))
              (list main-body)
              )))
        main-body)
      (let-inits expr))))

;; test
(define test-exp 
  '(let fib-iter ((a fib-iter)
                 (b 0)
                 (count n))
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1)))))
(assert
  (equal? 
    (let->combination test-exp)
    '(((lambda (r) ((lambda (f) (f f)) (lambda (y) (r (lambda args (apply (y y) args)))))) 
      (lambda (fib-iter) 
        (lambda (a b count) (if (= count 0) b (fib-iter (+ a b) a (- count 1))))))
      fib-iter 0 n)))

(define n 5)
(define fib-iter 1)
;; 1. When Scheme runs the following, operator and operands for Z application are evaluated *independently*.
;; 2. from book
;; > We also specify that defining a symbol using define creates a binding in the current environment frame
;; So no binding in GE.
;; 3. env 
;; (naming convention: 
;; a. env1x has env1 as the enclosing environment. Similar for others.
;; b. l-r means (lambda (r) ...) and lambda-(fib-iter) means (lambda (fib-iter) ...).
;; c. a->b means a is binded to b.
;; d. ): 
;; env1 (application of l-r created in GE): r-> lambda-(fib-iter)
;; env11 (application of l-f created by l-r): f-> l-y
;; env12 (application of l-y created by l-r): y-> l-y.
;; env2 (application of r/lambda-(fib-iter) created in GE): fib-iter-> l-args.
;; env21 (application of lambda-(a b count) created by lambda-(fib-iter)): a b count-> 1 0 n.
;; Then recursively call fib-iter possibly, by creating one new frame enclosed by GE.
;; 4. https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Procedure-Call-Syntax.html
;; > The operator and operand expressions are evaluated and the resulting procedure is passed the resulting arguments.
;; So "operator and operand" should be "evaluated" in the same env.
;; Then we think of (Z ...) as one proc, then (1 0 n) should be evaluated in GE.
(assert 
  (= 5 (((lambda (r) ((lambda (f) (f f)) (lambda (y) (r (lambda args (apply (y y) args)))))) 
      (lambda (fib-iter) 
        (lambda (a b count) (if (= count 0) b (fib-iter (+ a b) a (- count 1))))))
      fib-iter 0 n)))