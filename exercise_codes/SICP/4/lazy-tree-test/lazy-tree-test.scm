(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lazy-tree-test/normal-tree-test.scm")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; infinite car
(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "book-stream-lib.scm")
(define nested-ones (cons-stream ones nested-ones))
(car nested-ones)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; paper
;; contents:
; 1 Introduction
; 2 An Analogy with Structured Programming
; 3 Gluing Functions Together
; 4 Gluing Programs Together
; 4.1 Newton-Raphson Square Roots
; 4.2 Numerical Differentiation
; 4.3 Numerical Integration
; 5 An Example from Artificial Intelligence
; 6 Conclusion
;; Only 5 is related with tree application and 3 is about tree structure

;; lazy context
;; > Since this method of evaluation runs f as little as possible, it is called “lazy evaluation”
;; stream can also do that but just not totally lazy.
;; > only functional languages (and not even all of them) use lazy evaluation uniformly for every function call
;; Just give one tree lib based on stream. Then uniformly for tree.
;; > More importantly, lazy evaluation permits us to modularize evaluate in this way. Since gametree has a potentially infinite result, this program would never terminate without lazy evaluation
;; See infinite context.

;; > Since each part
; can be thrown away (reclaimed by the garbage collector) as soon as maximize
; has finished with it, the whole tree is never resident in memory. Only a small
; part of the tree is stored at a time. The lazy program is therefore efficient.
;; this is due to lazy combined with garbage collector. Stream can also do that.

;; > Thanks to lazy evaluation, if maximize doesn’t look at all of
; the list of numbers, some of them will not be computed
;; Stream can also do that.

;; > This efficiency depends on an interaction between maximize (the last function
; in the chain of compositions) and gametree (the first); without lazy evaluation
;; i.e. the chain will generate each depth level of the gametree infinitely.

;; > Thanks to lazy evaluation, the fact that maximize0
; looks at less of the tree
; means that the whole program runs more efficiently
;; maximize' implies lazy by dropping some subtrees based on checking the number relation with minleq.
;; Since rest etc are stream, so infinite val of rest is fine.


;; infinite context
;; > The function repeat is an example of a function with an “infinite” output
;; > the function repeat used to construct infinite lists
;; > The function integrate computes an infinite list of better and better approximations to the integral
;; Just like infinite stream 
;; > it doesn’t work for infinite trees, because maximize keeps on recursing until it finds a node with no subtrees
;; > If it’s possible for a game to go on forever with neither side winning, its game tree is infinite
;; infinite depth
;; > statically evaluates all the positions in the tree (which may be infinitely many)
;; infinite width/depth
;; > First of all, it doesn’t work for infinite trees, because maximize keeps on recursing
;; since lazy is about argument evaluation instead of procedure calls.
;; > Since gametree has a potentially infinite result, this program would never terminate without lazy evaluation.
;; For stream, `maptree static . prune 5 . gametree` will be one stream.
;; >> maximize (Node n sub) = max (map minimize sub)
;; keep recursion until reaching the leaves which must exist implied by prune.
;; >>> just as the fact that prune looks at only part of an infinite tree enables the program to terminate 

(define custom-car stream-car)
(define custom-cdr stream-cdr)

;; similar structure as reptree.
; (define (prune max-depth tree)
;   (define (iter depth subtree)
;     (cons-stream 
;       (custom-car subtree)
;       ;; changed. Then we don't need care about combining multiple '()s to one '().
;       (if (= depth (- max-depth 1))
;         '() ; no children
;         (stream-map (lambda (child) (iter (+ 1 depth) child)) (custom-cdr subtree)))))
;   (iter 0 tree)
;   )

;; based on paper definition
;; The above interface is different from the paper since the former has base 1 by (- max-depth 1).
(define (prune max-depth tree)
  (if (= 0 max-depth)
    (cons-stream (stream-car tree) the-empty-stream)
    (cons-stream (stream-car tree) (stream-map (lambda (subtree) (prune (- max-depth 1) subtree)) (stream-cdr tree))))
  )

;; from book
; (define (flatmap-only-nil proc seq)
;   (fold-right 
;     (lambda (elm lst) 
;       (if (null? elm)
;         ; (append elm lst)
;         lst
;         (cons-stream elm lst)
;         )) 
;     '()
;     (map proc seq)))

(define infinite-width-leaves
  (cons-stream (cons-stream 'a the-empty-stream) infinite-width-leaves))

(define (demo-tree)
  (cons-stream 0
        (stream 
          (cons-stream 1   
                (stream 
                  (cons-stream 3 
                        (stream 
                          (cons-stream 5 (stream (cons-stream 7 '()) (cons-stream 8 '()))) 
                          (cons-stream 6 '()))) 
                  (cons-stream 4 '()))) 
          (cons-stream 2 infinite-width-leaves))))
(demo-tree)
;; not infinite
(define test-stream (prune 3 (demo-tree)))
; (stream-head test-stream (stream-length test-stream))
(stream->list test-stream)
(stream-cdr (stream-car (stream-cdr test-stream)))
(stream-cdr (stream-car (stream-cdr (stream-cdr test-stream))))

;; Since the rest is always one list when forced.
; (define map stream-map)
;; just store a list of children. Delay will be done by cons-stream.
; (define list stream)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; infinite depth
(define demo-tree-with-infinite-depth
  (cons-stream 0 (cons-stream demo-tree-with-infinite-depth infinite-width-leaves)))
(define test-stream-2 (prune 10 demo-tree-with-infinite-depth))
test-stream-2
(stream->list (prune 0 demo-tree-with-infinite-depth))
; (stream->list test-stream-2)