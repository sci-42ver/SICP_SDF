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

;;; same as amb-eval
;; > The continuation represents an entire (default) future for the computation.
;; Actually here continuation is not (define x _) but (lambda () (define x _) (define y ...) ...)
;; The behavior is similar to Exercise 4.53.
(define (y-fail-then-x-fail)
  (define x (amb 1 2))
  (define y (amb 3 4))
  (write-line (cons x y))
  (amb)
  )
(y-fail-then-x-fail)
; (1 . 3)
; (1 . 4)
; (2 . 3)
; (2 . 4)
; ;Amb tree exhausted

(define fail 
  (lambda () 
    (error "Amb tree exhausted")))

;;; amb-eval can't detect the old amb due to driver-loop machanism. 
;; no procedure wrapper
(define x (amb 1 2))
(define y (amb 3 4))
(write-line (cons x y))
; (1 . 3)
; ;Unspecified return value
(amb)
;Value: y
(amb)
;Value: x
(amb)
;Amb tree exhausted

;; same as amb-eval
(define (demo)
  (define x (amb 1 2))
  (define y (amb 3 4))
  (write-line (cons x y)))
(demo)
(amb)
(amb)
(amb)
;(2 . 4)
(amb)
;Amb tree exhausted