This is from SICP exercise 4.9.

Example to implement [`do` in MIT/GNU Scheme][1].
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
       
         See C++, maybe by namespace
  
    In a nut shell, "the interpreter scan the code" is possible for MIT/GNU Scheme to implement "derived expressions". "Reserve additional keywords" may work for Racket since redefinition is restricted more there.

3. Then I checked [standard implementation](https://people.csail.mit.edu/jaffer/r5rs/Derived-expression-type.html) (I haven't studied `syntax-rules` which is also not taught in SICP. I also don't know how to grasp the main ideas from the long contents in [the official doc](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Pattern-Language.html#index-syntax_002drules).)
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

  [1]: https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Iteration.html#index-do-2