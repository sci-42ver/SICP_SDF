(load "minimal_test/1_45_minimal_test.scm")
;;; same as the wiki parameter choice.
(define (find_valid_average_damp_level max_root start_root bound init)
  (define x 2.0)
  (define (helper root_order average_damp_level)
    ;; same as Kaihao's implementation, otherwise the above will output differently although it also converges
    (if (< (root root_order x average_damp_level bound init #t #f #t) bound)
      (begin
        (displayln "")
        (displayln "needed average_damp_level:")
        average_damp_level)
      (helper root_order (+ average_damp_level 1))))
  (if (> start_root max_root)
    (displayln "finish")
    (begin
      (displayln "")
      (displayln "start_root:")
      (displayln start_root)
      (displayln (helper start_root 1))
      (find_valid_average_damp_level max_root (+ start_root 1) bound init))))
(find_valid_average_damp_level 20 2 small_bound 1.0)
;; outputs
; ...
; start_root:
; 6
;
; average_damp_level:
; 1
; finished count:
; 100
; result:
; .9019353334996821
;
; average_damp_level:
; 2
; finished count:
; 15
; result:
; 1.1224648393618204
;
; needed average_damp_level:
; 2
; ...

;;; check how $sqrt[6]{2}$ converges when "Required Average Damps" is 1.
(root 6 2.0 1 1000000000 1.0 #t #f #t)
;; outputs with the same result as the following `(nth-root 2.0 6 1)`.
; average_damp_level:
; 1
; finished count:
; 319396
; result:
; 1.1224584896267153
;Value: 319396


;;; from wiki Kaihao's comment
(define tolerance 0.00001) 

(define (fixed-point f first-guess) 
  (define (close-enough? v1 v2) 
    (< (abs (- v1 v2)) tolerance)) 
  (define (try guess) 
    (let ((next (f guess)))
      ; (displayln next) 
      (if (close-enough? guess next) 
        next
        (try next)))) 
  (try first-guess)) 

(define (average a b) 
  (/ (+ a b) 2)) 

(define (average-damp f) 
  (lambda (x) (average x (f x)))) 

(define (square x) 
  (* x x)) 

(define (fast-expt b n) 
  (cond ((= n 0) 1) 
        ((even? n) (square (fast-expt b (/ n 2)))) 
        (else (* b (fast-expt b (- n 1)))))) 

(define (compose f g) 
  (lambda (x) 
    (g (f x)))) 

(define (repeated f n) 
  (if (> n 1) 
    (compose (repeated f (- n 1)) f) 
    f)) 

;; avarage-damp d times 
(define (nth-root x n d) 
  (fixed-point ((repeated average-damp d)  
                ; (lambda (y) (/ x (fast-expt y (- n 1))))) 
                ;; `fast-expt` seems to be same as the internal `expt` since they have the same result.
                (lambda (y) (/ x (expt y (- n 1))))) 
               1.0))
(nth-root 2.0 6 1)
