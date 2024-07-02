 (define (cube-root-iter guess x) 
   (if (good-enough? guess x) 
     guess 
     (cube-root-iter (improve guess x) x))) 

(define (improve guess x) 
  (average (/ x (square guess)) (* 2 guess))) 

(define (average x y) 
  (/ (+ x y) 3)) 

(define (square x) (* x x)) 

(define (good-enough? guess x) 
  (< (abs (- (cube guess) x)) (* guess 0.001))) 

(define (cube x) (* x x x)) 

(define (cube-root x)  
  (if (< x 0)  
    (* -1 (cube-root-iter 1.0 (abs x)))  
    (cube-root-iter 1.0 x))) 

(cube-root 27)

(cube-root -27)

; > it toggles between 4.641588833612779 and 4.641588833612778
; On my machine it can't occur.
; master only changes good-enough?
(trace good-enough?)
(cube-root 100) 
(cube-root-iter 4.641588833612779 100)
(cube-root-iter 4.641588833612778 100)
; (cube-root 1e5) 
; (cube-root 1e10) 
