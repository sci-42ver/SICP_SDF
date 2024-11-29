(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

(query-driver-loop)

(assert! (rule (same ?x ?x)))
(assert! (rule (replace ?person-1 ?person-2)
               (and (job ?person-1 ?person-1-job)
                    (job ?person-2 ?person-2-job)
                    (or (same ?person-1-job ?person-2-job)
                        (can-do-job ?person-1-job ?person-2-job))
                    (not (same ?person-1 ?person-2)))))
;; a:
(replace ?x (Fect Cy D))
; or generates the seeming duplicate results
; (replace (bitdiddle ben) (fect cy d))
; (replace (hacker alyssa p) (fect cy d))
; (replace (hacker alyssa p) (fect cy d))
