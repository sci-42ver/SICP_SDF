(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lib.scm")

;; meteorgan modification
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

(define test-exp 
  '(let* ((x 3)
       (y (+ x 2))
       (z (+ x y 5)))
  (* x z)))
(define (test)
  (assert 
    (equal? '(let ((x 3)) (let ((y (+ x 2))) (let ((z (+ x y 5))) (* x z)))) 
      (let*->nested-lets test-exp)))
  (assert 
    (equal? '(let ((x 1)) (let ((y 2)) (begin x y))) 
      (let*->nested-lets '(let* ((x 1) (y 2)) x y))))
  (assert 
    (equal? '(begin x y) 
      (let*->nested-lets '(let* () x y))))
  )
(test)

;; same as wiki mazj.
(define (let*-body expr) (cddr expr))
(define (let*->nested-lets expr)
  (let ((inits (let*-inits expr))
        (body (let*-body expr)))
    (define (make-lets exprs)
      (if (null? exprs)
        (cons 'begin body)
        ;; modified
        (let ((rest (cdr exprs)))
          (if (null? rest)
              (append (list 'let (list (car exprs))) body)
              (list 'let (list (car exprs)) (make-lets rest))))
        ))
    (make-lets inits)))
; (test)
; (let ((x 3)) (let ((y (+ x 2))) (let ((z (+ x y 5))) (* x z))))
; (let ((x 1)) (let ((y 2)) x y))
; (begin x y)

;; 3pmtea
(define (let-args exp) (cadr exp)) 
(define (let-body exp) (cddr exp)) 
(define (make-let args body) (cons 'let (cons args body))) 

; (trace make-let)
(define (let*->nested-lets exp) 
  (define (reduce-let* args body) 
    (if (null? args) 
        (sequence->exp body) ; changed
        (make-let (list (car args)) 
                  (list (reduce-let* (cdr args) body))))) 
  (reduce-let* (let-args exp) (let-body exp)))
(let-body test-exp)
(test)

;; fold
(define (let*->nested-lets exp)                                                                                                                                               
  (define (wrap def exp)                                                                                                                                                     
    (list 'let (list def) exp))                                                                                                                                         
  (let ((bindings (cadr exp))                                                                                                                                         
        (body (sequence->exp (cddr exp))))                                                                                                                                                 
    (fold-right wrap body bindings)))
(test)