;; not work
(use-modules (system syntax))

(define aux-property (make-object-property))
(define-syntax-rule (with-aux aux value)
  (let ((trans value))
    (set! (aux-property trans) aux)
    trans))
(define-syntax retrieve-aux
  (lambda (x)
    (syntax-case x ()
      ((x id)
       (call-with-values (lambda () (syntax-local-binding #'id))
         (lambda (type val)
           (with-syntax ((aux (datum->syntax #'here
                                             (and (eq? type 'macro)
                                                  (aux-property val)))))
             #''aux
            ;  (aux-property val)
             )))))))
(define-syntax foo
  (with-aux 'bar
    (syntax-rules () ((_) 'foo))))
(foo)
; ⇒ foo
(retrieve-aux foo)
; ⇒ bar