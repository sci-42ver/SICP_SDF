(define (fast-expt b n)
  (define (even? n)
    (= (remainder n 2) 0))
  (define (fast-expt-iter a b n)
    (cond ((= n 0) a)
          ((even? n) (fast-expt-iter a (square b) (/ n 2)))
          ; This combines wiki `(/ (- N 1) 2)` into one line.
          (else (fast-expt-iter (* a b) (square b) (quotient n 2)))))
  (fast-expt-iter 1 b n))

;;; Solution 2
(define (fast-expt b n) 
  (define (cube x) (* x x x)) 
  (define (fast-expt-iter b a counter) 
    (cond ((= counter 0) a) 
          ((= counter 1) (* a b)) 
          ((even? counter) (fast-expt-iter  
                             (square b) 
                             ; Here -1 will count the minimum unit, so (* (square b) a) in advance.
                             (* (square b) a) 
                             (- (/ counter 2) 1))) 
          (else (fast-expt-iter  
                  (square b)  
                  ;  similar to above "in advance" makes `b` to `(cube b)`.
                  (* (cube b) a) 
                  (- (/ (- counter 1) 2) 1))))) 
  (fast-expt-iter b 1 n)) 
