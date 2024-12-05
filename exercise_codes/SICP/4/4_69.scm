(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "4_63.scm")

;; from 4.63
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
(assert! (rule (son ?f ?s) 
              (and (wife ?f ?w) 
                  (son ?w ?s))))

(assert! (rule (grandson ?g ?s) 
              (and (son ?f ?s) 
                    (son ?g ?f))))

;; See wiki based on last-pair.
(assert! (rule (ends-with-grandson (?x . ?rest))
              (ends-with-grandson ?rest)))
(assert! (rule (ends-with-grandson (grandson))))

;; TODO loop
(assert! (rule ((great grandson) ?x ?y)
              (and (grandson ?gf ?y)
                (son ?x ?gf)
                )))
; (assert! (rule ((grandson) ?x ?y) (grandson ?x ?y)))

(assert! (rule ((great . ?rel) ?x ?y)
              (and
                ;; Wrong since rel is unbound and then recursive calls are also unbound... 
                ; (ends-with-grandson ?rel)
                ;; put first since it can always restrict one more if ?x is bound and has one son.
                ; (?son ?x ?gf) ; Emm... not use ?son...
                (son ?x ?gf)
                (?rel ?gf ?y)
                (ends-with-grandson ?rel)
                )))

; (wife Jabal ?w)
; (and (wife Jabal ?w) 
;   (son ?w ?s))
; (son Jabal ?gf)
; (?rel Jabal ?y)

; (?relationship Adam ?y)

((great grandson) ?g ?ggs)
(?relationship Adam Irad)
(?relationship Adam Jabal)
