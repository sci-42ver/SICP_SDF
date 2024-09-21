; ;;;; Special Values & Predicates
(define *empty-binary-tree*
         '())
(define (empty-binary-tree? x) (null? x))
(define (binary-tree? x)
         (or (empty-binary-tree? x)
              (and (list? x) (= (length x) 3))))
(define (check-binary-tree x)
         (if (not (binary-tree? x))
              (error " not a binary tree : " x)))
; ;;;; Constructor
(define (make-node val ltree rtree)
         (list ltree val rtree))
; ;;;; Accessors
(define (node-value tree) (check-binary-tree tree) (second tree))
(define (left-subtree tree) (check-binary-tree tree) (first tree))
(define (right-subtree tree) (check-binary-tree tree) (third tree))

;; added
(define (set-left-subtree! tree val)
  (check-binary-tree tree)
  (set-car! tree val)
  tree ; to avoid returning #!unspecific.
  )

(define (set-right-subtree! tree val)
  (check-binary-tree tree)
  (set-car! (cddr tree) val)
  tree)
