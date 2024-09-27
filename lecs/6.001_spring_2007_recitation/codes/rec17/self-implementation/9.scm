(cd "~/SICP_SDF/lecs/6.001_spring_2007_recitation/codes/rec17/self-implementation")
(load "init-load.scm")
(load "2.scm")

(cd "~/SICP_SDF/lecs/6.001_spring_2007_recitation/codes/rec17")
(load "lib/misc-lib.scm")
(load "lib/test-lib.scm")

;; similar to spell
;; See sample-implementation.scm
(define (counterspell self name location)
  (let ((mobile-part (mobile-thing self name location)))
    (make-handler
      'counterspell
      (make-methods
        ;; wrong due to lacking something
        ;; > cast a *specific* spell on a target
        )
      mobile-part)))

(define (spell self name location incant action)
  (let ((mobile-part (mobile-thing self name location)))
    (make-handler
      'spell
      (make-methods
        'INCANT
        (lambda () incant)
        'ACTION
        (lambda () action)
        'USE
        (lambda (caster target)
          ;; modifed
          (if (ask target 'HAS-A 'counterspell)
            'do-nothing
            (action caster target))
          ))
      mobile-part)))