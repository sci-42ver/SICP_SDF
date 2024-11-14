;; lib
(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))
(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))
(define (sequence->exp seq)
  (cond ((null? seq) seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))))
(define (last-exp? seq) (null? (cdr seq)))
(define (first-exp seq) (car seq))
(define (rest-exps seq) (cdr seq))
(define (make-begin seq) (cons 'begin seq))

;; > uses the same data structures, syntax procedures
;; http://community.schemewiki.org/?sicp-ex-4.6
(define (let? expr) (tagged-list? expr 'let)) 
(define (let-vars expr) (map car (cadr expr))) 
(define (let-inits expr) (map cadr (cadr expr))) 
(define (let-body expr) (cddr expr)) 

(define (let->combination expr) 
  (cons (make-lambda (let-vars expr) (let-body expr)) 
        (let-inits expr)))

; (map car '())
; (let->combination '(let () (display 1)))
; ((lambda () (display 1)))

;; add to analyse
; ((let? exp) (analyze-let exp))

;; similar to wiki meteorgan's.
(define (analyze-let expr)
  (analyze-application (let->combination expr)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; also add named-let
;; from wiki meteorgan
(define (named-let? expr) (and (let? expr) (symbol? (cadr expr)))) 

(define (named-let-func-name expr) (cadr expr)) 

;; modified
(define (named-let-func-body expr) (cdddr expr)) 

(define (named-let-func-parameters expr) (map car (caddr expr))) 

(define (named-let-func-inits expr) (map cadr (caddr expr))) 

;; modified
(define (named-let->func expr) 
    (cons 'define  
          (cons 
            (cons (named-let-func-name expr) (named-let-func-parameters expr)) 
            (named-let-func-body expr)
            ))) 

(define (let->combination expr) 
    (if (named-let? expr) 
        ;; also work when as if-consequent.
        (sequence->exp 
          (list (named-let->func expr) 
                (cons (named-let-func-name expr) (named-let-func-inits expr)))) 
        (cons (make-lambda (let-vars expr) (let-body expr)) ; modified 
              (let-inits expr)))) 

(let->combination
  '(let fib-iter ()
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1)))))
; (begin 
;   (define (fib-iter) (if (= count 0) b (fib-iter (+ a b) a (- count 1))))
;   (fib-iter))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; let* from 4_7
(define (let*? expr) (tagged-list? expr 'let*)) 
(define (let*-body expr) (sequence->exp (cddr expr))) 
(define (let*-inits expr) (cadr expr)) 
(define (let*->nested-lets expr) 
  (let ((inits (let*-inits expr)) 
        (body (let*-body expr))) 
    (define (make-lets exprs) 
      (if (null? exprs) 
        body 
        (list 'let (list (car exprs)) (make-lets (cdr exprs))))) 
    (make-lets inits))) 
(define (analyze-let* expr)
  (analyze (let*->nested-lets expr)))