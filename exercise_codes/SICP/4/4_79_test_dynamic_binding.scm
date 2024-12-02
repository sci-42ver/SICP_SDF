(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

(query-driver-loop)
(assert! 
  (rule (outer ?x)
    (inner ?y)
    ))

(assert! 
  (rule (inner ?y)
    (base ?x)
    ))

(assert! (base Foo))

(outer ?x)
