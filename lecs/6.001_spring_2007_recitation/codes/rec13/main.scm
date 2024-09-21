;; Use `sed -i -f format.sed main.scm`.
(cd "~/SICP_SDF/lecs/6.001_spring_2007_recitation/codes/rec13")
(load "lib.scm")
(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "../lib.scm")

(define (binary-tree/fold op init tree)
  ; binary-tree/fold : (A ,B , B)- >B , B , binary-tree <A > ->B
  ; op takes a node value and the accumulated results of the node ' s left
  ; and right subtrees and creates a new accumulated result .
  ;; added by sol
  (check-binary-tree x)

  (if (empty-binary-tree? tree)
    init
    (op 
      (node-value tree) 
      (binary-tree/fold op init (left-subtree tree))
      (binary-tree/fold op init (right-subtree tree))
      ))
  )

(define (binary-tree/depth tree)
  (binary-tree/fold 
    (lambda (node left right) (+ 1 (max left right)))
    0 
    tree))

(define (bst/insert! val tree)
  (check-binary-tree tree)
  ;; This won't set (cdr lst) in place. See test1.
  (if (empty-binary-tree? tree)
    ;; Wrong since tree is one local variable binded to test-tree, so this won't change test-tree.
    ; (set! tree (make-node val *empty-binary-tree* *empty-binary-tree*))
    ;; See sol handle to avoid the above problem.

    (make-node val *empty-binary-tree* *empty-binary-tree*)
    (let ((curr-val (node-value tree))
          (left
            (left-subtree tree))
          (right
            (right-subtree tree)))
      (if (< val (node-value tree))
        (if (empty-binary-tree? left)
          ;; wrong
          ; (set-left-subtree! tree val)
          ;; So better see sol.
          (set-left-subtree! tree (make-node val *empty-binary-tree* *empty-binary-tree*))
          (bst/insert! val left))
        (if (empty-binary-tree? right)
          (set-right-subtree! tree val)
          (bst/insert! val right))
        ))))
(define (test1)
  (define test-lst (list 1))
  ((lambda (lst) 
     (set! lst (list 2)))
   (cdr test-lst))
  test-lst
  )
