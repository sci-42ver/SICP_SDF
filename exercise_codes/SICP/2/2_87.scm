;; based on 2.80
(define (install-=zero?-package)
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (=zero-ordinary? x)
    (= x 0))
  (define (=zero-rational? x)
    (= (numer x) 0))
  (define (=zero-complex? x)
    (= (magnitude x) 0))
  ;; same as sam's.
  (define (=zero-poly? x)
    ;; based on 
    ;; > polynomial B is efficiently represented as ((100 1) (2 2) (0 1))
    (empty-termlist? (term-list x)))
  (put '=zero? '(scheme-number) =zero-ordinary?)
  (put '=zero? '(rational) =zero-rational?)
  (put '=zero? '(complex) =zero-complex?)
  (put '=zero? '(polynomial) =zero-poly?)
  )

(define (=zero? x)
  (apply-generic '=zero? x))