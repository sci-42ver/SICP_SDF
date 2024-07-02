 (define (square x) 
   (* x x)) 

(define (sum-of-squares x y) 
  (+ (square x) (square y))) 

(define (sum-of-squares-of-two-largest x y z) 
  (sum-of-squares (max x y) (max (min x y) z))) 

(sum-of-squares-of-two-largest 1 2 3) 
