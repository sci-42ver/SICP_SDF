; https://stackoverflow.com/questions/78597962/1-01e-100-1-in-mit-scheme/78626541#comment138620051_78597962
(define (round-prec num denom prec)
   (list 'RATIO
         (round (/ (* num (expt 10 prec)) denom))
         (expt 10 prec)))
(define (num_of_list x)
  (car (cdr x)))
(define (denom_of_list x)
  (car (cdr (cdr x))))
(define (to10thPower x_num x_denom N)
  ; (display (* x_num x_num))
  (define x2 (round-prec (* x_num x_num) (* x_denom x_denom) N))
  (newline)
  (display x2)
  (num_of_list x2)
  (define x4 (round-prec (* (num_of_list x2) (num_of_list x2)) (* (denom_of_list x2) (denom_of_list x2)) N))
  (define x8 (round-prec (* (num_of_list x4) (num_of_list x4)) (* (denom_of_list x4) (denom_of_list x4)) N))
  x8
  (round-prec (* (num_of_list x8) (num_of_list x2)) (* (denom_of_list x8) (denom_of_list x2)) N))
; (define x_num (+ 1e100 1))
; (define x_denom 1e100)
(define N 500)
; (* x_num x_num)
; (trace denom_of_list)
; (trace num_of_list)
; (round-prec (* x_num x_num) (* x_denom x_denom) N)
; (to10thPower x_num x_denom 100)

; https://stackoverflow.com/a/9313028/21294350
; (let loop ((times 100))
;    (if (= times 1)
;      (to10thPower x_num x_denom 100)
;      (begin (display "still looping...")
;             ; https://stackoverflow.com/a/10838225/21294350
;             (set! x_num (num_of_list (to10thPower x_num x_denom 100)))
;             (set! x_denom (denom_of_list (to10thPower x_num x_denom 100)))
;             (loop (- times 1)))))

; https://stackoverflow.com/a/3199603/21294350 https://stackoverflow.com/a/47850141/21294350
(do ((i 100 (- i 1))
     (x_num (+ 1e100 1) (num_of_list (to10thPower x_num x_denom N)))
     (x_denom 1e100 (denom_of_list (to10thPower x_num x_denom N))))
    ((= i 0) (list x_num x_denom))      ; maybe return the last value of the iteration
  (begin
    (newline)
    (display x_num)
    (newline)
    (display i)
    (newline)))