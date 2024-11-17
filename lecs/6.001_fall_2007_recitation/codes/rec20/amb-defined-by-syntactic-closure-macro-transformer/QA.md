Recently I read [one blog][1] implementing `amb` with macro transformer.

1. syntax-rules, i.e. Pattern Language
```scheme
(define-syntax amb
  (syntax-rules ()
    ((_) (fail))
    ((_ a) a)
    ((_ a b ...)
     (let ((fail0 fail))
       (call/cc
         (lambda (cc)
           (set! fail
             (lambda ()
               (set! fail fail0)
               (cc (amb b ...))))
           (cc a)))))))
```
2. syntactic-closures macro transformer
```scheme
; for MIT-Scheme only
; use it if you don't like warning during compilation
(define-syntax amb
  (sc-macro-transformer
   (lambda (exp env)
     (if (null? (cdr exp))
         `(fail)
       `(let ((fail0 fail))
          (call/cc
           (lambda (cc)
             (set! fail
                   (lambda ()
                     (set! fail fail0)
                     (cc (amb ,@(map (lambda (x)
                                       (make-syntactic-closure env '() x))
                                     (cddr exp))))))
             (cc ,(make-syntactic-closure env '() (second exp))))))))))
```

I can't understand "use it if you *don't like warning during compilation*".

[This `syntax-rules` detailed unofficial doc](https://hipster.home.xs4all.nl/lib/scheme/gauche/define-syntax-primer.txt) shows one case for *possible* compilation *error*
> ```scheme
> (define-syntax please
>      (syntax-rules ()
>        ((please . forms) forms)))
> ```
> ... subforms that are introduced by the *template* continue to refer to the lexical environment of the *macro definition*. The list that is returned from the PLEASE macro, however, is a subform that was not created at either the macro use point *or* at the macro definition point, but rather in the environment of the pattern matcher. ...
> The fix is trivial:
> ```scheme
>   (define-syntax please
>     (syntax-rules ()
>       ((please function . arguments) (function . arguments))))
> ```
> The resulting expansion is now a list *constructed within the template* of the macro

Here "the macro use point" may mean the case where the recursive structure is used, so partial expansion is also done while using the macro.

---

The structure of them are almost same except that Pattern Language replace `a b ...` with the pattern like `foo bar` in `(amb foo bar)` while syntactic-closures macro transformer uses syntactic closure.

syntactic closure's [original definition][2] is
> A syntactic closure consists of a form, a syntactic environment, and a list of identifiers. All identifiers in the form take their meaning from the syntactic environment, except those in the given list. The identifiers in the list are to have their meanings determined later.

IMHO syntactic closure is very similar to procedure in Scheme except that it has one `free-names` argument when construction `make-syntactic-closure environment free-names form` (see [MIT/GNU Scheme doc][3]) which means these variable are *not local* in `environment`.

The `environment` is normally passed by `sc-macro-transformer`. MIT/GNU Scheme doc says
> The second argument, the usage environment, is the syntactic environment in which *the input form occurred*.

That is very similar to continuation except that continuation is one procedure instead of one env variable.

Since `sc-macro-transformer` gives one fine-grained control for env, I thought about ont situation where `sc-macro-transformer` can achieve the excepted  behavior while `syntax-rules` can't hinted by [this QA][4].
```scheme
(define-syntax aif
  (sc-macro-transformer
    (lambda (exp env)
      (let ((test (make-syntactic-closure env '(it) (second exp)))
            (cthen (make-syntactic-closure env '() (third exp)))
            (celse (if (pair? (cdddr exp))
                     (make-syntactic-closure env '(it) (fourth exp))
                     #f)))
        `(let ((it ,test))
           (if it ,cthen ,celse))))))


(let ((i 4)
      (it (cons 1 2)))
  (aif (memv i '(2 4 6 8))
       (car it)))
;; captured by the output form, i.e. that created by let in the transformer.
; 4

;; here we need no extra literal
(define-syntax aif
  (syntax-rules ()
    ((aif test cthen)
      (let ((it test))
           (if it cthen #f)))
    ((aif test cthen celse)
      (let ((it test))
           (if it cthen celse)))))

(let ((i 4)
      (it (cons 1 2)))
  (aif (memv i '(2 4 6 8))
       (car it)))
;; it in the caller has no connection with it in the template. Also see "loop" context in https://stackoverflow.com/q/79098453/21294350
; 1
;; won'e be expanded as since MIT/GNU Scheme will differentiate it's at different locations appropriately as the above comment says.
(let ((i 4)
      (it (cons 1 2)))
  (let ((it (memv i '(2 4 6 8))))
    (if it (car it) #f)))
; 4
```

But this seems to have no relation with "warning during compilation".

Q:

What does the above "warning during compilation" mean for `syntax-rules`? If that doesn't exist for MIT/GNU Scheme 12.1, then when should we use sc-macro-transformer in MIT/GNU Scheme except for the above situation to have fine-grained control of env by `free-names`?


  [1]: https://www.sfu.ca/~tjd/383summer2019/scheme-amb.html
  [2]: https://people.csail.mit.edu/jaffer/slib/Syntactic-Closures.html
  [3]: https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/SC-Transformer-Definition.html#index-make_002dsyntactic_002dclosure
  [4]: https://stackoverflow.com/a/75051562/21294350