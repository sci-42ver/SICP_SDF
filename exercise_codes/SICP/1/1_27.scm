(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
          (remainder (* base (expmod base (- exp 1) m))
                     m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  ;; See wiki which exits directly when encountering `false`.
  (define (iter-test result num)
    (if (= num (- n 1))
      result
      (iter-test (and result (try-it num)) (+ num 1))))
  (iter-test #t 1))

(fermat-test 561)
(fermat-test 4)

;;; >  ;; Parse error: Spurious closing paren found
(define (carmichel-test n)
  (define (iter a n)
    (cond ((= a n) #t)
          ; ((expmod a n n ) a) (iter (+ a 1) n))
          ((expmod a n n ) a) (iter (+ a 1) n)
          ; (else #f)))
          (else #f))
    ; (iter 1 n))
    (iter 1 n)))

;;; > Both of the above implementations fail to take into account the special case of 1 which by definition is not a prime number.
;;; Same for the original implementation where `(random 0)` fails.
