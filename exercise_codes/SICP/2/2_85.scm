(define (install-project-package)
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (project-rational x)
    ;; better use make-scheme-number abstraction as meteorgan shows.
    (attach-tag 'integer (round (/ (numer x) (denom x)))))
  (define (project-real x)
    ;; https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Numerical-operations.html#index-rationalize
    ;; wrong. See meteorgan's.
    (attach-tag 'rational (rationalize (exact x) 1/10)))
  ;; wrong since we just "involve throwing away the imaginary part".
  (define (project-complex x)
    (if (= (imag-part x) 0)
      (attach-tag 'real (real-part x))
      (error "unable to project")))
  (put 'project '(rational) project-rational)
  (put 'project '(real) project-real)
  (put 'project '(complex) project-complex)
  )

(define (project x)
  (apply-generic 'project x))

;; copy from 2.79
(define (install-equality-package)
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (eqn-ordinary? x y)
    (= x y))
  (define (eqn-real? x y)
    (= (contents x) (contents y)))
  (define (eqn-rational? x y)
    (and (= (numer x) (numer y))
         (= (denom x) (denom y))))
  (define (eqn-complex? x y)
    (and (= (real-part x) (real-part y))
         (= (imag-part x) (imag-part y))))
  (put 'eqn? '(scheme-number scheme-number) eqn-ordinary?)
  (put 'eqn? '(integer integer) eqn-ordinary?)
  (put 'eqn? '(real real) eqn-real?)
  (put 'eqn? '(rational rational) eqn-rational?)
  (put 'eqn? '(complex complex) eqn-complex?))

(define (drop x)
  ;; lacks checking whether x can be projected.
  ;; and we should use `(contents x)`
  (if (eqn? (raise (project x)) x)
    (drop (project x))
    x))

;; > use drop to rewrite apply-generic from Exercise 2.84 so that it “simplifies” its answers.
;; use `(drop (apply proc (map contents args)))`