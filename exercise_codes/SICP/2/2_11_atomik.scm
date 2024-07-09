(load "../lib.scm")
;;; from Exercise 2.7
(define (upper-bound interval) (max (car interval) (cdr interval))) 
(define (lower-bound interval) (min (car interval) (cdr interval)))

(define (make-interval a b) 
  (if (< a b) 
    (cons a b) 
    (cons b a)))
; Warning. This is a hack. It makes no promises 
; of performance, comprehension, or maintainability. 
; It simply does what it needs to do. 

(define (generate-intervals) 
  (define test-list '()) 

  ; These lists can be edited by hand to produce different 
  ; interval sets. I try to make sure both lists contain 
  ; at least one 0 and some negative/positive numbers 
  ; with same/different values to ensure a variety of 
  ; intervals. 

  (define test-data 
    (cons (list 0 1 2 3 4 5 -6 -7 -8 -9 -10) 
          (list 5 4 3 2 1 0 -1 -2 -3 -4 -5))) 
  (for-each 
    (lambda (x) (set! test-list (append test-list x))) 
    (map    (lambda (x)     (map    (lambda (y) (make-interval x y)) 
                                    (cdr test-data))) 
            (car test-data))) 

  ; Our testing procedure will also be abusing for-each 
  ; and map to make combinations, so we take our test list 
  ; and pair it with its reverse ensure more varied 
  ; combinations of pairs. 
  (displayln (reverse test-list))
  ;; notice `(cons '(-10 . -5) '(-10 . -4))` -> `((-10 . -5) -10 . -4)`

  ;; See wiki `(cons test-list test-list)` also works since we use 2 `for-each`'s to iterate them.
  (cons test-list (reverse test-list))) 

; Capture the result of `generate-intervals` so we don't have to 
; run it again. 

(define test-intervals 
  (generate-intervals))

test-intervals

;;; test
; `test` will take two procedures, call each one 
; with the same data and compare their results. 
; We will hard-code the test-data because the 
; alternative is more than my job's worth. If 
; you want to use a different data-set, alter 
; the `generate-intervals` procedure. 

(define (test f g) 

  ; We need to define a special kind 
  ; of equality operator for intervals 

  (define (interval-equals a b) 
    (and (= (lower-bound a) (lower-bound b)) (= (upper-bound a) (upper-bound b))))
  ; (trace interval-equals)

  ; We will test every single possible combination 
  ; of pairs from either list. Thanks to the 
  ; commutativity of multiplication, this is fairly 
  ; straightforward. 
  ; If a pair passes the test, nothing gets printed 
  ; to the console, but if a pair fails, then both 
  ; the original intervals, as well as the results 
  ; of applying f and g to said intervals will be printed. 

  ;;; for-each usage https://conservatory.scheme.org/schemers/Documents/Standards/R5RS/HTML/r5rs-Z-H-9.html#%_idx_390
  ; (let ((v (make-vector 5)))
  ;   (for-each (lambda (i)
  ;               (vector-set! v i (* i i)))
  ;             '(0 1 2 3 4))
  ;   v)

  ;;; the following is corrected for its parentheses (modified)
  (for-each (lambda (x) 
              (for-each (lambda (y) 
                          ; (displayln y))
                          (cond   ((interval-equals (f x y) (g x y)) #t) 
                                  (else 
                                    (newline) 
                                    (display "failed on inputs: " ) ; corrected
                                    (display x) 
                                    (display y) 
                                    (newline) 
                                    (display (f x y)) 
                                    (display (g x y)) 
                                    (newline))))
                        (cdr test-intervals)))
            (car test-intervals)))

;; The first version of this is wrong which doesn't consider `zero? a` separately.
;; This considers a<=0<=b interval.
(define (opposite-pair? a b) 
  (cond ((positive? a) 
         (not (positive? a))) ; modified
        ((zero? a)
         #t) ; Here we consider the (0,0) interval where the result must be also (0,0)
        (else
          (not (negative? b)))))
;; This also works here since when we use `opposite-pair?` a<=b is met. 
;; Then a<=0 is catched by `(not (positive? a))` where we get a<=0<b with `(positive? b)` together.

;; Notice it drops (0 . 0) interval. But it is caught by 2 `else` in the original code.
; (define (opposite-pair? a b) 
;   (if (positive? a) 
;     (negative? b) 
;     (positive? b))) 

(define (positive-pair? a b) 
  (if (opposite-pair? a b) 
    #f 
    (positive? a)))

(define (negative-pair? a b) 
  (if (opposite-pair? a b) 
    #f 
    (negative? a))) 

(define (old-mul-interval x y) 
  (let            ((p1 (* (lower-bound x) (lower-bound y))) 
                   (p2 (* (lower-bound x) (upper-bound y))) 
                   (p3 (* (upper-bound x) (lower-bound y))) 
                   (p4 (* (upper-bound x) (upper-bound y)))) 
    (make-interval 
      (min p1 p2 p3 p4) 
      (max p1 p2 p3 p4)))) 

(define (mul-interval x y) 

  ; We will capture the boundaries 
  ; of each interval as variables 
  ; to avoid repeated function calls 

  (let        ((x0 (lower-bound x)) 
               (x1 (upper-bound x)) 
               (y0 (lower-bound y)) 
               (y1 (upper-bound y))) 

    ; At the moment, mul-interval just 
    ; passes its arguments on to 
    ; `old-mul-interval` 

    (cond   ((negative-pair? x0 x1) 
             (cond   ((negative-pair? y0 y1) 
                      (make-interval (* x0 y0) (* x1 y1)))
                     ((opposite-pair? y0 y1) 
                      (make-interval (* x0 y1) (* x0 y0)))
                     (else (make-interval (* x0 y1) (* x1 y0)))))
            ((opposite-pair? x0 x1)
             (cond   ((negative-pair? y0 y1) 
                      (make-interval (* x1 y0) (* x0 y0)))
                     ((opposite-pair? y0 y1) 
                      (let            ((p1 (* x0 y0)) 
                                       (p2 (* x0 y1)) 
                                       (p3 (* x1 y0)) 
                                       (p4 (* x1 y1))) 
                        (display "check error for ")
                        (display x)
                        (display y)
                        (displayln "")
                        (display p1)
                        (display ",")
                        (display p4)
                        (displayln "")
                        (make-interval 
                          (min p2 p3) 
                          (max p1 p4))))
                     (else (make-interval (* x0 y1) (* x1 y1)))))
            (else 
              (cond   ((negative-pair? y0 y1) 
                       (make-interval (* x0 y1) (* x1 y0)))
                      ((opposite-pair? y0 y1) 
                       (make-interval (* x1 y0) (* x1 y1)))
                      (else (make-interval (* x0 y0) (* x1 y1)))))))) 
; nothing will be printed as both procedures are basically the same. 

(test old-mul-interval mul-interval)
(old-mul-interval '(1 . 2) '(3 . 4))
