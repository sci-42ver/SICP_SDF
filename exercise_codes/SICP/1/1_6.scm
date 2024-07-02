(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))
(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))
(define (improve guess x)
  (average guess (/ x guess)))
(define (average x y)
  (/ (+ x y) 2))
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))
(define (sqrt x)
  (sqrt-iter 1.0 x))

(trace new-if)
(sqrt 5)

;;;;;;;;;;;;;;;;;;;;;;;; picard
; https://groups.csail.mit.edu/mac/ftpdir/scheme-7.4/doc-html/user_8.html `scheme -edwin -eval (edit)` to start edwin
; (load "~/SICP/exercise_codes/1/1_6.scm") C-Y to copy into emacs. Then C-x C-e to run.
; C-c C-d https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-user/Edwin-REPL-Mode.html
; Here `scheme -edwin -eval "(edit)" --load 1_6.scm --eval '(debug)'` no use since `--load 1_6.scm --eval '(debug)'` is not manipulated after "edit".

; copy in emacs https://askubuntu.com/a/61696 although not to the system clipboard in edwin (works in emacs at least with https://unix.stackexchange.com/a/6643/568529)

; Or `mit-scheme --batch-mode --load script.scm --eval '(debug)'` https://lists.gnu.org/archive/html/mit-scheme-devel/2019-09/msg00002.html
; then follow https://groups.csail.mit.edu/mac/users/gjs/6.945/dont-panic/#org14d3077

#|
not as useful as dont-panic example.
```
2 debug> h
h
SL#  Procedure-name          Expression

0                            ;compiled code
1    call-with-values        (let ((v (thunk))) (if (multi-values? v) (appl ...
                                                                            2    call-with-values        (let ((v (thunk))) (if (multi-values? v) (appl ...
                                                                                                                                                        3                            (begin (if (queue-empty? queue) (let ((environ ...
                                                                                                                                                                                                                                    4                            ;compiled code
                                                                                                                                                                                                                                    5                            ;compiled code
                                                                                                                                                                                                                                    6    loop                    (loop (bind-abort-restart cmdl (lambda () (wit ...
                                                                                                                                                                                                                                                                                                                7                            ;compiled code
                                                                                                                                                                                                                                                                                                                8                            ;compiled code
                                                                                                                                                                                                                                                                                                                9                            ;compiled code
                                                                                                                                                                                                                                                                                                                ```
                                                                                                                                                                                                                                                                                                                |#
