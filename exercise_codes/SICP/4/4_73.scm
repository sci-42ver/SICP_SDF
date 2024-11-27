(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")
(cd "~/SICP_SDF/exercise_codes/SICP/3/")
(load "book-stream-lib.scm")

(define (flatten-stream stream)
  (if (stream-null? stream)
      the-empty-stream
      (interleave
       (stream-car stream)
       (flatten-stream (stream-cdr stream)))))

(trace conjoin)

(query-driver-loop)
;; from repo
(assert! (completes Batman Joker))
(assert! (completes Batman Bane))
(assert! (rule (completes ?x ?y) (completes ?y ?x)))
(and (completes ?who Joker)
    ;; Here will pass the infinite stream
     (completes ?who Bane))
;; if use no delay, stuck at
; [Entering #[compound-procedure 14 conjoin]
;     Args: ((completes (? who) bane))
;           {(((? who) . batman)) ...}]
