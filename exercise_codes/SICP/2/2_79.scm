(define (install-common-number-package)
  ;; wrong. only check type???
  (define (equ? x y)
    (eq? (type-tag x) (type-tag y)))
  ;; type is also wrong.
  (put 'equ? 'common equ?))