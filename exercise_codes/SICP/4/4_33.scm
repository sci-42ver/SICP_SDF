(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lib/lazy/lazy-lib-with-cons-as-proc.scm")

;; (define cons (lambda (x y) (lambda (m) (m x y))))
;; The above won't make '(...) as lambda.

;; > Notice that we can install these definitions in the lazy evaluator simply by typing them at the driver loop. 
;; > If we had originally included cons, car, and cdr as primitives in the global environment, they will be redefined. (Also see exercises 4.33 and 4.34.)
;; definition in (driver-loop) will redefine locally which also make this exercise example fail.

;; meteorgan (same as repo) is better to let eval construct list so that it must use the compatible cons.
(define (list->lambda-cons lst)
  (if (null? lst)
    lst
    (cons-as-lambda (car lst) (list->lambda-cons (cdr lst)))))

(define (text-of-quotation exp) 
  (let ((val (cadr exp)))
    (if (list? val)
      (list->lambda-cons val)
      val)))