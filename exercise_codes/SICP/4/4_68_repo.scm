(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

(query-driver-loop)

(assert! (rule (reverse () ())))
(assert! (rule (reverse (?x . ?y) ?z)
               (and (append-to-form ?w (?x) ?z)
                    (reverse ?y ?w))))

;; infinite due to (append-to-form ?w (1) ?z) will call itself always without generating even 1 frame.
(reverse (1 2 3) ?x)
;; 0. (append-to-form ?w (?x) (1 2 3)) will have finite results and ?w is the proper subset of (1 2 3).
;; 0.a. proper subset
;; Due to all are matched to (append-to-form () ?y ?y) at last.
;; (?x) will be matched against (3).
(reverse ?x (1 2 3))
