<!-- solved now. See lecs/6.001_fall_2007_recitation/codes/rec20/amb-in-underlying-scheme-minimal-debug.scm -->

I have understood one somewhat complex example with `call/cc` in schemewiki which [this QA help][1]
```scheme
 (define (hefty-computation do-other-stuff) 
    (let loop ((n 5)) 
      (display "Hefty computation: ") 
      (display n) 
      (newline) 
      (set! do-other-stuff (call/cc do-other-stuff)) ; point A
...
      (if (> n 0) 
          (loop (- n 1)))))

 ;; notionally displays a clock 
 (define (superfluous-computation do-other-stuff) 
    (let loop () 
      (for-each (lambda (graphic) 
                  (display graphic) 
                  (newline) 
                  (set! do-other-stuff (call/cc do-other-stuff))) 
                '("Straight up." "Quarter after." "Half past."  "Quarter til.")) ; point B
      (loop))) 


(hefty-computation superfluous-computation) 
```

In a nutshell, call/cc is to pass continuation argument to do-other-stuff which is also one continuation `(set! do-other-stuff _)` so that the continuation can be *changed* then. So that we can `(call/cc do-other-stuff)` again to go to *that saved location*.

Then when I try to understand [the amb implementation with `call/cc`][2], I thought I have understood that:
```scheme
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
```

IMHO here `K-SUCCESS` is to pass back the candidate `expression` non-locally for the *outer* continuation when calling `(amb foo bar)` (notice here the expression is transformed to the thunk to be compatible with the following `FAIL-SAVE` procedure. So that both can be run then.). Then when again calling `(amb)` it will run `(K-FAILURE #f)` to go back to the 1st expression continuation and *directly* returns for the *inner* continuation. Then it tries for the 2nd candidate due to `...` will duplicate the previous pattern in some way (see ["modifies how the PREVIOUS form is interpreted by the macro language"][3]). Then when all candidates have been tried, `(FAIL-SAVE)` is called which will try the candidates of the former `(amb)` or the top-level `fail`.

---

But then I encountered with one weird behavior:
```scheme
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
```

The "no procedure wrapper" can be explained well with the above understanding where the (amb) calls `(define y _)` with the next candidate 4. The 2nd calls `(define x _)` after calling the `FAIL-SAVE` of `(define y (amb 3 4))` which goes back to trying the next candidate for `(define x (amb 1 2))`. Then calls the `FAIL-SAVE` of `(define x (amb 1 2))`  which runs `(error "Amb tree exhausted")`.

Q:

Why does `(cons x y)` automatically try all candidates seemingly

---

p.s.

Notice the above won't work for [the SICP version][4] since there we only consider *the previous expression*. The SICP corresponding part should be
```scheme
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
```


  [1]: https://stackoverflow.com/a/13338881/21294350
  [2]: http://community.schemewiki.org/?amb
  [3]: https://stackoverflow.com/questions/79098453/how-to-implement-one-anonymous-loop-form-like-do-in-the-evaluator-as-a-derived-e#comment139473764_79098453
  [4]: https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-28.html