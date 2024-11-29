(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

;; 0. https://en.wikipedia.org/wiki/Foobar#cite_note-1
;; 1. test whether we should use partial info from frame-stream.
(query-driver-loop)
(assert! (qux qux-person))
(assert! (baz baz-person))
(assert! (bar bar-person))
(assert! (foo foo-person))
(and
  ;; based on interleave-delayed, car is (bar ?person-1) result.
  (or (bar ?person-1) (foo ?person-2))
  (not (qux ?person-1))
  (baz ?person-1)
  )
; null

(and
  (or (bar ?person-1) (foo ?person-2))
  (baz ?person-1)
  (not (qux ?person-1))
  )
;; Here (bar baz-person) should be omitted since we choose (foo foo-person) for or.
; (and (or (bar baz-person) (foo foo-person)) (baz baz-person) (not (qux baz-person)))

;; 
(and (not (fum ?x)))
