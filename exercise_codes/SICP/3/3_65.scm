(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "book-stream-lib.scm")
(load "3_55.scm")

(define (sub-streams stream1 stream2) 
    (stream-map - stream1 stream2)) 

(define (one-order-difference stream) 
    (sub-streams (stream-cdr stream) stream)) 

(define (euler-transform s) 
    (sub-streams 
        (stream-cdr (stream-cdr s)) 
        (stream-map 
            / 
            (stream-map square (one-order-difference (stream-cdr s))) 
            (one-order-difference (one-order-difference s))))) 

(define (ln2-summands n) 
    (cons-stream 
        (/ 1.0 n) 
        (stream-map - (ln2-summands (+ n 1))))) 

(define ln2-stream 
    (partial-sums (ln2-summands 1))) 

(define (show-streams n . streams) 
  ;; see Exercise 2.38. Here streams is infinite, so fold may be better to use car `(= n 0)` first.
    (if (fold
          (lambda (a b) (or a b)) 
          #f 
          (cons (= n 0) (map stream-null? streams))) 
        (newline) 
        (begin 
            (display-line (map stream-car streams)) 
            (apply show-streams (cons (- n 1) (map stream-cdr streams)))))) 

(define (make-ln2-one-order-difference-tableau) 
    (let ((ln2-tableau (make-tableau euler-transform ln2-stream))) 
        (lambda (i) (one-order-difference (stream-ref ln2-tableau i))))) 

(define ln2-oodt (make-ln2-one-order-difference-tableau)) 

(show-streams 12 (ln2-oodt 4) (ln2-oodt 5) (ln2-oodt 6)) 