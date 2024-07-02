;;; Racket trace is much more readable.
#lang racket/base

; (load "1_43.scm")
(require "1_43.rkt")
(require "../miscs_lib.rkt")
;;; from book
(define (average-damp f)
  (lambda (x) (average x (f x))))
;;; borrow from 1.36
; (define tolerance 0.0000000000000000000000001)
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      ; (displayln guess)
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (cube_root_naive x)
  (fixed-point (lambda (y) (/ x (* y y)))
               1.0))
(define (cube_root x)
  (fixed-point (lambda (y) (average y (/ x (* y y))))
               1.0))

; (cube_root_naive 27) ; x^inf, so loop between inf and 0
(displayln "sqrt_3(27):")
(cube_root 27)

(define (quartic_root_one_average x)
  (fixed-point (lambda (y) (average y (/ x (* y y y))))
               1.0))
; (quartic_root_one_average 81)

;;; check Kaihao's comment in wiki
(define (fifth_root_one_average x)
  (fixed-point (lambda (y) (average y (/ x (* y y y y))))
               1.0))
; (fifth_root_one_average 729) ; 3^6

(define (sixth_root_one_average x)
  (fixed-point (lambda (y) (average y (/ x (* y y y y y))))
               1.0))
; (sixth_root_one_average 59049) ; 3^10

;;; check the needed average-damp count
(require racket/trace)
(define (fixed_point_bound f first-guess bound)
  (define (close-enough? v1 v2)
    ; (displayln (abs (- v1 v2)))
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
            next)
          (try next (+ count 1)))))
  ; (trace try)
  (displayln "fixed_point_bound:")
  (try first-guess 1))
;; from https://sicp.readthedocs.io/en/latest/chp1/45.html
(define (expt base n)
  ; (repeated (lambda (m) (* y m)) (- n 1))
  (if (= n 0)
    1
    ((repeated (lambda (x) (* base x)) n) 1)))
; (/ 27 (expt 1.0 50))
(define (init_map x y n)
  ; (/ x (expt y (- n 1))))
  (/ x ((repeated (lambda (m) (* y m)) (- n 1)) 1)))
(define (root n x average_damp_level count init)
  ;; This is wrong https://stackoverflow.com/a/53933846/21294350
  ; (fixed-point (repeated (average-damp f) average_damp_level) 1 count))
  ; (fixed-point ((repeated average-damp average_damp_level) f) 1 count))
  ;; 1 will make exact fraction which takes much longer time. See https://stackoverflow.com/a/78087299/21294350 (I only read partially including the main "in particular you're doing arithmetic on exact rationals")
  (define transformed_f ((repeated average-damp average_damp_level) (lambda (y) (init_map x y n))))
  ; (displayln (transformed_f 1.0))
  (fixed_point_bound transformed_f init count))

(define small_bound 100)
(define big_bound 1000)
(define factor 1000.0)
(define small_init (/ 3 1000.0))
(define large_init (* 3 1000.0))
; (- (root 3 27 1 small_bound 1.0) 3)
; (- (root 3 27 2 small_bound 1.0) 3)

(define n1 5)
;; https://www.zhihu.com/question/28838814
;; m=1, n=3
;; tangent slope is n*y^{n-1}=3*3^2=27
;; here it loops between 4.32 (slope: 2^m*y^{n-1}=2*4.32^2=37.3248) and 2.50 (slope: 2*2.5^2=12.5)
; (- (root n1 (expt 3 n1) 1 small_bound small_init) 3)
; (- (root n1 (expt 3 n1) 2 big_bound small_init) 3)
; (- (root n1 (expt 3 n1) 2 small_bound large_init) 3)
; (- (root n1 (expt 3 n1) 2 big_bound small_init) 3)
; (- (root n1 (expt 3 n1) 3 small_bound large_init) 3)

