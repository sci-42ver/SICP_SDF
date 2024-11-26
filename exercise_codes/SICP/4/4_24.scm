(define test-program
  (list 
    '(define (factorial n)
      (if (= n 1)
          1
          (* (factorial (- n 1)) n)))
    '(define (iter thunk cnt)
      (if (= cnt 0)
        'done
        (begin
          (thunk)
          (iter thunk (- cnt 1)))))
    '(iter (lambda () (factorial 10000)) 4)))

(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lib.scm")
(load "test-lib.scm")
(define (4-24-test program)
  (implemented-measure-interval
    (lambda () (run-program-list program the-global-environment))
    (runtime))
  )
; (4-24-test test-program)
;  *** 3.68
;; from wiki
(define test-program-2
  (list
    '(define (fib n) 
        (if (<= n 2) 
            1 
            (+ (fib (- n 1)) (fib (- n 2)))))
    '(display (fib 28))))
; (4-24-test test-program-2)
;  *** 51.81

(load "lib/analyze/analyze-lib.scm")
; (lookup-variable-value '= the-global-environment)
(4-24-test test-program)
;  *** 2.740000000000002
(4-24-test test-program-2)
;  *** 36.099999999999994
