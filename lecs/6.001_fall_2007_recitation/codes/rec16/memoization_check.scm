(define test
  (let ((cnt 0))
    (lambda () 
      (set! cnt (+ cnt 1))
      (if (= 0 (remainder cnt 2))
        #f
        #t)
      ))
  )
(test)
(test)

;; compare with the above.
;; same basic ideas as sol.
(define (memoization-check)
  (define test
    (let ((cnt 0))
      (lambda () 
        (set! cnt (+ cnt 1))
        (if (= 0 (remainder cnt 2))
          #f
          #t)
        ))
    )
  (define test-delay (delay test))
  (force test-delay)
  (if (force test-delay)
    (display "use memoization")
    (display "not use memoization")
    )
  )
(memoization-check)