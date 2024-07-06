#lang racket
;;; from https://people.eecs.berkeley.edu/~bh/61a-pages/Lectures/1.1/plural.scm
(require (planet dyoo/simply-scheme))
; (define (plural wd)
;   (word wd 's))

(require "../week_1/pigl_file.rkt")
;; > so that it correctly handles cases like (plural ’boy).
(define (plural wd)
  (if (and (equal? (last wd) 'y) (not (vowel? (last (bl wd)))))
      (word (bl wd) 'ies)
      (word wd 's)))
(plural 'boy)