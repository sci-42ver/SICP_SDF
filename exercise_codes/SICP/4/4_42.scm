(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lib/amb/amb-lib.scm")
(driver-loop)

;; i.e. xor
;; https://stackoverflow.com/a/4715330/21294350 same complexity as https://en.wikipedia.org/wiki/XOR_gate#AND-OR-Invert left.
(define (only-one a b)
  (and (not (and a b)) (or a b)))
;; almost same structure as multiple-dwelling.
(define (exam-rank)
  (let ((Betty (amb 1 2 3 4 5))
        (Ethel (amb 1 2 3 4 5))
        (Joan (amb 1 2 3 4 5))
        (Kitty (amb 1 2 3 4 5))
        (Mary (amb 1 2 3 4 5)))
    (require
      (distinct? (list Betty Ethel Joan Kitty Mary)))
    
    (require (only-one (= Kitty 2) (= Betty 3)))
    (require (only-one (= Joan 2) (= Ethel 1)))
    (require (only-one (= Joan 3) (= Ethel 5)))
    (require (only-one (= Kitty 2) (= Mary 4)))
    (require (only-one (= Mary 4) (= Betty 1)))
    
    (list (list 'Betty Betty)
          (list 'Ethel Ethel)
          (list 'Joan Joan)
          (list 'Kitty Kitty)
          (list 'Mary Mary))))
(define (require p)
  (if (not p) (amb)))
(define (distinct? items)
  (cond ((null? items) true)
        ((null? (cdr items)) true)
        ((member (car items) (cdr items)) false)
        (else (distinct? (cdr items)))))

(exam-rank)
try-again
; try-again
; try-again
; try-again
; try-again
