(define (have-people-and-things-around?)
  (and
    (not (null? (ask me 'PEOPLE-AROUND)))
    (not (null? (ask me 'STUFF-AROUND)))
    )
  )

(define (set-up-until pred name)
  (setup name)
  (do ()
    ((pred) 'done)
    (setup name)))
