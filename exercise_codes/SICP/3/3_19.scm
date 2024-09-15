(define (contains-cycle? lst) 
  (define (safe-cdr l) 
    (if (pair? l) 
        (cdr l) 
        '())) 
  (define (iter a b) 
    (cond 
      ;; based on until "hare = f(f(hare))" https://en.wikipedia.org/wiki/Cycle_detection#Floyd's_tortoise_and_hare
      ; ((not (pair? a)) #f) 
      ((not (pair? b)) #f) 
      ((eq? a b) #t) 
      ; ((eq? a (safe-cdr b)) #t) 
      (else (iter (safe-cdr a) (safe-cdr (safe-cdr b)))))) 
  (iter (safe-cdr lst) (safe-cdr (safe-cdr lst)))) 


; Tested with mzscheme implementation of R5RS: 
(define x '(1 2 3 4 5 6 7 8)) 
(define y '(1 2 3 4 5 6 7 8)) 
(set-cdr! (cdddr (cddddr y)) (cdddr y)) 
(define z '(1)) 
(set-cdr! z z) 
x ; (1 2 3 4 5 6 7 8) 
y ; (1 2 3 . #0=(4 5 6 7 8 . #0#)) 
z ; #0=(1 . #0#) 
(define (test func)
  (assert (not (func x))) ; #f 
  (assert (func y)) ; #t 
  (assert (func z)) ; #t 
  )
(test contains-cycle?)

;; gws
(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "../lib.scm")
;; TODO how does this work?
(define (cycle-const-space? x) 
  (displayln "new test")
  (define (iter x cont elem num) 
    (cond ((null? (cdr x)) false) 
          ((eq? x elem) true) 
          (else (if (= cont num) 
                  (iter (cdr x) 0 x (+ 1 num)) 
                  (iter (cdr x) (+ cont 1) elem num))))) 
  (trace iter)
  (iter x 0 nil 0))
(test cycle-const-space?)