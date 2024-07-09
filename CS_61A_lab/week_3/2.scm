;;; from book
(define (count-change amount)
  (cc amount 5))
(define (cc amount kinds-of-coins call_cnt)
  (display "call once")
  (newline)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination kinds-of-coins))
                     kinds-of-coins)))))
(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

(cc 5 2)
#|
(5 2)
/  \
/     \
/        \
/           \
(5 1)          (0 2)
/   \
(5 0) (4 1)
/   \
(4 0)  (3 1)
....
|#
;; to be compatible with `(cc 5 2)`
(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 5)
        ((= kinds-of-coins 2) 1)
        ))

(cc 5 2)
#|
(5 2)
/  \
/     \
/        \
/           \
(5 1)          (4 2)
/ \           /  \
/   \         /    \
(5 0) (0 1)   (4 1)  (3 2)
/  \
/    \
(4 0)  (-1 1)
|#
;; compared with the 1st one, each corresponding leaf will add 2 more calls.

;; Here we can use the similar analysis method as exercise 1.14
