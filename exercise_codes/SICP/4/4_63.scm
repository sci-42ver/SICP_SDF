(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

(initialize-data-base (append microshaft-data-base
  '((son Adam Cain)
(son Cain Enoch)
(son Enoch Irad)
(son Irad Mehujael)
(son Mehujael Methushael)
(son Methushael Lamech)
(wife Lamech Ada)
(son Ada Jabal)
(son Ada Jubal))
  ))

(query-driver-loop)

;; https://www.biblegateway.com/passage/?search=Genesis%204&version=NIV
;; Adam's son is Cain
;; It's fine to also define one rule with the same name as one assertion.
(assert! (rule (son ?f ?s) 
              (and (wife ?f ?w) 
                  (son ?w ?s))))

(assert! (rule (grandson ?g ?s) 
              (and (son ?f ?s) 
                    (son ?g ?f))))

(grandson Cain ?s) 

(son Lamech ?s)

(grandson Methushael ?s)
