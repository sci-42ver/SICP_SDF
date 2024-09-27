;; > prevents the person carrying it from being seen
;; Same as SDF Exercise 3.20: Invisibility

;; similar to person
(define (ring-of-obfuscation self name location)
  (let ((mobile-thing-part (mobile-thing self name birthplace)))
    (make-handler
      'ring-of-obfuscation
      (make-methods)
      mobile-thing-part)))

(define (person self name birthplace)
  (let ((mobile-thing-part (mobile-thing self name birthplace))
        (container-part    (container self))
        (health            3)
        (strength          1))
    (make-handler
      'person
      (make-methods
        'STRENGTH (lambda () strength)
        'HEALTH (lambda () health)
        'SAY
        (lambda (list-of-stuff)
          (ask screen 'TELL-ROOM (ask self 'location)
               (append (list "At" (ask (ask self 'LOCATION) 'NAME)
                             (ask self 'NAME) "says --")
                       list-of-stuff))
          'SAID-AND-HEARD)
        ;; TODO fit -> upset? 
        'HAVE-FIT
        (lambda ()
          (ask self 'SAY '("Yaaaah! I am upset!"))
          'I-feel-better-now)

        ;; changed
        'PEOPLE-AROUND        ; other people in room...
        (lambda ()
          (remove
            (lambda (person) 
              (find 
                (lambda (thing) (eq? 'ring-of-obfuscation (ask thing 'NAME))) 
                (ask person 'THINGS)))
            (delq self (find-all (ask self 'LOCATION) 'PERSON))))

        'STUFF-AROUND         ; stuff (non people) in room...
        (lambda ()
          (let* ((in-room (ask (ask self 'LOCATION) 'THINGS))
                 (stuff (filter (lambda (x) (not (ask x 'IS-A 'PERSON))) in-room)))
            stuff))

        'PEEK-AROUND          ; other people's stuff...
        (lambda ()
          (let ((people (ask self 'PEOPLE-AROUND)))
            ;; fold is also fine.
            (fold-right append '() (map (lambda (p) (ask p 'THINGS)) people))))

        'TAKE
        (lambda (thing)
          (cond ((ask self 'HAVE-THING? thing)  ; already have it
                 (ask self 'SAY (list "I am already carrying"
                                      (ask thing 'NAME)))
                 #f)
                ((or (ask thing 'IS-A 'PERSON)
                     (not (ask thing 'IS-A 'MOBILE-THING)))
                 (ask self 'SAY (list "I try but cannot take"
                                      (ask thing 'NAME)))
                 ;; Same as #f by eq?.
                 #F)
                (else
                  (let ((owner (ask thing 'LOCATION)))
                    (ask self 'SAY (list "I take" (ask thing 'NAME) 
                                         "from" (ask owner 'NAME)))
                    (if (ask owner 'IS-A 'PERSON)
                      (ask owner 'LOSE thing self)
                      (ask thing 'CHANGE-LOCATION self))
                    thing))))

        'LOSE
        (lambda (thing lose-to)
          (ask self 'SAY (list "I lose" (ask thing 'NAME)))
          (ask self 'HAVE-FIT)
          ;; this may be duplicate of `(ask thing 'CHANGE-LOCATION self)`. But fine for 'DIE.
          (ask thing 'CHANGE-LOCATION lose-to))

        'DROP
        (lambda (thing)
          (ask self 'SAY (list "I drop" (ask thing 'NAME)
                               "at" (ask (ask self 'LOCATION) 'NAME)))
          (ask thing 'CHANGE-LOCATION (ask self 'LOCATION)))

        'GO-EXIT
        (lambda (exit)
          (ask exit 'USE self))

        'GO
        (lambda (direction) ; symbol -> boolean
          (let ((exit (ask (ask self 'LOCATION) 'EXIT-TOWARDS direction)))
            ;; IMHO if not #f, must be exit.
            (if (and exit (ask exit 'IS-A 'EXIT))
              (ask self 'GO-EXIT exit)
              (begin (ask screen 'TELL-ROOM (ask self 'LOCATION)
                          (list "No exit in" direction "direction"))
                     #F))))
        'SUFFER
        (lambda (hits perp)
          (ask self 'SAY (list "Ouch!" hits "hits is more than I want!"))
          (set! health (- health hits))
          (if (<= health 0) (ask self 'DIE perp))
          health)

        'DIE          ; depends on global variable "death-exit"
        ;; perp is not used
        (lambda (perp)
          (for-each (lambda (item) (ask self 'LOSE item (ask self 'LOCATION)))
                    (ask self 'THINGS))
          (ask screen 'TELL-WORLD
               '("An earth-shattering, soul-piercing scream is heard..."))
          (ask self 'DESTROY))

        'ENTER-ROOM
        (lambda ()
          (let ((others (ask self 'PEOPLE-AROUND)))
            (if (not (null? others))
              (ask self 'SAY (cons "Hi" (names-of others)))))
          #T))
      mobile-thing-part container-part)))

;; > Note
;; > that the “feel the force” ability should be fooled by such rings, so you may want to alter
;; > your solution to Exercise 3 to reflect this.
;; Similar to 'PEOPLE-AROUND

;; > Modify the code in setup.scm to populate the world with some instances of ring-of-obfuscation.
;; > Demonstrate the effectiveness of your ring-of-obfuscation objects with test cases.
;; See SDF solution which also has "invisibility-cloak:held-time" to affect health.

;; > but only the methods changed in person and avatar.
;; IMHO only in person