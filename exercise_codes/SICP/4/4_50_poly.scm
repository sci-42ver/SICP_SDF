(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "amb-lib.scm")

(define (shuffle seq)
  (display "call shuffle")
  (define (iter seq res) 
    (if (null? seq) 
        res 
        (let ((index (random (length seq)))) 
          (let ((element (list-ref seq index))) 
            (iter (delete element seq) 
                  (cons element res)))))) 
  (iter seq '())) 

(define (amb-choices exp) (shuffle (cdr exp)))
; (4-50-test)
(driver-loop)
(define (require p)
  (if (not p) (amb)))
(list (amb 1 2 3 4 5 6 7 8 9) (amb 'a 'b))
try-again
try-again