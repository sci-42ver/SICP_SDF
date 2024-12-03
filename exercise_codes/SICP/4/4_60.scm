(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

(query-driver-loop)
;; 0. see wiki for one more general version
;; 1. datasnake's problem is implied by the ordering needed to avoid duplication
(assert!
  (rule (unidirectional-lives-near ?person-1 ?person-2)
      (and 
        ; (lisp-value (lambda (name-str1 name-str2) (symbol<? (car name-str1) (car name-str2))) ?person-1 ?person-2)
        (lives-near ?person-1 ?person-2)
        ;; It needs ?person-1 etc val's as 4.77 shows.
        (lisp-value (lambda (name-str1 name-str2) (symbol<? (car name-str1) (car name-str2))) ?person-1 ?person-2)
        )))

(unidirectional-lives-near ?person-1 ?person-2)
