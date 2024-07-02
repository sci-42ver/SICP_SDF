#lang racket

(require (planet dyoo/simply-scheme))
(define (numbers words)
  (if (sentence? words)
    (cond ((empty? words) '())
      ((number? (first words))
       (sentence (first words) (numbers (bf words))))
      (else
       (numbers (bf words))))
    "error"))
(equal? (numbers '(76 trombones and 110 cornets)) '(76 110))
