(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")
(cd "~/SICP_SDF/exercise_codes/SICP/3/")
(load "book-stream-lib.scm")

;; just as append implies, the latter won't be checked due to the former being infinite.
; (define (disjoin disjuncts frame-stream)
;   (if (empty-disjunction? disjuncts)
;       the-empty-stream
;       (stream-append-delayed
;        (qeval (first-disjunct disjuncts) frame-stream)
;        (delay (disjoin (rest-disjuncts disjuncts)
;                        frame-stream)))))
; (put 'or 'qeval disjoin)
; (pp (get 'or 'qeval))
;; The above will keep "(or (killed kenny they) (killed pooh ?who2))".

(query-driver-loop)

;; from SICP/4_Metalinguistic_Abstraction/4.4_Logic_Programming/Exercise_4_72.rkt
(assert! (killed They Kenny))
(assert! (killed Randy Pooh))
(assert! (rule (killed ?x ?y) (killed ?y ?x)))
;; IMHO here using 2 distinct ?who's is more appropriate.
; (or (killed Kenny ?who)
;     (killed Pooh ?who))
; (or (killed Kenny ?who1)
;     (killed Pooh ?who2))

(assert! (married Minnie Mickey))
(assert! (married Randy Pooh))
(assert! (rule (married ?x ?y)
               (married ?y ?x)))
(or (married Mickey ?who1)
    (married Pooh ?who2)
    )
;; loop
; (or (married mickey minnie) (married pooh ?who2))
; (or (married mickey ?who1) (married pooh randy))
