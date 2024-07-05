#lang racket/base
;;; from the above wiki
(define (average-damp f) 
  (lambda (x) (/ (+ x (f x)) 2)))
(define (repeated f n) 
  (define (compose f g) 
    (lambda (x) (f (g x)))) 
  (if (= n 1) 
    f 
    (compose f (repeated f (- n 1)))))

;;; from book
(define tolerance 0.00001)

;;; small modified fixed_point
(define (displayln x)
  (newline)
  (display x))
(define (fixed_point_bound f first-guess bound whether_output_cnt)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess count)
    (let ((next (f guess)))
      (displayln guess)
      (if (or (close-enough? guess next) (= count bound))
        (begin 
          (displayln "finished count:")
          (displayln count)
          (displayln guess)
          (displayln next)
          (if whether_output_cnt
            count
            next))
        (try next (+ count 1)))))
  (displayln "fixed_point_bound:")
  (try first-guess 1))

(define small_bound 100)
(define (init_map x y n) 
  (/ x ((repeated (lambda (m) (* y m)) (- n 1)) 1))) 
(define (root n x average_damp_level bound init whether_output_cnt) 
  (define transformed_f ((repeated average-damp average_damp_level) (lambda (y) (init_map x y n)))) 
  (displayln "average_damp_level:")
  (displayln average_damp_level)
  (fixed_point_bound transformed_f init bound whether_output_cnt)) 
(define n2 50) 
(- (root n2 (expt 3 n2) 1 (* small_bound 2) 1.0 #f) 3) 
(- (root n2 (expt 3 n2) n2 small_bound 1.0 #f) 3)

; (- (root n2 (expt 3 n2) 1 1.0) 3) will have `y` sequence including the loop above. 

; (- (root n2 (expt 3 n2) n2 1.0) 3) will have `y` sequence: 
; 1.0 
; 637621501.2140495 
; 637621501.2140489 

;;; compare floor and ceil for log n
(define (log_base base n)
  (/ (log n) (log base)))
(define (find_floor_worse_than_ceil init_exp base count init ending_exp)
  (define n (- (expt 2 init_exp) 1)) ; this will make n-floor(n) greatest for one init_exp
  (define x (expt base n))
  (define floor_average_damp_level (inexact->exact (floor (log_base 2 n))))
  (define ceiling_average_damp_level (inexact->exact (ceiling (log_base 2 n))))
  (displayln "init_exp:")
  (displayln init_exp)
  (let ((diff (- (root n x floor_average_damp_level count init #t) (root n x ceiling_average_damp_level count init #t))))
    (if (> diff 0)
      (displayln "ceiling better")
      (displayln "floor better"))
    (if (= init_exp ending_exp)
      (displayln "finish")
      (find_floor_worse_than_ceil (+ init_exp 1) base count init ending_exp))))

(define big_bound (* small_bound 3))
(find_floor_worse_than_ceil 2 3 small_bound 1.0 10) ; Here 1 will floor to 0 which is not considered in repeated.
;; the above will change from "ceiling better" to "floor better" when init_exp change from 3 to 4.
;; result will become inf (in Racket)/nan (in ) when init_exp becomes 10

; (find_floor_worse_than_ceil 3 3 (* small_bound 10) 1.0 4)