(define (test-bst/insert!)
  ; (define test-tree '()) ; not use *empty-binary-tree* to avoid change that.
  (define test-tree (make-node 0 *empty-binary-tree* *empty-binary-tree*)) ; not use *empty-binary-tree* to avoid change that.
  (bst/insert! 1 test-tree)
  (displayln test-tree)
  (bst/insert! 2 test-tree)
  (displayln test-tree)
  (bst/insert! 3 test-tree)
  test-tree
  )
; (test-bst/insert!)

;; sol
(define (bst/insert! val tree)
  ; Space : Theta (log n) if balanced , up to Theta (n) otherwise
  ; Time : Theta (log n) if balanced , up to Theta (n) otherwise
  ;
  ; Recursive version (deferred set-left-subtree!)
  (check-binary-tree tree)
  (cond ((empty-binary-tree? tree)
         (make-node val *empty-binary-tree* *empty-binary-tree*))
        ((< val (node-value tree))
         (set-left-subtree! tree
                            (bst/insert! val (left-subtree tree))))
        (else
          (set-right-subtree! tree
                              (bst/insert! val (right-subtree tree))))))
(test-bst/insert!)

; > below are a set of increasingly " better " solutions that try to
; > (the tree return values count as deferred operations)
;; Here actually we only need to set! for the deepest subtree, so we only use `set-left-subtree!` for (empty-binary-tree? ...).

;; `(iter handle)` is one iteration where we all use `(make-node val *empty-binary-tree* *empty-binary-tree*)` to avoid "deferred operations".

;; IGNORE: IMHO the last doesn't solve the problem solved by the second to last.
;; IMHO the last just tries to avoid using `set-cdr!` which is less readable?
(define (bst/insert! val tree)
  ; Space : Theta (1) always
  ; Time : Theta (log n) if balanced , up to Theta (n) otherwise
  ;
  ; Okay , this one actually is iterative . We create a handle : a cons cell that
  ; has a dummy car part and whose cdr part points to the subtree we 're handling .
  ; We use the handle to simulate pass-by-reference (note : this is actually quite
  ; similar to the way C simulates pass-by-reference by using pointers).
  (define (iter handle)
    (cond
      ; Here it 's easiest to handle the error condition first
      ((not (binary-tree? (cdr handle)))
       (error " not a tree :" (cdr handle)))
      ; special base case : create a new node if the original tree was empty . Note :
      ; the handle will never be null (it 's an extra cons cell that was tacked onto
      ; our tree) , so it 's always safe to set-cdr! to it.
      ((empty-binary-tree? (cdr handle))
       (set-cdr! handle (make-node val *empty-binary-tree* *empty-binary-tree*)))
      ; Need to go down the left subtree?
      ((< val (node-value (cdr handle)))
       (if (empty-binary-tree? (left-subtree (cdr handle)))
         ; we 're about to walk off the tree to the left , so stop early and
         ; attach a new node
         (set-left-subtree! (cdr handle)
                            (make-node val *empty-binary-tree* *empty-binary-tree*))
         ; create a new handle and step down the left subtree
         (iter (cons '() (left-subtree (cdr handle))))))
      ; right subtree case looks similar to the left subtree ...
      (else
        (if (empty-binary-tree? (right-subtree (cdr handle)))
          (set-right-subtree! (cdr handle)
                              (make-node val *empty-binary-tree* *empty-binary-tree*))
          (iter (cons '() (right-subtree (cdr handle))))))))
  ; First , create and keep a handle to the root of our tree . This allows us to
  ; handle null trees
  (let ((handle (cons '() tree)))
    ; Do the mutating insertion . Its return value is undefined .
    (iter handle)
    (cdr handle)))
; (define (null-init-test-bst/insert!)
;   (define test-tree '())
;   (bst/insert! 1 test-tree)
;   (displayln test-tree)
;   (bst/insert! 2 test-tree)
;   (displayln test-tree)
;   (bst/insert! 3 test-tree)
;   test-tree
;)
; (null-init-test-bst/insert!)

;; > Let's make a more efficient version that stops wasting time with append!:
;; i.e. use iter and then construct step by step without duplication.
(define (binary-tree->list tree)
  (check-binary-tree x)

  (if (empty-binary-tree? tree)
    '()
    ;; I don't know how to concatenate 2 lists efficiently.
    (cons (node-value tree) (append (binary-tree->list (left-subtree tree)) (binary-tree->list (right-subtree tree))))
    )
  )

;; sol
;; Here `tail` means tail recursion instead of elements from the right tail (actaully the elements are added from left).
;; Here `(list '())` is to ensure the 1st `set-cdr!` work, so at the end we do `(cdr answer-handle)`.
(define (binary-tree->list tree)
  ; efficient version
  ; Space : Theta (n)
  ; Time : Theta (n)
  (define (iter tail node)
    (check-binary-tree node)
    (if (empty-binary-tree? node)
      tail ; add nothing.
      ;; Notice although tail is local, we add values based on the old tail and then return back, so it works.
      (begin
        (set! tail (iter tail (left-subtree node)))
        (set-cdr! tail (list (node-value node)))
        ;; add right-subtree. Notice (cdr tail) has node-value.
        (iter (cdr tail) (right-subtree node)))))
  (trace iter)
  (let ((answer-handle (list '())))
    (iter answer-handle tree)
    (cdr answer-handle)))
(define (test-binary-tree->list)
  (define test-tree (make-node 0 *empty-binary-tree* *empty-binary-tree*)) ; not use *empty-binary-tree* to avoid change that.
  (bst/insert! 1 test-tree)
  (displayln test-tree)
  (bst/insert! 2 test-tree)
  (displayln test-tree)
  (bst/insert! 3 test-tree)
  (displayln test-tree)

  (binary-tree->list test-tree)
  )
(test-binary-tree->list)