; Like map, but for streams.  Can operate on any number of streams.  
; If any input streams are finite, the resulting stream's length is the length
; of the shortest input stream.
(define (map-streams f . args)
  (if (not (null? (filter empty-stream? args)))
      the-empty-stream
      (cons-stream (apply f (map stream-car args)) 
                   (apply map-streams (cons f (map stream-cdr args))))))