(define (count-change amount)
  (cc amount 5))
(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination kinds-of-coins))
                     kinds-of-coins)))))
(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 
         (begin 
           (display "remove change:")
           (display 1)
           (newline)
           1))
        ((= kinds-of-coins 2) 
         (begin 
           (display "remove change:")
           (display 5)
           (newline)
           5))
        ((= kinds-of-coins 3) 
         (begin 
           (display "remove change:")
           (display 10)
           (newline)
           10))
        ((= kinds-of-coins 4) 
         (begin 
           (display "remove change:")
           (display 25)
           (newline)
           25))
        ((= kinds-of-coins 5) 
         (begin 
           (display "remove change:")
           (display 50)
           (newline)
           50))))

; (count-change 100)

(define choice 2)

(cond ((= choice 1)
       ;; my 2nd solution
       (define (cc amount kinds-of-coins)
         (cond ((= amount 0) 1)
               ((or (< amount 0) (= kinds-of-coins 0)) 0)
               (else (+ (cc amount
                            (- kinds-of-coins 1))
                        (cc (- amount
                               (first-denomination (- 6 kinds-of-coins)))
                            kinds-of-coins)))))
       (count-change 100)
       )
      ((= choice 2) 
       ;; instructor
       (define (count-change amount)
         (cc amount 1)) ; This is also changed

       (define (cc amount kinds-of-coins)
         (cond ((= amount 0) 1)
               ((or (< amount 0) (> kinds-of-coins 5)) 0)     ; changed here
               ; (else (+ (cc (- amount
               ;             (first-denomination kinds-of-coins))
               ;               kinds-of-coins)
               ;           (cc amount
               ;               (+ kinds-of-coins 1))))))         ; changed here
               ;; We should not change the order since the output will be totally different
               (else (+  (cc amount
                             (+ kinds-of-coins 1))
                         (cc (- amount
                                (first-denomination kinds-of-coins))
                             kinds-of-coins)))))         ; changed here
       (count-change 100)
       )
      ((= choice 3) 
       ;; obvious solution
       (define (first-denomination kinds-of-coins)
         (cond ((= kinds-of-coins 1) 
                (begin 
                  (display "remove change:")
                  (display 50)
                  (newline)
                  50))
               ((= kinds-of-coins 2) 
                (begin 
                  (display "remove change:")
                  (display 25)
                  (newline)
                  25))
               ((= kinds-of-coins 3) 
                (begin 
                  (display "remove change:")
                  (display 10)
                  (newline)
                  10))
               ((= kinds-of-coins 4) 
                (begin 
                  (display "remove change:")
                  (display 5)
                  (newline)
                  5))
               ((= kinds-of-coins 5) 
                (begin 
                  (display "remove change:")
                  (display 1)
                  (newline)
                  1))))
       (count-change 100)
       ))
