Recently when I self-learnt MIT 6.5151 course, I first read CS 61AS Unit 0 as the preparation. Then I have read SICP 1 to 2.1 (with related lecture notes) as [ps0][1] requires (also read 2.2.1 as [CS 61A notes][2] requires) and then [Software Design for Flexibility (SDF)][3] Prologue, chapter 1 and partly Appendix on Scheme.

Currently I am reading SDF chapter 2 and doing exercise 2.11 (f).
> f. Another big extension is to build make-converter so that it
can derive compound conversions, as required, from previously
registered conversions. This will require *a graph search*.

I want to make `unit-conversion-key-graph` equal to `(((quote tonne) ((quote kg) (quote g))) ((quote celsius) ((quote kelvin) (quote fahrenheit))))` in the following code.

But using `set!` in `fold` will throw errors since `res` may be used like the *state* variable in `fold` (This is similar to `for i in range(10): i=i+1; print(i)` in python but the latter doesn't throw errors and `i=i+1` does nothing at all.). This is one restriction. It will throw error ";The object #!unspecific, passed as the first argument to car, is not the correct type." sometime after `set!`.

The following `unit-conversion-list` is to be consistent with [this code block in the code base][4] where each unit pair is paired with some conversion procedure.

```scheme
(define (displayln x)
      (newline)
      (display x))

(define unit-conversion-list '((('celsius . 'kelvin) . 1) (('tonne . 'kg) . 2)
                                (('tonne . 'g) . 3) (('celsius . 'fahrenheit) . 4)))
(displayln unit-conversion-list)

;; https://stackoverflow.com/a/7871106/21294350
(define (list-with lst idx val)
  (if (null? lst)
    lst
    (cons
      (if (zero? idx)
        val
        (car lst))
      (list-with (cdr lst) (- idx 1) val))))

;; https://cookbook.scheme.org/find-index-of-element-in-list/
(define (list-index fn lst)
  (displayln lst)
  (let iter ((lst lst) (index 0))
    (if (null? lst)
        -1
        (let ((item (car lst)))
          (if (fn item)
              index
              (iter (cdr lst) (+ index 1)))))))

(define unit-conversion-key-graph 
  (fold 
    (lambda (unit-conversion res) 
      (let ((key-pair (car unit-conversion)))
        (let* ((from (car key-pair))
              (to (cdr key-pair))
              (from-idx 
                (list-index 
                  (lambda (adjacent-node-pair) (equal? from (car adjacent-node-pair))) 
                  res)))
          (if (>= from-idx 0)
            (begin 
              (displayln from-idx) 
              (set! res (list-with res from-idx (list from (list (cadr (list-ref res from-idx)) to))))
              (displayln res)
              (displayln "one iter ends"))
            (cons (list from to) res)))))
    '()
    unit-conversion-list))
``` 

Then is there one elegant way similar to the above `fold` (both books recommends functional programming) but without the above restriction to make `unit-conversion-key-graph` right?


  [1]: https://groups.csail.mit.edu/mac/users/gjs/6.945/psets/ps00/dh.pdf
  [2]: https://people.eecs.berkeley.edu/~bh/61a-pages/Volume2/notes.pdf
  [3]: https://mitpress.ublish.com/ebook/software-design-for-flexibility-preview/12618/27
  [4]: https://github.com/sci-42ver/SDF_exercise_solution/blob/1673ef69165bb83232c38f4d9292819949e1ef22/software/sdf/wrappers/units.scm#L77-L83

---

@ilkkachu I followed the reference in the SDF book published in 2021. More specifically, the POSIX specification seems to have no `\s` although https://regex101.com/ supports it which implies many programming languages supports it. POSIX supports `[:space:]` https://stackoverflow.com/a/26397083/21294350.

@muru "it's up to the user (you) to not provide regexes that result in undefined regexes": Yes. Maybe you are arguing about my test of `a\+c`, that's one demo to check whether regex engine is BRE. Sorry for possible lackness of rigorousness.

@Shawn 1. Is there one reference of "more conventionally written `(nested_var_arg arg_1 . args)`"? 2. "Lispy languages use kebab-case by convention, not snake_case." Probably that's true since the SICP and SDF both normally use it. I use "snake_case" since in VSCode it is convenient to select the word by double click when using snake_case instead of kebab-case.

@muru Sorry for my phrasing problems. As your 1st comment and Ed Morton's answer "tools can define `\s` as meaning the same as `[[:space:]]` **to that tool** and still conform to the POSIX standard" say, whether `\+` is supported someway (throwing error or other ways) here doesn't influence whether it complies to BRE. I will edit my question to say more clearly.

@Shawn Thanks. Do you mean `(arg_1 . args)` can be thought as *pair*? This is fine since `args` can be one list in `(arg_1 . args)`. In https://standards.scheme.org/corrected-r7rs/r7rs-Z-H-8.html#TAG:__tex2page_sec_6.4 "(a b c . d) is equivalent to
(a . (b . (c . d)))" implies `(c . d)` can be seen as `(. (c . d))` although it seems impossible to construct such a seemingly weird pair `(. (c . d))`. Demo: `'(. (1 . 2))` will throw error ";Ill-formed dotted list: (." and `(cons '. (cons 1 2))` will throw error ";Dot allowed only in list".

@kos "I don't see it as "an addition"": See answer "BRE ordinary characters whose meaning is *defined* when preceded by a backslash ..." and "why tools can define `\s` ...". `\+` is not necessary to be one "ordinary character".

@Shawn Fine. Maybe Scheme has some special manipulation of `. (arg_1 . args)` in `(nested-var-arg . (arg_1 . args))` to make it same as `(arg_1 . args)` although I don't know the details of that.

one typo found recently: "quaiquote" needs to be "quasiquote".

Thanks for your explanation based on *reader to read programs*. This is implied by Shawn's 1st comment but I didn't notice that until reading your answer. So here we should take `(nested_var_arg . (arg_1 . args))` as one *whole entity* instead of thinking separately about `. (arg_1 . args)` as arg list of `nested_var_arg`.

1. Your 2nd link is really helpful to show why back-references are not supported by ERE. 2. Fine. IMHO the key is whether we uses "substitution" in `sed` since "substitution" is not supported with the mere RE due to that RE is only to *match* something.

I upvoted your answer. Your answer is better than ignis volens's answer assuming less knowledge background (I only read up to SICP chapter 2 and SDF chapter 2 to learn programming). So I changed to accept yours. 1. 3 reference links in the 1st paragraph are very helpful, especially "rather, it is an external representation of *a three-element list*, the elements of which are the symbol + and the integers 2 and 6." in 3.3. This is implied in Shawn's 3rd comment but I didn't pay attention to them and only focused "section 6.4 of R7RS".

1. Thanks for your *very detailed* explanation, especially pointing out "improper list". 3. Thanks for pointing out my error implied in my manual relation of `(var_arg . lst)` and `(nested_var_arg . (arg_1 . args))` and in your answer "`(<variable> . <formal>)`". 4. `<variable1> ...` seems to be one special case since 1.3.3 says "indicates *zero* or more occurrences of a <thing>" while 4.1.4 https://standards.scheme.org/corrected-r7rs/r7rs-Z-H-6.html#TAG:__tex2page_index_116 says "(it is an error if there is *not at least one*)". This is also implied in Shawn's 4th comment.

Possibly one typo: `(<variable1> . ... <variablen> <variablen+1>)` -> `(<variable1> ... <variablen> . <variablen+1>)`.

Now https://cookbook.scheme.org/remove-duplicates-from-list/ also works which is based on https://srfi.schemers.org/srfi-125/srfi-125.html.

We can generalize this https://stackoverflow.com/a/64324025/21294350 although this  question requires duplicate once.