(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      ;; See wiki. We don't need to print the ending value duplicately
      ; (display next)
      (newline) ; This should be printed first to be more readable
      (display guess)
      (if (close-enough? guess next)
          next
          (try next))))
  ; (display first-guess)
  ; (newline)
  (try first-guess))

(fixed-point (lambda (x) (/ (log 1000) (log x))) 2) ; 34 iterations
(fixed-point (lambda (x) (/ (log 1000) (log x))) 10.0) ; 33 iterations
(define (average x y)
  (/ (+ x y) 2))
(display "average damping")
(newline)
(fixed-point (lambda (x) (average (/ (log 1000) (log x)) x)) 2) ; 9 iterations
(fixed-point (lambda (x) (average (/ (log 1000) (log x)) x)) 10.0) ; 10 iterations same as wiki