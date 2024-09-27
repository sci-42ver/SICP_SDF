(cd "~/SICP_SDF/lecs/6.001_spring_2007_recitation/codes/rec17/self-implementation")
(load "init-load.scm")

;; wand and 'HAS-A in 2.scm
(cd "~/SICP_SDF/lecs/6.001_spring_2007_recitation/codes/rec17/self-implementation")
(load "5.scm")

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
          ;; > each  student  should  begin  their  life  carrying  a  wand.
          (ask container-part 'ADD-THING (create-instance wand 'wand self))
          )
        )
      mobile-thing-part container-part)))

(define (wit-student self name birthplace activity miserly)
  (let ((autonomous-person-part (autonomous-person self name birthplace activity miserly)))
    (make-handler
      'autonomous-person
      (make-methods
        'INSTALL
        (lambda ()
          (ask autonomous-person-part 'INSTALL)
          (ask clock 'ADD-CALLBACK
               (create-clock-callback 'zap-someone self 
                                      'ZAP-SOMEONE)))
        'ZAP-SOMEONE
        (lambda () 
          (ask screen 'TELL-WORLD (list "Wit-student" (ask self 'NAME) "is zapping."))
          (let* ((find-wand (ask self 'HAS-A 'wand))
                 (wand-inst 
                   (and
                     (not-empty? find-wand)
                     (pick-random find-wand)))
                 (find-people (ask self 'PEOPLE-AROUND))
                 (person-inst 
                   (and
                     (not-empty? find-people)
                     (pick-random find-people)))
                 )
            ;; See sample-implementation.scm which is more elegant.
            (cond 
              ((and wand-inst person-inst) (ask wand-inst 'ZAP person-inst))
              ;; > If the student has a wand, but there are no  people  present,  then  the  student  should  WAVE  the  wand  at  a  random  target.
              (wand-inst (ask wand-inst 'WAVE))
              (else 'do-nothing)
              )))
        'DIE
        (lambda (perp)
          ;; similar to autonomous-person
          (ask screen 'TELL-WORLD (list "Wit-student" (ask self 'NAME) "died."))
          (ask clock 'REMOVE-CALLBACK self 'zap-someone)
          (ask autonomous-person-part 'DIE perp)
          )
        )
      autonomous-person-part
      )))

(define (create-wit-student name birthplace activity miserly)
  (create-instance wit-student name birthplace activity miserly))

(define (populate-players rooms)
  (let* ((students (map (lambda (name)
                          (create-wit-student name
                                              (pick-random rooms)
                                              (random-number 3)
                                              (random-number 3)))
                        '(ben-bitdiddle alyssa-hacker
                                        course-6-frosh lambda-man)))
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
            ;	    profs        ;uncomment after writing wit-professor
            monitors trolls)))

(setup 'foo)
(ask screen 'DEITY-MODE #f)
(run-clock 50)
; --- the-clock Tick 32 --- 
; Wit-student ben-bitdiddle is zapping. 
; Wit-student alyssa-hacker is zapping. 
; Wit-student alyssa-hacker died. 
;; Then alyssa-hacker won't do any clock-callback. 
