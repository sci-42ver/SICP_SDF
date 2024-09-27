(load "sample-implementation-objsys.scm")
(load "sample-implementation-objtypes.scm")
(load "sample-implementation-setup.scm")

(define test-place (create-place 'test-place))
(define person-1 (create-person 'person-1 test-place))

(define test-chosen-one (create-chosen-one 'test-chosen-one test-place 10 10))
(ask test-chosen-one 'SUFFER 10 person-1)

;; wrong
(ask test-chosen-one 'HEALTH)