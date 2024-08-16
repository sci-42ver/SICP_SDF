;; just use already defined func.
;; See wiki better not to change primitives.
(define (+ x y)
  (add x y))

(define (install-square-package)
  (put 'square '(rational) 
    ;; Here I not use internal square to avoid unnecessary possible mess.
    (lambda (x) 
      (attach-tag 'rational 
        ;; contents will be done by apply-generic.
        (make-rat 
          (* (numer x) (numer x)) 
          (* (denom x) (denom x))))))
  (put 'square '(scheme-number)
    (lambda (x) 
      (attach-tag 'scheme-number 
        (* x x))))
  )

(define (square x)
  (apply-generic 'square x))

;; The rest is similar.
;; sin just transforms real.

; (define (+ x)
;   (square x))
; (define (square x)
;   (* x x x))
; ;; Here square is modified.
; (+ 3)

(define (install-sin-package)
  (put 'sin-generic '(rational) 
    (lambda (x) 
      (attach-tag 'rational 
        ;; use repo but use the following `real->rational`.
        ; (define (real->rational x)
        ;   (rationalize (exact x) 1/10))
        
        ;; IGNORE: see wiki, since we use `(* r (sin a))` it is better to just keep real.
        ;; mul will make `(mul r (sin a))` work for rat.
        ((get-coercion 'real 'rational) (sin (contents ((get-coercion 'rational 'real) x)))))))
  (put 'sin-generic '(scheme-number)
    sin)
  )

;; should define sine as the exercise requests.
(define (sin-generic x)
  (apply-generic 'sin-generic x))

;; cos similar.