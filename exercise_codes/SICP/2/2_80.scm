;; mimicking repo 2.79
;; combination of meteorgan's and parital Reimu's
;; same as repo.
(define (install-=zero?-package)
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (=zero-ordinary? x)
    (= x 0))
  (define (=zero-rational? x)
    (= (numer x) 0))
  (define (=zero-complex? x)
    (= (magnitude x) 0))
  (put '=zero? '(scheme-number) =zero-ordinary?)
  (put '=zero? '(rational) =zero-rational?)
  (put '=zero? '(complex) =zero-complex?)
  )

(define (=zero? x)
  (apply-generic '=zero? x))