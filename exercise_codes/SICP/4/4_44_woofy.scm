(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "amb-lib.scm")
(driver-loop)
(define (require p)
  (if (not p) (amb)))
(define (an-integer-between low high)  
  (require (<= low high))  
  (amb low (an-integer-between (+ low 1) high)))
(define nil '())
(define binary-map
  (lambda (proc items1 items2)
    (define (iter proc items1 items2)
      (if (null? items1)
        nil
        (cons (proc (car items1) (car items2))
              (binary-map proc (cdr items1) (cdr items2)))))
    (if (not (= (length items1) (length items2)))
      (error (list "wrong arg" items1 items2))
      (iter proc items1 items2))
    ))

(define (no-conflict col board board-col-lower-bound board-col-upper-bound) ; modified
    (define (iter next k skip-check-base-downward skip-check-base-upward) ; modified
        (or (null? next) 
            ;; modified
            (let ((base-downward (or skip-check-base-downward (+ col k)))
                  (base-upward (or skip-check-base-upward (- col k))))
              (let ((base-downward-reach-limit (or skip-check-base-downward (> base-downward board-col-upper-bound)))
                    (base-upward-reach-limit (or skip-check-base-upward (< base-upward board-col-lower-bound))))
                (and
                  (not (= (car next) col))
                  ;; By searching "or", this short circuit seems to not exist in wiki.
                  (or base-downward-reach-limit (not (= (car next) base-downward)))
                  (or base-upward-reach-limit (not (= (car next) base-upward)))
                  (iter (cdr next) (+ k 1) base-downward-reach-limit base-upward-reach-limit) ; since "(= (car next) col)" is always possible.
                  )))
                )) 
    (iter board 1 false false)) 

; searching order is that we begin to choose col for row-1, then row-2,3...
(define (queens n) 
    (define (iter row result) 
        (if (= row n)
            ;; 0. to be compatible with 2.42
            ;; 1. Actually by the original program meaning, here result is (col-of-row-8 col-of-row-7 ...)
            ;; But since it is fine to filp up and down for the board and still get one valid board layout 
            ;; (this is due to the above restrictions about col/diagonal are still met which can be intuitively got by drawing the figure. Strict maths proof is also possible IMHO).
            ;; So "(+ row 1) (+ col 1)" here.
            (display (binary-map (lambda (row col) (list (+ row 1) (+ col 1))) (iota n) result))
            (let ((upper-bound (- n 1)))
              (let ((col (an-integer-between 0 upper-bound))) 
                (require (no-conflict col result 0 upper-bound))
                ;; modified for the above until (= row n)
                (iter (+ row 1) (cons col result)))))) 
    (iter 0 '()))

; same as 4_44.scm
(define (queens-iterate-cols n) 
    (define (iter col result) 
        (if (= col n)
            ;; 0. use the outer reverse to have the same form as 2.42.
            ;; 1. (reverse result) to have the original interpretation instead of doing flip.
            (display (reverse (binary-map (lambda (row col) (list (+ row 1) (+ col 1))) (reverse result) (iota n))))
            (let ((upper-bound (- n 1)))
              (let ((row (an-integer-between 0 upper-bound))) 
                (require (no-conflict row result 0 upper-bound))
                (iter (+ col 1) (cons row result)))))) 
    (iter 0 '()))

(queens 8)
; ((1 4) (2 2) (3 7) (4 3) (5 6) (6 8) (7 5) (8 1))
try-again
try-again
try-again
try-again
try-again

(queens-iterate-cols 8)
; ((4 8) (2 7) (7 6) (3 5) (6 4) (8 3) (5 2) (1 1))
(queens-iterate-cols 10)