(cd "~/SICP_SDF/lecs/CS_61A/lib")
(load "vambeval.scm")

; (mce)

; (if #t
;   1
;   2)
; 1

;; comments are not read by (read)
(define (eval-if exp env succeed fail)
  ; WRONG!
  (if (ambeval (if-predicate exp) env succeed fail)
    (begin
      (write-line "run consequent")
      (ambeval (if-consequent exp) env succeed fail))
    (begin
      (write-line "run alternative")
      (ambeval (if-alternative exp) env succeed fail))
    ))

(mce)

;;; 
(if #t
  1
  2)
; #t

;; if fail, then the 1st expectedly calls fail.
(if (amb)
  1
  2)

(if n ; error thrown by lookup-variable-value
  1
  2)
