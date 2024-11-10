;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; implementation choice
;; https://www.geeksforgeeks.org/bash-scripting-until-loop/# is similar to do https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Iteration.html#index-do-2
;; where "test expression" functions as until.
;; So implement do which will function as until,do in Bash and do,while and for in C.

;; https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Iteration.html#index-do-2
(define test (vector 3))
(do ((vec (make-vector 5))
      (i 0 (+ i 1)))
    ;; use assignment similar to https://stackoverflow.com/a/276519/21294350
    ;; https://en.cppreference.com/w/c/language/for
    ;; > cond-expression is *evaluated* before the loop body
    ((begin 
      (set! test vec)
      (= i 5)) (list vec test))
   (vector-set! vec i i))

; becomes named let
;; > iterative processes can be expressed
;; IMHO the procedure name has no convenient way to avoid name clash/shadow. Just use the normal loop name.
;; IGNORE: TODO compared with 4.8 where loop name is offered, so it can't clash with variable since they all may be used in body.
  ;; but here how to do that? 
  ;; See https://stackoverflow.com/q/79108604/21294350
(let loop
  ;; > the init expressions are stored in the bindings of the variables, and then the iteration phase begins.
  ((vec (make-vector 5))
    (i 0))
  (if (= i 5) 
    vec
    (begin
      (vector-set! vec i i)
      ;; > the step expressions are evaluated in some *unspecified* order, the variables are bound to fresh locations, the results of the steps are stored in the bindings of the variables, and the next iteration begins.
      (loop vec (+ i 1)))))

;; mimic cond->if.
(define (do-vars clauses)
  body)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; name clash summary by searching "name"
;; woofy: i -> while-procedure
;; karthikk (avoid duplicate define problems): same as woofy by i->while-iter
;; djrochford: lets programmer to explicitly avoid. Then just named-let.
;; joew: same as woofy.
;; squarebat, krubar: better to use jotti since it keeps keyword like for/while.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; pvk 1st comment
(define (do)
  (display "redefine do"))
(do)
;; https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Iteration.html#index-do-2
(do ((vec (make-vector 5))
      (i 0 (+ i 1)))
    ((= i 5) vec)
   (vector-set! vec i i))
; fail

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; pvk 2nd comment
;; > risks name collision if the body of the while happens to refer to variables with the same name
;; See karthikk for let

;; > The ways I can see around this issue are:
;; Fine:
;; 1. > Reserve additional *keywords* such as while-rec
;; 2. "done here"?
;; 3. See above.
;; 4. See C++, maybe by namespace https://stackoverflow.com/a/3871548/21294350