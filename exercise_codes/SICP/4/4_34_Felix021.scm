(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "Lazy_Evaluation_lib.scm")

;; based on 4-33 

(map (lambda (name obj) 
       (define-variable!  name (list 'primitive obj) the-global-environment)) 
     (list 'raw-cons 'raw-car 'raw-cdr) 
     (list cons car cdr)) 

(actual-value 
  '(begin 

     (define (cons x y) 
       (raw-cons 'cons (lambda (m) (m x y)))) 

     (define (car z) 
       ((raw-cdr z) (lambda (p q) p))) 

     (define (cdr z) 
       ((raw-cdr z) (lambda (p q) q))) 
     ) 
  the-global-environment) 

;; here depth means tree width.
(define (disp-cons obj depth)
  ; (bkpt "debug0")
  (letrec ((user-car (lambda (z) 
                       (force-it (lookup-variable-value 'x (procedure-environment (cdr z)))))) 
           (user-cdr (lambda (z) 
                       (force-it (lookup-variable-value 'y (procedure-environment (cdr z))))))) 
    ; (bkpt "debug")
    (cond 
      ((>= depth 10) 
       (display "... )")) 
      ((null? obj) 
       (display "")) 
      (else 
        (let ((cdr-value (user-cdr obj))) 
          (display "(") 
          ;; This may have infinite tree depth.
          (user-print-wrapper (user-car obj) (+ depth 1)) 
          (if (tagged-list? cdr-value 'cons) 
            (begin 
              (display " ") 
              (disp-cons cdr-value (+ depth 1))) 
            (if (not (null? cdr-value))
              (begin 
                (display " . ") 
                (display cdr-value)))) 
          (display ")")))))) 

(define (user-print-wrapper object depth)
  (if (tagged-list? object 'cons)
    (disp-cons object depth)
    (user-print object) ))

(define (user-print object) 
  (if (compound-procedure? object) 
    (display 
      (list 'compound-procedure 
            (procedure-parameters object) 
            (procedure-body object) 
            '<procedure-env>)) 
    (if (tagged-list? object 'cons) 
      (disp-cons object 0) 
      (display object)))) 

; (driver-loop)
(load "test-lib.scm")
(define user-print-general user-print)

;; http://community.schemewiki.org/?sicp-ex-4.30
(run-program-list 
  '((cons 1 2)
    ;; `integers` is with the same structure, i.e. one non-nested list.
    (define ones (cons 1 ones))
    ones
    ;; SICP p158
    (define (accumulate op initial sequence)
      (if (null? sequence)
        initial
        (op (raw-car sequence)
            (accumulate op initial (raw-cdr sequence)))))
    ;; so many cars
    (define many-cars (accumulate (lambda (elm res) (cons res elm)) ones (iota 20)))
    many-cars
    (cons 'a (cons 'b (cons (cons 'c (cons 'd '())) '())))
    (cons 'a (cons 'b (cons 'c '())))
    )
  the-global-environment)
; (1 . 2)ok(1 (1 (1 (1 (1 (1 (1 (1 (1 (1 ... )))))))))))okok((((((((((... ) . 9) . 8) . 7) . 6) . 5) . 4) . 3) . 2) . 1) . 0)(a (b ((c (d)))))(a (b (c)))
