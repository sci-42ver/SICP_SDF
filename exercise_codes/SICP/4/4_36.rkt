#lang sicp
;; https://docs.racket-lang.org/sicp-manual/Installation.html

(define (require p) (if (not p) (amb)))

(define (an-integer-starting-from n)
  (amb n (an-integer-starting-from (+ n 1))))

;; misc
(define (square x)
  (* x x))

;; from wiki
(define (hypotenuse-squared i j) 
  (+ (square i) (square j))) 

(define (round-to-integer x)  
  (inexact->exact (round x))) 

(define (perfect-square? i) 
  (= i (square (round-to-integer (sqrt i))))) 

;; based on prime-sum-pair
(define (a-pythagorean-triple)
  (let* ((a (an-integer-starting-from 1))
        (b (an-integer-starting-from a))
        (square-sum (hypotenuse-squared a b)))
    (require (perfect-square? square-sum))
    (list a b (sqrt square-sum))))

;; fail since 1 has no related triple.
;; So we should have infinite only for one possible number, i.e. index the iteration process.
;; That is how wiki xdavidliu does.
; (a-pythagorean-triple)

;;; xdavidliu
;; from 4.35
(define (an-integer-between low high)  
  (require (<= low high))  
  (amb low (an-integer-between (+ low 1) high))) 

(define (a-pythagorean-triple-with-middle-fixed middle) 
  ;; no infinite for each "middle" index, but the above b will be infinite for each a...
  (let ((i (an-integer-between 1 middle))) 
    (let ((hypot2 (hypotenuse-squared i middle))) 
      (require (perfect-square? hypot2)) 
      (list i middle (sqrt hypot2)))))
(define (all-pythagorean-triples)
  ;; "index the iteration process"
  (let ((middle (an-integer-starting-from 1))) 
    (let ((triple (a-pythagorean-triple-with-middle-fixed middle))) 
      triple)))

(all-pythagorean-triples)
;; only has amb https://docs.racket-lang.org/sicp-manual/SICP_Language.html#%28form._%28%28lib._sicp%2Fmain..rkt%29._amb%29%29
; try-again
; try-again
; try-again