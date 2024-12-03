(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

(query-driver-loop)
(assert! (rule (big-shot ?person-1)
               (and (job ?person-1 (?division . ?rest))
                    ;; 0. See wiki, "does not have a supervisor who works in the division." has 2 cases.
                    ;; 0.a. IMHO "recursive" implies wheel or outranked-by which is not needed by the exercise.
                    ;; So carpdiem's is not needed. 
                    ;; IGNORE: And imelendez's lacks one case "(not (supervisor ?person ?boss))".
                    ;; imelendez's is more straightforward based on "does not"->not.
                    (supervisor ?person-1 ?p2)
                    (not (job ?p2 (?division . ?rest2))))))

;; 
(assert! (rule (big-shot ?person ?division) 
              (and (job ?person (?division . ?rest)) 
                    (or (not (supervisor ?person ?boss)) 
                        (and (supervisor ?person ?boss) 
                            (not (job ?boss (?division . ?r))))))))

(big-shot ?x)
(big-shot ?x ?y)
; (big-shot (warbucks oliver) administration)
; (big-shot (scrooge eben) accounting)
; (big-shot (bitdiddle ben) computer)

