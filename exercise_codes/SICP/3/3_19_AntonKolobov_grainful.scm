;;; This just generalize https://en.wikipedia.org/wiki/Cycle_detection#Floyd's_tortoise_and_hare to 2d.
(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "../lib.scm")

(define (has-cycle? tree) 
  ;; Helpers
  (define node-value cdr)
  (define node-path-from-root car)
  (define (make-node path val) 
    (assert (number? path))
    (cons path val))
  ;; 0. 000 means keeping car, 001 means cdr,car...
  ;; 0.1 So here all path are stored as the above number.
  ;; 1. Here I parse number from right since IMHO normal calculation follows this pattern so that that is more convenient
  (define (walk-based-on-idx idxed-node idx walked-steps node-path-len)
    (let ((node (node-value idxed-node))
          (path-num (node-path-from-root idxed-node)))
      (define (add-path orig-path addend orig-path-len)
        (+ (* addend (expt 2 orig-path-len)) orig-path)
        )
      (define (iter node idx walked-steps addend-path-idx)
        (if (= 0 walked-steps)
          (make-node (add-path path-num addend-path-idx node-path-len) node)
          (if (pair? node)
            (iter 
              ((if (even? idx)
                car
                cdr)
                node) 
              (quotient idx 2) (- walked-steps 1) addend-path-idx)
            #f)))
      (iter node idx walked-steps idx)))
  (define (forward-n-steps n node node-path-len)
    (filter-map (lambda (idx) (walk-based-on-idx node idx n node-path-len)) (iota (expt 2 n))))
  (define (fast-nodes-forward-2steps fast-nodes node-path-len-from-root)
    (reduce append '() (map (lambda (node) (forward-n-steps 2 node node-path-len-from-root)) fast-nodes)))
  (define (match-idxed-code root idxed-node)
    (assert (pair? idxed-node))
    (eq? root (node-value idxed-node)))
  (define (filter-branches idxed-nodes path-num-end end-digit-num)
    (define (pred idxed-node path-num-end)
      (let ((path-num (node-path-from-root idxed-node)))
        (= (remainder path-num (expt 2 end-digit-num)) path-num-end)))
    (filter (lambda (node) (pred node path-num-end)) idxed-nodes))
  (define (drop-first-path idxed-node)
    (let ((node (node-value idxed-node))
          (path-num (node-path-from-root idxed-node)))
      (make-node (quotient path-num 2) node)))
  (define (drop-first-path-step-for-all idxed-nodes)
    (map (lambda (node) (drop-first-path node)) idxed-nodes))
  (define (filter-left-left idxed-nodes)
    ;; 00
    (filter-branches idxed-nodes 0 2)
    )
  (define (filter-left-right idxed-nodes)
    ;; 10
    (filter-branches idxed-nodes 2 2)
    )
  (define (filter-right-left idxed-nodes)
    ;; 01
    (filter-branches idxed-nodes 1 2)
    )
  (define (filter-right-right idxed-nodes)
    ;; 11
    (filter-branches idxed-nodes 3 2)
    )

  ;; 0. From original
  ;; slow-it - tracks each node (1, 2, 3, 4...) 
  ;; fast-it - tracks only even nodes (2, 4...)  
  ;; 0.0
  ;; Here root is just slow-it which has run clock-cnt steps.
  ;; Then list all possible fast-it by left-fast-nodes etc and check whether they are equal.
  ;; 1.
  ;; when car, 
  ;; root -> (car root)
  ;; fast-node: (path-from-root node)
  ;;; IMHO first append is better, since both are about left-fast-nodes.
  ;; left-fast-nodes -> list of ((remove-car-path-then-choose-left-then-append path-from-root) (forward node)) from left-fast-nodes
  ;; i.e. choose 00 ending.
  ;; right-fast-nodes -> list of ((remove-car-path-then-choose-right-then-append path-from-root) (forward node)) from left-fast-nodes
  ;; i.e. choose 10 ending.
  ;;; Then cdr is similar.
  ;;; Then we don't need to expand clock-cnt steps but just 2 steps. Here I assume time complexity is considered more than space.
  ;; 1.1
  ;; left-fast-node has path-num from idxed-root inside itself.
  ;; root has no path-num.
  (define (dfs root left-fast-nodes right-fast-nodes clock-cnt)
    (displayln (list "clock-cnt" clock-cnt))
    (if (not (pair? root))
      #f
      (if 
        (or
          (any (lambda (idxed-node) (match-idxed-code root idxed-node)) left-fast-nodes)
          (any (lambda (idxed-node) (match-idxed-code root idxed-node)) right-fast-nodes))
        #t
        (let ((clock-cnt-updated (+ 1 clock-cnt))
              (left (car root))
              (right (cdr root))
              (left-forwarded-fast-nodes (fast-nodes-forward-2steps left-fast-nodes clock-cnt))
              (right-forwarded-fast-nodes (fast-nodes-forward-2steps right-fast-nodes clock-cnt))
              )
          ; (bkpt "debug")
          (or 
            (dfs left 
              ;; first filter, then `drop-first-path-step-for-all` may  probably have less to process.
              ;; This is more efficient than the alternative order of these 2 operations.
              (drop-first-path-step-for-all (filter-left-left left-forwarded-fast-nodes))
              (drop-first-path-step-for-all (filter-left-right left-forwarded-fast-nodes))
              clock-cnt-updated)
            (dfs right 
              (drop-first-path-step-for-all (filter-right-left right-forwarded-fast-nodes))
              (drop-first-path-step-for-all (filter-right-right right-forwarded-fast-nodes))
              clock-cnt-updated) 
            ))
        ))
    )
  ;; clock-cnt=0
  ;; This is to make dfs have the same start as wikipedia "Floyd's "tortoise and hare" cycle" image.
  (define (dfs-starter root clock-cnt)
    (if (not (pair? root))
      #f
      (let* ((clock-cnt-updated (+ 1 clock-cnt))
            (left (car root))
            (right (cdr root))
            (left-forwarded-fast-nodes (forward-n-steps 1 (make-node 0 left) 1))
            (right-forwarded-fast-nodes (forward-n-steps 1 (make-node 1 right) 1))
            )
        ; (bkpt "debug")
        (or 
            (dfs left 
              (drop-first-path-step-for-all (filter-left-left left-forwarded-fast-nodes))
              (drop-first-path-step-for-all (filter-left-right left-forwarded-fast-nodes))
              clock-cnt-updated)
            (dfs right 
              (drop-first-path-step-for-all (filter-right-left right-forwarded-fast-nodes))
              (drop-first-path-step-for-all (filter-right-right right-forwarded-fast-nodes))
              clock-cnt-updated) 
            )
        )
      ))
  ; (trace dfs)
  ; (trace dfs-starter)
  ; (dfs tree (iterator tree 0) (iterator '() 0) 0)
  (dfs-starter tree 0)
  )

(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "3_18_19_tests.scm")
(full-test-with-3-32-and-4-34-tests has-cycle?)