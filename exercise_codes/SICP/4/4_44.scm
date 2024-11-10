;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Comment contained in wiki for 4_44_unfeasible_method.scm, 4_44_woofy.scm, 4_44.scm, 
; (cd "~/SICP_SDF/exercise_codes/SICP/2")
; (load "2_42.scm")
;; We should follow the *efficient* structure in 2.42.
;; i.e. at least similar to the nested let structure in 4.40.

(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "amb-lib.scm")
(driver-loop)
(define (require p)
  (if (not p) (amb)))
(define (an-integer-between low high)  
  (require (<= low high))  
  (amb low (an-integer-between (+ low 1) high)))

(define (queens board-size)
  ;; similar to 2.42
  (define row car)
  (define col cadr)
  (define make-pos list)
  ;; similar to 2.42
  (define (check-row pos1 pos2)
    (not (= (row pos1) (row pos2))))
  ;; from 2.42
  (define (check-anti-diagonal pos-1 pos-2)
    (define (row-minus-col pos)
      (- (row pos) (col pos)))
    (not (= (row-minus-col pos-1) (row-minus-col pos-2))))

  (define (check-diagonal pos-1 pos-2)
    (define (row-plus-col pos)
      (+ (row pos) (col pos)))
    (not (= (row-plus-col pos-1) (row-plus-col pos-2))))

  ;; 1. correspond to safe?
  ;; 1.a. IMHO it is more efficient to directly compare the addition with the former ones instead of filtering(donald)/selecting(mine in 2_42) the addition after insertion and then doing the comparison.
  ;; 1.b. both uses customized iter/accumulate(mine in 2_42, actually still iter...) to ensure all conditions are met.
  ;; 2. almost same as wiki woofy's but that uses implicit row index, i.e. similar to check-car above.
  ;; But it doesn't need iter above due to induction.
  (define (check former-positions pos)
    ;; since true, so can use or as wiki woofy's.
    (if (null? former-positions)
      true
      (let ((pos1 (car former-positions)))
        (and
          (check-row pos1 pos)
          (check-diagonal pos1 pos)
          (check-anti-diagonal pos1 pos)
          (check (cdr former-positions) pos)
          ))
      ))
  ;; searching order is that we begin to choose row for col-1, then col-2,3...
  (define (iter former-positions col-idx)
    (if (> col-idx board-size)
      former-positions
      (let ((current (make-pos (an-integer-between 1 board-size) col-idx)))
        (require (check former-positions current))
        (iter (cons current former-positions) (+ 1 col-idx))
        )))
  (iter '() 1)

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; original version attempt.
  ;; See donald for the correct one.
  ; (define (queen-cols k)  
  ;   (if (= k 0)
  ;     (list empty-board)
  ;     ; (filter
  ;     ;   (lambda (positions) (safe? k positions))
  ;     ;   (flatmap
  ;     ;     (lambda (rest-of-queens)
  ;     ;       (map (lambda (new-row)
  ;     ;              (adjoin-position new-row k rest-of-queens))
  ;     ;            (enumerate-interval 1 board-size)))
  ;     ;     (queen-cols (- k 1))))
  ;     ;; but how to choose "positions"? (same problem as "(apply amb (all-combinations board-size))")
  ;     (let ((positions 
  ;             (adjoin-position (an-integer-between 1 board-size) k (an-element-of (queen-cols (- k 1))))))
  ;       (require (safe? k positions))
  ;       positions
  ;       )
  ;     ))
  ; ;; Due to the nondeterministic paradigm, here only one val is returned...
  ; ;; So the original structure can't be used.
  ; (queen-cols board-size)
  )
;; same results as 2.42 but here is iterative while 2.42 is recursive.
;; Why iterative and recursive have the same traversal ordering?
;; As the above shows, iterative will use the 1st row for col-1, then 1st row for col-2,3...
;; Then if fails, we use 1st row for col-1,2...,7 but 2nd row for col-8. The rest can be done similarly.
;; For recursive, we must get (queen-cols (- k 1)) value... so the 1st "(an-integer-between 1 board-size)" is *also* done for col-1
;; So they have the *same* traversal ordering.
(queens 8)
; ((4 8) (2 7) (7 6) (3 5) (6 4) (8 3) (5 2) (1 1))