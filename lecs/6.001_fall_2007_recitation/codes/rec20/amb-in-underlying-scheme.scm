;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; from rec (not work when transforming from define-macro to define-syntax)
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; checking TODO in notes 4.3
;; 3. In summary, 
;; 3.a. "Execution procedures and continuations" bullet point part
;; only "assignment" can't be implemented by just the above amb syntax.
;; "the top-level driver" is implemented by the top-level fail.
;; "try-again" can be implemented as (amb) ~~since here fail is *global*.~~ since (amb) just calls the *passed* fail (i.e. global fail here) same as try-again.
  ;; So "back to the previous choice point" can be also implemented.
;; 3.b. The passing along property for "as the execution procedures call each other." can be also implemented by *global* fail.
;; Here I just give one demo where a in sequentially can influence the fail of b.
;; That's obvious since fail is *global*.
(define (y-fail-then-x-fail)
  (define x (amb 1 2))
  (define y (amb 3 4))
  ;; just use for-each etc since not in amb-eval
  ; (define (iter n)
  ;   (if (> n 0)
  ;     (begin
  ;       (write-line (cons x y))
  ;       (amb)
  ;       (iter (- n 1))) 
  ;     ))
  ; (iter 5)

  ; (error "test")
  (for-each
    (lambda (ignore)
      (write-line (cons x y))
      (amb))
    (iota 10))
  (amb)
  (amb)
  (amb)
  (amb)
  )
;; TODO why here always outputs (1 4)
(y-fail-then-x-fail)
(define x (amb 1 2))
(define y (amb 3 4))
(amb)
(amb)
(amb)
(amb) ;Amb tree exhausted

;; > If the execution of pproc *fails*
(if (amb) "1" "2")

;; > *the reason for keeping track of the continuations*
;; here is non-local exit (no need to "propagate" step by step). See lecs/6.001_fall_2007_recitation/codes/rec20/call-cc-complex.scm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; "amb review after reading 4.3.3" is trivially implemented by the recursive structure of syntax.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; from wiki
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