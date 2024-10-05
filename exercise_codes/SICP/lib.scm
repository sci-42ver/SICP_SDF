(define (average x y)
  (/ (+ x y) 2))
(define (displayln x)
  (newline)
  (display x))
(define nil '())

(define (assert-predicate pred x y)
  (assert (pred x y)))

;; See stack-test.scm
;; Can't catch syntax errors seemingly, see named-lambda-self-reference.scm. Maybe due to being based on *exception* thrown by error.
(let ((top-env (the-environment)))
  (define (assert-throws expr)
    (let ((exception-thrown #f))
      ;; Since I use MIT-scheme instead of DrScheme (i.e. Drracket now)
      ;; https://standards.scheme.org/corrected-r7rs/r7rs-Z-H-8.html#TAG:__tex2page_index_910 hinted by https://practical-scheme.net/wiliki/schemexref.cgi?with-handlers -> https://practical-scheme.net/wiliki/schemexref.cgi?with-exception-handler
      (call-with-current-continuation
        (lambda (k)
          (with-exception-handler
            (lambda (x)
              (newline)
              (display "thrown by: ")
              (write x)
              (set! exception-thrown #t)
              ;; return the appropriate value to avoid throwing errors
              (k 'exception))
            (lambda ()
              (display (list "in" top-env "to run" expr))
              (eval expr top-env)))))
      (if (not exception-thrown)
        (error " The following expression should have raised an exception :" expr)))))

(define (loop cnt thunk)
  (do ((i 0 (+ i 1)))
    ((= i cnt) 'done)
    (thunk)))

(define (loop-cnt-ref cnt func)
  (do ((i 0 (+ i 1)))
    ((= i cnt) 'done)
    (func i)))