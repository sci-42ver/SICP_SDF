(cd "~/SICP_SDF/exercise_codes/SICP")
(load "lib.scm")

(cd "~/SICP_SDF/lecs/6.001_spring_2007_recitation/codes/rec17")
(load "self-implementation/2.scm")

(define (find-type obj typename)
  (pick-random
    (filter (lambda (x) (ask x 'IS-A typename)) (ask obj 'THINGS))))

(load "lib/misc-lib.scm")

(define (wand self name location)
  (let ((thing-part (mobile-thing self name location)))
    (make-handler
      'wand ; typename
      (make-methods
        ;; IGNORE: See sample-implementation.scm where 'CASTER is more defensive
        'WORKING 
        (lambda () 
          ;; > not work unless a person is carrying it.
          ;; same reason for why using `ask` as `'DESTROY` by thing.
          (ask (ask self 'LOCATION) 'IS-A 'person))
        'ZAP 
        (lambda (target)
          (if (ask self 'WORKING)
            (let* ((caster (ask self 'LOCATION))
                   (caster-name (ask caster 'NAME-STR))
                   (waving-msg (string-append caster-name " is waving wand arbitrarily")))
              ;; See sample-implementation.scm where we can extract waving-msg out.
              (cond 
                ((not-empty? (ask caster 'HAS-A 'spell)) 
                 (let ((spell (find-type caster 'spell)))
                   (ask caster 'EMIT 
                        (list (string-append waving-msg " and saying incant " (ask spell 'INCANT))))
                   (ask spell 'USE caster target)
                   ))
                (else 
                  (ask caster 'EMIT (list waving-msg)))))
            'do-nothing)
          )
        'WAVE 
        (lambda ()
          (if (ask self 'WORKING)
            (let* ((caster (ask self 'LOCATION))
                   (caster-loc (ask caster 'LOCATION))
                   ;; > You  should  decide whether  you  want  this  to  apply  only  to  people,  or  to  any  type  of  thing. 
                   ;; By the effects of spell "only  to  people".
                   ;; > You should probably also ensure that you don't accidentally cast a spell on yourself
                   (target 
                     (pick-random 
                       ;; See sample-implementation.scm better to use `(ask caster 'PEOPLE-AROUND)` since we only consider person.
                       (remove 
                         (lambda (person) (eq? caster person)) 
                         ;; See Computer Exercise 7. Here all things should be considered.
                         ;  (filter person? (ask caster-loc 'THINGS))
                         (ask caster-loc 'THINGS)
                         )))
                   ) 
              (and
                target
                (ask self 'ZAP target)))
            'do-nothing
            ))
        )
      thing-part)))

(load "lib/test-lib.scm")
(set-up-until have-people-and-things-around? 'foo)

(let ((loc (ask me 'location)))
  (create-instance wand 'wand loc)
  (ask me 'take (thing-named 'wand))
  (ask me 'take (find-type loc 'spell))
  (let ((wand-inst (find-type me 'wand)))
    ;; use `(filter person? (ask caster-loc 'THINGS))` to test both WAVE and ZAP.
    (ask wand-inst 'WAVE))
  )
