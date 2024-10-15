; Does element-wise addition of the input streams
(define (add-streams . args)
  (apply map-streams + args))
