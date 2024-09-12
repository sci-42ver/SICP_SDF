(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

(cd "~/SICP_SDF/exercise_codes/SICP/2")
(load "2_3.scm")
;; Here I assume both min-val and max-val are floating numbers.
(define (random-in-range min-val max-val)
  (+ min-val (random (- max-val min-val))))
(define (random-point x1 x2 y1 y2)
  (make-point (random-in-range x2 x1) (random-in-range y2 y1)))

;; 1. See repo which doesn't use any external base implementation.
;; 2. > upper and lower bounds x1, x2, y1, and y2
(define (estimate-integral P x1 x2 y1 y2 trials)
  (define (experiment)
    (P (random-point x1 x2 y1 y2)))
  (let ((rect 
          (make-rect (make-point x2 y2) 
                    (make-point x1 y1))))
    (* (area-rect rect) (monte-carlo trials experiment))))

(define x2 0.0)
(define y2 0.0)
(define x1 3.0)
(define y1 3.0)
(load "../lib.scm")
;; See wiki GP
;; That encapsulates the following center-x/y with unit-cir
;; It also uses `unit-square` for the rectangle.
(define (unit-circle-test point)
  (let ((x (x-point point))
        (y (y-point point))
        (center-x (average x1 x2))
        (center-y (average y1 y2))
        )
    (<= (+ (square (- x center-x)) (square (- y center-y))) 1)))

(estimate-integral unit-circle-test x1 x2 y1 y2 100000)