(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "normal-tree-test.scm")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; infinite car
(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "book-stream-lib.scm")
(define nested-ones (cons-stream ones nested-ones))
(car nested-ones)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; paper
(define custom-cons cons)
(define custom-car car)
(define custom-cdr cdr)

;; https://www.cs.kent.ac.uk/people/staff/dat/miranda/whyfp90.pdf ~/SICP_SDF/references/papers/whyfp90.pdf
;; 0. > Since gametree has a potentially infinite result, this program would never terminate without lazy evaluation
;; But if gametree is one stream, then we can work.
;; 1. > prune 5 . gametree 
;; i.e. (prune 5 gametree), see p6. (I won't dig into the syntax. I assume prune 5 is one whole entity by prune definition)
;; > The function (prune n) takes a tree and “cuts off” all nodes further than n from the root.
;; 2. By book Figure 2.6, tree is just nested list
;; By paper "would be represented by", just use data structure (cons node children)
(define (prune max-depth tree)
  (define (iter depth subtree)
    (if (= depth max-depth)
      '() ; no children
      (custom-cons (custom-car subtree) (flatmap-only-nil (lambda (child) (iter (+ 1 depth) child)) (custom-cdr subtree)))))
  (iter 0 tree)
  )

;; from book
(define (flatmap-only-nil proc seq)
  (fold-right 
    (lambda (elm lst) 
      (if (null? elm)
        ; (append elm lst)
        lst
        (custom-cons elm lst)
        )) 
    '()
    (map proc seq)))

(define (demo-tree)
  (custom-cons 0 
        (list 
          (custom-cons 1   
                (list 
                  (custom-cons 3 
                        (list 
                          (custom-cons 5 (list (custom-cons 7 '()) (custom-cons 8 '()))) 
                          (custom-cons 6 '()))) 
                  (custom-cons 4 '()))) 
          (custom-cons 2 '()))))
(prune 3 (demo-tree))

; https://www.shido.info/lisp/scheme_syntax_e.html
;; cons will have ";Variable reference to a syntactic keyword: cons" error.
(define-syntax custom-cons
  (syntax-rules ()
    (
    ;  (_ x y)
     (custom-cons x y)
    ;  (set! x y)
     (cons-stream x y)
     )))
(custom-cons 1 2)

;; not redefine these since they may be implicitly used by list.
; (define car stream-car)
; (define cdr stream-cdr)

(define custom-car stream-car)
(define custom-cdr stream-cdr)
;; Since the rest is always one list when forced.
; (define map stream-map)
;; just store a list of children. Delay will be done by custom-cons.
; (define list stream)

; (demo-tree)
; (prune 3 (demo-tree))

;; TODO see custom-cons-debug.scm
(prune 3
  (custom-cons 0 
        (list 
          (custom-cons 1   
                (list 
                  (custom-cons 3 
                        (list 
                          (custom-cons 5 (list (custom-cons 7 '()) (custom-cons 8 '()))) 
                          (custom-cons 6 '()))) 
                  (custom-cons 4 '()))) 
          (custom-cons 2 '()))))
