;; similar 2.80
(define (install-raise-package)
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (raise-integer x)
    (if (exact-integer? x)
      (attach-tag 'rational (make-rat x 1))
      (error "wrong arg" x)))
  (define (raise-rational x)
    ;; Here I assume scheme-number is just rational.
    ;; wiki meteorgan's better use floating.
    (attach-tag 'real (/ (numer x) (denom x))))
  (define (raise-real x)
    (attach-tag 'complex (make-complex-from-real-imag x 0)))
  (put 'raise '(integer) raise-integer)
  (put 'raise '(rational) raise-rational)
  (put 'raise '(real) raise-real)
  )

(define (raise x)
  (apply-generic 'raise x))