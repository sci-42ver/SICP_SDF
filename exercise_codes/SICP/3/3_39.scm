(cd "~/SICP_SDF/exercise_codes/SICP/3")
; (load "serializer-lib.scm")
(load "parallel.scm")

;; wiki karthikk
(define (run-many-times in-test num) 
  (define (run-test numtimes output) 
    (let ((m (in-test))) 
      (cond ((= 0 numtimes) output) 
            ((memq m output) (run-test (- numtimes 1) output)) 
            (true 
              (newline)
              (display (list "add" m))
              (run-test (- numtimes 1) (cons m output)))))) 
  (run-test num '())) 

(define (test-2) 
  (define x 10) 
  (define s (make-serializer)) 
  (parallel-execute (lambda () (set! x ((s (lambda () (* x x)))))) 
                    (s (lambda () (set! x (+ x 1))))) 
  x) 

(display (run-many-times test-2 1000000)) 
;; weird "(add 10)", i.e. doing nothing.
;; See 3_39.rkt