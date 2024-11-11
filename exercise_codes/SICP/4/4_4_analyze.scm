(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))
(define (and? exp)
  (tagged-list? exp 'and))
(define (or? exp)
  (tagged-list? exp 'or))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; wiki dummy
;; procedures to extract the parts of the expressions 
(define (and-clauses exp) (cdr exp)) 
(define (or-clauses exp) (cdr exp)) 
(define (first-exp seq) (car seq)) 
(define (rest-exp seq) (cdr seq)) 
(define (empty-exp? seq) (null? seq)) 
(define (last-exp? seq) (null? (cdr seq))) 

(define (and->if exp) 
  (expand-and-clauses (and-clauses exp))) 

(define (expand-and-clauses clauses) 
  (cond ((empty-exp? clauses) 'true) 
        ((last-exp? clauses) (first-exp clauses)) 
        (else (make-if (first-exp clauses) 
                      (expand-and-clauses (rest-exp clauses)) 
                      'false)))) 

(define (or->if exp) 
  (expand-or-clauses (or-clauses exp))) 

(define (expand-or-clauses clauses) 
  (cond ((empty-exp? clauses) 'false)
        ;; > all expressions evaluate to false
        ;; here if false, directly return that false value, i.e. false in MIT/GNU Scheme.
        ((last-exp? clauses) (first-exp clauses)) 
        (else (make-if (first-exp clauses) 
                      (first-exp clauses)
                      (expand-or-clauses (rest-exp clauses))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; test from 4_4.scm
(define (display-ret ret)
  (display (list "return" ret))
  ret)
(define e 2)
(define test-exp1 '(and (display-ret 1) (display-ret e) (display-ret #f) (display-ret e)))
(define test-exp2 '(and (display-ret 1) (display-ret e)))
(define test-exp3 '(and (display-ret false) (display-ret e) (display-ret #f) (display-ret e)))
;; from x3v test
(define test-exp4 '(and (display-ret false) (display-ret false)))
; (define test-exp5 '(and (begin (define x 3) (display-ret x)) (display-ret (* x x))))
(define test-lst (list test-exp1 test-exp2 test-exp3 test-exp4))
(define (test proc test-lst env)
  (for-each 
    (lambda (exp) 
      (display 
        (proc exp env))
      (newline))
    test-lst
    ))

; (test (lambda (exp env) (eval (and->if exp) env)) test-lst (the-environment))

;; Here test-exp5 will be
; (if (begin (define x 3) (display-ret x))
;   (if (display-ret (* x x))
;     (display-ret (* x x))
;     false)
;   false)
;; that won't work.
;; It should be
; (define x 3)
; (if (display-ret x)
;   (if (display-ret (* x x))
;     (display-ret (* x x))
;     false)
;   false)

(define (show-expand expand-proc test-lst)
  (for-each 
    (lambda (exp) 
      (display 
        (expand-proc exp))
      (newline))
    test-lst
    ))
; (show-expand and->if test-lst)
; (show-expand or->if test-lst)
