(load "deriv_lib.scm")
;; b
(define (install-plus-package)
  (define (plus operands var)
    (make-sum (deriv (car operands) var) ; here we better abstract car etc. For simplicity, I directly use it.
              (deriv (cadr exp) var)))
  (put 'deriv '+ plus))
;; product should be similar where `make-sum should not call `'deriv '+ plus` since that will then make interfaces not independent.

;; c
(define (install-expt-package)
  ;; See BE's make-exponentiation.
  (define (make-exponentiation base exp) 
    (cond ((=number? base 1) 1) 
          ((=number? exp 1) base) 
          ((=number? exp 0) 1) 
          (else  
            (list '** base exp)))) 
  ;; based on wiki top solution
  (define (expt operands var)
    (if (=number? (deriv (exponent expr) var) 0)
      (let ((b (car expr)) (e (cadr expr))) 
            (make-product (deriv b var) 
                          ;; better than (- (exponent operands) 1) since exp may be `y` when var is `x`.
                          (make-product e (make-exponentiation b (make-sum e -1)))))
      (error "not implemented")))
  (put 'deriv '** expt))

;; d: just change put