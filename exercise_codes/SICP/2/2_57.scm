(load "deriv_lib.scm")

(define (augend s) 
  (let ((a (cddr s))) 
    (if (= (length a) 1) 
      (car a) 
      (append '(+) a)
      ))) 
(define (multiplicand p) 
  (let ((m (cddr p))) 
    (if (= (length m) 1) 
      (car m)
      (append '(*) m))))

(deriv '(* (* x y) (+ x 3)) 'x)
(deriv '(* x y (+ x 3)) 'x)
