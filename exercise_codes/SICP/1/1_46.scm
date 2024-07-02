(define (iterative-improve good_enough? improve f guess)
  (if (good_enough? guess)
    (f guess)
    (iterative-improve good_enough? (improve guess) f guess)))

(define (sqrt x)
  (define (improve guess x)
    (average guess (/ x guess)))
  (define (average x y)
    (/ (+ x y) 2))
  (define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))
  )

;;; See wiki, iterative-improve should return "a procedure"
(define (iterative-improve good_enough? improve)
  (lambda (guess)
    (if (good_enough? guess)
        guess
        ((iterative-improve good_enough? improve) (improve guess))))) ; from wiki

(define guess 1.0)
(define (sqrt x)
  (define (improve guess) ; directly use the top `x` parameter
    (average guess (/ x guess)))
  (define (average x y)
    (/ (+ x y) 2))
  (define (good_enough? guess) ; directly use the top `x` parameter
    (< (abs (- (square guess) x)) 0.001))
  ((iterative-improve good_enough? improve) guess))
(sqrt 2)

(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (define (good_enough? v1) ; consistent with the above implementation
    (< (abs (- v1 (f v1))) tolerance))
  ((iterative-improve good_enough? f) first-guess))

(fixed-point cos guess)

;;; from wiki
(define (iterative-improve good-enough? improve) 
  (lambda (first-guess) 
    (define (iter guess) 
      (if (good-enough? guess) 
          guess 
          (iter (improve guess)))) 
    iter))

; (define (iterative-improve good-enough? improve)  
;   (define (iter guess)  
;     (if (good-enough? guess)  
;         guess  
;         (iter (improve guess))))  
;   iter) 

(fixed-point cos guess)