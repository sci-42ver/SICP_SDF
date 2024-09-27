(cd "~/SICP_SDF/lecs/6.001_spring_2007_recitation/codes/rec17")
(load "objsys.scm")
(load "objtypes.scm")
(load "setup.scm")

(load "lib/misc-lib.scm")

;; > sense the locations of other people in the world
;; Similar to SDF "Exercise 3.19: A palantir".

;; > You will find the procedure all-people (see the file setup.scm) useful.
;; in SDF but not here.
(define all-people 'will-be-set-by-setup)
(define (setup name)
  (ask clock 'RESET)
  ;; to add back since having reset.
  (ask clock 'ADD-CALLBACK
       (create-clock-callback 'tick-printer clock 'PRINT-TICK))
  ;; > It has ... objects, 
  (let ((rooms (create-world)))
    (set! chamber-of-stata (instantiate-spells))

    (populate-spells rooms)

    ;uncomment after writing chosen one
    ;    (create-chosen-one 'hairy-cdr (pick-random rooms)
    ;		       (random-number 3) (random-number 3))

    (set! me (create-avatar name (pick-random rooms)))
    (ask screen 'SET-ME me)
    ;; added
    (set! all-people (cons me (populate-players rooms)))
    (set! all-rooms rooms)
    'ready))

(cd "~/SICP_SDF/exercise_codes/SICP")
(load "lib.scm")

(define (avatar self name birthplace)
  (let ((person-part (person self name birthplace)))
    (make-handler
      'avatar
      (make-methods
        ;; added
        'FEEL-THE-FORCE
        (lambda () 
          (for-each 
            (lambda (person)
              ;; See sample-implementation.scm where `display-message` is more appropriate.
              (displayln 
                (string-append 
                  (ask person 'NAME-STR)
                  " is at " 
                  (ask person 'NAME-STR))))
            all-people))

        'LOOK-AROUND          ; report on world around you
        (lambda ()
          (let* ((place (ask self 'LOCATION))
                 (exits (ask place 'EXITS))
                 (other-people (ask self 'PEOPLE-AROUND))
                 (my-stuff (ask self 'THINGS))
                 (stuff (ask self 'STUFF-AROUND)))
            ;; TODO shouldn't this be 'TELL-ROOM.
            (ask screen 'TELL-WORLD (list "You are in" (ask place 'NAME)))
            (ask screen 'TELL-WORLD
                 (if (null? my-stuff)
                   '("You are not holding anything.")
                   (append '("You are holding:") (names-of my-stuff))))
            (ask screen 'TELL-WORLD
                 (if (null? stuff)
                   '("There is no stuff in the room.")
                   (append '("You see stuff in the room:") (names-of stuff))))
            (ask screen 'TELL-WORLD
                 (if (null? other-people)
                   '("There are no other people around you.")
                   (append '("You see other people:") (names-of other-people))))
            (ask screen 'TELL-WORLD
                 (if (not (null? exits))
                   (append '("The exits are in directions:") (names-of exits))
                   ;; heaven is only place with no exits
                   '("There are no exits... you are dead and gone to heaven!")))
            'OK))

        'GO
        (lambda (direction)  ; Shadows person's GO
          (let ((success? (ask person-part 'GO direction)))
            (if success? (ask clock 'TICK))
            success?))

        'DIE
        (lambda (perp)
          (ask self 'SAY (list "I am slain!"))
          (ask person-part 'DIE perp)))

      person-part)))

(setup 'foo)
(ask me 'FEEL-THE-FORCE)
