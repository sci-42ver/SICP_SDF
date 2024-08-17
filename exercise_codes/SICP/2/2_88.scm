;; based on 2.80
(define (install-negation-package)
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (negation-ordinary x)
    (- x))
  ;; Here as former exercises imply, we assume numer/real-part etc. are all real numbers.
  (define (negation-rational x)
    (make-rational (- (numer x)) (- (denom x))))
  (define (negation-complex x)
    ;; use Exercise 2.77
    (make-complex-from-real-imag (- (real-part x)) (- (imag-part x))))
  (put 'negation '(scheme-number) negation-ordinary)
  (put 'negation '(rational) negation-rational)
  (put 'negation '(complex) negation-complex)
  )

(define (negation x)
  (apply-generic 'negation x))

(install-negation-package)

(define (install-polynomial-package)
  ; ...
  (define (negation-poly x)
    (make-polynomial 
      (variable x)
      (map 
        (lambda (term) 
          ;; better just use `(mul (coeff first) -1 )`. See wiki
          (make-term (order term) (negation (coeff term)))) 
        (term-list x))))
  (define (subtract-poly p1 p2)
    (add-poly p1 (negation p2)))
  (put 'negation '(polynomial) negation-poly)
  (put 'subtract '(polynomial) subtract-poly) ; wrong type
  )
