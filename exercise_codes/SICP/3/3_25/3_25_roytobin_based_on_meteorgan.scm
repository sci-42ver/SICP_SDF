; My implementation of the approach suggested by meteorgan at 
; http://community.schemewiki.org/?sicp-ex-3.25
;
;   "I don't think we need change the procedure make-table.
;   If we use a list as the key, all things can keep the same."
; 
; This approach is superior in every way.
;
;  - Firstly, it passes the 600 transaction torture test.
;  - The solution's lookup procedure is only three lines
;  - and the insert! procedure is only four.
;  - There are only two set!s used in the entire solution.
;  - The solution does not need recursion.
;  - Only uses scheme features introduced by SICP up to exercise 3.25
;
(define (make-table)
  (define table '())
  (define (lookup keys)
    (let ((record (assoc keys table)))
      (and record (cadr record))))
  (define (insert keys value)
    (let ((record (assoc keys table)))
      (cond (record  (set-car! (cdr record) value))
            (else    (set! table (cons (list keys value) table))))))
  (define (dispatch m)
    (cond ((eq? m 'lookup) lookup)
          ((eq? m 'insert) insert)
          (else (error "Unknown request -- NTABLE" m))))
  dispatch)
(define (insert! nt keys value)  ((nt 'insert) keys value) value)
(define (lookup  nt keys)        ((nt 'lookup) keys))

; Usage
;(define t1 (make-table))
;(insert! t1 '(a b c) 17)
;(print (lookup t1 '(a b c)))
;(print (lookup t1 '(a c)))
;(print (lookup t1 '(a b )))

(load "3_25_test_step.scm")
