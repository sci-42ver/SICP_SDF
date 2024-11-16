;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; amb
(define fail 
  (lambda () 
    (error "Amb tree exhausted"))) 

(define-syntax amb 
  (syntax-rules () 
    ((AMB) (FAIL))                      ; Two shortcuts. 
    ((AMB expression) expression) 

    ((AMB expression ...) 
     (LET ((FAIL-SAVE FAIL)) 
          ((CALL-WITH-CURRENT-CONTINUATION ; Capture a continuation to 
             (LAMBDA (K-SUCCESS)           ;   which we return possibles. 
                     (CALL-WITH-CURRENT-CONTINUATION 
                       (LAMBDA (K-FAILURE)       ; K-FAILURE will try the next 
                               (SET! FAIL              ;   possible expression. 
                                     (LAMBDA () 
                                      (K-FAILURE #f)
                                      ; (K-FAILURE 'anything-is-fine-here)
                                      )) 
                               (K-SUCCESS              ; Note that the expression is 
                                 (LAMBDA ()             ;   evaluated in tail position 
                                         expression))))       ;   with respect to AMB. 
                     ... 
                     (SET! FAIL FAIL-SAVE)      ; Finally, if this is reached, 
                     FAIL-SAVE)))))))           ;   we restore the saved FAIL. 

(define (require condition) 
  (if (not condition) 
    (fail)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; test
(list (amb 1 2) (amb 3 4))
(amb) 
;; implicitly pass fail to try the next (1 4).
(define (y-fail-then-x-fail)
  (define x (amb 1 2))
  (define y (amb 3 4))
  (for-each
    (lambda (ignore)
      (write-line (list ignore (cons x y)))
      (amb))
    (iota 10))
  (write-line (cons x y))
  (amb)
  (amb)
  (amb)
  (amb)
  (amb))
(y-fail-then-x-fail)
;; outputs (1 4) and then exit totally from y-fail-then-x-fail, so the latter (write-line (cons x y))'s are not run at all.'