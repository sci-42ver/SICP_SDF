(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

(query-driver-loop)
(lives-near ?x (Bitdiddle Ben))

(assert! (rule (ignore ?x ?y)))
(or (ignore Foo ?x)
    ;; and, not
    (lives-near ?y (Bitdiddle Ben))
    ;; lisp-value
    (and (salary ?person ?amount)
     (lisp-value > ?amount 30000))
    )
; (or (ignore foo ?y-5) (lives-near ?y (bitdiddle ben)) (and (salary ?person ?amount) (lisp-value > ?amount 30000)))
; (or (ignore foo ?x) (lives-near (aull dewitt) (bitdiddle ben)) (and (salary ?person ?amount) (lisp-value > ?amount 30000)))
; (or (ignore foo ?x) (lives-near ?y (bitdiddle ben)) (and (salary (scrooge eben) 75000) (lisp-value > 75000 30000)))
; (or (ignore foo ?x) (lives-near (reasoner louis) (bitdiddle ben)) (and (salary ?person ?amount) (lisp-value > ?amount 30000)))
; (or (ignore foo ?x) (lives-near ?y (bitdiddle ben)) (and (salary (warbucks oliver) 150000) (lisp-value > 150000 30000)))
; (or (ignore foo ?x) (lives-near ?y (bitdiddle ben)) (and (salary (fect cy d) 35000) (lisp-value > 35000 30000)))
; (or (ignore foo ?x) (lives-near ?y (bitdiddle ben)) (and (salary (hacker alyssa p) 40000) (lisp-value > 40000 30000)))
; (or (ignore foo ?x) (lives-near ?y (bitdiddle ben)) (and (salary (bitdiddle ben) 60000) (lisp-value > 60000 30000)))

(and (job ?x (computer programmer))
     (lives-near ?x (Bitdiddle Ben)))

(and (job ?x (computer programmer))
     (supervisor ?x ?z))
; (and (job (fect cy d) (computer programmer)) (supervisor (fect cy d) (bitdiddle ben)))
; (and (job (hacker alyssa p) (computer programmer)) (supervisor (hacker alyssa p) (bitdiddle ben)))
