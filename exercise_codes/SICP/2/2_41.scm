(load "conventional_interfaces_lib.scm")
;; naming similar to exercise 2.40
;; Here we let 1<=k<j<i<=n, then use permutation after being filtered.
(define (decreasing-unique-triples n)
  (flatmap
    (lambda (i)
      (flatmap 
        (lambda (j) 
          (map 
            (lambda (k) (list i j k)) 
            (enumerate-interval 1 (- j 1))))
        (enumerate-interval 1 (- i 1))))
    (enumerate-interval 1 n)))

(define (filtered-sum-triple s n)
  (flatmap permutations (filter (lambda (triple) (= s (accumulate + 0 triple))) (decreasing-unique-triples n))))

(filtered-sum-triple 5 10)
(filtered-sum-triple 20 30)

;; wiki Woofy
;; This is decreasing tuple implied by `(cons n tuple)`. So it is not ordered triples https://byjus.com/question-answer/what-do-you-mean-by-ordered-pair-and-ordered-triplet-give-example/.
(define (unique-tuples n k) 
  (cond ((< n k) nil) 
        ((= k 0) (list nil)) 
        (else (append (unique-tuples (- n 1) k) 
                      (map (lambda (tuple) (cons n tuple)) 
                           (unique-tuples (- n 1) (- k 1)))))))

(unique-tuples 1 1)
(define correct-tuples (unique-tuples 30 3))
(length correct-tuples)

(define (unique-tuples n k) 
  (define (iter m k) 
    (if (= k 0) 
      (list nil) 
      (flatmap (lambda (j) 
                 (map (lambda (tuple) (cons j tuple)) 
                      (iter (+ j 1) (- k 1)))) 
               (enumerate-interval m n)))) 
  (iter 1 k))
(length correct-tuples)
(/ (* 30 29 28) 6)
(length (decreasing-unique-triples 30))

;; wiki Poc
(define (tuples nb max-int) 
  (define (iter size) 
    (if (= size nb) (map list (enumerate-interval nb max-int)) 
      (flatmap (lambda (i) 
                 (map (lambda (j) (cons j i)) (enumerate-interval size (- (car i) 1)))) 
               (iter (+ size 1))))) 
  (iter 1))
(length (tuples 3 30))
