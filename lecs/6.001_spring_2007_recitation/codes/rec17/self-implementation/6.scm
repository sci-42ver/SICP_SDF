(cd "~/SICP_SDF/exercise_codes/SICP")
(load "lib.scm")

(cd "~/SICP_SDF/lecs/6.001_spring_2007_recitation/codes/rec17")
(load "objsys.scm")
(load "objtypes.scm")
(load "setup.scm")

(define (instantiate-spells)
  (let ((chamber (create-place 'chamber-of-stata)))
    ;; added. Put first to make it at last of 'THINGS.
    (create-spell
      'wind-of-doom
      chamber
      "wind-of-doom doom"
      (lambda (caster target)
        ;; added
        (cond 
          ((ask target 'IS-A 'person) 
           (ask target 'SUFFER (random-number 2) caster))
          (else
            (ask screen 'TELL-ROOM (ask caster 'location)
                 (list (ask caster 'NAME)
                       "destroyed"
                       (ask target 'NAME)))
            (ask target 'DESTROY)))
        ))
    (create-spell
      'boil-spell
      chamber
      "habooic katarnum"
      (lambda (caster target)
        ;; added
        (if (ask target 'IS-A 'person)
          (ask target 'EMIT
               (list (ask target 'NAME) "grows boils on their nose"))
          'do-nothing)
        ))
    (create-spell
      'slug-spell
      chamber
      "dagnabbit ekaterin"
      (lambda (caster target)
        ;; added
        (cond 
          ((ask target 'IS-A 'person)
           (ask target 'EMIT (list "A slug comes out of" (ask target 'NAME) "'s mouth."))
           (create-mobile-thing 'slug (ask target 'LOCATION)))
          (else
            'do-nothing))
        ))
    ;; > Finally, create some completely new spell of your design and add it to the world.
    ;; Skipped.
    chamber))

(load "lib/test-lib.scm")
(set-up-until have-people-and-things-around? 'foo)

(let ((loc (ask me 'location)))
  (let ((person-target (pick-random (ask me 'PEOPLE-AROUND)))
        (thing-target (pick-random (ask me 'STUFF-AROUND)))
        )
    ;; > Demonstrate tests using all of your spells.
    (for-each 
      (lambda (thing)
        (ask thing 'USE me person-target)
        (ask thing 'USE me thing-target)
        )
      (ask chamber-of-stata 'THINGS)))
  )
