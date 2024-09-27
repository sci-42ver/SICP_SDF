(cd "~/SICP_SDF/lecs/6.001_spring_2007_recitation/codes/rec17")
(load "objsys.scm")
(load "objtypes.scm")
(load "setup.scm")

(define (container self)
  (let ((root-part (root-object self))
        (things '()))
    (make-handler
      'container
      (make-methods
        'THINGS      (lambda () things)
        ;; added
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

(setup 'foo)
(ask me 'look-around)
(ask me 'take (thing-named 'boil-spell))
;; > Demonstrate them working on some test cases.
(ask me 'HAS-A 'spell)
(ask me 'HAS-A-THING-NAMED 'slug-spell)
(ask me 'HAS-A-THING-NAMED 'boil-spell)