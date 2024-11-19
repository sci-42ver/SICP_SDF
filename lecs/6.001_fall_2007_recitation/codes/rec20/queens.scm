;; use syntax here
(cd "~/SICP_SDF/lecs/6.001_fall_2007_recitation/codes/rec20/amb-defined-by-syntax/")
;; not set! in on branch, so fine to use syntax.
(load "amb-sfu.scm")

(define (distinct? items) 
  (cond ((null? items) true) 
        ((null? (cdr items)) true) 
        ((member (car items) (cdr items)) false) 
        (else (distinct? (cdr items)))))
(define (except n lst)
  (filter (lambda (x) (not (eq? x n))) lst))
(define (enumerate-interval l u)
  (if (> l u) '()
    (cons l (enumerate-interval (+ l 1) u))))

;; from sol
(define (generate-board size)
  (map
    (lambda (x)
      (an-element-of (enumerate-interval 1 size)))
    (enumerate-interval 1 size)))
(define (queens n generate-board-proc)
  (define (safe? board)
    ;; check conflict with former cols
    (define (check-col i)
      (if (= i n) #t
        (let ((row (list-ref board i)))
          (if (safe-vs row (- i 1) 1)
            (check-col (+ i 1))
            #f))))
    (define (safe-vs row col offset)
      (cond ((< col 0) #t)
            ((= (+ row offset) (list-ref board col)) #f)
            ((= (- row offset) (list-ref board col)) #f)
            (else (safe-vs row (- col 1) (+ offset 1)))))
    (check-col 1))
  (let ((board (generate-board-proc)))
  ; (let ((board (generate-board 8)))
    (require
      (distinct? board))
    (require (safe? board))
    board))
;; do this to try one new problem
(reset-fail)
;; too slow.
; (queens 8 (lambda () (generate-board 8)))
(queens 4 (lambda () (generate-board 4)))
;; reverse of the following dp since here amb starts from the 1st elem to the last
;; while dp is from the last to the 1st due to recursive calls.
; (2 4 1 3)

;;; similar to wiki closeparen
(define (a-permutation-of s) 
  (define (amb-permutations s) 
    (define (proc x) 
      (map (lambda (p) (cons x p)) (amb-permutations (delete x s)))) 

    (define (iter sequence) 
      (if (null? sequence) 
        (amb) 
        (amb (proc (car sequence)) 
             (iter (cdr sequence))))) 

    (if (null? s) 
      (list '()) 
      ;; each time it will only choose one (proc (car sequence)) etc. Then based on induction, (proc x) will be len-1.
      (iter s)
      )) 

  ; (car (amb-permutations s))
  (amb-permutations s)
  )
(reset-fail)
(a-permutation-of (iota 8))
(amb)
(amb)

;; since we only need one, no need for outer list wrapper
(define (a-permutation-of s) 
  (define (amb-permutations s) 
    (define (proc x)
      ;; mod
      (cons x (amb-permutations (delete x s)))) 

    (define (iter sequence) 
      (if (null? sequence) 
        (amb) ; we have tried all possible 1st elems for s, so call fail for the next possible parent alternative.
        (amb (proc (car sequence)) 
             (iter (cdr sequence))))) 

    (if (null? s) 
      '() ; mod
      (iter s))) 

  ;; mod
  (amb-permutations s)
  )
(reset-fail)
(a-permutation-of (iota 8))
(amb)
(amb)
(reset-fail)
(queens 8 (lambda () (a-permutation-of (map (lambda (x) (+ x 1)) (iota 8)))))

;;; dp
(define (upto k)
  (enumerate-interval 1 k))
(define (n-queens-dp n k) 

  (define (choices rest-of-board) 
    (define (conflicts-diagonal? x op board) 
      (cond ((null? board) false) 
            ((= (car board) x) true) 
            (else (conflicts-diagonal? (op x) op (cdr board))))) 

    (define (good-choice choice) 
      (cond ((memq choice rest-of-board) false) 
            ;; similar check as woofy
            ((conflicts-diagonal? 
               (- choice 1) 
               (lambda (x) (- x 1)) 
               rest-of-board) 
             false) 
            ((conflicts-diagonal? 
               (+ choice 1) 
               (lambda (x) (+ x 1)) 
               rest-of-board) 
             false) 
            (else true))) 

    (filter good-choice (upto k))) 

  (if (= n 0) 
    '()   
    (let ((rest-of-board (n-queens-dp (- n 1) k))) 
      ;; As queens-iterate-cols implies, here we can either think of this as cols or rows.
      (cons (an-element-of (choices rest-of-board)) 
            rest-of-board)))) 
(reset-fail)
(n-queens-dp 8 8)
; (4 2 7 3 6 8 5 1)
(reset-fail)
(n-queens-dp 4 4)
; (3 1 4 2)

;;; dp modified
(define (n-queens n) 

  (define (ensure board) ; added
    (define (ensure-choice choice rest-of-board) ; modified.
      ;; these 2 helpers are unchanged
      (define (conflicts-diagonal? x op board) 
        (cond ((null? board) false) 
              ((= (car board) x) true) 
              (else (conflicts-diagonal? (op x) op (cdr board))))) 

      (define (good-choice choice) 
        (cond ((memq choice rest-of-board) false) 
              ((conflicts-diagonal? (- choice 1) 
                                    (lambda (x) (- x 1)) rest-of-board) false) 
              ((conflicts-diagonal? (+ choice 1) 
                                    (lambda (x) (+ x 1)) rest-of-board) false) 
              (else true))) 
      ;; mod
      (or (null? rest-of-board)
        (and (good-choice choice)
          (ensure-choice (car rest-of-board) (cdr rest-of-board)))))
    (ensure-choice (car board) (cdr board))
    ) 
  
  (if (= n 0) 
      '()   
      ;; mod
      ;; You can also change this to use combination and add distinct? test.
      (let ((board (a-permutation-of (map (lambda (x) (+ x 1)) (iota n)))))
        (require (ensure board))
        board
        )     
      ))
(reset-fail)
(n-queens 1) 
(reset-fail)
(n-queens 4)
(reset-fail)
(n-queens 8)
