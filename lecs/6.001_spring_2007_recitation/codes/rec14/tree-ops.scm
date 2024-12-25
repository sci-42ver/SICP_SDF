;; from lec12
(define (leaf? obj) (not (pair? obj)))

;; similar to https://stackoverflow.com/a/61080168/21294350 
;; and consider that tree is null in map.
;; similar to https://stackoverflow.com/a/35301730/21294350
;; but don't assume car can't be sub-tree.
(define (tree-map f tree)
  (if (leaf? tree)
    (f tree)
    (map (lambda (e) (tree-map f e))
         tree)))

;; added
(define (identity x)
  x)
