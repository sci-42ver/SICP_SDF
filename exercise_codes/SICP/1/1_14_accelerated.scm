;;; From https://sicp-solutions.net/post/sicp-solution-exercise-1-14/

(define (square x) (* x x))

(define (count-change amount)
  (cc amount 5))

;; Original version of cc with counter added
(define (cc amount kinds-of-coins)
  (set! counter (+ counter 1))
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
              (- kinds-of-coins 1))
          (cc (- amount
            (first-denomination kinds-of-coins))
              kinds-of-coins)))))

;; Second version of cc: 
;; ---------------------
;; condition
;;   ((= amount 0) 1)
;; replaced by
;;   ((or (= amount 0) (= kinds-of-coins 1)) 1);
;; this eliminates all subtrees with root node (cc amount 1)
;; and reduces number of steps significantly
(define (cc amount kinds-of-coins)
  (set! counter (+ counter 1))
  (cond ((or (= amount 0) (= kinds-of-coins 1)) 1) ; assume leave penny eventually
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
              (- kinds-of-coins 1))
          (cc (- amount
            (first-denomination kinds-of-coins))
              kinds-of-coins)))))

;; Third version: 
;; --------------
;; additional condition
;;   ((= kinds-of-coins 2) (+ 1 (quotient amount 5)))
;; eliminates all subtrees with root node (cc amount 2)
;; and reduces number of steps even further
(define (cc amount kinds-of-coins)
  (set! counter (+ counter 1))
  (cond ((= kinds-of-coins 2) (+ 1 (quotient amount 5))) ; Here we directly use the solution in sicp-solutions.
        ((or (= kinds-of-coins 1) (= amount 0)) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
              (- kinds-of-coins 1))
          (cc (- amount
            (first-denomination kinds-of-coins))
              kinds-of-coins)))))

;; Fourth version: 
;; ---------------
;; additional condition
;; eliminates all subtrees with root node (cc amount 3)
;; and short-circuits still more steps
(define (cc amount kinds-of-coins)
  (set! counter (+ counter 1))
  (cond ((= kinds-of-coins 3) (+ (* (quotient amount 10)
				    (quotient amount 5))
                                (- (square (quotient amount 10)))
                                (quotient amount 5)
                                1))
        ((= kinds-of-coins 2) (+ 1 (quotient amount 5)))
        ((or (= kinds-of-coins 1) (= amount 0)) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
              (- kinds-of-coins 1))
          (cc (- amount
            (first-denomination kinds-of-coins))
              kinds-of-coins)))))

;; US coin denominations
(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

;; Experimental estimation of big-O in time

;; counts the cc procedure calls
(define counter 0)

;; Base n logarithm
(define (logn n x)
  (/ (log x) (log n)))

(define (estimation amount)
  (begin
    (set! counter 0)
    (newline)
    ; (trace logn)
    ;; Here no mutually recursive procedures are called. https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_6.html#IDX93 
    ; (letrec ((ways (count-change amount))
    ; (let ((ways (count-change amount))
    ;; > but the bindings are performed sequentially from left to right
    ;; "the region of a binding" may mean the region influenced by the binding.
    (let* ((ways (count-change amount))
	    ;  (c (logn amount counter))) 
	     (k (exact->inexact (/ counter (square amount)))))
      (display ways) (display " ways to make change for ") 
      (display amount) (display " cents") (newline)
      (display "number of calls to cc: ") (display counter) (newline)
      ;; This is to directly calculate n of a^n in sicp-solutions
      ; (display "the c in O(n^c): ") (display c) (newline))))
      (display "the k in Theta(n^2)=kn^2: ") (display k) (newline))))

;                       # of ways         4th   3rd   2nd   original
(estimation 11)       ; 4            c -> 0.67  0.92  1.18  1.67
(estimation 100)      ; 292               0.62  0.96  1.39  2.10
(estimation 200)      ; 2435              0.73  1.14  1.60  2.33
(estimation 500)      ; 59576             0.88  1.35  1.88  2.63
(estimation 1000)     ; 801451            0.98  1.50  2.07  2.84
(estimation 1500)     ; 3820626           1.03  1.57  2.17
(estimation 2000)     ; 11712101          1.07  1.62  2.23
(estimation 2500)     ; 28070876          1.09  1.66  2.28
(estimation 3000)     ; 57491951          1.11  1.69
(estimation 4000)     ; 178901001         1.14  1.73
(estimation 6000)     ; 891646701         1.18  1.79
(estimation 10000)    ; 6794128501        1.23  1.86
(estimation 15000)    ; 34179287751       1.26  1.91
(estimation 20000)    ; 107683177001      1.28
(estimation 30000)    ; 543427145501      1.31
(estimation 40000)    ; 1714786034001     1.33
(estimation 50000)    ; 4182519842501     1.34
(estimation 70000)    ; 16050152219501    1.36

; (estimation 100000)   ; 66793412685001    1.38
; (estimation 150000)   ; 337927678527501   1.40
; (estimation 200000)   ; 1067680317370001  1.42

; (time (estimation 200000)) ; takes 8 seconds

;; Bill the Lizard has a very good explanation of the time complexity here:
;; http://www.billthelizard.com/2009/12/sicp-exercise-114-counting-change.html

;; He shows that the number of steps grows as O(n⁵).

;; I claim that the fourth version of cc above reduces it to O(n²).
;; 55 steps to count ways of change to 11 cents is reduced to 5 steps!

(define (cc amount kinds-of-coins)
  (set! counter (+ counter 1))
  ;; 1. This formula is more intuitive using Arithmetic Progression
  ;; 2. Here we can use the similar analysis as sicp-solutions. So it should be Theta(n^2).
  (cond ((= kinds-of-coins 3) (* (+ (quotient amount 10) 1) 
                                 (+ (quotient amount 5) 1 
                                    (quotient (- amount (* 10 (quotient amount 10))) 5) 1)
                                 (/ 1 2)))
        ((= kinds-of-coins 2) (+ 1 (quotient amount 5)))
        ((or (= kinds-of-coins 1) (= amount 0)) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
              (- kinds-of-coins 1))
          (cc (- amount
            (first-denomination kinds-of-coins))
              kinds-of-coins)))))
