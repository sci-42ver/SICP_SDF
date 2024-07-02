(define (round-prec num denom prec)
   (list 'RATIO
         (round (/ (* num (expt 10 prec)) denom))
         (expt 10 prec)))
(define (num_of_list x)
  (car (cdr x)))
(define (denom_of_list x)
  (car (cdr (cdr x))))
(define (to10thPower x_num x_denom N)
  (define x2 (round-prec (* x_num x_num) (* x_denom x_denom) N))
  (newline)
  (display x2)
  (define x4 (round-prec (* (num_of_list x2) (num_of_list x2)) (* (denom_of_list x2) (denom_of_list x2)) N))
  (define x8 (round-prec (* (num_of_list x4) (num_of_list x4)) (* (denom_of_list x4) (denom_of_list x4)) N))
  (round-prec (* (num_of_list x8) (num_of_list x2)) (* (denom_of_list x8) (denom_of_list x2)) N))
; if 100, then (+ 1e100 1) -> 1e100
(define N 500)


(do ((i 100 (- i 1))
     (x_num (+ 1e100 1) (num_of_list (to10thPower x_num x_denom N)))
     (x_denom 1e100 (denom_of_list (to10thPower x_num x_denom N))))
    ((= i 0) (list x_num x_denom))      ; maybe return the last value of the iteration
  (begin
    (newline)
    (display x_num)
    (newline)))