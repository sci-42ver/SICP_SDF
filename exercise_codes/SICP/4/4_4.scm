(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lib.scm")

(define (and? exp)
  (tagged-list? exp 'and))
;; see wiki woofy better to pass env down.
(define (eval-and ops)
  (define (iter rest)
    (if (null? rest)
      'true ; see expand-clauses
      (let ((item (car rest)))
        (cond 
          ((false? item) item)
          ((null? (cdr rest)) (car rest))
          (else (iter (cdr rest)))
          ))))
  (iter ops)
  )

;; just add the following for `eval`:
;; ((and? exp) (eval-and (operands exp)))
;; or is similar

;; derived expressions. sc->short circuit.
;; without using derivation.
(define (test-ops ops null-val stop-test? sc-ret)
  (if (null? ops)
      null-val                          ; no else clause
      (let loop ((first (car ops))
            (rest (cdr ops)))
        (if (stop-test? first)
            (and sc-ret first)
            (if (null? rest)
              first
              (loop (car rest) (cdr rest)))))))

(define (make-test-clause test? elm consequent)
  (list (list test? elm) consequent))
;; see wiki, if is more appropriate for "short circuit" to avoid unnecessary later clauses.
(define (test-ops ops null-val stop-test? sc-ret)
  (if (null? ops)
      null-val                          ; no else clause
      (cons 'cond
        (append
          (map 
            (lambda (elm) (make-test-clause stop-test? elm (list 'and sc-ret first)))
            ops)
          (list 'else (car (last-pair ops)))
          )
        )))

(define (and->cond exp)
  (test-ops (operands exp) true false? false))
(define (or->cond exp)
  (test-ops (operands exp) false true? true))

;; woofy modification
(define (and? exp) (tagged-list? exp 'and)) 
(define (and-predicates exp) (cdr exp)) 
(define (first-predicate seq) (car seq)) 
(define (rest-predicates seq) (cdr seq)) 
(define (no-predicate? seq) (null? seq))
(define (eval-and-predicates exps env) 
  (if (no-predicate? exps)
    true
    (let ((first (eval (first-predicate exps) env))
          (rest (rest-predicates exps)))
      (cond 
        ((not (true? first)) false)
        ((null? rest) first)
        (else (eval-and-predicates rest env))
        )
      )))

(define (display-ret ret)
  (display (list "return" ret))
  ret)
;; here just use scheme internal eval to test although this is not one full test for nested and.
;; But based on induction, if non-nested and work, then nested one should also work.
(define e 2)
(define test-exp1 '(and (display-ret 1) (display-ret e) (display-ret #f) (display-ret e)))
(define test-exp2 '(and (display-ret 1) (display-ret e)))
(define test-exp3 '(and (display-ret false) (display-ret e) (display-ret #f) (display-ret e)))
;; from x3v test
(define test-exp4 '(and (display-ret false) (display-ret false)))
(define test-lst (list test-exp1 test-exp2 test-exp3 test-exp4))
(define (test proc test-lst env)
  (for-each 
    (lambda (exp) 
      (display 
        (proc (and-predicates exp) env))
      (newline))
    test-lst
    ))
(test eval-and-predicates test-lst (the-environment))
;; 1. no duplicate display 2. short circuit expectedly 3. the 2nd returns 2 expectedly.
; (return 1)(return 2)(return #f)#f
; (return 1)(return 2)2
; (return #f)#f
; (return #f)#f

(define (expand-and-predicates predicates env)
  (if (no-predicate? predicates) 
      'true 
       (let  
        ;; to avoid "evaluate any predicate twice" 
        ((first (eval (first-predicate predicates) env)) 
          (rest (rest-predicates predicates))) 
        ;; to avoid expanding and then doing eval for all elements unnecessarily. 
        (if first 
          ;; since we don't introduce more variables here, so no "name shadowing". 
          (make-if  
            first 
            (if (null? rest) 
              ;; "returns the correct value". 
              first 
              (expand-and-predicates rest env))
            'false)
          'false)
          )))
(test expand-and-predicates test-lst (the-environment))
;; notice here `(if 2 false false)` doesn't keep expanding further to `(if 2 (if false ...) false)`.
; (return 1)(return 2)(return #f)(if 1 (if 2 false false) false)
; (return 1)(return 2)(if 1 (if 2 2 false) false)
;; here false is transformed to #f by MIT/GNU Scheme.
; (return #f)false
; (return #f)false

(define (expand-or-predicates predicates env)
  (if (no-predicate? predicates) 
      'false 
      (let  
        ((first (eval (first-predicate predicates) env)) 
          (rest (rest-predicates predicates))) 
        (if first 
          first
          (make-if  
            first 
            first 
            (expand-or-predicates rest env))))))
(test expand-or-predicates test-lst (the-environment))
; (return 1)1
; (return 1)1
; (return #f)(return 2)(if #f #f 2)
; (return #f)(return #f)(if #f #f (if #f #f false))