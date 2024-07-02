(define (fast-mul a b)
  (define (double x) (+ x x))
  (define (halve x) (/ x 2))
  (define (even? n)
    (= (remainder n 2) 0))
  (define (fast-mul-iter a b n)
    (cond ((= n 0) a)
          ((even? n) (fast-mul-iter a (double b) (halve n)))
          ; This combines wiki `(/ (- N 1) 2)` into one line.
          (else (fast-mul-iter (+ a b) (double b) (quotient n 2)))))
  (fast-mul-iter 0 a b))
(fast-mul 3 9)
;;; > Isn't this version just skipping ahead to the next one, Exercise 1.18?
;;; I mistakenly understand "Exercise 1.17" since it doesn't need "iterative".

;;; > Doesn't this accomplish the same thing but more efficiently?
;;; borrowed from iterative.
;;; > Not sure it changes about efficiency
;;; at least avoid accumulating `double` in the stack

;;;
(define (double x) (+ x x))
(define (halve x) (/ x 2))

(define (fast-* a b) 
  (cond ((= b 1) 
         a) 
        ((even? b) 
         (double (fast-* a (halve b)))) 
        (else 
          ;; similar to `(* a b) (square b)` in 1.16
          (+ a (double (fast-* a (halve (- b 1)))))))) 
(fast-* 3 7)
