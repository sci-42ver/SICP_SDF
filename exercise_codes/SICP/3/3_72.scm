
;; 3.70
(define (merge-weighted s1 s2 proc) 
  (cond ((stream-null? s1) s2) 
        ((stream-null? s2) s1) 
        (else 
        (let ((s1car (stream-car s1)) 
              (s2car (stream-car s2))) 
          (let ((w1 (proc s1car)) 
                (w2 (proc s2car))) 
            (if (< w1 w2) 
                (cons-stream s1car 
                              (merge-weighted (stream-cdr s1) s2 proc)) 
                (cons-stream s2car 
                              (merge-weighted s1 (stream-cdr s2) proc)))))))) 
(define (weighted-pairs s1 s2 proc) 
  (cons-stream 
    (list (stream-car s1) (stream-car s2)) 
    (merge-weighted 
      (stream-map (lambda (x) (list (stream-car s1) x)) (stream-cdr s2)) 
      (weighted-pairs (stream-cdr s1) (stream-cdr s2) proc) 
      proc))) 

;; 3.72
(define (sum-of-squares p) 
  (+ (square (car p)) (square (cadr p)))) 

(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "book-stream-lib.scm")

(define ordered-pairs 
  (weighted-pairs integers integers sum-of-squares)) 

(define (equiv-sum-squares-stream s) 
  (let ((next-1 (stream-cdr s)) 
        (next-2 (stream-cdr (stream-cdr s)))) 
    (let ((p1 (stream-car s)) 
          (p2 (stream-car next-1)) 
          (p3 (stream-car next-2))) 
      (let ((x1 (sum-of-squares p1)) 
            (x2 (sum-of-squares p2)) 
            (x3 (sum-of-squares p3))) 
        (if (= x1 x2 x3) 
            (cons-stream 
              (list x1 p1 p2 p3) 
              ;; modified
              (equiv-sum-squares-stream (stream-cdr next-1))) 
            (equiv-sum-squares-stream next-1)))))) 

(stream-head (equiv-sum-squares-stream ordered-pairs) 5) 