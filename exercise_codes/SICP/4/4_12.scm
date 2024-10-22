;; wiki woofy's is more general to allow define func in arg where arg is only those not in the caller.
;; The 3 branch locations are same.
;; `(lookup-variables-value var (enclosing-environment env))` etc -> `tranverse ...` -> `env-loop`, so same as here.
(define 
  (traverse var use-enclosing-environment err-msg env . val)
  (define (loop env)
    ;; For lookup-variable-value, this just check frame before (define (scan vars vals) ...). This is fine.
    (let ((frame 
            ;; IMHO we also need to check this for define-variable! to make `first-frame` valid.
            (if (eq? env the-empty-environment)
              (error err-msg var)
              (first-frame env))))
      (define (scan vars vals)
        (cond ((null? vars)
              (if use-enclosing-environment
                (loop (enclosing-environment env))
                (add-binding-to-frame! var val frame)))
              ((eq? var (car vars))
              (if (null? val)
                (car vals)
                (set-car! vals val)
                ))
              (else (scan (cdr vars) (cdr vals)))))
      (scan (frame-variables frame)
            (frame-values frame))))
  (loop env)
  )

(define (lookup-variable-value var env)
  (traverse var #t "Unbound variable" env)
  )

(define (set-variable-value! var val env)
  (traverse var #t "Unbound variable -- SET!" env val)
  )

(define (define-variable! var val env)
  (traverse var #f "Can't bind variable" env val)
  )

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (car vals))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable -- SET!" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

;; doesn't check the-empty-environment for env...
(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (cond ((null? vars)
             (add-binding-to-frame! var val frame))
            ((eq? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame)
          (frame-values frame))))

(define test (list 1 2))
(delq! 1 test)
test