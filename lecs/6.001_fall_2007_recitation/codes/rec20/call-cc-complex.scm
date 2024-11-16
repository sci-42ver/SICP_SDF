;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; call/cc return
(define return #f) 

(+ 1 (call/cc 
      (lambda (cont) 
        (set! return cont) 
        1)))
; 2
;; So (call/cc foo) returns (foo cont) result.

(define use-set! true)
(define (call/cc-do-other-stuff do-other-stuff)
  (if use-set!
    (set! do-other-stuff (call/cc do-other-stuff))
    (call/cc do-other-stuff)))

(define (hefty-computation do-other-stuff) 
  (let loop ((n 5)) 
    (display "Hefty computation: ") 
    (display n) 
    (newline) 
    ;; (set! do-other-stuff [do-other-stuff1] (call/cc do-other-stuff))
    (set! do-other-stuff (call/cc do-other-stuff))
    ; (call/cc-do-other-stuff do-other-stuff)
    (display "Hefty computation (b)")  
    (newline) 
    ;; (set! do-other-stuff [do-other-stuff3] (call/cc do-other-stuff))
    (set! do-other-stuff (call/cc do-other-stuff))
    ; (call/cc-do-other-stuff do-other-stuff)
    (display "Hefty computation (c)") 
    (newline) 
    (set! do-other-stuff (call/cc do-other-stuff))
    ; (call/cc-do-other-stuff do-other-stuff)
    (if (> n 0) 
        (loop (- n 1))))) 
;; notionally displays a clock 
(define (superfluous-computation do-other-stuff) 
  (let loop () 
    (for-each (lambda (graphic) 
                (display graphic) 
                (newline) 
                ;; (set! do-other-stuff [do-other-stuff2] (call/cc do-other-stuff)) for "Straight up."
                (set! do-other-stuff (call/cc do-other-stuff))
                ; (call/cc-do-other-stuff do-other-stuff)
                ) 
              '("Straight up." "Quarter after." "Half past."  "Quarter til.")) 
    (loop))) 

(hefty-computation superfluous-computation)
;;; IGNORE the following
  ;; 0: (set! do-other-stuff (call/cc do-other-stuff)) with do-other-stuff as superfluous-computation
    ;; 00: (set! do-other-stuff (call/cc do-other-stuff)) with do-other-stuff as the continuation before "(display "Hefty computation (b)")"
  ;; (set! do-other-stuff (call/cc do-other-stuff)) TODO what is set value of the last set!?
;; See https://stackoverflow.com/a/13338881/21294350
;; Here the 1st (call/cc superfluous-computation) passes the 1st (set! do-other-stuff _) to do-other-stuff of superfluous-computation
;; Then (call/cc (set! do-other-stuff _)) will pass (set! do-other-stuff _) in superfluous-computation to _ in the former.
;; So we *finishes* the 1st set! in hefty-computation.
;; Then the rest is similar.

;; > let's go do this function
;; i.e. (call/cc do-other-stuff) will *implicitly* call do-other-stuff with continuation (just its name).
;; also see r7rs
;; > passes it as an argument to proc.

;;; > In this code all they do is change the value of `do-other-work` to the newest continuation.
;; Why here we must use set! (see ...wrong2.scm)
;; (call/cc superfluous-computation)->(call/cc do-other-stuff1)->(do-other-stuff1 do-other-stuff2), i.e. (set! do-other-stuff do-other-stuff2)
;; Then (call/cc do-other-stuff) (more precisely do-other-stuff2) will do (do-other-stuff2 do-other-stuff3). So the control is back to the location where we have consumed "Straight up.".
;; Otherwise, do-other-stuff in hefty-computation is always superfluous-computation instead of somewhere inside that.
;; And since superfluous-computation is the *callee*, it can always return to the appropriate location.

;; Why (call/cc-do-other-stuff do-other-stuff) wrapper fails (see ...wrong.scm)
;; since it changes the local binding of do-other-stuff instead of that in hefty-computation.

;; 0. The above exhibits "Non-Local Exit" https://www.gnu.org/software/libc/manual/html_node/Non_002dLocal-Intro.html
;; implied by r7rs https://standards.scheme.org/corrected-r7rs/r7rs-Z-H-8.html#TAG:__tex2page_sec_6.10
;; i.e. *early* exit intuitively speaking.
;; > because a non-local exit would bypass the intervening phases and their associated cleanup code entirely
;; and also http://community.schemewiki.org/?call-with-current-continuation-for-C-programmers
;; > Here's the secret: it's setjmp/longjmp.
;; 0.a. diff
;; > But in Scheme you can jump back down as well, or even "sideways".
;; 0.b.
;; > the idea of a continuation is much more fundamental.
;; i.e. "A continuation represents the "what thing(s) to do next"" (i.e. future)
;; 1. Directly reading the source code is impractical https://git.savannah.gnu.org/cgit/mit-scheme.git/tree/src/runtime/contin.scm?id=2a8e55327658a3d18c777daa775f1754572773f5.