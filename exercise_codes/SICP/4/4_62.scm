(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

(query-driver-loop)

;; meteorgan's with base is better.
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

(last-pair (3) ?x)
(last-pair (1 2 3) ?x)
(last-pair (2 ?x) (3))
;; 0. similar to reverse, can't.
;; But this also can't when we directly think about this pattern since it is infinite.
;; 1. Here it just outputs with placeholders.
(last-pair ?x (3))

;; see repo
;; swap the order
(assert!
  (rule (last-pair (?u . ?v) (?x))
      (last-pair ?v (?x))))
(assert! (rule (last-pair (?x) (?x))))
(last-pair ?x (3))
