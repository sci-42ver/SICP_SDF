(load "../lib.scm")
(define (make-segment point_1 point_2)
  (cons point_1 point_2))
(define (start-segment line)
  (car line))
(define (end-segment line)
  (cdr line))

;; almost same as the above but with one different naming
(define (make-point coordinate_1 coordinate_2)
  (cons coordinate_1 coordinate_2))
(define (x-point point)
  (car point))
(define (y-point point)
  (cdr point))

(define (midpoint-segment line)
  ;; See wiki and repo. Better use let to where `start_pnt` etc. are used.
  (define start_pnt (start-segment line))
  (define end_pnt (end-segment line))
  (make-point (average (x-point start_pnt) (x-point end_pnt))
              (average (y-point start_pnt) (y-point end_pnt))))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(print-point
  (midpoint-segment
    (make-segment
      (make-point 0 0)
      (make-point 2 2))))
