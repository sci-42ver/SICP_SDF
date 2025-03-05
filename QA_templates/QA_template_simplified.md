Recently I self-learnt MIT 6.5151 course to learn SICP and [Software Design for Flexibility (SDF)][1] book. I am reading SDF chapter 5 which which is similar to SICP [section 4.1][2] but using *generic* procedures.

I am doing SDF exercise 5.5 in section 5.1:
> As pointed out on page 238, evaluating the expression
> ```scheme
> eval> (map (lambda (x) (* x x)) '(1 2 3))
> ```
> in our interpreter does not work if the map in this expression refers
to the map procedure from the underlying Scheme system.
> 
> However, if we redefine map for our interpreter it does work:
> ```scheme
> eval> (define (map f l)
>           (if (null? l)
>               '()
>               (cons (f (car l)) (map f (cdr l)))))
> map
> eval> (map (lambda (x) (* x x)) '(1 2 3))
> (1 4 9)
> ```
> Why does it not work to use the underlying procedures that take
procedural arguments, such as map? Explain. Outline a strategy to
fix the problem and implement your solution. Note: This is subtle to
get right, so *don't spend infinite time trying to make it work
perfectly*.

The related book code base codes are shown in the directory of [this main file][3].

## Solution

### exercise question 1

- > Why does it not work to use the underlying procedures that take procedural arguments, such as map? Explain.

