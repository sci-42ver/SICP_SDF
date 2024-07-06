#lang racket
(require (planet dyoo/simply-scheme))

(define (count-change amount)
  (cc amount '(50 25 10 5 1)))

(define (cc amount coin_list)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (empty? coin_list)) 0)
        (else (+ (cc amount
                     (bf coin_list))
                 (cc (- amount
                        (first-denomination coin_list))
                     coin_list)))))

(define (first-denomination coin_list)
  (first coin_list))

(count-change 100)