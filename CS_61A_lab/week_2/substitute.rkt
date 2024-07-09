#lang racket
(require (planet dyoo/simply-scheme))

(define (substitute words old_wd new_wd)
  (if (empty? words)
    '()
    (if (equal? (first words) old_wd)
      (sentence new_wd (substitute (bf words) old_wd new_wd))
      (sentence (first words) (substitute (bf words) old_wd new_wd)))))
(substitute '(she loves you yeah yeah yeah) 'yeah 'maybe)
