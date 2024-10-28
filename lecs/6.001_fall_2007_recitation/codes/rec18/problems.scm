(cd "~/SICP_SDF/lecs/6.001_fall_2007_recitation/codes/rec18")
(load "interpreter.scm")

;; different from read, here quote is not passed in.
;; different from book one.
; 1 ]=> (driver-loop)
; ;;; M-Eval input:
; 'x
; ;;; M-Eval value:
; x

(eval 'x *GE*)
(eval ''x *GE*)

;; The pdf adds one unnecessary eval.
(eval '(> x 4)
      (extend *GE*
              '(x)
              (list 3)))

(eval '((lambda (x) (+ x 2)) 5) *GE*)

(eval '(cond ((> x 4) (quote a))
             ((> 1 x) (quote b))
             (else (quote c)))
      (extend *GE*
              '(x)
              (list 2)))

;; 5 already done in the book
;; Same for 6.