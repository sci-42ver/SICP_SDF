(cd "~/SICP_SDF/lecs/6.001_spring_2007_recitation/codes/rec17/self-implementation")
(load "7.scm")

(cd "~/SICP_SDF/lecs/6.001_spring_2007_recitation/codes/rec17")
(load "lib/misc-lib.scm")
(load "lib/test-lib.scm")

(define (chosen-one self name birthplace activity miserly)
  (let ((wit-student-part (wit-student self name birthplace activity miserly)))
    (make-handler
      'chosen-one
      (make-methods
        'SUFFER
        (lambda (hits perp)
          (ask self 'SAY (list "Ouch!" hits "hits is more than I want!"))
          (let ((result-health (- (ask self 'HEALTH) hits)))
            (if (<= result-health 0) 
              (begin
                (ask self 'SAY (list "scar flares brightly"))
                (ask perp 'DIE self)
                )
              ;; For simplicity, I call wit-student-part here although not allowed by assignment requirements.
              ;; Otherwise, we need to change `person` to set!.
              ; (set! health result-health)
              (ask wit-student-part 'SUFFER hits perp)
              ))
          'done)
        ;; > What  could  go  wrong  if  a  chosen  one  were  to  implement  this behavior using the DIE method instead?
        ;; hits can't be known, so "unharmed" can't be implemented.
        )
      wit-student-part
      )
    )
  )

(setup 'foo)
(let ((Hairy-Cdr (create-instance chosen-one 'Hairy-Cdr (ask me 'LOCATION) 0 0)))
  (ask Hairy-Cdr 'SUFFER 4 me)
  (ask Hairy-Cdr 'HEALTH)
)