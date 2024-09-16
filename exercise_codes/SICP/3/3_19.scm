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
  ; (trace iter)
  (iter x 0 nil 0))
(test cycle-const-space?)

;; wiki AntonKolobov
(define (has-cycle? tree)
  ;; Helpers 
  (define (iterator value idx) 
    (cons value idx)) 
  (define (update-iterator it value idx) 
    (set-car! it value) 
    (set-cdr! it idx)) 
  (define (iterator-id it) 
    (cdr it)) 
  (define (iterator-value it) 
    (car it)) 
  (define (iterator-same-pos? it1 it2) 
    (eq? (iterator-id it1) (iterator-id it2))) 
  (define (iterator-eq? it1 it2) 
    (and (iterator-same-pos? it1 it2) 
         (eq? (iterator-value it1) (iterator-value it2)))) 
  (define (iterator-same-value? it1 it2) 
    (eq? (iterator-value it1) (iterator-value it2))) 

  ;; slow-it - tracks each node (1, 2, 3, 4...) 
  ;; fast-it - tracks only even nodes (2, 4...) 
  (let ((slow-it (iterator tree 0)) 
        (fast-it (iterator '() 0)) 
        (clock-cnt 0)) 
    (define (dfs root)
      (displayln (list "clock-cnt" clock-cnt))
      (if (not (pair? root)) ; leaf as the base case.
        false 
        (begin
          (set! clock-cnt (+ clock-cnt 1))
          ;; Here the minimal step is 2 clock-cnt's.
          ;; Still work since x_i=x_{2i} -> x_{2i}=x_{4i}, so if x_{2i}!=x_{4i} -> x_i!=x_{2i} -> not have cycle.
          ;; And trivially x_{2i}=x_{4i} -> have cycle.
          (if 
            (and (even? clock-cnt) 
                 (iterator-same-pos? slow-it fast-it)) 
            ; (odd? clock-cnt)
            (begin
              (displayln "update slow-it")
              (update-iterator slow-it root clock-cnt))) 
          (if (even? clock-cnt) 
            (update-iterator fast-it root 
                             (+ (iterator-id fast-it) 1)
                             ; clock-cnt
                             )) 
          (if 
            (iterator-eq? slow-it fast-it) 
            ; (iterator-same-value? slow-it fast-it)
            true 
            (or (dfs (car root)) 
                (dfs (cdr root))))))) 
    (trace dfs)
    (dfs tree)))

(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "3_18_19_tests.scm")
; (test has-cycle?)
; (assert (has-cycle? cycle-1))

(define (has-cycle? tree) 
  ;; Helpers 
  (define (iterator value idx) 
    (cons value idx)) 
  (define (update-iterator it value idx) 
    (set-car! it value) 
    (set-cdr! it idx)) 
  (define (iterator-id it) 
    (cdr it)) 
  (define (iterator-value it) 
    (car it)) 
  (define (iterator-same-pos? it1 it2) 
    (eq? (iterator-id it1) (iterator-id it2))) 
  (define (iterator-eq? it1 it2) 
    (and (iterator-same-pos? it1 it2) 
        (eq? (iterator-value it1) (iterator-value it2)))) 

  ;; slow-it - tracks each node (1, 2, 3, 4...) 
  ;; fast-it - tracks only even nodes (2, 4...) 
  (let ((slow-it (iterator tree 0)) 
        (fast-it (iterator '() 0)) 
        (clock-cnt 0)) 
    (define (dfs root) 
      (if (not (pair? root)) 
          false 
          (begin 
            (set! clock-cnt (+ clock-cnt 1)) 
            (if (and (even? clock-cnt) 
                    (iterator-same-pos? slow-it fast-it)) 
                (update-iterator slow-it root clock-cnt)) 
            (if (even? clock-cnt) 
                (update-iterator fast-it root 
                                (+ (iterator-id fast-it) 1))) 
            (if (iterator-eq? slow-it fast-it) 
                true 
                (or (dfs (car root)) 
                    (dfs (cdr root))))))) 
    (dfs tree))) 