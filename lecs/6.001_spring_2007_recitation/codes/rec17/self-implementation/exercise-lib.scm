;; 2
(define (container self)
  (let ((root-part (root-object self))
        (things '()))
    (make-handler
      'container
      (make-methods
        'THINGS      (lambda () things)
        ;; added
        ;; sample-implementation.scm uses `(car (ask t 'TYPE))` which IMHO is not general.
        'HAS-A (lambda (typename) (filter (lambda (thing) (ask thing 'IS-A typename)) things))
        'HAS-A-THING-NAMED (lambda (typename) (filter (lambda (thing) (eq? typename (ask thing 'NAME))) things))
        'HAVE-THING? (lambda (thing)
                       (memq thing things)
                       )
        'ADD-THING   (lambda (thing)
                       (if (not (ask self 'HAVE-THING? thing))
                         (set! things (cons thing things)))
                       'DONE)
        'DEL-THING   (lambda (thing)
                       (set! things (delq thing things))
                       'DONE))
      root-part)))