#lang racket

(define (recursive_f n)
  (if (< n 3)
    n
    (+ (recursive_f (- n 1)) (* 2 (recursive_f (- n 2))) (* 3 (recursive_f (- n 3))))))

#|
Compare this with (foo n) in wiki
it first check `(< n 3)` -> n (i.e. the following `((< n 2) n)`)
and then call recursively where `(< n1 3)` must be `(= n1 2)`.

Same as the 1st "another iterative solution".
|#
(define (iterative_f n_1 n_2 n_3 n)
  (cond 
    ((< n 2) n)
    ((= n 2) n_1)
    (else (iterative_f (+ n_1 (* 2 n_2) (* 3 n_3)) n_1 n_2 (- n 1)))))

(require racket/trace)
(trace recursive_f)
(trace iterative_f)

(recursive_f 10)
; (iterative_f 0 1 2 10)
(iterative_f 2 1 0 10)

;;; wiki

(define (f n) 
  (cond ((< n 3) n) 
    (else (+ (f (- n 1)) 
             (* 2 (f (- n 2))) 
             (* 3 (f (- n 3))))))) 
(f 10)
(f 10.1)

(define (f_iter n)
  ;; This is better for abstraction
  (define (f-i a b c count) 
    (cond ((< n 3) n) 
      ; ((<= count 0) a) ; "handle non-integer values" partly
      ((and (>= count 0) (< count 1)) a) ; "handle non-integer values"
      (else (f-i (+ a (* 2 b) (* 3 c)) a b (- count 1)))))
  (trace f-i)
  ; (f-i 2 1 0 (- n 2))) 
  (define decimal (- n (round n)))
  (f-i (+ 2 decimal) (+ 1 decimal) decimal (- n 2))) ;
(trace f_iter)
(f_iter 10)
(f_iter 10.1)

;;; Here is another iterative version that the original poster called "a little bit different".
#|
kw:
For n < 3, the function should just return n
|#
(define (f_using_coeff n) 
  (define (f-iter n a b c) 
    ;; this makes f(n) = a f(2) + b f(1) + c f(0) for integer n. 
    (if (< n 4) 
      ;; N < 4. cause n-1 < 3 
      (+ (* a (- n 1) ) 
         (* b (- n 2)) 
         (* c (- n 3)))
      ;; assumes f(n) = a f(i-1) + b f(i-2) + c f(i-3) -> a (f(i-2) + 2 f(i-3) + 3 f(i-4)) ...
      ;; -> (+ b a) (+ c (* 2 a)) (* 3 a)
      (f-iter (- n 1) (+ b a) (+ c (* 2 a)) (* 3 a)))) 
  (f-iter n 1 2 3)) 

#|
Another iterative version

This is the version of the 1st one without considering decimal fraction
|#
(define (f-iterative n) 
  (define (sub1 x) (- x 1)) 
  (define (iter count n-1 n-2 n-3) 
    (define (f) 
      (+ n-1 (* 2 n-2) (* 3 n-3))) 
    (if (= count 0) 
      n-1 
      (iter (sub1 count) (f) n-1 n-2))) 
  (if (< n 3) 
    n 
    (iter (- n 2) 2 1 0))) 
(f-iterative 10.1) ; infinite loop
