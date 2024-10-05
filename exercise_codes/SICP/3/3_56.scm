;; from ~/SICP_SDF/lecs/6.001_spring_2007_lec/Lect12_list_tree_huffman.pdf
(define (merge x y less?)
  (cond ((and (null? x) (null? y)) '())
        ((null? x) y)
        ((null? y) x)
        ((less? (car x) (car y))
         (cons (car x) (merge (cdr x) y less?)))
        (else (cons (car y) (merge x (cdr y) less?)))))

(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "book-stream-lib.scm")
(load "../lib.scm")

;; similar to ordered set `adjoin-set` but that is on elem and list instead of 2 lists.
(define (merge s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (cond ((< s1car s2car)
                  (cons-stream s1car (merge (stream-cdr s1) s2)))
                 ((> s1car s2car)
                  (cons-stream s2car (merge s1 (stream-cdr s2))))
                 (else
                  (cons-stream s1car
                               (merge (stream-cdr s1)
                                      (stream-cdr s2)))))))))

(define S 
  (cons-stream 
  1 
  (merge (merge (scale-stream S 2) 
                (scale-stream S 3)) 
          (scale-stream S 5)))) 

(define S2 
  (cons-stream 
  1 
  (merge (scale-stream S2 2) 
          (merge (scale-stream S2 3) 
                (scale-stream S2 5))))) 

;; https://stackoverflow.com/a/15706361/21294350 we can't test promise equality, so also for stream.
;; We need to force and then check.

(loop-cnt-ref 1000
  (lambda (idx) 
    (assert (= (stream-ref S2 idx) (stream-ref S idx)))))