;; from lec12
(define (leaf? obj) (not (pair? obj)))

(define (tree-map f tree)
(if (leaf? tree)
(f tree)
(map (lambda (e) (tree-map f e))
tree)))

;; added
(define (identity x)
  x)