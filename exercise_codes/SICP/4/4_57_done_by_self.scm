(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

(query-driver-loop)

;; 0. Their orders are not same maybe due to stream-flatmap for each simple query.
;; 1.  Similar to repo except for not part.
(assert! 
  (rule (replace ?person1 ?person2)
    (and (job ?person1 ?job1)
      (job ?person2 ?job2)
      ;; IMHO this is better to filter immediately when possible.
      (not (same ?person1 ?person2))
      (or (same ?job1 ?job2)
        ;; Here job1 can be still same as job2
        (can-do-job ?job1 ?job2)
        )
      )
    ))

;; from wiki
; (assert!
;   (rule (replace ?person1 ?person2) 
;     (and (job ?person1 ?job1) 
;         (or (job ?person2 ?job1) 
;             (and (job ?person2 ?job2) 
;                   (can-do-job ?job1 ?job2))) 
;         (not (same ?person1 ?person2)))) )

(replace (Fect Cy D) ?x)
; (replace (fect cy d) (reasoner louis))
; (replace (fect cy d) (hacker alyssa p))

(replace ?x (Fect Cy D))
; (replace (hacker alyssa p) (fect cy d))
; (replace (bitdiddle ben) (fect cy d))

(and (replace ?x ?y)
  (salary ?x ?amount1)
  (salary ?y ?amount2)
  (lisp-value > ?amount2 ?amount1)
  )
; (and (replace (fect cy d) (hacker alyssa p)) (salary (fect cy d) 35000) (salary (hacker alyssa p) 40000) (lisp-value > 40000 35000))
; (and (replace (aull dewitt) (warbucks oliver)) (salary (aull dewitt) 25000) (salary (warbucks oliver) 150000) (lisp-value > 150000 25000))
