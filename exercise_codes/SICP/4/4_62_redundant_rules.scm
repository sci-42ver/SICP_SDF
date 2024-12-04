(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

(query-driver-loop)

;; whether to use this will generate the different results. 
(assert! 
  ;; Won't work for (last-pair (2 ?x) (3)).
  (rule (last-pair (?u . ?v) ?y)
      (or 
        (and 
          ;; will bind ?v->?x->().
          (same ?v ())
          ;; For `(2 ?x) (3)`, ?x->?y->(3), ?x->...(3)->(?u). Then ?u->3, i.e. ?x-input.
          (same ?y (?u)))
        (last-pair ?v ?y)
        ))
  )
(assert!
  (rule (last-pair (?u . ?v) (?x))
      (last-pair ?v (?x))))
(assert! (rule (last-pair (?x) (?x))))
(last-pair ?x (3))
