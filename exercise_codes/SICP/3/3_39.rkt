#lang racket
; (load "~/SICP_SDF/exercise_codes/SICP/3/serializer-lib-rkt.rkt")
;; https://docs.racket-lang.org/reference/require.html#%28form._%28%28lib._racket%2Fprivate%2Fbase..rkt%29._require%29%29
;; https://stackoverflow.com/a/48549745/21294350 https://beautifulracket.com/explainer/importing-and-exporting.html

;; for simplicity, I use absolute path here. https://stackoverflow.com/a/16843630/21294350

;; https://docs.racket-lang.org/reference/require.html#%28form._%28%28lib._racket%2Fprivate%2Fbase..rkt%29._file%29%29
;; https://stackoverflow.com/a/73005651/21294350
(require (file "/home/foo/SICP_SDF/exercise_codes/SICP/3/serializer-lib-rkt.rkt"))

;; wiki karthikk
(define (run-many-times in-test num) 
  (define (run-test numtimes output) 
    (let ((m (in-test))) 
      (cond ((= 0 numtimes) output) 
            ((memq m output) (run-test (- numtimes 1) output)) 
            (true
              (displayln (list "add" m))
              (run-test (- numtimes 1) (cons m output)))))) 
  (run-test num '())) 

(define (test-2) 
  (define x 10) 
  (define s (make-serializer)) 
  (parallel-execute (lambda () (set! x ((s (lambda () (* x x)))))) 
                    (s (lambda () (set! x (+ x 1))))) 
  x) 

(displayln (run-many-times test-2 100000000))
;; only show (the time is too long):
;; (add 121)
;; (add 101)