(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lib/amb/amb-lib.scm")

(define primitive-procedures
  (list
    (list 'write-line write-line)
    (list 'prime? 
      (lambda (n) 
        (define times 100)
        (define (fast-prime? n times)
          (define (fermat-test n)
            (define (try-it a)
              (= (expmod a n n) a))
            (try-it (+ 1 (inexact->exact (round (random (- n 1))))))) ; to ensure integer
          (define (expmod base exp m)
            (cond ((= exp 0) 1)
                  ((even? exp)
                  (remainder (square (expmod base (/ exp 2) m))
                              m))
                  (else
                    (remainder (* base (expmod base (- exp 1) m))
                              m))))    
          (cond ((= times 0) true)
                ((fermat-test (inexact->exact n)) ; enforce using integer
                (fast-prime? (inexact->exact n) (- times 1)))
                (else false)))
        (fast-prime? n times)
        ))
        ))
(define the-global-environment (setup-environment))

(driver-loop-wrapper)

; (require ((lambda () (write-line "try") (let ((num (amb 1651263541264132 1652113613 16411411 1651414))) (and (prime? num) num)))))
; (require (let ((num (amb 1651263541264132 1652113613 16411411 1651414))) (and (prime? num) num)))
; (require (let ((num (amb 1651263541264132 1652113613 16411411 1651414))) (prime? num)))
(require (prime? (amb 1651263541264132 1652113613 16411411 1651414)))
try-again
