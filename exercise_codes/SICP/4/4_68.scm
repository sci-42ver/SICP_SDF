(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

(query-driver-loop)
;; 2 to 1 is fine.
(append-to-form ?x (2 3) (1 2 3))

(assert! 
  (rule (reverse () ?z)
    (same () ?z)
    ))
; (assert! 
;   (rule (reverse (?u . ?v) ?z)
;       ;; consider ?v is ()
;       ;; This can't call rule.
;       (append-to-form (reverse ?v) (?u) ?z)))

;; to support both, but may cause infinite loop just like married.
; (assert! 
;   (rule (reverse ?x ?y)
;     (reverse ?y ?x)
;     ))

; (assert! (rule (reverse () ())))

;; wiki poly
;; just uses and to call reverse internally.
(assert! (rule (reverse (?x . ?y) ?z)
               (and (reverse ?y ?v)
                    (append-to-form ?v (?x) ?z))))

(reverse (1 2 3) ?x)
; (reverse (1) ?x)

;; fail due to ?x can't be matched
;; Then it end up calling (reverse ?y ?v) always uselessly.
(reverse ?x (1 2 3))


