#lang racket

(require (planet dyoo/simply-scheme))
(define (countdown num)
  (if (and (number? num) (>= num 0))
    (if (= num 0)
      'blastoff!
      (sentence num (countdown (- num 1))))
    "error"))
(countdown 10)
(countdown 1)
(countdown 0)