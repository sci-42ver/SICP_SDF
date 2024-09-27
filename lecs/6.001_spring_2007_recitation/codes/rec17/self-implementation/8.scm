(cd "~/SICP_SDF/lecs/6.001_spring_2007_recitation/codes/rec17/self-implementation")
(load "init-load.scm")

(cd "~/SICP_SDF/lecs/6.001_spring_2007_recitation/codes/rec17")
(load "lib/misc-lib.scm")
(load "lib/test-lib.scm")

(define (wit-professor self name birthplace activity miserly)
  ;; See sample-implementation.scm.
  (let ((autonomous-person-part (autonomous-person self name birthplace activity miserly)))
    (make-handler
      'wit-professor
      (make-methods
        'INSTALL
        (lambda ()
          (ask autonomous-person-part 'INSTALL)
          (ask clock 'ADD-CALLBACK
               (create-clock-callback 'teach-someone self 
                                      'TEACH-SOMEONE))
          (ask screen 'TELL-WORLD
               (list "create one professor" (ask self 'NAME)))
          )
        'TEACH-SOMEONE
        (lambda ()
          (let ((student 
                  (pick-random 
                    ;; Better to use one more specific `student?`
                    (filter autonomous-person? (ask self 'PEOPLE-AROUND))
                    )))
            (if student
              (let ((spell-choice (pick-random (ask chamber-of-stata 'THINGS))))
                (clone-spell spell-choice student)
                (ask screen 'TELL-WORLD
                     (list (ask self 'NAME) "taught" (ask student 'NAME) (ask spell-choice 'NAME)))
                )
              'do-nothing)))
        ;; See sample-implementation.scm. Similar to wit-student, we need to specialize `'DIE`.
        )
      autonomous-person-part
      )))

(define (create-wit-professor name birthplace activity miserly)
  (create-instance wit-professor name birthplace activity miserly))

(define (populate-players rooms)
  (displayln (list "use local populate-players"))
  (let* ((students (map (lambda (name)
                          (create-autonomous-person name
                                                    (pick-random rooms)
                                                    (random-number 3)
                                                    (random-number 3)))
                        '(ben-bitdiddle alyssa-hacker
                                        course-6-frosh lambda-man)))
         ;uncomment after writing professors
         (profs (map (lambda (name)
                       (create-wit-professor name
                                            ;  (pick-random rooms)
                                            ;; for test
                                             (ask (car students) 'LOCATION)
                                             (random-number 3)
                                             (random-number 3)))
                     '(susan-hockfield eric-grimson)))
         (monitors (map (lambda (name)
                          (create-hall-monitor name
                                               (pick-random rooms)
                                               (random-number 3)
                                               (random-number 3)))
                        '(dr-evil mr-bigglesworth)))
         (trolls (map (lambda (name)
                        (create-troll name
                                      (pick-random rooms)
                                      (random-number 3)
                                      (random-number 3)))
                      '(grendel registrar))))

    (append students
            profs        ;uncomment after writing wit-professor
            monitors trolls)))

(set-up-cnt 5 'foo #f)
