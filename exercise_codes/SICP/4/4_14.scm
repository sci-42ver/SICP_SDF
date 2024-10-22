(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lib.scm")
(load "../lib.scm")

;; https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-15.html#%_sec_2.2
(define map
  ;; evaluated by the underlying Scheme
  (lambda (proc items)
    (if (null? items)
        nil
        (cons (proc (car items))
              (map proc (cdr items))))))

(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        (list 'square (lambda (x) (* x x)))
        (list 'square-twice (lambda (x) (square (square x))))
        (list 'first car)
        ;; added
        (list 'map map)
        (list '+ +)
        ))

(define the-global-environment (setup-environment))
; (driver-loop)

;; `(apply (eval (operator exp) env) ...)` -> `(apply-primitive-procedure procedure arguments)` for map will use the above lambda.
;; Then proc is got by `make-procedure`.
;; Then `(proc (car items))` won't be evaluated by M-Eval, so wrong.
; (map (lambda (x) (+ x 1)) '(2 3))

;; IGNORE: similarly but square is the value evaluated by the underlying Scheme above. So `(proc (car items))` is fine.
; (map square '(2 3))