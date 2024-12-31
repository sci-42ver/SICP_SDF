This is from [SICP exercise 4.9][1].
> Exercise 4.9.  Many languages support a variety of iteration constructs, such as do, for, while, and until. In Scheme, iterative processes can be expressed *in terms of ordinary procedure calls*, so special iteration constructs provide no essential gain in computational power. On the other hand, such constructs are often convenient. Design some iteration constructs, give examples of their use, and show how to implement them as *derived expressions*.

Example to implement [`do` in MIT/GNU Scheme][2].
```scheme
(define test (vector 3))
(do ((vec (make-vector 5))
      (i 0 (+ i 1)))
    ;; use assignment similar to C for loop https://stackoverflow.com/a/276519/21294350
    ;; https://en.cppreference.com/w/c/language/for
    ;; > cond-expression is *evaluated* before the loop body
    ((begin 
      (set! test vec)
      (= i 5)) (list vec test))
   (vector-set! vec i i))
```

1. I first tried to implement it with named-let
     ```scheme
      (define test (vector 3))
      (let loop
        ;; > the init expressions are stored in the bindings of the variables, and then the iteration phase begins.
        ((vec (make-vector 5))
          (i 0))
        (if (begin 
               (set! test vec)
               (= i 5))
          (list vec test)
          (begin
            (vector-set! vec i i)
            ;; > the step expressions are evaluated in some *unspecified* order, the variables are bound to fresh locations, the results of the steps are stored in the bindings of the variables, and the next iteration begins.
            (loop vec (+ i 1)))))
      ```
      but the above will *fail* if we change `loop` to `vec`.

2. Most of [schemewiki solutions](http://community.schemewiki.org/?sicp-ex-4.9) are to implement `while`.
     - Since the main problem above is *name collision*, so LisScheSic's 1st comment is fine to follow. 
       
       My above problem is same as woofy's and karthikk's due to *introducing one new variable* to body.

       djrochford's `(while <name> <predicate> <body>)` is inappropriate as "not for do in MIT/GNU Scheme since it is *anonymous*" says.

       jotti's `(if <predicate> <body> (while <predicate> <body>))` is not "Not strictly derived expressions" as the comment says.
     - Solutions offered by pvk's 2nd comment
       - > Reserve additional *keywords* such as while-rec
       
         Seemingly not valid for MIT/GNU Scheme since we can even redefine primitives like `+`.
       - > Implement special syntax for while as done here;

         i.e. jotti's.
       - i.e. djrochford's
       - > Make the interpreter scan the code for all variable names before translating
       
         See C++, maybe by [namespace][3]
  
    In a nut shell, "the interpreter scan the code" is possible for MIT/GNU Scheme to implement "derived expressions". "Reserve additional keywords" may work for Racket since redefinition is restricted more there.

3. Then I checked [R5RS standard implementation](https://people.csail.mit.edu/jaffer/r5rs/Derived-expression-type.html) (same as [R7RS][4]) (I haven't studied `syntax-rules` which is also not taught in SICP. I also don't know how to grasp the main ideas from the long contents in [the official doc](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Pattern-Language.html#index-syntax_002drules).)
     ```scheme
     (define-syntax do
        (syntax-rules ()
          ((do ((var init step ...) ...)
              (test expr ...)
              command ...)
          (letrec
            ((loop
              (lambda (var ...)
                (if test
                    (begin
                      (if #f #f)
                      expr ...)
                    (begin
                      command
                      ...
                      (loop (do "step" var step ...)
                            ...))))))
            (loop init ...)))
          ((do "step" x)
          x)
          ((do "step" x y)
          y)))
     ;; similarly we can use named let for the above letrec part
     (let loop 
      ((var init) ...)
        (if test
            ; ...... same as the above
            ))
     ```

     The above actually avoids the name collision problem where `loop` is used by `letrec` above.
     ```scheme
     (do ((loop (make-vector 5))
           (i 0 (+ i 1)))
         ((= i 5) loop)
       (vector-set! loop i i))
     ```

     But if I expand naively (I don't know how `syntax-rules` *replace* maybe intelligently), the error is thrown:
     ```scheme
     ;; > pattern variables that occur in the template are *replaced* by the subforms they match in the input.
     (letrec
       ((loop
         (lambda (loop i)
           (if (= i 5)
               (begin
                 (if #f #f)
                 loop)
               (begin
                 (vector-set! loop i i)
                 (loop loop (+ i 1)))))))
       (loop (make-vector 5) 0))
     ;The object #(0 #f #f #f #f) is not applicable.
     ```

Q:

As the above shows, the main problem is "name collision". "In a nut shell" works possibly and `define-syntax` works although I don't know how that does internally. How does `define-syntax` work to solve the above `loop` name collision? If that is complex, is there some more elegant way to implement `do` using "derived expressions" besides scan and "Reserve additional keywords"?

p.s. 

1. the only former exercise in chapter 4 related with iteration exercise 4.8 to implement [named-let][5] `let name ((variable init) …) expr expr …` doesn't have the above problem since `name` and `variable`s are *implicitly* contained in `expr`s. So there is no "name collision" otherwise the definition is *wrong*. Then we can use *Z-combinator* to avoid "name collision" between `init`s and `name` as [LisScheSic's 1st comment][6] does.

2. Thanks for Shawn's help. We can add one `(bkpt "test loop")` before `(loop (do "step" var step ...) ...)`. Then when running `do` after `(define-syntax do ......)` by `scheme --interactive --eval '(load "demo.scm")'` (I used MIT/GNU Scheme):
   ```bash
   2 bkpt> (debug)
   ...
   Expression (from stack):
       (begin <!> (.loop.0 loop (+ i 1)))
    subproblem being executed (marked by <!>):
       (bkpt "test loop")
   ```
   As the above shows, here the `loop` in `syntax-rules` is renamed to `.loop.0` (if we use `.loop.0` as one variable in the code, then the interpreter will still rename `loop` to `.loop.0`. But the code can still run. Maybe as the link offered by Shawn says "They are paired up properly", so the interpreter won't mess up the superficial name collision of `.loop.0`).
  - 2.1
    As [this comment](https://stackoverflow.com/questions/79098453/how-to-implement-one-anonymous-loop-form-like-do-in-the-evaluator-as-a-derived-e#comment139484711_79098453) says, the name collision may be actually avoided by
    > Maybe that is done by just *keeping duplicate `var`s* instead of substituting that with loop or i in template (so avoid `loop` collision) and the clever *pairing* mechanism (so no name collision due to duplicate `var` names).
    
    implied by Shawn's link example in the context of "name collisions":
    > Since we run the *expansion step* three times, one for each variable to be assigned, we get three variables named temp.  They are paired up properly because we generated all references to them at the same time.
    
    So probably at *each expansion step*, `var` will be *also* paired up with the appropriate variable like `loop` or `i` at *the expansion step when applying* `(do ((loop (make-vector 5)) ...))`. `(loop (do "step" var step ...) ...)` will be paired with the definition of the `loop` func in `letrec` instead of the variable `loop` vector probably at the `define-syntax` step.


  [1]: https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-26.html
  [2]: https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Iteration.html#index-do-2
  [3]: https://stackoverflow.com/a/3871548/21294350
  [4]: https://standards.scheme.org/corrected-r7rs/r7rs-Z-H-9.html#TAG:__tex2page_sec_7.3
  [5]: https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Iteration.html#index-let-6
  [6]: http://community.schemewiki.org/?sicp-ex-4.8