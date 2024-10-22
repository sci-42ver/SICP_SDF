(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "4_11_lib.scm")

;; hinted by repo
;; same as 4_11.scm
(define (make-frame variables values)
  ;; wiki is more robust.
  (map (lambda (var val) (cons var val)) variables values))
(define (frame-variables frame) (map car frame))
(define (frame-values frame) (map cdr frame))