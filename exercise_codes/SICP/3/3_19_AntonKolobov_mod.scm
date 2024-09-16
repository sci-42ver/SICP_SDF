(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "../lib.scm")

(define (has-cycle? tree)
  ;; Helpers 
  (define (iterator value idx) 
    (cons value idx)) 
  (define (update-iterator it value idx) 
    (set-car! it value) 
    (set-cdr! it idx)) 
  (define (iterator-id it) 
    (cdr it)) 
  (define (iterator-value it) 
    (car it)) 
  (define (iterator-same-pos? it1 it2) 
    (eq? (iterator-id it1) (iterator-id it2))) 
  (define (iterator-eq? it1 it2) 
    (and (iterator-same-pos? it1 it2) 
         (eq? (iterator-value it1) (iterator-value it2)))) 
  (define (iterator-same-value? it1 it2) 
    (eq? (iterator-value it1) (iterator-value it2))) 

  ;; slow-it - tracks each node (1, 2, 3, 4...) 
  ;; fast-it - tracks only even nodes (2, 4...)  
  (define (dfs root slow-it fast-it clock-cnt)
    (displayln (list "clock-cnt" clock-cnt))
    (if (not (pair? root)) ; leaf as the base case.
      false 
      (let* ((clock-cnt-updated (+ 1 clock-cnt)) ; put first to ensure the first set is when clock-cnt-updated=2 instead of clock-cnt=0.
            (slow-it-updated 
              ;; Here the minimal step is 2 clock-cnt's.
              ;; Still work since x_i=x_{2i} -> x_{2i}=x_{4i}, so if x_{2i}!=x_{4i} -> x_i!=x_{2i} -> not have cycle.
              ;; And trivially x_{2i}=x_{4i} -> have cycle.
              (if 
                (and (even? clock-cnt-updated) 
                      (iterator-same-pos? slow-it fast-it)) 
                ; (odd? clock-cnt-updated)
                (begin
                  (displayln "update slow-it")
                  (iterator root clock-cnt-updated))
                slow-it))
            (fast-it-updated
              (if (even? clock-cnt-updated) 
                (iterator root (+ (iterator-id fast-it) 1))
                fast-it))
            )
        (if 
          (iterator-eq? slow-it fast-it) 
          ; (iterator-same-value? slow-it fast-it)
          true 
          (or (dfs (car root) slow-it-updated fast-it-updated clock-cnt-updated) 
              (dfs (cdr root) slow-it-updated fast-it-updated clock-cnt-updated)))))) 
  ; (trace dfs)
  (dfs tree (iterator tree 0) (iterator '() 0) 0))

(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "3_18_19_tests.scm")
(test has-cycle?)
(assert (has-cycle? cycle-1))