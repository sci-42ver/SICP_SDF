(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        ((exponentiation? exp) ; See wiki. This lacks checking of `(=number? (deriv (exponent expr) var) 0)` which allows exp to be number or variable different from var.
          (let ((exponentiation-base (base exp))
                (exponentiation-exp (exponent exp)))
            (make-product 
              exponentiation-exp 
              (make-product 
                (make-exponentiation base (- exponent 1))
                (deriv base var)))))
        (else
         (error "unknown expression type -- DERIV" exp))))

;; just mimicking
(define (exponentiation? exp)
  (and (pair? x) (eq? (car x) '**)))

(define (make-exponentiation base exponent)
  ;; See wiki we can add `((=number? base 1) 1)` and otakutyrant's.
  (cond ((= exponent 0) 1)
    ((= exponent 1) base)
    (else (list '** base exponent))))

(define (base exponentiation)
  (cadr exponentiation))

(define (exponent exponentiation)
  (caddr exponentiation))