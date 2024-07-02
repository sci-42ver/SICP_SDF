;;; Run with `racket -it How_Recursion_Works_count-ums.rkt`.
#lang racket

(require (planet dyoo/simply-scheme))
(define (count-ums words)
  (if (sentence? words)
    (if (empty? words)
      0
      (+  (if (equal? (first words) 'um)
            1
            0)
          (count-ums (bf words))))
    "error"))
(= (count-ums '()) 0)
(trace count-ums) ; This is more intuitive than MIT-scheme
(= (count-ums '(um)) 1)
(= (count-ums '(test um)) 1)

#|
In https://berkeley-cs61as.github.io/textbook/common-recursive-patterns.html#sub2:
(define (count-ums sent)
  (cond ((empty? sent) 0)
        ((um? (first sent)) (+ 1 (count-ums (bf sent))))
        (else (count-ums (bf sent)))))
|#