(define x 2)
(let ((x 3)
      (y (+ x 2)))
  (* x y))
(define (f)
  (define x 3)
  (define y (+ x 2))
  (* x y))
(f)
;;; > Sometimes we can use internal definitions to get the same effect as with let.
;;; As the above shows we need to be careful about variable naming when using `define` instead of `let`.
