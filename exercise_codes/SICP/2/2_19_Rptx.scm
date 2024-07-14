;;; book
(define us-coins (list 50 25 10 5 1))
;;; jz
;; Counting change. 

;; Helper methods, could define them in cc too: 
(define (first-denomination denominations) (car denominations)) 
(define (except-first-denom denominations) (cdr denominations)) 
(define (no-more? denominations) (null? denominations)) 

(define (cc amount denominations) 
  (cond  
    ;; If there's no change left, we have a solution 
    ((= amount 0) 1) 

    ;; If we're gone -ve amount, or there are no more kinds of coins 
    ;; to play with, we don't have a solution. 
    ((or (< amount 0) (no-more? denominations)) 0) 

    (else 
      ;; number of ways to make change without the current coin type 
      ;; plus the number of ways after subtracting the amount of the 
      ;; current coin. 
      (+ (cc amount (except-first-denom denominations)) 
         (cc (- amount  
                (first-denomination denominations))  
             denominations))))) 

;;; Rptx
(define r_us_c (reverse us-coins))
(define money_amount 400)
; (define money_amount 200)

(define (timed-cc amount coin-values start-time) 
  (cc amount coin-values) 
  (- (runtime) start-time)) 
(timed-cc money_amount us-coins (runtime))       ;.6799 
(timed-cc money_amount r_us_c (runtime)) ;1.27 

(if (> (timed-cc 100 (reverse us-coins) (runtime)) 
       (timed-cc 100 us-coins (runtime))) 
  (display "Reverse takes longer") 
  (display "Reverse does not take longer")) ;As expected, reverse takes longer 
