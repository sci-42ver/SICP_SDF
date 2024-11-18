#lang racket
(require racket/control)
; reference sequence
; https://en.wikipedia.org/wiki/Delimited_continuation
;; -> http://community.schemewiki.org/?composable-continuations-tutorial
; TODO I don't find "trampoline" in Oleg's
; Riastradh's is same as indirect method in Sperber paper https://web.archive.org/web/20110718075439/http://www-pu.informatik.uni-tuebingen.de/users/sperber/papers/shift-reset-direct.pdf
; I won't dig into the direct version based on stack/heap in Sperber paper.

; https://docs.racket-lang.org/reference/cont.html#%28form._%28%28lib._racket%2Fcontrol..rkt%29._shift%29%29
;; wikipedia demo.
(* 2 (reset (+ 1 (shift k (k 5)))))

;; schemewiki demo
(+ 1 (reset (+ 2 (shift k 
                  ;; Ignore K. 
                  3))))
;; can be implemented manually
(+ 1 (call/cc (lambda (k) (+ 2 (k 3)))))
;; Actually the corresponding call/cc version for the original is
(+ 1 (+ 2 (call/cc (lambda (k)
                    ;; Ignore K. 
                    3))))
