(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "Lazy_Evaluation_lib.scm")

(define car-as-lambda (lambda (z) (z (lambda (p q) p))))
; (define car (lambda (z) (z (lambda (p q) p))))
(define cdr-as-lambda (lambda (z) (z (lambda (p q) q))))
(define cons-as-lambda (lambda (x y) (lambda (m) (m x y))))
; (define cons (lambda (x y) (lambda (m) (m x y))))

(define primitive-procedures
  (list 
    ;; modified
    (list 'car car-as-lambda)
    (list 'cdr cdr-as-lambda)
    (list 'cons cons-as-lambda)

    (list 'null? null?)
    (list 'square (lambda (x) (* x x)))
    (list 'square-twice (lambda (x) (square (square x))))
    (list 'first car)
    ;; 4.24
    (list '= =)
    (list '- -)
    (list '* *)
    (list '<= <=)
    (list '+ +)
    (list 'display display)
    ;; 4.26. See 4.14 for why we don't define here.
    ; (list 'map map)
    ; (list 'nil '())
    (list 'length length)

    ;; 4.29
    (list 'remainder remainder)
    (list '/ /)
    ;; 4.30
    (list 'list list)
    (list 'newline newline)
    ))

(define the-global-environment (setup-environment))