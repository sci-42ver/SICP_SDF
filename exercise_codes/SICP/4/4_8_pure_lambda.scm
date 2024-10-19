(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "4_8_Y_combinator.scm")

(define (fib n)
  (let fib-iter ((a 1)
                 (b 0)
                 (count n))
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1)))))

(define n 5)
;; Here if we don't define Z by just substituting it with its lambda definition.
;; When Scheme runs the following, operator and operands for Z application are evaluated *independently*.
;; IGNORE: So no name clash will be caused by Z.
  ;; Then we can just think that lambda-(fib-iter) is passed as arg r to Z,
  ;; Then application of Z will return (r l-args) (i.e. lambda-(a b count)) where l-args is arg fib-iter.
(define fib-iter 1)
((Z
  (lambda (fib-iter)
  ;; the above 2 levels are added.
    (lambda (a b count)
      ;; copy of body
      (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1)))
    ))) fib-iter 0 n)
;; > We also specify that defining a symbol using define creates a binding in the current environment frame
;; So no binding in GE.
;; env: 
;; env1 (application of l-r created in GE): r-> lambda-(fib-iter)
;; env11 (application of l-f created by l-r): f-> l-y
;; env12 (application of l-y created by l-r): y-> l-y.
;; env2 (application of r/lambda-(fib-iter) created in GE): fib-iter-> l-args.
;; env21 (application of lambda-(a b count) created by lambda-(fib-iter)): a b count-> 1 0 n.
;; Then recursively call fib-iter possibly, by creating one new frame enclosed by GE.

;; https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Procedure-Call-Syntax.html
;; > The operator and operand expressions are evaluated and the resulting procedure is passed the resulting arguments.
;; So "operator and operand" should be "evaluated" in the same env.
;; Then we think of (Z ...) as one proc, then (1 0 n) should be evaluated in GE.

;; the original let
; ((lambda (a b count)
;   ;; copy of body
;   (if (= count 0)
;     b
;     (fib-iter (+ a b) a (- count 1)))
;   ) 1 0 n)

;; inchmeal's error
; ((lambda () 
;   (define fib-iter
;     (lambda (a b count)
;       (if (= count 0)
;         b
;         (fib-iter (+ a b) a (- count 1))))
;     )
;   (fib-iter fib-iter 0 n)
;   ))
;; https://chat.stackoverflow.com/transcript/message/57699973#57699973
;; no use since we redefine one global value *temporarily*.
;; so "probably shouldn't be done anyway" to use one global variable (i.e. to be more lexical).
((lambda () 
  (letrec 
    ((fib-iter (lambda (a b count)
      (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1))))))
    (fib-iter fib-iter 0 n))
  ))

;; modification based on meteorgan's
(define old-apply apply)
(load "lib.scm")
(define apply old-apply)

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

(((lambda (r) ((lambda (f) (f f)) (lambda (y) (r (lambda args (apply (y y) args)))))) 
      (lambda (fib-iter) 
        (lambda (a b count) (if (= count 0) b (fib-iter (+ a b) a (- count 1))))))
      fib-iter 0 n)