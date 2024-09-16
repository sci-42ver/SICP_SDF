;; similar to exercise 3.17 
;; wrong
(define (has-cycle? x) 
  (let ((encountered '())) 
    (define (helper x) 
      (if (memq x encountered)
        #t
        (begin 
          (set! encountered (cons (car x) encountered)) 
          (helper (cdr x)))))
  (helper x)))
;; similar to book test
; (define cycle (cons 1 2))
; (set-cdr! cycle (car cycle))

; (has-cycle? cycle)
;; wrong.
; (define normal-list (list 1 1))
; (has-cycle? normal-list)

;; See wiki the above lacks many cases.
;; 1. `(not (pair? lst))` for normal case like `(1 2)`
;; 2. `(set! encountered (cons lst encountered)) ...` for (set-cdr! cycle cycle)

(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "../lib.scm")
;; wiki anonymous 2
(define (contains-cycle? x) 
  (define(inner return) 
    (let((C '())) 
      (define (loop lat) 
        (set! C (cons lat C))
        (displayln (list "loop" lat C))
        (cond 
          ((not (pair? lat)) (return #f)) 
          (else 
            (if (memq (car lat) C) 
                (return #t) 
                (begin 
                  (set! C (cons (car lat) C)) 
                  (if(pair? (car lat)) 
                    (or (contains-cycle? (car lat)) 
                          (loop (cdr lat))) 
                    (loop (cdr lat)))))))) 
      (loop x))) 
  (call/cc inner))
(define t1 (cons 'a 'b)) 
(define t2 (cons t1 t1))
(contains-cycle? t2)

(load "3_18_19_tests.scm")
; (contains-cycle? cycle-1)

(define (contains-cycle? x) 
  (let((C '())) 
    (define (loop lat) 
      (set! C (cons lat C))
      (displayln (list "loop" lat C))
      (cond 
        ((not (pair? lat)) #f) 
        (else 
          (if (memq (car lat) C) 
              #t
              (begin 
                (set! C (cons (car lat) C)) 
                (if(pair? (car lat)) 
                  (or (contains-cycle? (car lat)) 
                        (loop (cdr lat))) 
                  (loop (cdr lat)))))))) 
    (loop x)))
(contains-cycle? t2)

; (call-with-current-continuation
;   (lambda (exit)
;     (for-each (lambda (x)
;                 (if (negative? x)
;                     (exit x)))
;               '(54 0 37 -3 245 19))
;     #t))

;; wiki gws
(define (cycle? x) 
  (define visited nil) 
  (define (iter x) 
    (set! visited (cons x visited)) 
    (cond ((null? (cdr x)) false) 
          ((memq (cdr x) visited) true) 
          (else (iter (cdr x))))) 
  (iter x))
(define book-testcase (make-cycle (list 'a 'b 'c)))
(cycle? book-testcase)

;; assume x is nested lists without pairs.
(define (cycle? x) 
  (define visited nil) 
  (define (iter x) 
    (set! visited (cons x visited)) 
    (cond ((null? (cdr x)) false) 
          ((memq (cdr x) visited) true) 
          (else 
            (or 
              (if (pair? (car x))
                (cycle? (car x))
                #f)
              (iter (cdr x)))))) 
  (iter x))

;; all tests
(test cycle?)

;; fail since the loop does cdr->car (here we get back) -> cdr ... This is not cdr-ing down.
; (cycle? cycle-1)

;; wiki mbndrk
;; Main idea: DFS.
(load "../set-lib.scm")
(define (inf_loop? L) 
  (define (iter items trav) 
    (cond ((not (pair? items)) #f) 
          ; ((eq? (cdr items) items) #t) 
          ((eq? (car items) (cdr items)) 
            (iter (cdr items) trav)) 
          ;; notice to use eq?
          ((element-of-set-eq? (car items) trav) #t) 
          ((element-of-set-eq? (cdr items) trav) #t) 
          (else  
          (if (not (pair? (car items))) 
              (iter (cdr items) (cons items trav)) 
              (or (iter (car items) (cons items trav)) 
                  (iter (cdr items) (cons items trav))))))) 
  (iter L '()))

(test inf_loop?)
(assert (inf_loop? cycle-1))