(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "4_41.scm")
;; put after to avoid overloading apply too early.
(load "amb-lib.scm")
;; Let this be primitive, since general map using *apply* is not easy be implemented in evaluator.
;; @return columns
(define combine*
  (lambda (xs . ys*)
    (cond
      ((null? ys*) (map list xs))
      ((null? (cdr ys*)) (combine xs (car ys*)))
      (else (concat/map xs (lambda (x)
                             (map (lambda (y) (cons x y))
                                  ;; modified
                                  (apply-in-underlying-scheme combine* ys*))))))))
(define (all-combinations n)
  (apply-in-underlying-scheme combine* (make-list n (iota-from-1 n))))
; (all-combinations 8)
;Aborting!: out of memory
;; This also happens for meteorgan's permutations, i.e. `(permutations (make-list 8 (iota-from-1 8)))`, 
;; since the problem is due to storing 8*8^8 numbers are too large for 16GB memory (actually 10GB due to others being used by other softwares).
;; Although actually to store these numbers by 32bit int only uses 0.5GB=8*8**8*32/(8*1024*1024*1024)GB
;; So this exhaustion method is not feasible.

(define primitive-procedures (cons (list 'all-combinations all-combinations) primitive-procedures))
(define the-global-environment (setup-environment))

(driver-loop)
(define (require p)
  (if (not p) (amb)))
(define (distinct? items) 
  (cond ((null? items) true) 
        ((null? (cdr items)) true) 
        ((member (car items) (cdr items)) false) 
        (else (distinct? (cdr items)))))
(define (an-element-of items)
  (require (not (null? items)))
  (amb (car items) (an-element-of (cdr items))))

;; 0. here just do filter for all board-size^board-size cases without using induction.
;; i.e. just avoids flatmap (induction)
;; 1. similar to multiple-dwelling
(define (queens board-size)
  ;; check both diagonal and anti-diagonal
  (define (check-diagonal lst)
    (define (check-car base rest steps)
      (let ((base-downward (+ base steps))
            (base-upward (- base steps)))
        (let ((base-downward-reach-limit (> base-downward board-size))
              (base-upward-reach-limit (< base-upward 1)))
          (or
            (null? rest)
            (and
              ;; By searching "or", this short circuit seems to not exist in wiki.
              (or base-downward-reach-limit (not (= (car rest) base-downward)))
              (or base-upward-reach-limit (not (= (car rest) base-upward)))
              (or 
                (and base-downward-reach-limit base-upward-reach-limit) 
                (check-car base (cdr rest) (+ 1 steps)))
              ))
            )))
    (define (iter rest)
      (or (null? rest) ; finish traversal
        (and
          (check-car (car rest) (cdr rest) 1)
          (iter (cdr rest))
          )))
    (iter lst)
    )
  ;; 0. Here we can use map with (iota-from-1 n) to have the same interface as 2_42, i.e. (row col).
  ;; For simplicity, col is assumed to increase by one each step.
  ;; 1. amb is not procedure. so how to do (amb (to-args (all-combinations board-size))) where to-args is what to be done when apply.
  ;; As r20 hints, use an-element-of
  (let ((rows (an-element-of (all-combinations board-size))))
    (require (distinct? rows))
    (require (check-diagonal rows))
    rows
    )
  )
(queens 2)
try-again
;; 2 https://ajayiyengar.com/2020/07/27/how-to-solve-the-4-queens-puzzle-in-java/#:~:text=Solution%20to%20the%204%20queens%20problem&text=With%20the%20constraints%20mentioned%20above,row%2C%20same%20column%20or%20diagonal.
(queens 4)
try-again
try-again
try-again
(queens 8) ; fail due to memory exhaustion caused by (all-combinations board-size)