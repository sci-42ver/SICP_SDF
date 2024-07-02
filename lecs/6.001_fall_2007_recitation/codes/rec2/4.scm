; (a)
(define biggie-size
  (lambda (x) 
    ; https://stackoverflow.com/a/4030505/21294350
    (if (and (<= x 4) (> x 0))
      (+ x 4)
      "error")))
(biggie-size 3)
(biggie-size 7)
(biggie-size 11)
; (b) similar to (a)
; (c)
(define biggie-size?
  (lambda (x) 
    ; https://stackoverflow.com/a/4030505/21294350
    (if (and (<= x 8) (>= x 5))
      #t
      #f)))
(biggie-size? 1)
(biggie-size? 5)
(biggie-size? 9)
; (d)
(define normal-size?
  (lambda (x) 
    ; https://stackoverflow.com/a/4030505/21294350
    (if (and (<= x 4) (>= x 1))
      #t
      #f)))
(define combo-price
  (lambda (x) 
    ; https://stackoverflow.com/a/4030505/21294350
    (if (biggie-size? x)
      (+ 0.5 (combo-price (- x 4))) ; O(1) space since at most 2 iterations
      (if (normal-size? x)
        (* x 1.17)
        0))))
(combo-price -3)
(combo-price 1)
(combo-price 5)
(combo-price 9)
; (e)
(define empty-order
  ; here can't let 0 be ' '. https://stackoverflow.com/a/17308922/21294350
  ; better use nil https://stackoverflow.com/a/9115801/21294350
  (lambda () '()))
(empty-order)
; (f)
(define add-to-order
  (lambda (x y) 
    (+ (* x 10) y)))
(add-to-order 1 2)
(add-to-order 12 2)
; (g) https://stackoverflow.com/a/46964914/21294350
(define (order-size n)
  (+ 1 (floor (/ (log n) (log 10))))
  )
(order-size 237)

; (define (fact n)
;   (cond
;     ((= n 1) 1)
;     (else (* n (fact (- n 1))))
;   )
; )

; (define (length n)
;   (+ 1 (floor (/ (log n) (log 10))))
; )

; only in racket
; (time (length (fact 10000)))

; (h)
; (define (order-cost order)
;   ; https://www.cs.utexas.edu/ftp/garbage/cs345/schintro-v14/schintro_54.html https://stackoverflow.com/a/42458512/21294350
;   (let (
;       (size (order-size order))
;       )
;     ; (= size (order-size order))
;     (define (digit_combo order digit)
;       (quotient (remainder order (expt 10 digit)) (expt 10 (- digit 1))))
;     ; https://groups.csail.mit.edu/mac/ftpdir/scheme-7.4/doc-html/scheme_3.html
;     (do ((cost 0 (+ cost (combo-price (digit_combo order digit)))) ; O(1) space since no call to self, i.e. no stack accumulation.
;           (digit 1 (+ digit 1)))
;         ((> digit size) cost))
;     ; mit-scheme no while 
;     ; (while (<= digit size)
;     ;   (= cost (+ cost (combo-price (digit_combo order digit))))
;     ;   (= digit (+ digit 1))
;     ; )
;     ))

; This follows the lecture iterative pattern
(define (order-cost order)
  (define max (order-size order))
  (define (digit_combo order digit)
    (combo-price (quotient (remainder order (expt 10 digit)) (expt 10 (- digit 1)))))
  (define (helper cost order digit max)
    (if (> digit max)
      cost
      (helper (+ cost (digit_combo order digit)) order (+ digit 1) max))) ; O(1) space
  (helper 0 order 1 max) ; if this is put in the above define of helper -> Unspecified return value error https://stackoverflow.com/a/47999614/21294350
  )

; (define (order-cost order)
;   (if (< order 10)
;     (combo-price order)
;     (+ (combo-price (remainder order 10)) (order-cost (quotient order 10))))) ; O(order-size) space
(order-cost 237)
(= (order-cost 237) (+ (combo-price 2) (+ (combo-price 3) (combo-price 7))))
(= (order-cost 0237) (+ (combo-price 2) (+ (combo-price 3) (combo-price 7))))
