;; from sol
(define (next-num n)
  (if (even? n)
      (/ n 2)
      (+ (* n 3) 1)))

;; self
(define (num-seq start)
  (define seq
    (cons-stream start (stream-map next-num seq)))
  seq
  )

(stream-head (num-seq 7) 20)