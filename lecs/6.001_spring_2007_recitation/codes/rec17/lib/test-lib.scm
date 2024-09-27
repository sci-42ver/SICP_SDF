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

(define (set-up-cnt cnt name deity?)
  (setup name)
  (ask screen 'DEITY-MODE deity?)
  (run-clock cnt))