(define n2 50)
(define very_big_bound 1000000)
; (define very_big_nest_level 1000000)
; (- (root n2 (expt 3 n2) 1 very_big_bound small_init) 3)
; (- (root n2 (expt 3 n2) n2 very_big_bound small_init) 3)

;;; debug why big average_damp_level will cause almost inf.
; (- (root n2 (expt 3 n2) n2 small_bound small_init) 3)
#|
Following the zhihu link formula

1. when `average_damp_level` is very large, the difference between mapping adjacent values is too small (< 0.00001 here) due to the high slope, e.g. 637621501.2140495 and 637621501.2140489.

2. when `average_damp_level` is very small, we have the following loop. Here I put the reasons behind the mapping inside the bracket pair:

2.2882799226996533 
-(due to the low slope $2^m y_k^{n-1}$)> 869130.4304532777 
-(/2: since following zhihu link formula when y=1, m=1, x>>y, y_{n+1}\approx y_n/2)> 434565.21522663883 -(/2)> 217282.60761331941
-> ... -> 1.668911759469753 -> 4526863251949.442
; when v1,v2 is very large, the original y is samll w.r.t. v1,v2. so v1-v2=v2

; (- (root n2 (expt 3 n2) 1 1.0) 3) will have `y` sequence including the loop above.

; (- (root n2 (expt 3 n2) n2 1.0) 3) will have `y` sequence:
; 1.0
; 637621501.2140495
; 637621501.2140489
|#
(- (root n2 (expt 3 n2) 1 (* small_bound 2) 1.0) 3)
(- (root n2 (expt 3 n2) n2 very_big_bound 1.0) 3)
; (- (root n2 (expt 3 n2) (floor (log n2 2)) very_big_bound 1.0) 3)
; (- (root n2 (expt 3 n2) (floor (log n2 2)) very_big_bound (- 1.0)) 3)
;; IGNORE: The following is fine outputing 1.0000000000000018
(define (average_damp_print_specific_value result level y)
  (displayln result)
  (if (= level 0)
    '()
    (average_damp_print_specific_value (average y result) (- level 1) y)))
(define y 1.0)
; (average_damp_print_specific_value (init_map 3 y n2) n2 y) ; This is wrong
; (average_damp_print_specific_value (init_map (expt 3 n2) y n2) n2 y)

;;; compare floor and ceil for log n
(define (fixed_point_output_iteration_cnt f first-guess bound)
  (define (close-enough? v1 v2)
    ; (displayln (abs (- v1 v2)))
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
            count)
          (try next (+ count 1)))))
  ; (trace try)
  (displayln "fixed_point_bound:")
  (try first-guess 1))

(define (find_floor_worse_than_ceil init_exp base count init ending_exp)
  (define (root n x average_damp_level count init)
    (define transformed_f ((repeated average-damp average_damp_level) (lambda (y) (init_map x y n))))
    (displayln "average_damp_level:")
    (displayln average_damp_level)
    (fixed_point_output_iteration_cnt transformed_f init count))
  (define n (- (expt 2 init_exp) 1)) ; this will make n-floor(n) greatest for one init_exp
  (define x (expt base n))
  (define floor_average_damp_level (floor (log n 2)))
  (define ceiling_average_damp_level (ceiling (log n 2)))
  (displayln "init_exp:")
  (displayln init_exp)
  (let ((diff (- (root n x floor_average_damp_level count init) (root n x ceiling_average_damp_level count init))))
    (if (> diff 0)
      (displayln "ceiling better")
      (displayln "floor better"))
    (if (= init_exp ending_exp)
      (displayln "finish")
      (find_floor_worse_than_ceil (+ init_exp 1) base count init ending_exp))))

; (find_floor_worse_than_ceil 2 3 very_big_bound 1.0 20) ; Here 1 will floor to 0 which is not considered in repeated.
;; the above will change from "ceiling better" to "floor better" when init_exp change from 3 to 4.
;; result will become inf when init_exp becomes 10

(find_floor_worse_than_ceil 3 3 very_big_bound 1.0 4)