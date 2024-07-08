(define (make-rat n d)
  (define abs_n (abs n))
  (define abs_d (abs d))
  (if (= d 0) 
    (display "error")
    (let ((g (gcd abs_n abs_d)))
      (if (>= (* n d) 0)
        ;; This is almost same as wiki Lily X's comment.
        (cons (/ abs_n g) (/ abs_d g))
        (cons (/ (- abs_n) g) (/ abs_d g))))))

(make-rat 6 9)
(make-rat 0 9)
(make-rat -6 9)
(make-rat 6 0)

;;; The above is almost same as the SICP repo implementation