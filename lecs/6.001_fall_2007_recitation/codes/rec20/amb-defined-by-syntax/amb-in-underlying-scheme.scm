;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; https://deadbeef.me/2016/01/ambiguous-function#:~:text=Definition,value%20of%20any%20expression%20operand. -> http://community.schemewiki.org/?amb
(define fail 
  (lambda () 
    (error "Amb tree exhausted")))
;; from sfu. IMHO since here cc is just nothing at all, so just return 'no-choise.
;;; initializing fail
(call/cc
 (lambda (cc)
   (set! fail
         (lambda ()
           (cc 'no-choise)))))

;;; Also see https://wiki.c2.com/?AmbSpecialForm
;; 0. (amb ?x ?y) uses only one call/cc since it wraps ?y and (set! *failure* old-failure) together,
;; i.e. all what to do wrapped in one procedure. so we don't need to go back to the continuation
;; 1. (amb ?x ?rest ...) is similar to an-element-of.
;; 2. Anyway, the basic ideas are same.
(define (*failure*) (error "Failure"))

(define-syntax amb
  (syntax-rules ()
    ((amb) (*failure*))
    ((amb ?x) ?x)
    ((amb ?x ?y)
     (let ((old-failure *failure*))
       ((call-with-current-continuation
          (lambda (cc)
            (set! *failure* 
              (lambda () 
                (set! *failure* old-failure)
                (cc (lambda () ?y))))
            (lambda () ?x))))))
    ((amb ?x ?rest ...)
     (amb ?x (amb ?rest ...)))))

;;; Also see https://rosettacode.org/wiki/Amb (rosettacode always have many implementations!!!)
;; trivially same as schemewiki
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
                                             )
                                     ;; rosettacode is wrong for this part. The rest is same as here.
                                     ; K-FAILURE
                                     ) 
                               (K-SUCCESS              ; Note that the expression is 
                                 (LAMBDA ()             ;   evaluated in tail position 
                                         expression))))       ;   with respect to AMB. 
                     ... 
                     (SET! FAIL FAIL-SAVE)      ; Finally, if this is reached, 
                     FAIL-SAVE)))))))           ;   we restore the saved FAIL. 

(define (require condition) 
  (if (not condition) 
    (fail)))
;; or use or as sfu link shows.
(define (assert pred)
  (or pred (amb)))

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
; (amb)

;; Notice
;; 0. from left to right is not ensured. But CALL-WITH-CURRENT-CONTINUATION still implies DFS just like stack https://stackoverflow.com/a/612839/21294350.
(list (begin (display "left") 1) (begin (display "right") 2))
;; explicit reset fail.
(define fail 
  (lambda () 
    (error "Amb tree exhausted"))) 
(list (amb 1 2) (amb 3 4))
(amb) 
; (2 3)
;; 1. set! can't restore, since that needs changing set! to get that old-value (maybe can be implemented by redefining set!... skip that since the logic is same as the book one).
;; As the above shows, amb just tries for different candidates without caring value restoration.
(define fail 
  (lambda () 
    (error "Amb tree exhausted")))
(define global-x '(0))
(define (test y)
  (define (demo-set! x)
    (set! global-x (cons x global-x))
    global-x)
  (demo-set! y))
(test (amb 1 2))
(amb)
; (amb) ; maybe (1 4) i.e. the above next candidate of (list (amb 1 2) (amb 3 4)).
;; So global fail is not feasible at all...
;; Anyway that is not functional programming...

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
(define fail 
  (lambda () 
    (error "Amb tree exhausted")))
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
  ; (for-each
  ;   (lambda (ignore)
  ;     (write-line (cons x y))
  ;     (amb))
  ;   (iota 1))

  ; (write-line (cons x y))
  ; (amb)

  (cons x y)
  (amb)
  )
;; here may outputs weird (1 4) etc if not explicitly resetting fail.
(y-fail-then-x-fail)
; error thrown here. Reasons see lecs/6.001_fall_2007_recitation/codes/rec20/amb-in-underlying-scheme-minimal-debug.scm

(define fail 
  (lambda () 
    (error "Amb tree exhausted"))) 
;Amb tree exhausted
(define x (amb 1 2))
(define y (amb 3 4))
(cons x y)
(amb)
(amb)
;; Here after x has exhausted it will call the former fail ";Amb tree exhausted"
;; instead of trying for y...
; (amb) ;Amb tree exhausted
(define fail 
  (lambda () 
    (error "Amb tree exhausted")))
(define x (amb 1 2))
(amb)
; (amb)

;; > If the execution of pproc *fails*
; (if (amb) "1" "2")

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
;; same as https://www.sfu.ca/~tjd/383summer2019/scheme-amb.html
(define-syntax set-of
  (syntax-rules ()
    ((_ s)
      (let ((acc '()))
        (amb (let ((v s))
               (set! acc (cons v acc))
               (fail))
             (reverse! acc))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; encure understanding call/cc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 1. https://stackoverflow.com/q/28645071/21294350
;; i.e. ((lambda () (cc #f))) -> (cc #f) -> ((cdr (cons 3 5)))
; ((cdr (or (call/cc (lambda (cc) (cons 2 (lambda () (cc #f))))) (cons 3 5))))
;; 
(define cc (cdr (or (call/cc (lambda (cc) (cons 2 (lambda () (cc #f))))) (cons 3 5))))
(cc) ; (define cc 5)
cc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 2 https://stackoverflow.com/q/28191524/21294350
;; trivial by just accumulating (+ 1 and then at last 0.
;; so 4 and 2014+4.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 3 https://stackoverflow.com/q/16529475/21294350
;; trivial by just return 2.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 4 https://stackoverflow.com/q/11641926/21294350 
;; trivial
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; some links https://stackoverflow.com/a/2786098/21294350

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; rosettacode
(let ((w-1 (amb "the" "that" "a"))
      (w-2 (amb "frog" "elephant" "thing"))
      (w-3 (amb "walked" "treaded" "grows"))
      (w-4 (amb "slowly" "quickly")))
  (define (joins? left right)
    (equal? (string-ref left (- (string-length left) 1)) (string-ref right 0)))
  (if (joins? w-1 w-2) '() (amb))
  (if (joins? w-2 w-3) '() (amb))
  (if (joins? w-3 w-4) '() (amb))
  (list w-1 w-2 w-3 w-4))
;; i.e.
;;; The list can contain as many lists as desired.
(define words (list '("the" "that" "a")
                    '("frog" "elephant" "thing")
                    '("walked" "treaded" "grows")
                    '("slowly" "quickly")))
(define (joins? a b)
  (char=? (string-ref a (sub1 (string-length a))) (string-ref b 0)))

;; added
(define (sub1 x)
  (- x 1))
(define (an-element-of items)
  (require (not (null? items)))
  (amb (car items) (an-element-of (cdr items))))

(let ((sentence (map an-element-of words))) ; modified
  ; (fold (lambda (x y)
  ;         (require (joins? x y))
  ;         y)
  ;       (car sentence) (cdr sentence))
  (fold
    (lambda (latest prev)
      (require (joins? prev latest))
      latest)
    (car sentence)
    (cdr sentence))
  sentence)
