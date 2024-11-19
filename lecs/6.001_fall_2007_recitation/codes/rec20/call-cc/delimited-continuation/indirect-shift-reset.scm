;;; TODO 
;; https://news.ycombinator.com/item?id=28287312 Effect Handler https://discuss.ocaml.org/t/the-relationship-between-call-cc-shift-reset-and-effect-handlers/11096
;; https://en.wikipedia.org/wiki/Delimited_continuation#A_worked-out_illustration_of_the_(shift_k_k)_idiom:_the_generalized_curry_function
;;; IMHO
;; the wikipedia "Examples" section contents after
;; > Let's take a look at a more complicated example
;; are just showing demo.
;;; I checked all contexts of reset and shift in wikipedia. Also "compos" contexts, "Return-cdr represents ...", Footnotes in schemewiki. (TODO "simplicity and columns"?)
;; reset just means resetting the working continuation for later shift
;; shift just means shifting to the previous stored reset continuation and bind that to one variable.
;;; > (The reset inside the lambda expression is the only difference between this and the control/prompt operators.)
;; skipped. Anyway, 
;; > They have since been used in a large number of domains, particularly in defining new control operators
;;; "static" meaning in wikipedia
;; i.e. static scope for env captured. See sds,+BRICS-RS-05-36.pdf p9 "*grafts* itself to the current context C1 0 " for dynamic.
;; This is implied by that we *directly* uses call/cc "current-continuation".

; http://mumble.net/~campbell/scheme/shift-reset.scm
;;; -*- Mode: Scheme -*-

;;;; Shift & Reset
;;;; Composable Continuation Operators in Terms of CWCC

;;; This code is written by Taylor Campbell and placed in the Public
;;; Domain.  All warranties are disclaimed.

(define *meta-continuation*
        (lambda (value)
          (error "No top-level RESET" value)))

(define-syntax reset
  (syntax-rules ()
    ((RESET body)
     (LET ((MC *META-CONTINUATION*))
       (CALL-WITH-CURRENT-CONTINUATION
         (LAMBDA (K)
           (SET! *META-CONTINUATION*
                 (LAMBDA (VALUE)
                   (SET! *META-CONTINUATION* MC)
                   (K VALUE)))
           ;; 0. Here implicitly "sets the limit for the continuation" (see "(LET ((RESULT (+ 1 ...)))")
           ;; so also
           ;; > Whatever result that shift produces is provided to the *innermost* reset
           ;; implied by the call/cc seq's.
           ;; 1. > discarding the continuation in between the reset and shift
           ;; implied by (SET! *META-CONTINUATION* MC) to restore.
           (LET ((RESULT body))
             ;** Do not beta-substitute!!
             (*META-CONTINUATION* RESULT))))))))

(define-syntax shift
  (syntax-rules ()
    ((SHIFT var body)
     ;; Combined with the above "limit", we
     ;; > surrounds the shift up to the reset
     (CALL-WITH-CURRENT-CONTINUATION
       (LAMBDA (K)
         (LET ((RESULT (LET ((var (LAMBDA (VALUE)
                                    (RESET (K VALUE))
                                    ; (K VALUE)
                                    )))
                         body)))
           ;** Do not beta-substitute!!
           ;; The above comment may mean the following will use the wrong K.
           ;  (SET! *META-CONTINUATION* MC)
           ;  (K RESULT)
           (*META-CONTINUATION* RESULT)))))))

