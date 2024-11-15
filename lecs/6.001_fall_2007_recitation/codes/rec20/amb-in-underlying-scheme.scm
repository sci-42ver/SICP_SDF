;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; from rec
(define amb-fail '*)
(define initialize-amb-fail
  (lambda ()
    (set! amb-fail
      (lambda ()
        (error "amb tree exhausted")))))
(initialize-amb-fail)
;; See r16 with exercise_codes/SICP/3/cons-stream-as-syntax.scm
; (define-macro amb
;               (lambda alts
(define-syntax amb
  (syntax-rules ()
    ;; https://stackoverflow.com/q/79098453/21294350
    ;; https://hipster.home.xs4all.nl/lib/scheme/gauche/define-syntax-primer.txt
    ;; > will expand to a list
    ((amb . alts)
     `(let ((+prev-amb-fail amb-fail))
        (call/cc
          (lambda (success)
            ,@(map (lambda (alt)
                     `(call/cc
                        (lambda (fail)
                          (set! amb-fail
                            (lambda ()
                              (set! amb-fail +prev-amb-fail)
                              (fail 'fail)))
                          (success ,alt))))
                   (list . alts))
            (+prev-amb-fail))))
     )
    ))
; (list (amb 1 2) (amb 2 3))
; ((let ((+prev-amb-fail amb-fail)) 
;   (call/cc (lambda (success) 
;     (call/cc (lambda (fail) (set! amb-fail (lambda () (set! amb-fail +prev-amb-fail) (fail (quote fail)))) (success 1))) 
;     (call/cc (lambda (fail) (set! amb-fail (lambda () (set! amb-fail +prev-amb-fail) (fail (quote fail)))) (success 2))) (+prev-amb-fail)))) (let ((+prev-amb-fail amb-fail)) (call/cc (lambda (success) (call/cc (lambda (fail) (set! amb-fail (lambda () (set! amb-fail +prev-amb-fail) (fail (quote fail)))) (success 2))) (call/cc (lambda (fail) (set! amb-fail (lambda () (set! amb-fail +prev-amb-fail) (fail (quote fail)))) (success 3))) (+prev-amb-fail)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; https://deadbeef.me/2016/01/ambiguous-function#:~:text=Definition,value%20of%20any%20expression%20operand. -> http://community.schemewiki.org/?amb
(define fail 
  (lambda () 
    (error "Amb tree exhausted"))) 

(define-syntax amb 
  (syntax-rules () 
    ((AMB) (FAIL))                      ; Two shortcuts. 
    ((AMB expression) expression) 

    ;; See exercise_codes/SICP/4/4_9_name_collision.scm for ... meaning.
    ((AMB expression ...) 
     (LET ((FAIL-SAVE FAIL)) 
          ;; notice there is one parenthesis pair outside CALL-WITH-CURRENT-CONTINUATION,
          ;; so we use FAIL-SAVE and (LAMBDA () expression) to return one *thunk*.
          ;; But the 2nd call/cc has no that parenthesis pair, so pass #f (anything other is also fine since its purpose is to return back and run ...) 
          ;; instead of one thunk to K-FAILURE.
          ((CALL-WITH-CURRENT-CONTINUATION ; Capture a continuation to 
             (LAMBDA (K-SUCCESS)           ;   which we return possibles. 
                     (CALL-WITH-CURRENT-CONTINUATION 
                       (LAMBDA (K-FAILURE)       ; K-FAILURE will try the next 
                               (SET! FAIL              ;   possible expression. 
                                     (LAMBDA () 
                                      ; (K-FAILURE #f)
                                      (K-FAILURE 'anything-is-fine-here)
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

; ;; when use ' to debug.
; (amb 1 2)
'((call-with-current-continuation (lambda (k-success) 
  (call-with-current-continuation (lambda (k-failure) (set! fail (lambda () (k-failure #f))) (k-success (lambda () 1)))) 
  (call-with-current-continuation (lambda (k-failure) (set! fail (lambda () (k-failure #f))) (k-success (lambda () 2)))) 
  (set! fail fail-save) fail-save)))

(list (amb 1 2)) ; call "K-SUCCESS" and *return*
(amb) 
;; call (FAIL) -> ((LAMBDA () (K-FAILURE #f))) -> (K-FAILURE #f), so we continue run ... part, i.e. next candidate.
;; Then induction. 
  ;; Notice as ... implies, K-SUCCESS is unchanged just as analyze-amb does since the continuation wanting one value from amb is *same*.
  ;; The only difference is just expression same as choices->(cdr choices) in the book.
(amb)

;; Notice
;; 0. from left to right is not ensured. But CALL-WITH-CURRENT-CONTINUATION still implies DFS just like stack https://stackoverflow.com/a/612839/21294350.
(list (begin (display "left") 1) (begin (display "right") 2))
(list (amb 1 2) (amb 3 4))
(amb) 
; (2 3)
;; 1. set! can't restore, since that needs changing set! to get that old-value (maybe can be implemented by redefining set!... skip that since the logic is same as the book one).
;; As the above shows, amb just tries for different candidates.
(define global-x '(0))
(define (test y)
  (define (demo-set! x)
    (set! global-x (cons x global-x))
    global-x)
  (demo-set! y))
(test (amb 1 2))
(amb)
; (2 1 0)
;; no restoration.

;; here is similar to Exercise 4.53.
(define-syntax amb-possibility-list 
  (syntax-rules () 
    ((AMB-POSSIBILITY-LIST expression) 
    (LET ((VALUE-LIST '())) 
      ;; This requires that AMB try its sub-forms left-to-right. 
      (AMB (let ((VALUE expression)) 
              (SET! VALUE-LIST (CONS VALUE VALUE-LIST)) 
              (FAIL)) 
            (REVERSE VALUE-LIST))))))   ; Order it nicely. 