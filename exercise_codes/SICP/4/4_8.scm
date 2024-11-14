;; notice here the possible fib-iter name conflict
(define (fib n)
  (define fib-iter 1)
  (let fib-iter ((a fib-iter)
                 (b 0)
                 (count n))
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1)))))
(fib 5)
; 5

;; book version
(define (fib n)
  (let fib-iter ((a 1)
                 (b 0)
                 (count n))
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1)))))
(fib 5)

; (define n 5)
; (let ((fib-iter 
;         (lambda (a b count)
;           (if (= count 0)
;             b
;             (fib-iter (+ a b) a (- count 1))))))
;   (fib-iter 1 0 n))
; error

;; as https://stackoverflow.com/a/31909550/21294350 shows, we need to use define.
(define (fib n)
  (define (fib-iter a b count)
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1))))
  (let fib-iter ((a 1)
                 (b 0)
                 (count n))
    ))
;; Also see 4_22.scm

;; https://aliquote.org/post/named-let-in-scheme/
;; 0. > A named let can also be an alternative to the following procedure
;; is wrong since `(let-body expr)` can't access func name just as the above let error shows.
;; 1. > Instead of a for loop, let’s consider a while loop...
;; These are about while and letrec, so skipped.

;; http://funcall.blogspot.com/2022/07/named-lambda-and-named-let.html seems to use one different Scheme implementation