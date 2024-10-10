(define (make-zero-crossings input-stream last-value)
  (let ((avpt (/ (+ (stream-car input-stream) last-value) 2)))
    (cons-stream (sign-change-detector avpt last-value)
                 (make-zero-crossings (stream-cdr input-stream)
                                      ;; > is does not correctly implement Alyssa’s plan.
                                      ;; this will keep averaging like series 1/2^n.
                                      avpt))))

;; same as meteorgan's and repo.
(define (make-zero-crossings input-stream last-value last-avg)
  (let* ((cur-val (stream-car input-stream))
         (avpt (/ (+ cur-val last-value) 2)))
    (cons-stream (sign-change-detector avpt last-avg)
                 (make-zero-crossings (stream-cdr input-stream)
                                      ;; changed
                                      cur-val
                                      avpt))))