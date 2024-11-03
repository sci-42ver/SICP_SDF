;; This problem is found when transforming (let ((x ... in 4_34_revc.scm to 2 define's...
;; I was wrong to suspect that the order may influence the result...
(define (test)
  ; (cond (else (define x 2) x))
  (define (test2)
    ;; will have ";Definition may not be used as an expression: #[defn-item 12 #[uninterned-symbol 13 .x.1] #[expr-item 14]]"
    (if #t
      (cond (else (define x 2) x)))
    
    ;; but this will work.
    ; (cond (else (define x 2) x))
    )
  (test2)
  )
;; Both of the above are marked as "expression" in doc https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Definitions.html#index-define-1
;; The different results may be due to
;; > Definitions are valid in *some but not all* contexts where expressions are allowed.
(test)