(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "../lib.scm")
(load "bst-book.scm")
;; from rec
(define (make-tree-node value left-subtree right-subtree)
  (list value left-subtree right-subtree))
(define the-empty-tree '())
(define empty-tree? null?)
;; 2
(define (tree-insert val tree)
  (cond ((empty-tree? tree)
         (make-tree-node val
                         the-empty-tree
                         the-empty-tree))
        ((< val (node-value tree))
         (make-tree-node (node-value tree)
                         (tree-insert val (node-left tree))
                         (node-right tree)))
        (else
          (make-tree-node (node-value tree)
                          (node-left tree)
                          (tree-insert val (node-right tree))))))

;return the last k elements of l
(define (list-tail l k)
  (if (zero? k)
    l
    (list-tail (cdr l) (- k 1))))
;return a list of the first k elements of l
(define (list-head l k)
  (if (zero? k)
    '()
    (cons (car l) (list-head (cdr l) (- k 1)))))
;lst must be sorted in increasing order
;; This is just same as Exercise 2.64
;; I tried to write this without using Exercise 2.64 to check my understanding.
(define (build-balanced-tree lst)
  (let ((len (length lst)))
    (cond 
      ;; to consider root-idx=0
      ((null? lst) lst)
      ((= 1 len) (make-tree-node (car lst) '() '()))
      (else 
        ;; assume balanced, then the root should be k+1 of 2k+1 elements, i.e. index k when len is 2k+1.

        ;; IGNORE: TODO IMHO `(root-idx (quotient len 2))` is better than `(- pivot 1)` which is same as the book exercise.
        ;;          Since if len is 2k+1, then mine is totally balanced while the sol will have (k-1 1 k+1) length triple
        ;;          if len is 2k, then mine is (k-1 1 k) and sol has (k-2 )

        ;; Here len: 2k+1, then root-idx must be k+1 starting from 1. If 2k, then k/k+1.
        ;; Here we choose (2k+1 k+1) and (2k k+1).
        (let* ((root-idx (quotient len 2))
               (left (list-head lst root-idx))
               (root-right (list-tail lst root-idx))
               (root (car root-right))
               (right (cdr root-right)))
          ;; include sol `((= a 1) (tree-insert (car lst) the-empty-tree))` -> `(make-tree-node val ...)`.
          (make-tree-node 
            root 
            (build-balanced-tree left) 
            (build-balanced-tree right)))
        ))))

(define n 20)
(define max-depth (ceiling (/ (log (+ 1 n)) (log 2))))
(define test-lst (iota n)) ; 0~n-1

(define res1 (build-balanced-tree test-lst))
res1

(define (depth tree)
  (define (iter cur-tree)
    (cond 
      ((null? cur-tree) 0)
      (else 
        (max
          (+ 1 (iter (left-branch cur-tree)))
          (+ 1 (iter (right-branch cur-tree)))))))
  (iter tree))

(assert (= max-depth (depth res1)))

; (10 (5 (2 (1 (0 () ()) ()) (4 (3 () ()) ())) (8 (7 (6 () ()) ()) (9 () ()))) (15 (13 (12 (11 () ()) ()) (14 () ())) (18 (17 (16 () ()) ()) (19 () ()))))

;; http://community.schemewiki.org/?sicp-ex-2.64
(define (list->tree elements)
  (car (partial-tree elements (length elements))))

;; based on wishful thinking, return (sorted-list of the former n elem's, rest elts)
;; where n=0 means nothing.

;; Compared with the above, IMHO this is unnecessarily more complex.
(define (partial-tree elts n)
  (if (= n 0)
    (cons '() elts)
    ;; compared with teh above, same for n=2k+1, but n=2k, this will have (k-1 1 k)
    (let ((left-size (quotient (- n 1) 2)))
      (let ((left-result
              (partial-tree elts left-size)))
        (let ((left-tree (car left-result))
              (non-left-elts (cdr left-result))
              (right-size (- n (+ left-size 1))))
          (let ((this-entry (car non-left-elts))
                (right-result
                  (partial-tree
                    (cdr non-left-elts)
                    right-size)))
            (let ((right-tree (car right-result))
                  (remaining-elts
                    (cdr right-result)))
              (displayln (list "remaining-elts" remaining-elts))
              (cons (make-tree this-entry
                               left-tree
                               right-tree)
                    remaining-elts))))))))

(define res2 (list->tree test-lst))
(displayln res2)

(assert (= (depth res2) (depth res1)))

;; sol wrong.
(define (build-balanced-tree lst)
  (let ((a (length lst)))
    (cond ((= a 0) the-empty-tree)
          ((= a 1) (tree-insert (car lst) the-empty-tree))
          (else
            (let ((pivot (quotient a 2)))
              (make-tree-node
                (list-ref lst (- pivot 1))
                (build-balanced-tree
                  (list-head lst (- pivot 1)))
                (build-balanced-tree
                  (list-tail lst pivot))))))))
(assert (= (depth (build-balanced-tree test-lst)) (depth res1)))
; (9 (3 (0 () (1 () (2 () ()))) (5 (4 () ()) (6 () (7 () (8 () ()))))) (14 (11 (10 () ()) (12 () (13 () ()))) (16 (15 () ()) (17 () (18 () (19 () ()))))))