;; Here (k 5) -> (RESET (K 5))
;; Then (K 5) returns to (+ 1 _) with 5.
(* 2 (reset (+ 1 (shift k (k 5)))))
(* 2 (+ 1 5))
;; 0. wikipedia
;; > However, if the continuation is invoked, then it effectively re-installs the continuation after returning to the reset.
;; Better see schemewiki rephrased words
;; > While an escape procedure does not return -- rather, it has the effect of returning control to another point in the program --, a composable continuation procedure does.
;; > ... it rather returns to where the composable continuation procedure was called!
;; so here inner (k 5) returns to the outer k instead of (* 2 _)
;; 1. How here works
;; (shift k (k (k 5))) will actually captures (LET ((RESULT (+ 1 ...))) in k
;; Then when body))) is run, it saves the env like (k _) at the 1st call here as the paper says.
;; 1.a. That is due to call/cc used by reset.
;; So what *META-CONTINUATION* and MC does is just to store *different K's*.
;; 1.a.a. It is used either by reset explicitly 
;; The 1st call uses MC to store exception handler and *META-CONTINUATION* to store that that delimited continuation.
;; 1.a.b. or implicitly in shift
;; The 2nd uses MC to store the previous *META-CONTINUATION* and *META-CONTINUATION* to store the outer K.
;; 1.a.b.a. Here gives one summary for the process:
;; env0 (reset (+ 1 (shift k (k (k 5))))): MC1-global, K0-(* 2 _),*MC*1-(->MC1,K0) Then run (LET ((RESULT body))
;; (shift k (k (k 5))): K1-(LET ((RESULT (+ 1 _)))
;; (k 5), i.e. (reset (K1 5)). Let it be RK1: MC2-*MC*1, K2-(RK1 _),*MC*2-(->MC2,K2)
;; (LET ((RESULT (K1 5))) which *goes* back to env0 but uses the *now modified* *META-CONTINUATION*.
  ;; Then we goes back to *MC*2 env, then we run (RK1 6) with *MC*1.
  ;; Notice if we have (k ... (k (k 5)) ...), it is still this case shown by induction [(reset (K1 5)), *MC*1] in level n->[(reset (K1 6)), *MC*1] in level n-1...
;; 1.a.b.a.a. what if no reset wrapper?
;; then when "*goes* back to env0" we uses the old *META-CONTINUATION*, so we run K0 instead of K2.
;; then (* 2 6).
;; 2. Then it runs (k 5), then (*META-CONTINUATION* RESULT)
(* 2 (reset (+ 1 (shift k (k (k 5))))))
(* 2 (+ 1 (+ 1 5)))
;; here the 2nd reset will store *META-CONTINUATION* from the 1st reset.
;; Then (k (t (t 5))) can follow the analysis of ";;; how nested k work"
;; Then we return (+ 1 (* 3 (* 3 5))) to the 2nd reset and then the 1st implied by stack.
(* 2 (reset (+ 1 (shift k (reset (* 3 (shift t (k (t (t 5))))))))))
; (* 2 (+ 1 (* 3 (* 3 5))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; wikipedia demo
(define null '())
;; Here similar to (* 2 (reset (+ 1 (shift k (k (k 5))))))
;; (cons 1 _) will be saved in the stack-like(FIFO) *META-CONTINUATION*
;; (k 'ignored) again will go to the reset loc (begin _ ...).
;; Then we calculate (shift k (cons 2 (k 'ignored))) in (begin _ ...) which *isn't nested in* the former shift.
;; So RESULT in (LET ((RESULT (k 'ignored))) here will become the ending null.
;; Then we run K related with the previous set *META-CONTINUATION*, i.e. reset from k in (cons 2 (k 'ignored)).
;;; how nested k work
;; (NOTICE each RESET will put its K in *META-CONTINUATION* so the latter calculation in body must be used as the *return* value for that reset expression)
;; So for body like (k (k (k 5))), it means (RESET (K (RESET (K (RESET (K 5))))))
;; We expand the innermost RESET first. Notice K is related with the outer SHIFT, so it is unchanged.
;; Then (K 5) goes to the outer reset
;; > Calling a composable continuation procedure has the effect of returning control to the point where *shift was called*.
;; It calculates the result and then call *META-CONTINUATION* which again returns value to the loc corresponding to the innermost (RESET (K 5))
;; Then *follow* the process for (K 5)
;; When all implicit RESETs are manipulated, *META-CONTINUATION* will be also meanwhile restored.
;; So we return to *META-CONTINUATION* formed by the former explicit RESET.
;; Then again do the restoration before returning back value.
;;; "how nested k work" continued
;; 0. The inserted implicit RESETs does this re-installation, i.e. we can always use the K introduced directly by shift.
;; Actually "re-install" is done before "returning to the reset" with (K 5). That is done by syntax expansion.
;; > effectively re-installs the continuation after returning to the reset
;; 1. > once the entire computation within shift is completed, the continuation is discarded, and execution restarts outside reset
;; > the shift expression has terminated, and the rest of the reset expression is discarded.
;; "discarded" is done by the above stack restoration and that K is totally dropped when shift is finished by yielding control by K in (*META-CONTINUATION* RESULT).
;; "the rest of the reset expression is discarded." is done by K in reset.
;; 2. > `Composable' means that the procedure will return
;; implied by (RESET (K 5)) which *inserts*/returns 6 or something based on delimiter loc at that place. 
;; > , and so it can be composed with other procedures.
;; i.e. the outer k.
;; 2.a. > Calling a composable continuation procedure has the effect of returning control to the point where shift was called.
;; > call composable continuation procedures multiple times;
;; i.e. use K introduced by shift which is done by (RESET (K 5)).
;; > it rather returns to where the composable continuation procedure
;; done by that implicit RESET.
;; 2.b. > then shift has the effect of discarding everything between it and the dynamically enclosing reset.
;; since we calls (*META-CONTINUATION* RESULT) which may call K introduced by RESET, so "discarding everything between it ..."
(reset
  (begin
    ;; 0. by induction, (cons 1 latter)
    ;; 1. > (begin #<void> null) = null
    ;; so 'ignored is also fine.
    (shift k (cons 1 (k 'ignored)))
    ;; latter is (cons 2 null).
    (shift k (cons 2 (k 'ignored)))
    null))

(define stream-null the-empty-stream)
;; same as wiki except for not using stream-lambda which is fine since we just return one procedure which is already delayed. 
(define (for-each->stream-maker for-each) 
  (lambda (collection) 
    (reset (begin 
            (for-each (lambda (element) 
                        (shift k 
                          (stream-cons element (k 'ignored)))) 
                      collection) 
            stream-null))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; schemewiki
;;; (reset E)
;; i.e. trivial by just following *totally inside* reset
(+ 1 (reset (+ 2 3))) 
;Value: 6 

(cons 1 (reset (cons 2 '()))) 
;Value: (1 2)
;;; only one set! for *META-CONTINUATION*.
(+ 1 (reset (+ 2 (shift k 
                  ;; Ignore K. 
                  3)))) 
;Value: 4 

(cons 1 (reset (cons 2 (shift k 
                        ;; Ignore K. 
                        (cons 3 '()))))) 
;Value: (1 3)
;;; see the above (k (k 5)) explanation
(+ 1 (reset (+ 2 (shift k 
                  (+ 3 (k 4)))))) 
(+ 1 (reset (+ 2 (shift k 
                  (+ 3 (k 5) (k 1)))))) 

;;; will have pattern
;; (return-cdr1 (stream-cons element1 (return-next-cdr (stream-cons element2 ...))))
;; so (return-cdr1 (stream-cons element1 (stream-cons element2 ...)))
;; notice here the 1st return-to-for-each and return-next-cdr have all been used.
;; Then for the last, return-cdr-n uses the second to last one.
;; then return-to-for-each-n is to drop out of for-each. 
;; The last (return-cdr stream-null) is just return-next-cdr-n. So (stream-cons element '()).
;; Then we finish all, so (return-cdr1 (stream-cons element1 (stream-cons element2 ...))) back.
;;; wiki contents review
;; > Return-cdr represents the continuation of the expression evaluated in a reset;
;; i.e. return to reset
;; > Like shift, as we enter the point we want to save the program fragment to, 
;; > we reify a continuation -- return-to-for-each -- and then abort out to the next reset point, i.e. return-cdr.
;; return-to-for-each is to goto "the next reset point"
;; For shift k, this means (k 'ignored) will go back to somewhere where the corresponding shift is called in body of (LET ((RESULT body)).
;; Then it will then run for "the next reset point", i.e. the next (shift k ...).
;; In a nutshell, "save the program fragment" just means save the context of that shift, so call/cc outside return-cdr (i.e. the outer call/cc of shift).
;; > When we want to use the program fragment, as if invoking a composable continuation, we reify the continuation -- which is that of the stream's next cdr -- into return-next-cdr
;; > set return-cdr to that so that the program fragment can find where to return next
;; i.e. connect shifts (shown in pattern)
;; which is implicitly shown in shift sequence.
;; > return-to-for-each to re-enter the program fragment.
;; i.e. implicit RESET.
(define (for-each->stream-maker for-each) 
  (stream-lambda (collection) 
    (call-with-current-continuation 
      (lambda (return-cdr) 
        (for-each 
          (lambda (element) 
            (call-with-current-continuation 
              (lambda (return-to-for-each) 
                (return-cdr 
                  (stream-cons element 
                    (call-with-current-continuation 
                      (lambda (return-next-cdr) 
                        (set! return-cdr return-next-cdr) 
                        (return-to-for-each)))))))) 
          collection) 
        (return-cdr stream-null))))) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; self
(shift k (k 5))
;; Only this may use the 2nd (*META-CONTINUATION* RESULT).
(shift k 5)