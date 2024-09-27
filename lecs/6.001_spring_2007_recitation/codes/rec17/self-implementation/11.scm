;; > Moving Exits
;; See SDF Exercise 3.21 -> elevators
;; but here we have no context, so we can just develop one *independent* Moving Exits where we just change from, to` etc maybe in clock-callback.

;; > Dementors
;; inherit troll and overload "suffer". Also have "patronus spell" which has one specific action.

;; > Brooms
;; > “flying” exits
;; So just have one func which can go anywhere if the graph is "strongly connected"?

;; > Each student belongs to a house
;; So what is the function of "House points"?

;; > Casting spells uses up spell points, which return slowly over time.
;; "return slowly over time" is similar to SDF "Exercise 3.20" "slowly degrades the person's ...".

;; Here Brooms, House points are ambiguous for me. "Moving Exits" can be easily done if considering "no context".
;; Dementors is similar to "chosen-one" if having "patronus spell".
;; So I will do "Spell Points".

(define (person self name birthplace)
  (let ((mobile-thing-part (mobile-thing self name birthplace))
        (container-part    (container self))
        (health            3)
        (strength          1)
        ;; added
        (spell-points 5)
        (spell-points-tick 0)
        (spell-points-update-tick 5)
        )
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

        'PEOPLE-AROUND        ; other people in room...
        (lambda ()
          (delq self (find-all (ask self 'LOCATION) 'PERSON)))

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
          #T)
        
        'INSTALL
        (lambda ()
          (ask mobile-thing-part 'INSTALL)
          (ask container-part 'INSTALL)
          (ask clock 'ADD-CALLBACK
               (create-clock-callback 'restore-spell-points self 
                                      'RESTORE-SPELL-POINTS))
          ; (ask screen 'TELL-WORLD
          ;      (list "create one professor" (ask self 'NAME)))
          )
        
        'RESTORE-SPELL-POINTS
        (lambda () 
          (set! spell-points-tick (+ spell-points-tick 1))
          (if (= spell-points-tick spell-points-update-tick)
            (begin
              (set! spell-points-tick 0)
              (set! spell-points (+ spell-points 1))
              )
            'do-nothing)
          )
        'USE-SPELL-POINTS
        (lambda (amount) 
          (let ((condition (<= amount spell-points)))
            (if condition
              (set! spell-points (- spell-points amount))
              (ask self 'SAY (list "I lack spell-points with only" spell-points "points"))
              )
            condition)
          )
        )
      mobile-thing-part container-part)))

(define (spell self name location incant action)
  (let ((mobile-part (mobile-thing self name location))
        ;; for simplicity, I let this be static. Better as one arg passed in.
        (needed-spell-points 2)
        )
    (make-handler
      'spell
      (make-methods
        'INCANT
        (lambda () incant)
        'ACTION
        (lambda () action)
        'USE
        (lambda (caster target)
          (if (ask caster 'USE-SPELL-POINTS needed-spell-points)
            (action caster target)
            'do-nothing)
          )
        )
      mobile-part)))
