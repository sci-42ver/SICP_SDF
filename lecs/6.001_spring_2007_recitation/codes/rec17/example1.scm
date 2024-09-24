(load "objsys.scm")

;; Lect16 p2
(define (create-person name)
  (create-instance person name))
(define (person self name)
  (let (
        (root-part (root-object self)) ; modified for compatibility
        )
    (lambda (message)
      (case message
        ((TYPE) (lambda () (type-extend 'person root-part)))
        ((WHOAREYOU?)
         (lambda () name))
        ((SAY)
         (lambda (stuff) stuff))
        (else (get-method message root-part))))))

(define p1 (create-person 'joe))
(ask p1 'whoareyou?)
; ⇒ joe
(ask p1 'say '(the sky is blue))
; ⇒ (the sky is blue)
