(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "../lib.scm")
(load "table-lib.scm")

(define (memoize f)
  (let ((table (make-table)))
    (lambda (x)
      (let ((previously-computed-result (lookup x table)))
        (or previously-computed-result
            (let ((result (f x)))
              (displayln (list "recalculate for" x))
              (insert! x result table)
              result))))))

(define (test)
  (set! fib (memoize fib))
  (fib 3))

(test)

(define (memoize f)
  (let ((table (make-table))
        (local-f f))
    (lambda (x)
      (let ((previously-computed-result (lookup x table)))
        (or previously-computed-result
            (let ((result (local-f x)))
              (displayln (list "recalculate for" x))
              (insert! x result table)
              result))))))

(test)