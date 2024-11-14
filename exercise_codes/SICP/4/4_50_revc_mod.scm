(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "4_50_revc_mod_lib.scm")

(driver-loop)
(define (require p)
  (if (not p) (ramb)))

(define (an-integer-between low high) 
  (require (<= low high))
  ; (display)
  (ramb (<Prob> low 1) (<Prob> (an-integer-between (+ low 1) high) (- high low)))) 

;;;;;;;;;;;;;;; 
;;;; test;;;;;; 
;;;;;;;;;;;;;;; 
;; can implement one true uniform distribution for an-integer-between.
(an-integer-between 1 1000)
(an-integer-between 1 10)
(an-integer-between 1 10)
(an-integer-between 1 10)
(an-integer-between 1 10)
