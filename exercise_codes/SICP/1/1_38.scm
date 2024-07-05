;;; https://stackoverflow.com/a/22871381/21294350
(load "1_37.scm")
(- (cont-frac (lambda (i) 1.0)
              (lambda (i) (if (= (remainder i 3) 2)
                            (* (+ (quotient i 3) 1) 2)
                            1))
              k) 
   0.7182818284590451) ; e-2 from python math module

;;; ;Alternative solution. 
;;; It iterates all former terms until the target value which has \Theta(i) time complexity instead of \Theta(1) above.

;;; from wiki
(define (d i) ;  
  (define (d-iter  value times-two j) 
    (let ((j-mod-3 (modulo j 3))) 
      (if (> j  i) 
        value 
        (d-iter 
          (cond ((= j-mod-3 1) 1) 
                ((= j-mod-3 2) times-two) 
                ((= j-mod-3 0) 1)) 
          (if (= j-mod-3  2) 
            (+ times-two 2) 
            times-two) 
          (+ j 1))))) 
  (d-iter 0 2 1))    
(define (enum f n)  ;displays the function values upto and including n 
  (define (enum-iter list-of-values i) 
    (if (= i  n) 
      (display (reverse list-of-values)) 
      (enum-iter (cons (f i) list-of-values) (+ i 1)))) 
  (enum-iter '() 1)) 

;;; run
(define (f i) (* 1.0 (+ (cont-frac (lambda (i) 1.0) d i) 2)))
(enum f 100)
