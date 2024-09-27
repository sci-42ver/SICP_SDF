;; https://github.com/nrosiello/MIT-6.001/blob/master/project-4/project-4.scm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Project 4: Object-oriented Adventure Game
;; Nick Rosiello
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load "objsys.scm")
(load "objtypes.scm")
(load "setup.scm")
(load "../common/test.scm")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Warmup 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; me: an avatar
;; (ask me 'LOCATION): retuns a place object
;; place objects accept the following messages:  
;;    EXITS, EXIT-TOWARD, ADD EXIT
;;    from the container superclass: THINGS, HAVE-THING?, ADD-THING, DEL-THING
;;    from the named-object superclass: NAME, INSTALL, DESTROY
;;    from the root superclass: IS-A

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Warmup 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; classes defined in objtypes
;; (class): (superclasses)
;; named-object:
;; exit: named-object
;; thing: named-object
;; mobile-thing: thing, named-object
;; spell: mobile-thing, thing, named-object
;; container: root
;; place: container, root, named-object
;; person: container, root, mobile-thing, thing, named-object
;; avatar: person, container, root, mobile-thing, thing, named-object
;; autonomous-person: person, container, root, mobile-thing, thing, named-object 
;; troll: autonomous-person, person, container, root, mobile-thing, thing, named-object 
;; hall-monitor: autonomous-person, person, container, root, mobile-thing, thing, named-object 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Warmup 4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; several types of people (i.e. subclasses of person) are in the world:
;; autonomous persons: ben-bitdiddle, alyssa-hacker, course-6-frosh, lambda-man
;; hall-monitors: dr-evil, mr-bigglesworth
;; trolls: grendel, registrar

;; several random things are present in the world. for example: blackboard,
;; blackboard, lovely-trees, flag-pole, tons-of-code, problem-set, recitation-problem,
;; sicp, engineering-book, diploma

;; a room is randomly picked for each person to start out in.  the things are
;; placed in the the same room each time.  starting rooms are different between
;; the things.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; to get to the thing part, you ahve to go up the inheritance hierarchy from
;; the person part, to the mobile-thing part, to the thing part.
;; output from showing the thing part:
; HANDLER: #[compound-procedure 34 handler]
; TYPE: thing
;(methods (install #[compound-procedure 38])
;                  (location #[compound-procedure 37])
;                  (destroy #[compound-procedure 36])
;                  (emit #[compound-procedure 35]))
; Parent frame: #[environment 39]
; named-part:   #[compound-procedure 40 handler]
;    Parent frame: global-environment 
;    self:         (instance #[compound-procedure 13 handler])
;    name:         nick
;    location:     (instance #[compound-procedure 19 handler])

;; after moving from the birthplace of the avatar, the location of the
;; mobile-thing changes to the new location.

;; the value of the self variable for the superclass handlers of the avatar class
;; does not ever change, it always points to the base avatar class instance.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; testing of two new methods for people:
;; HAS-A method to determine if a person has any things of a given type
;; HAS-A-THING-NAMED method to determine if person has things with a given name
(setup 'nick)
(define loc (ask me 'location))
(define bob (create-person 'bob loc))
(define spell-1 (create-spell 'spell-1 loc '() '()))
(define spell-2 (create-spell 'spell-2 loc '() '()))

;; from https://github.com/nrosiello/MIT-6.001/blob/dae24973c4a8ccf296c152a9a11512f0be505e24/common/test.scm#L6
(load-option 'format)
(define (test-equal a b)
  (if (not (equal? a b))
    (format #t "Test failed: ~A not equal to ~A\n" a b)))

;; test that bob initially has no spells
(test-equal (ask bob 'HAS-A 'spell) '())

(ask bob 'ADD-THING spell-1)
(ask bob 'ADD-THING spell-2)

;; test that now bob has spells
(test-equal (ask bob 'HAS-A 'spell) (list spell-2 spell-1))
(test-equal (ask bob 'HAS-A 'fake-type) (list))

;; test has-a-thing-named method
(test-equal (ask bob 'HAS-A-THING-NAMED 'fake-name) (list))
(test-equal (ask bob 'HAS-A-THING-NAMED 'spell-1) (list spell-1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; test the feel-the-force procedure that displays the name and location of all
;; the people in the world
(ask me 'FEEL-THE-FORCE)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; creation of the ring of obfuscation that makes people who possess it invisible
;; test the method:
(define test-place (create-place 'test-place))
(define visible-person (create-person 'visible test-place))
(define invisible-person (create-person 'invisible test-place))
(define ring (create-ring-of-obfuscation 'ring test-place))
(ask invisible-person 'ADD-THING ring)

(test-equal (ask invisible-person 'PEOPLE-AROUND) (list visible-person))
(test-equal (ask visible-person 'PEOPLE-AROUND) '())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define person-1 (create-person 'person-1 test-place))
(define person-2 (create-person 'person-2 test-place))
(define wand-1 (create-wand 'wand-1 test-place))

;; test method for wand to identify its caster based on location and possession
;; of the item
;; initially, this should return null since the wand has not been added yet
(test-equal (ask wand-1 'CASTER) '())
(ask person-1 'ADD-THING wand-1)
(test-equal (ask wand-1 'CASTER) person-1)

;; test that if the wand is zapped without any spells, a message is 
;; printed but nothing happens
(ask wand-1 'ZAP person-2)

;; now add a spell to person-1 and test that it is used
(define test-spell (create-spell 'test-spell test-place 
                                 "incant-ing text"
                                 (lambda (caster target)
                                   (ask caster 'EMIT (list "Using test-spell, caster:"
                                                           (ask caster 'NAME)
                                                           ", target:"
                                                           (ask target 'NAME))))))
(ask person-1 'ADD-THING test-spell)
(ask wand-1 'ZAP person-2)

;; test wave method that uses the spell against a random person in the room
(ask wand-1 'WAVE)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 6
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setup 'nick)
(define (get-spell-from-stata name) (first (ask chamber-of-stata 'HAS-A-THING-NAMED name)))
(define boil-spell (get-spell-from-stata 'boil-spell))
(define slug-spell (get-spell-from-stata 'slug-spell))
(define wind-of-doom (get-spell-from-stata 'wind-of-doom)) 
(define possibly-destroy-spell (get-spell-from-stata 'possibly-destroy-spell))
(define not-a-person (create-mobile-thing 'not-a-person test-place))

;; test that the two spells cannot be used on non-person objects 
(ask boil-spell 'USE person-1 not-a-person)
(ask slug-spell 'USE person-1 not-a-person)

;; test that the two spells can be used on person objects
(ask boil-spell 'USE person-1 person-2)
(ask slug-spell 'USE person-1 person-2)

;; testing the wind-of-doom spell
(ask wind-of-doom 'USE person-1 not-a-person)
(ask wind-of-doom 'USE person-1 person-2)

;; testing the possibly-destroy spell
(ask possibly-destroy-spell 'USE person-1 not-a-person) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 7
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define test-wit-student (create-wit-student 'test-wit-student test-place 10 10))
(ask test-wit-student 'ATTEMPT-ZAP)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 8
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define test-wit-professer (create-wit-professor 'test-wit-professor test-place 10 10))
(ask test-wit-professer 'ATTEMPT-TEACH)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 9
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define person-with-counterspell (create-person 'person-with-counterspell test-place))
(ask person-with-counterspell 'ADD-THING (create-counterspell 'test-counterspell
                                                              test-place 'test-spell))

;; using a spell on a regular person should work as expected
(ask test-spell 'USE person-1 person-2)

;; check that a spell can identify if the target has a counterspell
(test-equal (ask test-spell 'HAS-COUNTERSPELL? person-1) #f)
(test-equal (ask test-spell 'HAS-COUNTERSPELL? person-with-counterspell) #t)

;; a counterspell does not allow the spell to be used
(test-equal (ask test-spell 'USE person-1 person-with-counterspell) 'countered)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 10
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; test implementation of the chosen-one class
(define test-chosen-one (create-chosen-one 'test-chosen-one test-place 10 10))
(ask test-chosen-one 'SUFFER 10 person-1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 11
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; add a new healer class to the system:
;; the healer is an autonomous person that, at every clock tick, randomly chooses
;; a player in the room and gives them an additional health point.  the healer dies
;; after it has given out 5 health points.
;;
;; the class inherits from the autonomous-person class.  it has an internal variable
;; that keeps track of the total number of health points it has given out.  there
;; is a new method, GIVE-HEALTH, that adds a health point to the person that is
;; given as an argument, in addition to incrementing the internal health given
;; state variable.  
;; there is also a method, HEAL-RANDOM, that attempts to find a person in the current
;; room, and then heals them using GIVE-HEALTH.
;; finally, there is a method CHECK-EXHAUSTED that will check if the healer should 
;; die because it has exhausted its health points to give out.

;; testing:
;; ensure that give-health increments the target health
(define healthy-person (create-person 'healthy-person test-place))
(define test-healer (create-healer 'test-healer test-place 10 10))

(define before-health (ask healthy-person 'HEALTH))
(ask test-healer 'GIVE-HEALTH healthy-person)
(define after-health (ask healthy-person 'HEALTH))
(test-equal (1+ before-health) after-health)

;; ensure that check-exhausted kills the healer if they have given out 5 points 
(test-equal (ask test-healer 'CHECK-EXHAUSTED) 'alive)
(repeat 5 (lambda () (ask test-healer 'GIVE-HEALTH healthy-person)))
(test-equal (ask test-healer 'CHECK-EXHAUSTED) 'dead)
