(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "Lazy_Evaluation_lib.scm")

; setup environment E0 for lazy evaluator 
(define E0 (setup-environment)) 

; (lazy-evaluator) cons constructor procedure 
(actual-value '(define (cons a d) (lambda (m) (m a d))) E0) 

; (lazy-evaluator) car selector procedure 
(actual-value '(define (car z) (z (lambda (a d) a))) E0) 

; (lazy-evaluator) cdr selector procedure 
(actual-value '(define (cdr z) (z (lambda (a d) d))) E0) 

; max-length definition                                         ;! 
(define max-length 8) 

; max-depth definition                                          ;! 
(define max-depth 4) 

; cons? predicate procedure                                     ;! 
; Or, "A 'cons' by any other name would construct as neat." 
(define (cons? object) 
  (and (compound-procedure? object) 
      (equal? (procedure-parameters object) '(m)) 
      (equal? (procedure-body object) '((m a d))))) 

; cons-print procedure                                          ;! 
(define (cons-print object length depth) 
  (let ((env (procedure-environment object))) 
    (let ((a (force-it (lookup-variable-value 'a env))) 
          (d (force-it (lookup-variable-value 'd env)))) 
      (if (= length max-length) 
          (display "(") 
          (display " ")) 
      (cond ((zero? length) (display "...")) 
            ((zero? depth) (display "...")) 
            ((cons? a) (lazy-print a max-length (- depth 1))) 
            (else (lazy-print a length depth))) 
      (cond ((zero? length) (display ")")) 
            ((zero? depth) (display ")")) 
            ((null? d) (display ")")) 
            ((cons? d) (lazy-print d (- length 1) depth)) 
            (else (display " . ") 
                  (lazy-print d (- length 1) depth) 
                  (display ")")))))) 

; lazy-print procedure                                          ;! 
(define (lazy-print object length depth) 
  (cond ((cons? object) 
        (cons-print object length depth)) 
        ((compound-procedure? object) 
        (display (list 'compound-procedure 
                        (procedure-parameters object) 
                        (procedure-body object) 
                        '<procedure-env>))) 
        (else (display object)))) 

; user-print procedure                                          ;! 
(define (user-print object) (lazy-print object max-length max-depth)) 

;; added
(map (lambda (name obj) 
       (define-variable!  name (list 'primitive obj) E0)) 
     (list 'raw-cons 'raw-car 'raw-cdr) 
     (list cons car cdr))
(load "test-lib.scm")
(define user-print-general user-print)

(run-program-list 
  '((cons 1 2)
    ;; won't work for original lazy lib since `(cons 1 ones)` will be run then ones will be forced before cons due to primitive.
    (define ones (cons 1 ones))
    ones
    ;; infinite car
    ; p158
    (define (accumulate op initial sequence)
      (if (null? sequence)
        initial
        (op (raw-car sequence)
            (accumulate op initial (raw-cdr sequence)))))
    (define many-cars (accumulate (lambda (elm res) (cons res elm)) ones (iota 20)))
    many-cars
    ; '(a b (c d))
    (cons 'a (cons 'b (cons (cons 'c (cons 'd '())) '())))
    (cons 'a (cons 'b (cons 'c '())))
    )
  E0)