(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(trace fast-expt)
; 16 Entering so 15 multiplication after excluding (fast-expt 2 0)
(fast-expt 2 1e3)
