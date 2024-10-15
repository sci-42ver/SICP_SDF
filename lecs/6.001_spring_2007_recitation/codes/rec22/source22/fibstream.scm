(load "streams.scm")(load "assert.scm")
(define fibstream 
  (cons-stream 
   1 
   (cons-stream 
    1 
    (map-streams + (stream-cdr fibstream) fibstream))))

(assert-equal
 (print-stream fibstream 20)
 '(1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6765))