This is same as [SICP Exercise 4.14][4] (Here we use `lambda` instead of primitive because  primitive in SDF Metacircular Evaluator just uses the same ones as the underlying Scheme which is shown in [`lookup-variable-value`][5]. Anyway the  underlying reasons are same that underlying Scheme procedure `map` *can't recognize* the data structure defined in Metacircular Evaluator.)
> primitive procedure + is interpreted as '(application + env)

### exercise question 2

- > Outline a strategy to fix the problem and implement your solution.

As the above says, the problem is due to data structure incompatibility. So we have the following strategies:
1. We define `map` manually inside the Metacircular Evaluator so that all data structures are those defined by the Metacircular Evaluator. This is implicitly used in [SICP Exercise 4.14][2] and also in the exercise example codes above.
2. IMHO SDF intends us to keep `map` as the underlying Scheme procedure. So we need to pass one *compatible* `(lambda (x) (* x x))`. IMHO this *must* be done by the underlying `eval` by `(eval '(lambda (x) (* x x)) current-env)`.

Due to this problem only holds when applying one primitive, we don't need to lazy-evaluate arguments but just force all of them which is already done in code base `g:advance` said in book p236.
> The purpose of g:advance is to continue evaluations
that have been postponed. We will not need to postpone evaluations
until section 5.2

#### what is needed to be done

As the above says, here we choose strategy 2.

Assumptions:
1. Only primitive procedures and [strict compound procedures][10] (i.e. those defined by `lambda`) are allowed in Metacircular Evaluator. This is fine up to this exercise because the code base only contains [2 handlers for generic `g:apply`][11].
   ```scheme
   (define (strict-compound-procedure? object)
     (and (compound-procedure? object)
          (every symbol? (procedure-parameters object))))
   ```
2. Only procedural arguments needs special compatibility manipulation and all others are already compatible between Metacircular Evaluator and the underlying Scheme. This seems well based on the exercise description. 

Based on the above assumptions, we only need to ensure for all places where *compound procedural arguments* occur that when applying something like `map`, they are all compatible underlying Scheme procedures. They may occur at:
```scheme
;; 0. operator must be primitive
;; 1. procedural-arg may be strict-compound-procedure
;; 1.a. Then there may be other strict-compound-procedure's inside body and env. procedure-parameters are just symbol var's.
;; 2. point 1 can be used for all other operands which may contain procedural-arg.
;; 3. primitive-non-procedural-arg's are just kept intact

;; Here point 1 and 2 are manipulated by tree-map-with-strict-compound-procedure-as-elem.
;; For point 1.a., we just need to pass the correct binding to env, then body can be manipulated implicitly.
```
In a nutshell, we need to transform procedural-arg, procedural-arg's *env*, non-procedural-arg maybe containing procedural-arg which exist in operands. Then we apply that primitive procedure operator.

So the problem is how to pass the *correct `current-env`* for *all* `strict-compound-procedure`s to eval they correctly.

##### environment

IMHO for env, we need to mimic the  behavior of [the strategy 1][8] (i.e. *lexical scope*).
```scheme
(define-generic-procedure-handler g:eval
  (match-args lambda? environment?)
  (lambda (expression environment)
    (make-compound-procedure
     (lambda-parameters expression)
     (lambda-body expression)
     environment)))
```

###### environment structure used by code base

This `environment` is constructed by `the-empty-environment` => [`the-global-environment`][9] and then is extended corresponding for each procedure call.
```scheme
(define (initialize-repl!)
  (set! the-global-environment (make-global-environment))
  'done)
```
IMHO we can check how `environment` by just looking at `lookup-variable-value`.

The precedence is implied in code base `environment` structure, so we need to pass one env combining the above used environments and with precedence `interpreter-env > base-env`.

###### Detailed strategy ideas

- care about env construction (temporarily only consider the precedence problem)

We need to extract its env encapsulated by `make-compound-procedure` (Notice this argument may be one variable, so we need to eval in advance to get the actual value). Then we use `extend-top-level-environment` to expand `base-env` (i.e. `(the-environment)` used by `lookup-scheme-value`.  Due to `the-environment` is "allowed only at top level", I use one var to store it for further usage) based on *sorted* bindings inside `(procedure-environment procedure-arg)`.

Here `(extend-top-level-environment env-with-y-bound-to-1 '(y y) '(2 3))` will have `y` bound to 2. This allows the above precedence implementation for env frames.

Then we need to care about "sort" for how to create that "sorted bindings" to ensure precedence. Sort is already done when construction with parent frames.

##### transform all `strict-compound-procedure`s

My strategy ideas based on "what is needed to be done" are as the following:

- care about strict-compound-procedure stored inside non-procedural-arg

For non-procedural parameters, there may be compound-procedure's (BTW I use `'` here to denote compound-procedure is one object as [this QA about english][12] shows) inside it, e.g. 
```scheme
(map 
    map
    (list lambda-proc1 lambda-proc2)
    (list '(1 2 3) '(1 2 3)))
```
So we should tree-traverse `operands` to transform all these compound-procedure's into the compatible underlying procedures.

- care about procedural-arg directly used as operands

This can be done trivially if the previous point is done.

##### implementation based on the above

Here is [my a bit naive implementation based on the above][13] (Procedure names imply their functions. For more details, please see the file link to check the related definitions of `strict-compound-procedure->underlying-procedure` etc):
```scheme
(define-generic-procedure-handler 
  g:apply
  (match-args strict-primitive-procedure?
              operands?
              environment?)
  (lambda (procedure operands calling-environment)
    (apply-primitive-procedure 
      procedure
      ;; modified
      ; (eval-operands operands calling-environment)
      ;; 0. not use eval-operands-and-keep-underlying-procedure-arg because we may have one var whose val is lambda procedure.
      ;; 1. Here proc-arg may be still something like map, so we need to dig into operands to  transform all strict-compound-procedure's.
      (tree-map-with-strict-compound-procedure-as-elem
        strict-compound-procedure->underlying-procedure
        (eval-operands operands calling-environment)))))
```

`tree-map-with-strict-compound-procedure-as-elem` solves the above point 1 and 2 as the above "what is needed to be done" says.

##### tricky parts

Here only point 1.a. in the above "what is needed to be done" is not done.

The tricky thing is that the procedural argument may use `strict-compound-procedure` defined inside Metacircular Evaluator. So we need also change the bindings inside the env created by Metacircular Evaluator (i.e. procedural-arg's env above).

But that may be difficult to implement for procedural argument whose body refers to the procedure defined in Metacircular Evaluator, e.g.
```
(define fib
  (lambda (n)
    (cond 
      ((= n 0) 0)
      ((= n 1) 1)
      ((> n 1) (+ (fib (- n 1)) (fib (- n 2))))
      (else (error (list "wrong arg for fib" n)))
      )
    )
  )
(map fib '(1 2))
```

This is because when doing `(eval fib-val cur-env)` transformation (`fib-val` is the value of `fib` definition), we need to get all bindings available, including `fib` itself. But that binding needs to get `(eval fib-val cur-env)` result... So the contradiction comes.

---

Final strategy based on the above "My strategy ideas": I used one a bit complex mechanism to solve with that problem. 

Step1: I first tree-traverse all operands and call `(eval proc-val cur-env)` with `cur-env` keeping those Metacircular Evaluator data structures. 

*At the same time during* this process, I also traverse all bindings inside the env of each traversed procedure with 2 *global variable*s (not passed around as the procedure argument to avoid make the procedure floating. IMHO it is not one habit to add one parameter in many places just to pass around one parameter to use in somewhere deep inside the procedure call stack.) used to a) bookkeep pairs with each pair storing the value of the transformed underlying Scheme procedure and the original var to `rewrite-env` later for "the transformed underlying Scheme procedure" b) avoid the loop shown above by avoiding manipulating with one var duplicately. 

Step2: Then I use these global variable's to rewrite the "transformed underlying Scheme procedure" env by `environment-assign!`.

This 2-step operation is just like `set!` for env although maybe a bit inefficient. The introduction of global variable's also make the codes much less readable. [The final codes][14] are a bit bloating.

Q:

Is there one better way to solve with the above `fib` contradiction problem (maybe need one different and subtle strategy)? 

Based on the above assumptions and then "what is needed to be done", IMHO my implementation is fine to meet the exercise requirements. But the book author says for this exercise:
> Note: This is subtle to get right, so don't spend infinite time trying to make it work perfectly.

So maybe I have neglected more corner cases (If you found one, please tell me. Thanks in advance.)



  [1]: https://mitpress.ublish.com/ebook/software-design-for-flexibility-preview/12618/27
  [2]: https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-26.html#%25_sec_4.1
  [3]: https://github.com/sci-42ver/SDF_exercise_solution/blob/master/software/sdf/generic-interpreter/interp.scm
  [4]: https://web.archive.org/web/20220605020920/http://community.schemewiki.org/?sicp-ex-4.14
  [5]: https://github.com/sci-42ver/SDF_exercise_solution/blob/3d4b7e660b39b6f42cdf1f3d3fa0209cac2deb87/software/sdf/generic-interpreter/shared-rtdata.scm#L118-L131
  [6]: https://github.com/sci-42ver/SDF_exercise_solution/blob/3d4b7e660b39b6f42cdf1f3d3fa0209cac2deb87/software/sdf/generic-interpreter/shared-rtdata.scm#L67-L73
  [7]: https://github.com/sci-42ver/SICP_SDF/blob/c2134c4ce1dd7ee4b527b5d37c166cbc92cdbbdc/exercise_codes/SICP/book-codes/ch4-mceval.scm#L209-L210
  [8]: https://github.com/sci-42ver/SDF_exercise_solution/blob/3d4b7e660b39b6f42cdf1f3d3fa0209cac2deb87/software/sdf/generic-interpreter/interp.scm#L72C1-L78C20
  [9]: https://github.com/sci-42ver/SDF_exercise_solution/blob/3d4b7e660b39b6f42cdf1f3d3fa0209cac2deb87/software/sdf/generic-interpreter/shared-repl.scm#L30-L32
  [10]: https://github.com/sci-42ver/SDF_exercise_solution/blob/3d4b7e660b39b6f42cdf1f3d3fa0209cac2deb87/software/sdf/generic-interpreter/interp.scm#L180-L182
  [11]: https://github.com/sci-42ver/SDF_exercise_solution/blob/3d4b7e660b39b6f42cdf1f3d3fa0209cac2deb87/software/sdf/generic-interpreter/interp.scm#L160-L199
  [12]: https://qr.ae/pYqro0
  [13]: https://github.com/sci-42ver/SDF_exercise_solution/blob/dd5eeb091d75a1a02eaab90ab87c6f233d013570/chapter_5/5_5.scm#L9-L21
  [14]: https://github.com/sci-42ver/SDF_exercise_solution/blob/046bc8ec021da777d41bfad8a7ea338a1d0741d4/chapter_5/5_5_correction.scm#L18-L70

```scheme
(define (make-global-environment)
  (extend-environment (map car initial-env-bindings)
                      (map cdr initial-env-bindings)
                      the-empty-environment))
(define (initialize-repl!)
  (set! the-global-environment (make-global-environment))
  'done)
(define (init)
  (initialize-repl!)
  (repl))
(define (repl)
  (check-repl-initialized)
  (let ((input (g:read)))
    ;; added
    (newline)
    (write-line (g:eval input the-global-environment))
    (repl)))
```
And then is extended corresponding for each procedure call.
```scheme
(define-generic-procedure-handler g:apply
  (match-args strict-compound-procedure? operands? environment?)
  (lambda (procedure operands calling-environment)
    (if (not (n:= (length (procedure-parameters procedure))
                  (length operands)))
        (error "Wrong number of operands supplied"))
    (g:eval (procedure-body procedure)
            (extend-environment
             (procedure-parameters procedure)
             (eval-operands operands calling-environment)
             (procedure-environment procedure)))))
```