(estimation 11)       ; 4            c -> 0.67  0.92  1.18  1.67
(estimation 100)      ; 292               0.62  0.96  1.39  2.10
(estimation 200)      ; 2435              0.73  1.14  1.60  2.33
(estimation 500)      ; 59576             0.88  1.35  1.88  2.63
(estimation 1000)     ; 801451            0.98  1.50  2.07  2.84
(estimation 1500)     ; 3820626           1.03  1.57  2.17
(estimation 2000)     ; 11712101          1.07  1.62  2.23
(estimation 2500)     ; 28070876          1.09  1.66  2.28
(estimation 3000)     ; 57491951          1.11  1.69
(estimation 4000)     ; 178901001         1.14  1.73
(estimation 6000)     ; 891646701         1.18  1.79
(estimation 10000)    ; 6794128501        1.23  1.86
(estimation 15000)    ; 34179287751       1.26  1.91
(estimation 20000)    ; 107683177001      1.28
(estimation 30000)    ; 543427145501      1.31
(estimation 40000)    ; 1714786034001     1.33
(estimation 50000)    ; 4182519842501     1.34
(estimation 70000)    ; 16050152219501    1.36
; (estimation 100000)   ; 66793412685001    1.38
; (estimation 150000)   ; 337927678527501   1.40
; (estimation 200000)   ; 1067680317370001  1.42

#|
1 ]=> (estimation 11)
4 ways to make change for 11 cents
number of calls to cc: 5
the k in Theta(n^2)=kn^2: .04132231404958678
;Unspecified return value

1 ]=> ; 4            c -> 0.67  0.92  1.18  1.67
(estimation 100)
292 ways to make change for 100 cents
number of calls to cc: 17
the k in Theta(n^2)=kn^2: .0017
;Unspecified return value

1 ]=> ; 292               0.62  0.96  1.39  2.10
(estimation 200)
2435 ways to make change for 200 cents
number of calls to cc: 49
the k in Theta(n^2)=kn^2: .001225
;Unspecified return value

1 ]=> ; 2435              0.73  1.14  1.60  2.33
(estimation 500)
59576 ways to make change for 500 cents
number of calls to cc: 241
the k in Theta(n^2)=kn^2: .000964
;Unspecified return value

1 ]=> ; 59576             0.88  1.35  1.88  2.63
(estimation 1000)
801451 ways to make change for 1000 cents
number of calls to cc: 881
the k in Theta(n^2)=kn^2: .000881
;Unspecified return value

1 ]=> ; 801451            0.98  1.50  2.07  2.84
(estimation 1500)
3820626 ways to make change for 1500 cents
number of calls to cc: 1921
the k in Theta(n^2)=kn^2: 8.537777777777777e-4
;Unspecified return value

...

The rest all have $k\approx 8.537777777777777e-4$
IMHO maybe only when n becomes large, the above cc calculation will become *the main part* of the whole process.
So when n is small, k is larger (i.e. other part proportion is larger). 
|#