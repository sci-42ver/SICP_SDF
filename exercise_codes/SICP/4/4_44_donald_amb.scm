(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "amb-lib.scm")
(driver-loop)
;; amb-misc-lib.scm
(define (require p)
  (if (not p) (amb)))
(define (an-integer-between low high)  
  (require (<= low high))  
  (amb low (an-integer-between (+ low 1) high)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; donald
; (define (enumerate-interval l h) 
;   (if (> l h) 
;       '() 
;       (cons l (enumerate-interval (+ l 1) h)))) 
;;; added
;; from book
(define nil '())
(define map
  (lambda (proc items)
    (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items))))))
(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))
;; from http://community.schemewiki.org/?sicp-ex-4.41
;; As book p167 shows, here result should be assumed to be all lists, so all append.
(define (flatmap proc li) 
  (if (null? li) 
      '() 
      (let ((result (proc (car li))) 
            (rest (flatmap proc (cdr li)))) 
        (if (pair? result) 
            (append result rest) 
            (cons result rest))))) 

(define empty-board '()) 
(define (adjoin-position row col rest) 
  (cons (list row col) rest)) 
(define (exclude item lst) 
  (define (scan items) 
    (cond ((null? items) 
           '()) 
          ((equal? item (car items)) 
           (scan (cdr items))) 
          (else (cons (car items) (scan (cdr items)))))) 
  (scan lst)) 
(define (safe? col positions) 
  (define (iter l) 
    (if (null? l) 
      true 
      (and (car l) (iter (cdr l)))))
  (let ((row (caar (filter (lambda (p) 
                             (eq? col (cadr p))) 
                           positions)))) 
    (iter (map (lambda (p) 
                 (not (or (eq? row (car p)) 
                          (eq? (- row col) (- (car p) (cadr p))) 
                          (eq? (+ row col) (+ (car p) (cadr p)))))) 
               (exclude (list row col) positions)))))
;; searching order is same as 2.42 where we begin to choose row for col-8, then col-7,6...
(define (queens board-size) 
  (define (queen-cols k) 
    (if (= k 0) 
      (list empty-board)
      ;; just same structure as 2.42!
      (map (lambda (positions)
            ;  (display positions)
            ;; IGNORE: TODO what if some position are not met, does this mean (queen-cols k) returns less elements?
             (require (safe? k positions))
             positions) 
           ;; no flatmap since each time we only add one case by an-integer-between.
           (map (lambda (rest-of-queens) 
                      (adjoin-position (an-integer-between 1 board-size) k
                                       rest-of-queens))
                    ;; this may return nothing due to require above. 
                    ;; IGNORE: But since queens have one solution for n!=2,3 (here n means board-size) cases https://qr.ae/p2lhvG, we can always assume this will return one valid value.
                      ;; For n=2, (queen-cols 0/1) both works fine. So
                    ;; But that's fine since amb evaluator will stops at the nothing (queen-cols (- k 1)) if possible.
                    ;; This is also shown in trace of (queens 2) where (queen-cols 1) is first *chosen* to be (((1 1))) 
                    ;; where (1 1) means the 1st queen pos, ((1 1)) means the 1x1 board, (((1 1))) means only one possible layout.
                    ;; But queen-2 has no feasible position when queen-1 is at (1 1), so backtrack and then (queen-cols 1) becomes (((2 1))).
                    ;; Again queen-2 has no feasible position. So queen-1 positions have been iterated through but with no valid final result.
                    ;; So ";;; There are no more values of..."
                    (queen-cols (- k 1)))))) 
  (queen-cols board-size))
; (queens 8)
; (((4 8) (2 7) (7 6) (3 5) (6 4) (8 3) (5 2) (1 1)))

; (queens 1)
; try-again
; (queens 2)
; (queens 3)
; (map (lambda (rest-of-queens) 
;         (adjoin-position (an-integer-between 1 3) 3
;                           rest-of-queens))
;       ;; this may return nothing due to require above. But since 
;       (queens 2))
; (queens 4)
; (map (lambda (num) (require (> num 2))) (iota 5)) ; fail earlier
; (map (lambda (num) (require (< num 2)) num) (iota 2)) ; work