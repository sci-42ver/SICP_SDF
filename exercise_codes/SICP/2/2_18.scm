(load "2_17.scm")

(define (reverse lst)
  ;; Here there is no easy way to extract `bf` of `lst`.
  ;; See wiki bmm's comment for how to do the above thing.
  (cons (car (last-pair lst)) (reverse lst)))