(cd "~/SICP_SDF/lecs/6.001_fall_2007_recitation/codes/rec15")
(load "rb-lib.scm")

;tagged list (ring-buffer capacity number-filled next-to-read next-to-fill)
(define (make-rb n)
  (let ((rl (make-list n 'foo)))
    (make-ring! rl)
    (list 'ring-buffer n 0 rl rl)))

;; sol should be 
; (let ((rl ((repeated (lambda (x) (cons 'empty x)) n)
;            '()))) ...)