For future readers, see https://stackoverflow.com/questions/20558036/r-function-called-when-pressing-ctrld/20558228#comment30784241_20558228, the top answer by Joshua Ulrich won't work for pressing ^D, also for Pafnucy's and flyingfinger's.

If someone doesn't want to install `lazyeval` which has many dependencies, we can just check the doc https://cran.r-project.org/web/packages/lazyeval/lazyeval.pdf `as.lazy` for "examples" of `?lazy`.

As Noldorin says, Wikipedia says "a function call is performed as soon as it is encountered in a procedure, so it is *also called* eager evaluation or greedy evaluation." IMHO it is better to check its reference which both says something like "Eager evaluation: An *operation* is executed as soon as it is encountered" which includes both function call and function argument evaluation. Trivially the latter is done before the former. Then it just means applicative order. So Wikipedia also says they "are synonymous".

At the first glance, "Non-strict refers to semantics" contradicts with https://en.wikipedia.org/wiki/Evaluation_strategy#Non-strict_evaluation "non-strict *evaluation* order" which is related with runtime. But following its reference, section 2.1 & 2.2 just says same as https://en.wikibooks.org/wiki/Haskell/Denotational_semantics#Strict_and_Non-Strict_Semantics.

Thanks so much. I updated my question to offer more information for the OS in use. With `Sys.getenv("PAGER")`, `PAGER` defaults to be `/usr/bin/more`. I updated that envvar to be `less` in `.Renviron`, then it works as expected.

0. As one complement for what user2357112 says, introselect may be based on heapselect https://en.wikipedia.org/wiki/Introselect which is related with heapsort https://en.wikipedia.org/wiki/Heap_(data_structure)#Applications. `heapify` is O(n) as https://en.wikipedia.org/wiki/Heapsort#Pseudocode says which is enough to get the top. Heapq is related with priority queue, i.e. heap https://en.wikipedia.org/wiki/Heap_(data_structure)#cite_ref-4 used by heapsort.

1. OP may refer to this blog https://apfelmus.nfshost.com/articles/quicksearch.html#message-1---mergesort for "linear time using lazy evaluation with take" which IMHO is *wrong* as point 0 says. That behavior doesn't hold for some recursive sorting algorithm like mergesort which has no guarantee when we find the max/min. We can think for mergesort using one example to illustrate that https://en.wikipedia.org/wiki/Merge_sort#Analysis: to get the final min 3 there, we need to get the min of its two merged lists, and so on.

Based on https://stackoverflow.com/q/66293709/21294350, IMHO `heapify` used by heapsort will work although less straightforward than one-pass traversal. But that won't work for mergesort or quicksort.

Partial summary for luqui's link (notice it shows lazy evaluation advantages instead of disadvantages): with lazy evaluation, sort won't sort the whole list until they are needed. So for mergesort https://en.wikipedia.org/wiki/Merge_sort#Analysis, if we only want to get the min, we only need to compare min of the 2 lists to merge, so the recurrence relation becomes T(n) = 2T(n/2) + *1*, which is O(n) https://www.wolframalpha.com/input?i2d=true&i=a%5C%2891%29n%5C%2893%29%3D%3D++2+a%5C%2891%29Divide%5Bn%2C2%5D%5C%2893%29+%2B+1. This is similar for max. Continued...

0. WFH: work from home :). Fine although not related with this QA at all. 1. @alternative could you give some reference? https://en.wikipedia.org/wiki/Beta_normal_form#cite_note-:1-5 uses normal form and explains the *inclusive* relation among (Weak) (Head) Normal Form. 1.a. For all readers, here the definition from the book for Weak Head Normal Form adds `y e1 . . . em` compared with that in wikipedia where `y` is one un-evaluated variable instead of one possible function (You can check this in p32 of that book) which is same as https://en.wikipedia.org/wiki/Lambda_calculus rules. Cont.

For both definitions, the single variable and function application are all not WHNF, so also not NF. (Thanks for user295190 to point out that helpful wikipedia link.)

0. Firefox needs to disable Quick Find https://support.mozilla.org/en-US/questions/1287036#answer-1312882. 1. The problem is that it can't support case-insensitive search, even with flag https://stackoverflow.com/a/2287449/21294350. To support that, see https://superuser.com/a/1317035.

@CMCDragonkai see user295190's comment.

More specifically for future readers, this corresponds to constructor in https://wiki.haskell.org/index.php?title=Weak_head_normal_form.

WHNF means lambda body can be redex at least compared with HNF and the rest for them are same, then what does "I.e. the top level is not a redex" in the reference mean?

0. This won't work if some website doesn't use form to implement that login part. 1. For  future readers, also see https://doc.scrapy.org/en/latest/topics/request-response.html#using-formrequest-from-response-to-simulate-a-user-login for more about the case when login is implemented with form.

For me, this problem is due to I have no project shown in https://doc.scrapy.org/en/latest/intro/tutorial.html#creating-a-project. Only one file shown in https://doc.scrapy.org/en/latest/intro/overview.html#walk-through-of-an-example-spider won't work.

More specifically, the blog gives one possible haskell  implementation for mergesort. You can check "((1 `f` 2) `f` (3 `f` 4)) `f` ((5 `f` 6) `f` (7 `f` 8))" example which is just doing many `pairs` operations, so "O(n + n/2 + n/4 + n/8 + ..) = O(n) time" https://www.wolframalpha.com/input?i2d=true&i=n%2BDivide%5Bn%2C2%5D%2BDivide%5Bn%2C4%5D%2B...%2B1. Then to get each min element requires O(log n) due to binary tree structure. So O(n + k*log n) time. (You can check others there like that for quicksort if interested.)

1. Actually mergesort also works if with lazy evaluation, see https://stackoverflow.com/questions/63698539/how-is-lazy-evaluation-implemented-in-a-way-that-doesnt-require-more-overhead-t#comment140438797_63698539.

It is possible if with lazy evaluation https://stackoverflow.com/questions/63698539/how-is-lazy-evaluation-implemented-in-a-way-that-doesnt-require-more-overhead-t#comment140438797_63698539 or we only do partial work in one sorting algorithm like `heapify` in heapsort https://stackoverflow.com/questions/66293709/lazy-sort-in-python#comment140438540_66293709.

Also see https://stackoverflow.com/a/76020184/21294350 which says about the above quote more clearly.

At least in R 4.5.0, this method doesn't work.

We can also set env for R in `.Renviron`.

More specifically, we set `R_LIBS` https://www.nas.nasa.gov/hecc/support/kb/installing-r-packages-in-your-own-directories_542.html which is also said in https://cran.r-project.org/doc/manuals/r-patched/R-admin.html#index-R_005fLIBS. Then we can use `Sys.getenv()` to check that.

"But as FUZxxl points out, laziness is not the only way to implement non-strict semantics.": It is unavailable now. https://wiki.haskell.org/index.php?title=Lazy_vs._non-strict#Further_references may help where lazy may have  one huge influence for *parallelisation*. So https://en.wikipedia.org/wiki/Evaluation_strategy#Call_by_future is preferred which is non-deterministic to help parallelisation. Then we need something like lock etc to ensure program can achieve what we wants. Optimistic evaluation IMHO is just call-by-need version for lenient evaluation.

One very good explanation based on comparison with `map`! IMHO it is clearer to check haskell official definitions (search with hoogle) of `map` https://hackage.haskell.org/package/base-4.21.0.0/docs/Prelude.html#v:map and functor https://hackage.haskell.org/package/base-4.21.0.0/docs/Prelude.html#t:Functor. So `map f a` is just applying `f` to each element of `a` while `fmap` is normally one *method* of one functor. So the above `Maybe` and `Either` are functors as AndrewC says. That is also implied in https://wiki.haskell.org/index.php?title=Functor. Continued...

IMHO It is better to relate with maths https://en.wikipedia.org/wiki/Functor#Definition where `fmap` corresponds to morphism part while "associates each object ..." part is just what the original function does. For example, `Maybe` just maps one type, e.g. `Int`, to its codomain and also has one `fmap` method for `F(f)` part.

"implies a loss of control": More specifically if someone is confused. That means "lose control over the order in which their code is executed" https://softwareengineering.stackexchange.com/q/163985/466148. But we have more  control for definging control structures since all are lazy https://en.wikipedia.org/wiki/Lazy_evaluation#Control_structures although for eager evaluation we have macro etc to do that in the Scheme language context.

As one note for future readers: Here "always maps to $\bot$" means we always do that if possible. You can check https://en.wikipedia.org/wiki/Least_fixed_point#Denotational_semantics definition of $\text{fact}_0$ and $\text{fact}$. "The set of all mathematical functions ..." definition for "the least fixed point" may give you one more understandable interpretation for "the least fixed point".

1. For $\bot$, wikipedia means "undefined" which is same as the above "diverge" if we doesn't do fine-grained classification including exception etc https://stackoverflow.com/q/14698414/21294350. We can always think that they are same https://stackoverflow.com/a/34466765/21294350 which is actually one "artificial mathematical object" besides those normal objects in the mapping domain to capture the corner case.

Can we say that we can't calculate the exact value of "least fixed point" in program analysis just like we can't calculate exact $\pi$ value but just give one property for $\pi$, e.g. circle area relation with that which is similar to the above $\text{W}  \equiv  \Phi(\text{W})$?
# Notice
I learnt SICP as [mit_6_006_2005](https://ocw.mit.edu/courses/6-046j-introduction-to-algorithms-sma-5503-fall-2005/pages/syllabus/) recommends and then finds 6.5151 course. So my intention is "A strong understanding of *programming*".
- I won't read many reference papers except when they are *specifically about programming*.
- I don't have time to test all possible *types* of inputs. I will only give some types of inputs which IMHO are all possible types without the review from others.
  **Any review of this repo is appreciated.**
- I skipped digging into
  - the complexity of *internal functions* like `remainder` since by modularity this is unnecessary. 
  - the details of `testing.scm` since it is not covered in the book.
  - *mathematical formulae* unknown when reading SDF since it is off-topic.
  - ~~`make-unit-conversion` implementation since it uses functions not covered when  introducing this function.~~
    - ~~similar for `register-predicate!`.~~
- *contract* meaning. See SICP
  > together with specified conditions that these procedures must fulfill in order to be a valid representation
  or https://htdp.org/2003-09-26/Book/curriculum-Z-H-35.html#node_idx_1852 from https://stackoverflow.com/a/9035697/21294350
  or 6.001 lec11
  > Stack Contract
- Sometimes I use *yellow mark* to show I have read some footnotes.
- [SDF_original_book] search is a bit weird. Better to search codes which will be successful most of time (searching paragraph contents may fail).
  - Emm... codes may fail at some time.
- [CPH means chris-hanson](https://sites.google.com/a/chris-hanson.org/cph/)
## Won't dig into
- I am to learn programming *general strategies*
  so won't dig into
  1. maths proof etc
  2. ingenious algorithm or program structure etc (should be taught in CRLS etc).
## related docs from 6.945 course
### commented on 5/7/2025
- https://groups.csail.mit.edu/mac/users/gjs/6.945/L17-anti-unification.pdf
  - fine to skip since it is not in the book
- https://groups.csail.mit.edu/mac/users/gjs/6.945/code/introduction-to-scheme/introduction-to-scheme.pdf
  - fine to skip since SICP has already taught enough about scheme basics.
# related summary
- See https://www.infoq.com/presentations/We-Really-Dont-Know-How-To-Compute/ from https://news.ycombinator.com/item?id=14169292
# miscs
- cph: Competitive Programming Helper
## misc clipboard
- SDF_exercises TODO
- code_base TODO
  - check by `grep TODO -r . | grep -v SDF_exercises | grep -v ";;;\|IGNORE"`
- regex search `sdf/**/*.scm`
- compared with SICP 
# @How to learn
- I forgot how I read book contents in chapter 1~3 (maybe just read the 1st sentence in each paragraph if that is sufficient to get the main ideas).
  From chapter 4, I will read codes first and then read 
  1. *code term* contexts since IMHO SDF codes are complexer than SICP although this may not hold for chapter 4.
  2. the *1st sentence* in each paragraph
  3. contents enclosed by ~~square brackets~~ *parentheses*
  4. contexts of italic words if I found those.
  - ~~For chapter 5, since most of contents in the preface have been taught in SICP, so I will  focus on the general ideas first (the above 3 items) and then detailed codes.~~
## @%Check p14, 23~27 and other pages (*chapter 1* underlined words by searching "section"/"chapter" as what I did when learning SICP) *after reading each chapter*.
Here chapter 1 is like one introduction chapter not teaching the detailed programming techniques.
- chapter 2, 3, 4 checked (no need for checking "section" contexts since they have no underlined words).
## @%Check the *preface* of each chapter and *section* same as SICP.
I probably only checked the preface before something like "Pattern constants" instead of 4.3.1
- done up to section 4.6 included.
## Chapters to check
"chapter, section" contexts
- Updated up to section 3.6 included.
- From chapter 4, also check the "page, exercise" context.
  I forgot whether I checked exercise contexts in chapter 1~3.
### chapter 2
- ~~> In the implementation of section 2.4.1, we used the terms jumping and capturing interchangeably.~~
### chapter 3
- ~~> but they have limitations, which we will discuss in section 3.1.5.~~
- ~~> In section 3.2 we will see how to add new kinds of arithmetic incrementally, without having to decide where they go in a hierarchy, and without having to change the existing parts that already work.~~
  Since all are dispatched by "generic procedure" if using `add-to-generic-arithmetic!`.
- ~~> And functional differentiation can be viewed as a generic extension of arithmetic to a compound data type (see section 3.3).~~
  i.e. differential type.
  - See [this](https://en.wikipedia.org/wiki/Functional_(mathematics))
    - > it refers to a mapping from a space X ${\displaystyle X}$ into the field of real or complex numbers
      i.e. multi variable calculus.
    - > it is synonymous with a higher-order function
      see `extract-dx-function`.
- ~~> We will extend to n-ary functions in section 3.3.2~~
- ~~> For an alternative strategy, see exercise 3.8 on page 113.~~
- ~~> The details will be explained in section 3.3.3.~~
  ~~> special addition and multiplication procedures d:+ and d:* for differential objects, to be explained in section 3.3.3.~~
  ~~> We will explain this technical detail and fix it in section 3.3.3,~~
  ~~> It will be fully explained in section 3.3.3.~~
- ~~> We will return to the problem of explicit tagging in section 3.5~~
  See `tagging-strategy:always` where `tag` only has data `simple-tag-shared` got by `%make-tag-shared` for `make-simple-tag`.
- ~~> We will see an example of this in the clock handler of the adventure game in section 3.5.4.~~
  IMHO it is more appropriate to check something like `enter-place!` since `avatar?` <= `person?`.
### chapter 4
exercise checked until section 4.6, page checked until section 4.6, section checked until section 4.6 ("chapter" checking is finished).
- ~~> We will see this technique again in chapter 4, where we use it to compile *combinations* of pattern-matching procedures from patterns.~~
- ~~> (We will explore algebraic simplification in section 4.2.)~~
- ~~> In section 4.2 we will demonstrate this in a term-rewriting system for elementary algebra.~~
- ~~> unless, somehow, x=(+ x y).1 We will learn about that sort of situation when we study unification matching in section 4.4~~
  See SDF_exercises/chapter_4/tests/unify-book-demos.scm
- ~~> We will learn how a pattern is compiled into a match procedure in section 4.3;~~
- ~~> This will be needed in the code supporting section 4.5.~~
- ~~> In this chapter we have seen how to build a term-rewriting system.~~
- ~~> This code is more complex than one might expect, because we will extend the variable syntax in section 4.5 and some of the exercises.~~
- ~~> In section 4.4.4, when we add code to experiment with segment variables in the patterns, we will be able to extract multiple matches by returning #f from succeed, indicating that the result was not the one wanted~~
- ~~> the graph can be changed only by *adding* more nodes and edges. This will have consequences that we will see in section 4.5.4.~~
  See `populate-side`.
- ~~> a dictionary of bindings accumulated in the match, as described in section 4.3.~~
- ~~> This pattern shares several characteristics with those we've looked at in previous sections~~
- ~~> In exercise 4.24 on page 225 we will fix this problem.~~
### @%chapter 5
exercise checked before section 5.2
page checked before section 5.2
section checked before section 5.2
"chapter" checking is finished.
- > In chapter 5 we will transcend this embedding strategy, using the powerful idea of metalinguistic abstraction.
- > We will not need to postpone evaluations until section 5.2, so until then g:advance is just an identity function
- > we make it possible to include procedures that require *normal-order evaluation for some parameters* (e.g., call by need) or procedures that make declarations on parameters, such as *types* and *units*. We will make some extensions like these in section 5.2.
  > a parameter could be declared to require that its argument satisfy given *predicates*, which could be types and units; etc.
- > We will examine more general ways of dealing with backtracking in section 5.4.
- > In this chapter we have seen that we have great power from the Church-Turing universality of computation.
### chapter 6
- > This is a kind of layering strategy, which we will expand upon in chapter 6.
### chapter 7
- > We will examine a very nice example of this optimization in chapter 7
  in chapter 1 footnote 17.
- > We will investigate even more powerful backtracking strategies in section 7.5.2.
# func description
## code base
- [`n:...`](https://stackoverflow.com/questions/78815439/weird-definition-of-close-enuf-in-software-design-for-flexibility)
- `(default-object)`
  see [default-object?](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Lambda-Expressions.html#index-_0023_0021optional-1)
  - ~~maybe just returns `#t` for `default-object?` implied by `(remove default-object? ...)`.~~
    > The procedure default-object produces an object that is *different from any possible constant*. The procedure default-object? *identifies* that value.
## scheme internal
- `make-parameter` see https://srfi.schemers.org/srfi-39/srfi-39.html and common/predicate-counter.scm
- [`fresh-line`](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Output-Procedures.html#index-fresh_002dline)
  > If port is such a port, this procedure writes an *end-of-line* to the port only if the port is *not already at the beginning of a line*. If port is not such a port, this procedure is identical to newline.
  `newline` -> "Writes *an end of line* to textual output port."
  - Also see SDF_exercises/chapter_5/tests/read_behaviors.scm
- > `define-record-type <property>`
  Here it may be just used when debugging due to "bound".
  > `<type name>` is bound to a representation of the record type itself.
- checked
  - `lset-adjoin`
- `reduce` compared with `fold`
  [See](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Folding-of-Lists.html#index-reduce)
  > You typically use reduce when applying f is expensive and you’d like to *avoid the extra application incurred when fold applies f to the head of list* and the identity value, redundantly producing the same value passed in to f.
  The diff is just on `ridentity`
  > ridentity should be a "right identity" ... ...in other words, we compute (fold f ridentity list).
- [`read`](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Input-Procedures.html#index-read-7)
  - i.e. the object newly "convert"ed from "external representations".
    > It returns the next object parsable from the given textual input port
  - TODO "end of file" can't be used by MIT/GNU Scheme seemingly when typing [Ctrl-d](https://stackoverflow.com/a/463944/21294350) which will just  exiting this Scheme application.
- `make-key-weak-eqv-hash-table`
  see SDF_exercises/software/sdf/combinators/function-combinators.scm reference.
  - [TODO](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Construction-of-Hash-Tables.html)
    > Note that if *a datum holds a key strongly*, the table will effectively hold that key strongly.
- `delay-force`
  - [purpose](https://standards.scheme.org/corrected-r7rs/r7rs-Z-H-6.html#TAG:__tex2page_index_200)
    > Thus iterative lazy algorithms that might result in *a long series of chains of delay and force* can be rewritten using delay-force to *prevent consuming unbounded space* during evaluation.
    where space consumption means stack space.
  - [same](https://www.gnu.org/software/kawa/Lazy-evaluation.html) as `lazy`
    also see https://srfi.schemers.org/srfi-45/srfi-45.html
    > In order to correctly simulate naive graph reduction we should instead find a way of forcing tail suspensions *iteratively*, each time *overwriting the previous result*.
    - > wrap procedure bodies with (delay (force ...)).
      just to delay.
      But for the mere `delay`, when `force`, we will have `(force (delay (if ...)))` instead of `(if ... (force (delay '())))` which will help iterative algorithm as the above says.
  - [this](https://srfi.schemers.org/srfi-155/srfi-155.html) says `delay-force` is unneeded due to
    > (delay-force <expression>) Equivalent to (delay (force <expression>)).
    > It is, however, possible to implement this requirement using the continuation marks of SRFI 157, which is demonstrated by the sample implementation accompanying this SRFI. 
    TODO check the implementation.
    - [TODO](https://srfi.schemers.org/srfi-154/srfi-154.html)
      >  Fruitful discussions with him led to the definition of shallow keys to prevent space leaks in SRFI 155
  - tail call better see wikipedia.
# TODO
## SDF code base
- `define-load-spec` seems to be [only one instruction](https://groups.csail.mit.edu/mac/users/gjs/6.945/psets/ps02/ps.pdf) but does nothing.
  >  The instructions for which files to load
- ~~`guarantee`~~ ~~(TODO seemingly defined in code base)~~
  search `name guarantee)` in SDF_exercises/software/sdf/manager/saved-total-index
- `missed-essential-match!` is not defined.
### not in MIT_Scheme_Reference, saved-total-index and the book
- `#!default`
- ~~`bundle?`~~ (see p473 for bundle which is just one family of related procedures *bundled* together)
- `uninterned-symbol?` (but works in mere MIT/GNU Scheme.)
  - Also for 
    1. `symbol>?`
    2. ~~`make-bundle-predicate`~~
    3. `->environment`
    4. `object-type`
    5. `symbol`
    6. `list-of-type?`
    7. `list-of-unique-symbols?`
    8. `unspecific`
    9. make-working-env-model
    10. enter-working-environment
    11. current-load-pathname
  - not knowing how to use
    - `define-pp-describer`
    - `(conjoin)`
- `(declare (ignore fail))` works
  but directly `(ignore fail)` won't.
  It seems to be in [common lisp](http://www.ai.mit.edu/projects/iiip/doc/CommonLISP/HyperSpec/Body/dec_ignorecm_ignorable.html).
### skipped due to small relations with where it is referred to.
- ~~`package-installer`~~
- temporarily
  - ~~`arithmetic->package`~~
  - ~~`combined-arithmetic`~~
  - ~~`get-constant` in `make-arithmetic`~~
- `simple-function` in `is-generic-handler-applicable?`.
- ~~`parse-plist`~~
- ~~`autonomous-agent?`~~
### after reading related chapters
- generic-procedure
  - `equal*?` used by `tagged-data=`.
    - not used by chapter 3.
- tag
  - ~~`simple-abstract-predicate`~~
  - ~~`predicate-constructor`~~
## TODO after algorithm
- `make-key-weak-eqv-hash-table`.
- https://11011110.github.io/blog/2013/12/17/stack-based-graph-traversal.html from https://en.wikipedia.org/wiki/Depth-first_search#Pseudocode.
  > Alternatively
  same as wikipedia 1st iterative implementation.
  - TODO 
    > These two variations of DFS visit the neighbors of each vertex in the opposite order from each other
    IMHO we can use queue keeping DFS.
  - > it delays checking ...
    to emulate "discovered" behavior when recursion.
## TODO after numerical analysis
- https://stackoverflow.com/q/78815439/21294350 -> https://stackoverflow.com/a/21261885/21294350
  > For example, if you are sorting numbers in a list or other data structure, you should not use any tolerance for comparison.
  - kw
    > Similarly, comparing for inequality or order is a discontinuous function: A slight change in inputs can change the answer completely.
## TODO after OOP like C++
- > choose one of the arguments to be the principal dispatch center
  - > It is better to have 100 functions operate on one data structure than 10 functions on 10 data structures.”
    the former may mean "the types of all of the arguments"
    while the latter may mean sometimes "thing being moved" is "the principal dispatch center" while sometimes "the source location" is.
- "class-free" in SDF_exercises/chapter_5/5_7_pratt_operator_precedence_parser/README.md
  - better usage of this (maybe dropped as QA1 there says.)
  - how to implement class without using Prototypal inheritance, i.e. different from https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Inheritance_and_the_prototype_chain.
- https://stackoverflow.com/questions/3545080/c-and-java-use-of-virtual-base-class#comment3712771_3545080 https://en.wikipedia.org/wiki/Virtual_function#Abstract_classes_and_pure_virtual_functions
- Java vs Python https://stackoverflow.com/a/34249160/21294350
  https://stackoverflow.com/a/16872315/21294350
  > I find classical inheritance usually gets in the way of programming, but maybe that's just Java. Python has an amazing classical inheritance system.
  - Multiple Inheritance https://www.geeksforgeeks.org/how-to-implement-multiple-inheritance-by-using-interfaces-in-java/
- virtual dispatch https://stackoverflow.com/a/3972780/21294350 said in https://www.oilshell.org/blog/2016/11/03.html.
## TODO after compiler
- 4.4.3. exercises. At least 4.14.
  - algorithm W [may be not the best](https://stackoverflow.com/q/66825356/21294350) for Hindley-Milner type inference
    - also see [1](https://stackoverflow.com/a/415574/21294350) [2](https://cs.stackexchange.com/q/90190/161388) [3](https://www.reddit.com/r/haskell/comments/4s71um/is_there_any_easy_to_understand_type_inference/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) [4](https://web.archive.org/web/20180913063304/http://dev.stephendiehl.com/fun/006_hindley_milner.html#constraint-generation)
- more about how tail-call optimization is implemented.
- > For example, in C there are lvalues and rvalues, and they are handled differently.
  [brief difference](https://stackoverflow.com/a/10646838/21294350)
- https://stackoverflow.com/a/9234136/21294350 about Deep/Shallow binding
- https://stackoverflow.com/q/55797832/21294350 related with Pratt Parser in ex 5.7.
- https://en.wikipedia.org/wiki/Operator-precedence_parser#Precedence_climbing_method
  - [predictive recursive-descent parser](https://www.geeksforgeeks.org/predictive-parser-in-compiler-design/)
    why no backtracking
- [LR(0)](https://cs.stackexchange.com/a/132101/161388) and [LR(0) parsing table](https://en.wikipedia.org/wiki/LR_parser#Constructing_LR(0)_parsing_tables)
- tokenizer more robust than I implemented based on regex (same as thegreenplace) in ex 5.7.
- https://stackoverflow.com/a/17382911/21294350 (same as Closing words in https://eli.thegreenplace.net/2010/01/02/top-down-operator-precedence-parsing)
  Here Pratt isn't like LR is due to it is [not based on grammar](https://u-aizu.ac.jp/~hamada/LP/L06-LP-Handouts.pdf)?
- TODO in SDF_exercises/chapter_5/5_7_naive_algorithm_for_operator_precedence_parser/README.md.
- https://en.cppreference.com/w/c/language/operator_precedence#cite_note-4
  > Many compilers ignore this rule and detect the invalidity semantically. For example, e = a < d ? a++ : a = d is an expression that *cannot be parsed* because of this rule. However, many compilers ignore this rule and parse it as e = ( ((a < d) ? (a++) : a) = d ), and then give an error because it is *semantically invalid*.
  so what is the difference between manipulating that with rule and detecting semantically? 
  - semantically invalid https://stackoverflow.com/a/2816250/21294350
    Here it means lhs of = is not lvalue. see https://en.cppreference.com/w/c/language/operator_other#Notes_3
- [static loading advantages over dynamic loading programming](https://stackoverflow.com/questions/23114414/is-the-static-loading-of-shared-libraries-linked-like-dynamic-loading-or-static)
- https://www.oilshell.org/blog/2017/03/30.html
  - > Python: uses a bespoke LL parser generator.
    https://stackoverflow.com/a/53597413/21294350
  - > uses yacc, an LR parser generator.
## TODO after Automata theory
- https://stackoverflow.com/questions/17381930/what-kind-of-parser-is-a-pratt-parser#comment137698939_17382911
### Maybe
- https://en.wikipedia.org/wiki/Scope_(computer_science)#Dynamic_scope
  > With referential transparency the dynamic scope is restricted to the argument stack of the current function only, and coincides with the lexical scope.
# [ps](https://github.com/sci-42ver/6.945_assignment_solution) (It doesn't have solutions for all SDF exercises)
## ps00
- I won't dig into the reasons of implementation shown in https://ee.stanford.edu/%7Ehellman/publications/24.pdf.
  I also skipped the paper in footnote 4.
- ` Pb Sa (modp) = aSb Sa (modp)` is [due to](https://testbook.com/maths/modular-multiplication#:~:text=for%20modular%20multiplication%3F-,In%20modular%20arithmetic%2C%20the%20rule%20for%20multiplication%20is%3A%20(a,took%20the%20product%20modulo%20c.)
  > In modular arithmetic, the rule for multiplication is:
- For "Problem ...", I only give one brief reading of the 1st sentence of each paragraph and the bold texts.
- > binary modular operators
  See https://www.aleksandrhovhannisyan.com/blog/modular-arithmetic-and-diffie-hellman/#:~:text=In%20number%20theory%2C%20the%20binary,or%20base%20of%20the%20operation.
- > The following definitions are equivalent:
  This is shown in Appendix B.
- > The converse of the theorem doesn’t hold, unfortunately; if p is composite (not prime), then it isn’t always true that ap 6= a (mod p).
  The latter is [Inverse](https://en.wikipedia.org/wiki/Inverse_(logic)).
- > Some composite numbers p, called Carmichael numbers, pass the test for almost all a
  [See](https://mathworld.wolfram.com/CarmichaelNumber.html). Here we should not use "almost".
- I skipped https://sci-hub.se/https://doi.org/10.1007/3-540-39568-7_2 since this is one programming course.
- > xS (modp) = aST (modp) = P T (modp)
  See https://en.wikipedia.org/wiki/Modular_arithmetic "compatibility with multiplication"
  So
  $$
  \begin{align*}
    x^S\pmod{p}&=(a^T)^S\pmod{p}=a^{ST}\pmod{p}\\
               &=(a^{S}\pmod{p})^T\pmod{p}=P^T\pmod{p}\\
    y(x^S)^{-1}\pmod{p}&=mP^T(x^S)^{-1}\pmod{p}\\
                       &=mx^S(x^S)^{-1}\pmod{p}\\
                       &=m\pmod{p}\\
                       &\overbrace{=}^{\text{Here p have 100 digits, so probably m << p}}m
  \end{align*}
  $$
### `p0utils.scm`
- > discrete logarithm problem
  https://en.wikipedia.org/wiki/Discrete_logarithm
  It only considers the integer solution.
- ~~Notice "y=m*P^T(mod p)" is different from the original Diffie-Hellman algorithm.~~
- IMHO for `m=(y/x^S)(mod p)`, `y` and $x^S$ should not take `(mod p)` to make it work.
- "leading zeros" may mean "leading ones".
### 6.945_assignment_solution
- I lacks "(d) Test Fermat's Little Theorem:".
## ps01 (unfortunately ps01 when 6.945_assignment_solution isn't same as 2024 version.)
- TODO `index-fixnum?` implementation which is not documented in [MIT_Scheme_Reference].
  ```scheme
  (pp index-fixnum?)
  (named-lambda (non-negative-fixnum? a1)
    (index-fixnum? a1))
  ```
- 2.b See Exercise 2.2.
## ps03
- > To allow use of assign-handler ! do the following :
  Since we need to rebind original procedures to generic procedures.
  - > This makes the default top-level arithmetic
    it may mean `*current-arithmetic*` or the above.
## ps04
- reader/writer bugs
  - See my notes for former books learnt.
  - csapp3e
    > Writers must have *exclusive* access to the object, but readers may *share* the object with an unlimited number of other readers.
    It shows [first and second](https://en.wikipedia.org/wiki/Readers%E2%80%93writers_problem#First_readers%E2%80%93writers_problem) readers-writers problem. In a nutshell, this just decides how the *waiting order* is based on the *arrival order*.
    - See exercise 12.19~12.21.
      - Gosh! After the review I found many of my implementations at that time are so weird and also wrong. I took some time to review this (about 6 hours).
  - OSTEP
    since csapp has already contained 3 types. I won't review it.
- "video interface" and "distributed game" are beyond the intention of following this course and reading this book. So I won't do these.
## ps05
- > section 2.11: Macros. This is complicated stuff, so don’t try to read it until you need to.
  Actually only needed by the code base but not the exercises (at least when I did the exercises, I didn't use that).
  ```bash
  [~/SICP_SDF/SDF_exercises/software/sdf/generic-interpreter]$ grep 'syntax' -r ../**/*.scm --color=always | grep -E '(term|design|unification|graph)'
  ../design-of-the-matcher/matcher.scm:;;;; Pattern syntax
  ../term-rewriting/rule-implementation.scm:                              ;; make-rule is only used by (define-syntax rule ...).
  ../term-rewriting/rule-implementation.scm:(define-syntax rule
  ...
  ```
# [project](https://github.com/bmitc/mit-6.945-project) (it only has https://github.com/bmitc/the-little-schemer but not solutions for SDF exercises)
- Also see https://ocw.mit.edu/courses/6-945-adventures-in-advanced-symbolic-programming-spring-2009/pages/projects/ and https://groups.csail.mit.edu/mac/users/gjs/6.945/rfp.pdf.
  - kw: free software
  - See Suggestions for Projects
  - TODO
    interchangeable parts, proposal.

---

# Acknowledgment
- > the lambda papers
  [See](https://research.scheme.org/lambda-papers/)
- [PPA](https://ell.stackexchange.com/a/325015)
# chapter 1
Interestingly this chapter compares the computer system with many other systems like biology and physics, etc. (I only read the footnotes about biology detailedly possibly.)
- > Thus a designer may design a compound function and later choose the family for implementation.
  > The families differ in such characteristics as speed and power dissipation, but *not in function*.
  > The families are cross-consistent as well as internally *consistent* in that each function is available in each family, with the same packaging and a consistent nomenclature for description.
  IMHO it means we should construct multiple alternative primitive implementations.
- [Hox complex](https://en.wikipedia.org/wiki/Hox_gene)
- > To the optimist, the glass is half full. To the pessimist, the glass is half empty. To the engineer, the glass is twice as big as it needs to be.
  [See](https://qr.ae/psfaJy)
# chapter 2
- > A program that implements this idea is straightforward:
  See [R5RS](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_8.html#IDX360) for why we use `apply` here.
- > The result of ((iterate n) f) is a new function, of the same type as f.
  Same domain and codomain.
- `(((iterate 3) square) 5)` same as python `((5**2)**2)**2`.
- > so it does not have a well-defined numerical arity, and thus it cannot be passed to another combinator that needs its arity.
  I didn't dig into the arity implementation `(hash-table-ref/default arity-table proc #f)` since it is related with data structure (i.e. hash table) which should be learnt in CRLS, i.e. [`procedure-arity`][MIT_Scheme_Reference].
- > In the mathematical tensor product, f and g are linear functions of their inputs, and h is a trace over some shared indices
  TODO IMHO it is more related with ["direct sum"](https://www.math3ma.com/blog/the-tensor-product-demystified).
- > Note that here we do not need to use restrict-arity because the returned procedure has exactly one argument.
  The main difference here is that here the func parameter is *not variant*.
## regular expression (Here only give one translator from Scheme `r:...` to normal regex but not give one interpreter to *match* regex.)
- > the quotation conventions are baroquen
  [See](https://www.merriam-webster.com/dictionary/baroque#:~:text=Baroque%20came%20to%20English%20from,lines%2C%20gilt%2C%20and%20gold.)
  TODO how is regex related with quotation?
- > the parenthesis characters are treated as self-quoting characters
  i.e. mere parenthesis
- See [this](https://web.archive.org/web/20130419005313/http://www.research.att.com/%7Egsf/testregex/re-interpretation.html#The%20Dark%20Corners) from [this](https://stackoverflow.com/a/13356328/21294350)
  > :RE#46:B	\(a\{0,1\}\)*b\1	ab	(0,2)(1,1)
  `echo "ab" | sed -n "s/\(a\{0,1\}\)*b\1/\1/p"` will give the wrong output `a` since `ba` doesn't exist in `ab`.
### TODO related with regex syntax (no relation with programming)
- > There is also a special case for a set containing only caret and hyphen
- > most regular expressions are *not composable* to make larger regular expressions
  IMHO regex is easy to be nested.
- > protect a pattern beginning with “-”
  in `man grep`.
## unit
- `(unit:invert inch-to-meter)` can be thought as inch/meter.
  so applying twice make psi->psm.
  - similar for `pound-to-newton`
  - notice here it applies to those conversions with only `/` or `*` at least.
    But if with something like `+`, it *may not* hold.
    For example, if `inch-to-meter` is `(lambda (inches) (+ inches meters-per-inch))`.
    Then `A/B^2 psi` will become `A/B^2+2*mpi psi` instead of `A/(B+mpi)^2 psi`.
- > broadening its applicability without changing the original program.
  just based on something like the lib, i.e. `units.scm` here.
  > wrap it to specialize it for a particular purpose
  i.e. `make-specialized-gas-law-volume` and `conventional-gas-law-volume`.
- > And the unit-specializer procedure knows very little about either.
  i.e. what `gas-law-volume` is and what input units are.
- > This is somewhat like a combinator system except that the combinators are generated by the compiler according to a high-level specification.
  by seeing its code, it is just based on finding necessary "primitive unit conversions" by `make-converter` and then nested procedure calls in `(output-converter ...)`.
## checker
- > First, the aggregated moves may contain jumps for some pieces and ordinary moves for others, in which case only the jumps are legal moves.
  It should be "for some *paths*".
- TODO
  > For example, the accumulation of changes (steps in the path) is built into the control structure, as is chaining of a multiple jump.
  Maybe it means we need to pass `paths` arg implied by "distribution".
- > We redefine should-be-crowned? and crown-piece to use the piece type, so they behave the same as before, but they are no longer part of the core domain model.
  > we will abstract away the checkers-specific parts and hide many of the details of the domain model.
  IMHO so "the core domain model" is all defined in `game-interpreter.scm`. The details are defined in *rules*.
  > The domain model we will use has *three abstract types*.
  > The domain model's implementation is fairly complex, providing implementations of pieces, coordinates, and the board.
  > in which the *nouns* and verbs of the language are directly related to the problem domain
  > The domain model provides a set of primitives that are combined to make the rules, giving us a language for *expressing the rules*.
  The rest are defined in `board.scm` and `coords.scm`.
  > This is an informal description of a domain model for a class of board games.
  So *without codes*, it is just one definition of how we play one board game.
### chess
- TODO
  - https://en.wikipedia.org/wiki/Rules_of_chess#End_of_the_game
    - > Under FIDE Laws, a resignation by one player results in a draw if their opponent has no way to checkmate them via any series of legal moves, *or a loss by that player otherwise*.
- ~~why~~ ["stalemate"](https://support.chess.com/en/articles/8557490-what-is-stalemate) is draw ~~since IMHO here "Black" doesn't have "no legal move" but each move will make "Black" lose.~~
  The difference is that here we are *not in check* (in Checkmate we are *already in check*) but must be in check after *any move*.
  This is what ["has no legal move"](https://en.wikipedia.org/wiki/Rules_of_chess#Draws) means.
- [dead position](https://www.europechess.org/dead-position/#:~:text=White%20is%20about%20to%20play,leads%20to%20a%20dead%20position.&text=Even%20though%20there%20are%20many,White%20makes%20the%20move%20c5.)
  > both kings are trapped on their respective sides
  since all black positions at black's 4th row are occupied.
  > the pawns cannot move
  i.e. "Blocked positions can arise" in wikipedia.
## summary
- > using mix-and-match *interchangeable* parts
  ~~means combined by~~
  ~~> we used the terms jumping and capturing interchangeably.~~
  means "a family of" by 
  > defines a set of interchangeable incrementers.
  - mix-and-match just means use the *appropriate interfaces* (i.e. match).
- TODO
  - How "lexical scoping" is related with "combinators".
- > C that do not have lexically scoped higher-order procedures.
  "lexically scoped" implies [no env propogation](https://qr.ae/p2pjwk) different from ["Dynamic Scoping"](https://www.geeksforgeeks.org/static-and-dynamic-scoping/#) (better [see](https://prl.khoury.northeastern.edu/blog/2019/09/05/lexical-and-dynamic-scope/) or [same](https://langdev.stackexchange.com/q/253)) ~~("calling functions" means ancestor. See "the value returned by f() is not dependent on who is calling it")~~.
  ~~> In simpler terms, in dynamic scoping, the compiler first searches the current block and then *successively all the calling functions*.~~
  > Under dynamic scoping, a variable is bound to the *most recent* value assigned to that variable
  - [dynamic binding in Scheme](https://stackoverflow.com/a/3787068/21294350) from https://stackoverflow.com/questions/78908635/what-is-the-relation-of-parent-env-and-the-child-env-in-mit-scheme#comment139125389_78908764.
    [shadow](https://stackoverflow.com/a/59447655/21294350)
  Notice C uses ["Static scoping is also called lexical scoping"](https://www.geeksforgeeks.org/static-and-dynamic-scoping/#)
- > When we are confronted with a system based on parts that *do not compose cleanly*, such as regular expressions, it is often possible to ameliorate the difficulties by *metaprogramming*
  - the 1st part is due to regex expr is just one str which needs manual inspection to find its  structure, i.e. composition.
    So "domain-specific intermediate language"
    > but it is not so nice as a scripting language for a user to type.
  - TODO how is it related with [Metaprogramming](https://en.wikipedia.org/wiki/Metaprogramming#:~:text=Metaprogramming%20is%20a%20computer%20programming,even%20modify%20itself%2C%20while%20running.) since it doesn't read programs?
- > For that purpose we would want to design a clean and more concise syntax for matching strings that can be compiled to a combinator-based intermediate language.
  maybe [str --> intermediate (e.g. `regexp-replace`)](https://srfi.schemers.org/srfi-115/srfi-115.html) -> regex --(regex matching program)> result (--> means not covered by SDF). 
- > Scheme's powerful means of combination and abstraction
  i.e. some lib func like `fold` etc. for combination and "higher-order procedures" for abstraction.
## self summary
- > It provides a general framework for the construction of a variety of related programs that share the domain of discourse.
  See the referee system.
- > In this chapter we first introduce systems of combinators, a powerful organizational strategy for the erection of domain-specific language layers.
  e.g. `(reduce compose (lambda (x) x) aggregate-rules)` in the referee system.
- > We will demonstrate the effectiveness of this strategy by showing how to reformulate the ugly mess of regular expressions for string matching into a pretty combinator-based domain-specific language embedded in Scheme.
  maybe
  > Using composable parts and combinators to make *new parts by combining others*
  - TODO it seems only use *nested functions* withouting using something like `compose` etc.
    e.g. 
    `r:char-not-from`, `r:char-from` based on `bracket` and `quote-bracketed-contents`.
    `r:*`, `r:+` based on *merely* `r:repeat`.
    - exercise 2.7 (see `sdf-regex.rkt`), 2.8 (see 6.945_assignment_solution), 2.9, 2.10 (see 6.945_assignment_solution) all have no relations with "combinators".
- > We illustrate this with a domain-specific language for making unit-conversion wrappers for procedures
  i.e. `unit:*` etc. which redefines `*`, etc.
# chapter 3
- > We first generalize arithmetic to deal with symbolic algebraic expressions, and then to functions
  See `extract-dx-part`
## comparison with SICP
Here I am mainly based on SICP "Data-Directed Programming" since that is more structural than explicit dispatch and based on data instead of proc dispatching (similar to `operation-applicability` dispatching in `operation-union-dispatch` here).
- 3.1
  - it mainly uses `make-arithmetic` (* means they are largely different.)
    1. `name` is only for debugging or `arithmetic->package`.
    2. `bases` is related with `base-operations` which helps defining primitive operations.
      In SICP `install-polynomial-package` just uses one *generic* procedure like `add` to *combine all bases*. Here we can do this step by step with `add-arithmetics`.
    3. `domain-predicate` is used when functioning as the base of another arithmetic.
      In SICP this is done by tag.
      Here it is done by record primitive data type.
    4. * `get-constant` is mainly used for `get-identity`.
      In SICP it only considers argument >=2 (see Exercise 2.82).
    5. `get-operation` uses `operation-applicability` to choose the correct operation procedure and selects the *first* available operation by `operation-union-dispatch`.
      In SICP, it uses hash table to store procedures with `type` and uses `(get ⟨op ⟩ ⟨type ⟩)` to find the *unique* entry.
  - Then it uses `add-arithmetics` to increment (`operation-union` *may overload* if not carefully used, see exercise 3.3).
    In SICP it just does many `install-...` since it won't overload due to *no type conflicts*.
## 3.1
IMHO this is almost duplicate of SICP chapter 2, especially 2.5, by reading the preface.
- It introduces arithmetic
  1. symbolic-arithmetic-1
  2. combined-arithmetic
  3. pure-function-extender
  4. function-extender
  - vector-extender in exercise 3.2.
  - matrix-extender in exercise 3.6.
- > a well-specified and coherent entity.
  IMHO "coherent" -> closely related.
- > the use of combinators to build complex structures by combining simpler ones
  i.e. `bases` in `make-arithmetic`
  or `(extend-arithmetic extender base-arithmetic)`, etc.
- > A program that depends on the exactness of operations on integers may not work correctly for inexact floating-point numbers.
  TODO IMHO it means we need to check whether we manipulate with "integers" or "floating-point numbers"?
- Stormer's integrator of order 2 See p102.
### 3.1.1 A simple ODE integrator
- what arithmetic operations are used in `evolver`?
  1. `stormer-2`: `+,*,/,expt,` and what is used in `F`.
  2. `stepper`: `+`
  3. `make-initial-history`: `-,*`.
### 3.1.5
Problems with combinators and possible solutions using generic procedure:
1. > add-arithmetics prioritized its arguments, such that *their order can matter*
  See `constant-union` from `add-arithmetics`
  - ~~sol~~: See `add-generic-arith-constants!` which still uses `constant-union`, so the above problem is not solved.
    See 3.2.2 Construction depends on order! where `add-handler!` *may* overload handlers so "order" matters.
1. > means that it's impossible to *augment the codomain arithmetic* after the function arithmetic has been constructed.
  implied in `(arithmetic-domain-predicate codomain-arithmetic)` in `function-extender` by `extend-arithmetic` which calls `add-arithmetics`.
  - sol: solved by `extend-generic-arithmetic!` and `add-generic-arith-operations!`
    since we delayed func addition until `add-generic-arith-operations!` and "generic" have no restriction for dispatch.
1. > we might wish to define an arithmetic for functions that return functions.
  ~~IMHO `pure-function-extender` has done this by `(lambda args (apply-operation ...))`.~~
  (the above is wrong since `codomain-operation` doesn't support func type supported by `pure-function-extender`. So `(apply-operation codomain-operation '(func-1 func-2))` will fail.)
  - The key problem may be "self reference" implying nested recursion.
    See exercise 3.4.
  - sol: same as the above point
    since generic will always dispatch, ~~after ((* num func-1) arg) -> (* num func-2), ~~ the above `codomain-operation` must work if inner handler supports that.
1. TODO
  > One problem is that *the shapes of the parts* must be worked out *ahead of time* ... This is not a problem for a well-understood domain, such as arithmetic
  IMHO See exercise 3.4, i.e. what types do each func allow decides the order of arithmetics.
  - sol: again all are *delayed* until `add-generic-arith-operations!`.
1. > Other problems with combinators are that the behavior of any part of a combinator system must be independent of its context. A powerful source of flexibility that is available to a designer is to *build systems that do depend upon their context*.
  IMHO this is due to that they don't need global variables.
  This is also shown in `add-arithmetics`.
  - sol: Maybe again due to `add-generic-arith-operations!` since handler is that context and for outside we just uses *generic*?
## 3.2
- The power of extensible generics
  I only read the context of "generic".
### 3.2.1
- > The problems we indicated in section 3.1.5 are the result of using the combinator add-arithmetics.
  See the above.
- [CLOS](https://en.wikipedia.org/wiki/Common_Lisp_Object_System) and [tinyCLOS](http://community.schemewiki.org/?tiny-clos)
  - [SOS](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-sos.html)
- > where both the vectors and the components of a vector are manipulated by the *same generic procedures*. We could not build such a structure using just add-arithmetics introduced earlier.
  since `add-arithmetics` is based on *base* arithmetic.
  But actually they are all done by `operation-union-dispatch` which selects the appropriate operation.
- > We also added function arithmetic *over numeric arithmetic*, so if functions are numerically combined (here by +) their outputs may be combined only if the outputs are numbers.
  see `(apply-operation codomain-operation ...)`.
- > because the functions are defined over the generic arithmetic:
  see `codomain-operation` in `function-extender` which is *`generic` operation* here which can "add new kinds of arithmetic *incrementally*".
  - call order of `(+ ’c cos sin)`:
    generic -> `get-handler` to choose `function-extender` -> call `(cos (+ 3 ’a))`
    - then call order of `(+ 3 ’a)`:
      generic -> `symbolic-extender` -> return `(+ 3 a)` by `(cons operator args)`.
    - then call order of `(cos (+ 3 a))`:
      almost same as `(+ 3 ’a)`
    -> call `(+ c (cos (+ 3 a)))` -> `symbolic-extender` ...
    - The key here is "defined over the generic arithmetic"
      so operation always works but let possible errors thrown in "handler" (**Abstraction**).
  - > We can even use functions that return functions:
    This is due to `(make-generic-arithmetic make-simple-dispatch-store)` has one generic-procedure. Then we only change `generic-procedure-handler` by (`add-to-generic-arithmetic!` -> `add-generic-arith-operations!` -> `define-generic-procedure-handler`) without changing the procedure.
    - notice when calling the generic *operation*
      it always work due to `any-object?`.
      Then it calls `generic-procedure` which then calls `generic-procedure-dispatch` -> `get-generic-procedure-handler` -> `generic-metadata-getter` if possible (otherwise `generic-metadata-default-getter` to throw errors here since `default-handler` is `#f`) -> `get-handler` -> `predicates-match?`
      notice here predicates are `(operation-applicability operation)` of base `arithmetic` which is probably not `any-object?`.
    - call order:
      generic -> `function-extender` to `(+ (lambda (y) (cons 3 y)) (lambda (y) (cons y 3)))` -> *generic* (see SDF_exercises `3_3.scm` where `+` in `codomain-operation` doesn't support the currently defined func arithmetic) -> again similarly `(+ (cons 3 4) (cons 4 3))`.
### 3.2.2
- > which worked in the previous arithmetic, fails because the symbolic arithmetic captures (+ ’c cos sin) to produce a symbolic expression
  - This is a bit like overload in `3_3.scm` due to *too general* `any-object?` sometimes.
  - See `add-handler!` which prioritizes the latter added `handler` based on `find` in `get-handler`.
    so `(symbolic? any-object?)` is prioritized over `(any-object? function?)`.
    Here it just have "ambiguity"
    > because there is no ambiguity in the choice of rules.
- TODO
  > With this mechanism we are now in a position to evaluate the Stormer integrator with a literal function: ...
  What does these want to say?
  just to say:
  > Though each integration step in the basic integrator makes three calls to f, the two steps *overlap* on two intermediate calls.
  ?
## 3.3
- > Its relation to an expression derivative is: ...
  Here $\frac{d}{dx}f(x)$ is "the derivative Df".
- equation (3.5):
  it means $f([x,\delta x])=f(x+\delta x)=f(x)+Df(x)\delta x=[f(x),Df(x)\delta x]$
  - So
    > we obtain the chain-rule answer we would hope for:
    where we just substitute 
    1. $f$ with $g$
    2. $x$ with $f(x)$
    3. $\delta x$ with $Df(x)\delta x$
  - (3.6) is similar.
- > The handler for exponentiation f (x, y) = x is a bit more
  see [SDF_original_book].
- > Here we are extracting the coefficient of the infinitesimal dx in the result of applying f to the arguments supplied with the ith argument incremented by dx.
  This is based on $f(x_0,x_1,\ldots,x_i+\delta x_i,\ldots,x_n)=f(x_0,x_1,\ldots,x_i,\ldots,x_n)+f'_{i}(x_0,x_1,\ldots,x_i,\ldots,x_n)\delta x_i$ (In my review of calculus, this should be right by thinking of we move delta in each direction until we get $f(x_0+\delta x_0,x_1+\delta x_1,\ldots,x_i+\delta x_i,\ldots,x_n+\delta x_n)$. I won't verify it since I am learning programming and I have learnt calculus at least 3 times, one in class, one to prepare for one contest and another to prepare for the graduate entrance exam. I am a bit ambiguous about calculus now due to forgetting.)
- `general-derivative` just calculates $Dg(args)\cdot \Delta(args)$.
- > If the result of applying a function to a differential object is a function
  i.e. the 1st `derivative` calls `(f (d:+ x (make-infinitesimal dx)))` where `f` is the 1st `lambda`. This returns the 2nd `derivative` which is func.
  So we need to call `extract-dx-function`.
  - Let $g(x,y)=x*y$, then the inner func does `(lambda (x) g_y(x,y))`, so this func does [$g_{yx}(x,y)$](https://economics.uwo.ca/math/resources/calculus-multivariable-functions/3-second-order-partial-derivatives/content/)
### TODO
- >  we define an algebra of differential objects in “infinitesimal space.” The objects are multivariate power series in which no infinitesimal increment has exponent greater than one.
  I won't dig into [Multivariable calculus](https://en.wikipedia.org/wiki/Multivariable_calculus#Theorems_regarding_multivariate_limits_and_continuity) (also [see](https://math.stackexchange.com/q/485731/1059606))
  also for [infinitesimal space](https://ncatlab.org/nlab/show/infinitesimal+object)
- I won't dig into [bug fix [87]](https://arxiv.org/pdf/1211.4892) since I am to learn programming *general strategies* (skip-due-to-general-strategy-target).
- ~~active-tag related funcs like `with-active-tag`, `tag-active?`.~~
- ""maximal factor" in differential analysis" doesn't have anything related with
  > with any one of the maximal factors (here δx or δy) being primary.
## 3.4
- > This is a simple example of the use of delegation to extend an interface, as opposed to the better-known inheritance idea
  i.e. change one passed init arg instead of ...
- > the results of different handlers can be combined to provide better information.
  For "numerical interval", we may get the intersection of all these numerical intervals.
- > The call to simple-list-memoizer wraps a cache around its last argument
  i.e. only needs `args` (see `make-simple-list-memoizer` the inner lambda).
## 3.5
- > The tags were implementation-specific symbols, such as pair, vector, or procedure.
  `efficient-generic-procedures/cached-generics.scm` uses `implementation-type-name`.
  ```scheme
  (define microcode-type/code->name
    (access microcode-type/code->name (->environment '(runtime))))
  (microcode-type/code->name (object-type symbol?))
  ;Value: compiled-entry
  (microcode-type/code->name (object-type pair?))
  ;Value: compiled-entry
  ```
- > We could not have rules that distinguish between integers that satisfy even-integer? and integers that satisfy odd-integer?, for example.
  TODO maybe due to only having `integer?`?
  - IMHO the code base only defines "superset" and `tag<=` but doesn't define `set=?` and `combinartion-sets` etc.
- > The tag will be easy to attach to objects that are accepted by the predicate.
  TODO IMHO this may be "attach to" "predicate". See `tag->predicate` and `predicate->tag`.
- > Consequently the tagged object can be tested for the property defined by the expensive predicate by using the *fast abstract predicate* (or, equivalently, by dispatching on its tag).
  See `tagging-strategy:always` -> `predicate` in `tagging.scm`
  It is only fast for those not registered by `predicate-constructor` since `(tagged-data? object)` is #f.
- > but adding an associative lookup to get the metadata of a predicate, as we did with the arity of a function (on page 28)
  "arity" uses hash-table.
  > chasing these references must be efficient.
  i.e. efficient search.
- > Since the subset relation is a partial order, it may not be clear which handler is most specific
  [due to](https://en.wikipedia.org/wiki/Partially_ordered_set) 
  > The word partial is used to indicate that not every pair of elements needs to be comparable
- > In this implementation, the property objects are specified by themselves, and two properties with the same name are distinct.
### adventure game type relations
- (troll? student? house-master?) <= autonomous-agent? <= person? <= mobile-thing? <= thing? <= object?
  - Here I assume `(set-predicate<=! student? autonomous-agent?)` won't do duplicate actions like doing this after doing `(set-predicate<=! student? person?)` (See `uncached-tag<=` comments).
- exit? <= object?
- (place? bag?) <= container? <= object?
### adventure game code review (this project code is much heavier than before).
- [x] The game
- > In this implementation, the property objects are specified by themselves, and two properties with the same name are distinct.
  See `make-type` which calls `%set-type-properties!`
  and `(type-properties type)` called by `type-instantiator`.
  Here `make-type` always has one `prefix:...`. So "distinct".
  - Notice `(lookup-value property)` is based on search indexed by `property-name`.
    So mammal may have `(mammal:forelimb mammal-forelimb-inst)`
    while bat may have `(bat:forelimb bat-forelimb-inst)` and `(mammal:forelimb bat-forelimb-inst)`
- `property-setter` will at last use the `(lambda (#!optional new-value) ... (set-cdr! p new-value)...)` in `make-instance-data`
  So we use `set-holder!` implying that the modification is *in-place*.
## summary
- > Extensions of arithmetic are pretty tame
  ~~See `add-arithmetics` in `arith.scm` where `operation-union` just chooses *one* possible func implementation for each type predicate list by `find`.~~
  ~~It doesn't have generic, ~~ See 3.1.5
- > addition of floating-point numbers is not associative
  i.e. applicability matters, so also holds for generic.
  [See](https://stackoverflow.com/a/10371890/21294350) 
  - TODO the reference is said in one QA comment of [this user](https://stackoverflow.com/users/21294350/an5drama) with one paper *pdf* link.
- > On the good side, it is straightforward to extend arithmetic to *symbolic expressions* containing literal numbers as well as purely numerical quantities
  [literal numbers](https://www.ibm.com/docs/en/informix-servers/12.10?topic=dte-literal-number)
  > as an *integer*, as a fixed-point *decimal* number, or in *exponential notation*
  - TODO what is [purely numerical quantities](https://en.wikipedia.org/wiki/Physical_quantity#:~:text=Purely%20numerical%20quantities%2C%20even%20those,%CE%B1%2C%20sinh%20%CE%B3%2C%20log%20x)
    maybe [without unit](https://media.physicsisbeautiful.com/resources/2019/02/09/MasteringPhysics__Dimensions_of_Physical_Quantities.pdf) (also [see](https://blog.ansi.org/iso-80000-1-2022-quantities-and-units/))
  - > For symbolic arithmetic, the operation is implemented as a procedure that creates a symbolic expression by *consing* the operator the operator name onto the list of its arguments
    so straightforward.
- > symbolic vectors are not the same as vectors with symbolic coordinates
  ~~For `(+ (vector 'a) (vector 'b))` the former ~~
  - > However, we eventually run into real problems with the ordering of extensions—symbolic vectors are not the same as vectors with symbolic coordinates
    See "3.2.2 Construction depends on order!"
    - TODO I don't know how ordering influences "vectors with symbolic coordinates" since `vector` in `(vector 'a 'b)` isn't changed by the code base implementation of `vector-extender` and `symbolic-extender` due to that it is not in `%arithmetic-operator-alist`.
      The former may probably not mean [this](https://www.mathworks.com/help/symbolic/sym.html#bu1rqzj-1) since that is "vectors with symbolic coordinates". It may mean literal vector (see Exercise 3.7).
- > We also can get into complications with the typing of symbolic functions.
  TODO symbolic functions = literal function (see 3.3.4)?
- > *forward-mode* automatic differentiation
  See
  > we obtain the chain-rule answer we would hope for:
  where $Dg(f(x))\delta f(x)\mapsto Dg(f(x))Df(x)\delta x$ is similar to ["Forward accumulation computes the recursive relation"](https://en.wikipedia.org/wiki/Automatic_differentiation#Forward_and_reverse_accumulation)
  This is done by `(g (f (d:+ x (make-infinitesimal dx))))` (see `derivative`) where `d:+` returns one `differential` object and all `+,-,*` etc can work for `differential` (see `diff:binary-proc`). (See the above "equation (3.5)").
- > However, making this work correctly with higher-order functions that return functions as values was difficult
  See `extract-dx-function` (trivially due to generic procedure, this works for higher-order functions which returns one higher-order function which returns one normal func or even more levels. see `extract-dx-function-deep-level-test.scm`)
  > most programmers writing applications that need automatic differentiation do not need to worry about this complication.
  maybe means using "automatic differentiation" lib so no "worry".
- > introduced a predicate registration and tagging system that allowed us to add declarations of relationships among the types.
  See `simple-abstract-predicate` for "a predicate registration and tagging system" and `tag<=` using hash table `tag<=-cache` and base pred `generic-tag<=`. The latter uses `get-tag-supersets` for inheritance.
  - `generic-tag<=` uses `bottom-tag?` #f and `top-tag?` #t.
    i.e. if something is `any-object?` then all objects are in its subset.
  - See `tag-supersets` etc.
    Here tag can do many things including the above "relationships".
    > For example, we may tag data with its provenance, or how it was derived, or the assumptions it was based on.
    So we *don't directly* set predicate relations.
    And this tag can work for other data types like complex number, etc.
- > We demonstrated this with a simple but elegantly extensible adventure game.
  See `make-chaining-dispatch-store`.
- > if we dispatched on the first argument to produce a procedure that dispatched on the second argument, and so on
  See "because in such a design one must choose one of the arguments to be the *principal* dispatch center" and footnote 31.
  Notice this is different from trie since that *only* has actual data (i.e. handler here) at *leaf*.
  > single-dispatch
  i.e. "dispatched on the first argument".
  > So modeling these behaviors in a typical single-dispatch objectoriented system would be more complicated.
  since that will have *much more* generic procedures.
- > We used tagged data to efficiently implement extensible generic procedures. The data was tagged with the information required to *decide which procedures* to use to implement the indicated operations.
  See `type-instantiator` where "information" is something like `tag-supersets` to be used for `rule<` used by `make-subsetting-dispatch-store-maker` -> `get-handler`.
  > Such audit trails may be useful for access control, for tracing the use of sensitive data, or for debugging complex systems
  After all it can do anything if possible since it is *data*.
# chapter 4
I first read 4.2.2 (actually directly read the codes after reading the contents before Exercise 4.1 since the book doesn't say much about codes seemingly...)
- > if more than one rule is applicable, the results may depend on the ordering of application
  - ~~Similar to SICP~~
    > depend on the order of clauses in an and
    i.e. one rule may cause
  - SICP uses `stream-flatmap`
    Here at least result *order* "may depend on".
- > We already encountered problems with the interaction of rules, in the boardgame rule interpreter. (See the critique on page 63.)
  These problems are not about correctness but *design improvements*.
- > The first rule could be in the control-structure part of the optimizer,
  [see](https://www.avrfreaks.net/s/topic/a5C3l000000UALjEAO/t053581?comment=P-428870) although [the normal call](https://en.wikipedia.org/wiki/Peephole_optimization#Removing_redundant_stack_instructions) doesn't have this pattern seemingly
- https://en.wikiversity.org/wiki/Basic_Laws_of_Algebra
- > See section 5.4.2 on page 273 for more examples and explanation of this success/failure pattern.
  I didn't dig into that codes currently, but with a glance, it should be similar to SICP implementation based on "backtracking".
  Actually, understanding SICP amb implementation is enough to understand codes here.
- > convergent term-rewriting systems
  [see (I skipped digging)](https://en.wikipedia.org/wiki/Abstract_rewriting_system#Termination_and_convergence)
- > matches a list of any number of elements
  IMHO it is >= 2.
- > headed list
  see sicp_notes.md or SICP Figure 3.22.
- > change the syntax of patterns any way we like
  i.e. the way patterns are constructed.
- > the need for backtracking because of segment variables
  See SICP or [wikipedia](https://en.wikipedia.org/wiki/Backtracking#Pseudocode) where `next(P,s)` just means `(lp (+ i 1))` in SDF_exercises/software/sdf/design-of-the-matcher/matcher.scm.
- > the creation of domain-specific languages and other systems that should have an additive character
  see 4.6
  > they are also a very useful way to *organize parts of a system for additivity*. ... but compilers do huge amounts of this kind of manipulation, to compute optimizations and sometimes to *generate code*.
- > A pattern can be matched to a part of a larger datum; the context of the match is unspecified.
  Sometimes "the context" may have something like `board` var in `graph-match`.
- > Generic procedures allow us to do miraculous things by modulating the meanings of the free variables in a program
  Maybe in some special "Generic procedures", its handler has different "meanings of the free variables" for different combinations of predicates.
- > If we instead use patterns to advertise jobs to be done and other patterns to advertise procedures that might do those jobs, we have a much richer language: pattern-directed invocation.
  See [this](https://dspace.mit.edu/bitstream/handle/1721.1/41187/AI_WP_296.pdf?sequence=4&isAllowed=y) p2~3 `f(0, ?x)` which corresponds to the latter "other patterns ..."
  - TODO the meaning of "use patterns to advertise jobs to be done".
## 4.4
- `(unifier a b)` etc have been taught in SICP.
- ~~> Often there are constraints among the variables in an expression.~~
- ~~Here I read codes following the book based on *abstraction* (e.g. understanding `unifier` ideas only knowing what `unify` should do but not how) since unification ideas have been taught in SICP.~~
  - IMHO better to read codes and then read the book contents which will be more fluent.
- > In the guts of this unifier it is convenient for a failure to make an *explicit call* to a failure continuation.
  maybe it means what SICP does by *explicitly* issuing `try-again`.
  > returning #f from a success continuation
  i.e. we change *success continuation* instead of calling `fail` *explicitly*.
  - Anyway at last we will call `fail`.
  - > we had to make the reverse transition: the matcher used the #f convention, so make-rule (on page 166) had to implement the transition.
    i.e. `or` in `match:segment`.
    So `make-rule` needs to pass `#f` to `succeed`, which is what `print-all-matches` does.
    - "reverse" just means ~~`make-rule` needs to be compatible with "matcher" reversely.~~
      i.e. use #f without using `fail` at all -> use `fail`.
      > This is to make the convention for use of the unifier the same as the convention for use of the matcher of section 4.3.This is an interesting transition.
      i.e. use #f but here we uses `fail` which is similar to what `make-rule` does.
  - ~~TODO~~
    > is easy to interface these disparate ways of implementing backtracking.
    see
    > This is to make the convention for use of the unifier the same as the convention for use of the matcher of section 4.3.
    where matcher actually *doesn't have fail continuation* (see SDF_exercises/software/sdf/design-of-the-matcher/matcher.scm).
    - So "interface" just means between ways using `fail` (i.e. SDF_exercises/software/sdf/term-rewriting/rules.scm) and not (i.e. matcher).
- > recursively descend into the pattern, comparing subpatterns of the patterns as lists of terms.
  same as one-sided `match:list`.
- > the unification matcher is organized around lists of terms to allow later extension to segment variables.
  i.e. allowing `grab` one arbitrary subsequence in the *rest*.
- > The unifier is the most general *common* substitution instance of the two patterns: any other common substitution instance of the two patterns is a *substitution instance* of the unifier.
  Here "common" means shared. See Exercise 4.19 and 4.20.
### 4.4.2
- > it is a procedure that takes one numerical input and produces a numerical output.
  > takes two numerical arguments and produces a numerical result.
  These are all be done by `unify` with `primitive-type`.
  i.e.
  > the type of each *internal variable* has been determined
- > The process of type inference has four phases.
  i.e. `annotate-program` -> `program-constraints` -> `unify-constraints` -> `match:dict-substitution`.
  - > semantic structure of the program.
    here "semantic" means type.
- > this could be accomplished by passing information back in the failure continuations.
  This is just what `fail` should do. But then `fail` 1. won't be thunk 2. or depends on one global variable 3. or just add infos like SICP does for `set!`, i.e. redefine `fail`.
- > The annotate-expr procedure takes an environment for bindings of the type variables.
  Here it means cdr of each binding is "type variables".
- > the same as the types
  Emm... My English is poor that I used merely "same as" before which is [wrong](https://textranch.com/c/is-the-same-as-or-is-same-as/)...
### 4.4.4
- > ((w () ??) (y () ??) (x (b b b) ??))
  > ((w () ??) (y () ??) (x (b b b) ??))
  ~~This is due to `unify:segment-var-var` has ~~
  See SDF_exercises/chapter_4/term-rewriting/book-demo/bidirectional-segments.scm
- TODO
  ["general unifier" p17](https://www.csd.uwo.ca/~mmorenom/cs2209_moreno/read/read6-unification.pdf)
- > The other four are not as general as possible.
  i.e. same here.
- > But these expressions do match, with the following bindings:
  Here `(?? x)` intersects with `(?? y)` sharing the value 5.
  But tht codes only consider the containing relation in `grab-segment`.
## 4.5
- > The pattern matching we have developed so far is for matching list structures.
  Just term-rewriting or the general unification.
  The former see SDF_exercises/software/sdf/term-rewriting/rule-implementation.scm which is just based on `match:compile-pattern`. Since all exp's in Scheme are list as SICP says in chapter 4, we have "matching list structures".
  > Such structures are excellent for representing expressions
  - Similar for SDF_exercises/software/sdf/unification/unify.scm `(unify:dispatch (list pattern1) (list pattern2))` etc.
- > just the description of the interconnect
  [interconnect](https://semiengineering.com/all-about-interconnects/) related with *layer*s (see global interconnect and local interconnect).
- > The order in which the symmetry transformations are applied doesn't matter *for the transformations we use*.
  See comments for `symmetrize-move` in SDF_exercises/software/sdf/pattern-matching-on-graphs/chess-moves.scm.
- > the others are similar remappings of the compass directions
  "remapping" refers to the `map` used many times in `symmetrize-move`.
- > likewise each color sees the leftmost column as 0 and the rightmost as 7. 
  This is different from [wikipedia indexing conventions](https://en.wikipedia.org/wiki/Rules_of_chess#Movement).
- > The inverse of node-at is the delegate procedure address-of .
  same as [converse in logic](https://en.wikipedia.org/wiki/Converse_(logic)).
- > from that node with the label n
  Notice here graphs are all default to be directional.
- > King Bishop 3
  [See](https://en.wikipedia.org/wiki/Descriptive_notation#Nomenclature)
- BNF in p275 shows the path from the `source-node` but not includes that `source-node`.
## 4.6
- > We also saw a flexible way to construct a pattern matcher, by “compiling” a pattern *into a combination of simple matchers* that all have the same interface structure.
  “compiling” [means](https://www.geeksforgeeks.org/difference-between-compiler-and-interpreter/)
  > translates the whole program at once
- > because there may be multiple possible matches to any particular data if the pattern has more than one segment variable.
  If there is only "one segment variable", then all the rest positions are determined, which then decide the "segment variable" position.
## TODO
- ~~> Let's see how to organize programs based on pattern matching.~~
- ~~> And with only a small amount of work we can add semantic attachments, such as the commutativity of lists beginning with the symbols + and *.~~
  TODO Maybe like
  > (define addition-commutativity 
  >  ’(= (+ (? u) (? v)) (+ (? v) (? u))))
  where `=` is like the constraint form, so data for `unify` are just `(+ (? u) (? v))` etc.
- ~~`SDF_exercises/software/sdf/unification/possible-bug.scm`~~
- ~~> here we are not trying to build a complete and correct segment unifier.~~
  - ~~maybe~~
    > but an element variable may not have a segment variable as its value.
  - See Exercise 4.19 and 4.20.
- ~~> handle (literal) edge cases~~
  i.e. edge *between nodes* instead of something like `(node ’connect! ’address address)`.
### maybe skipped
- ~~Exercise 2.12,13 -> SDF_exercises/chapter_2/test-chess.scm~~
  are also "chess referee".
  But it is a bit too long time ago that I wrote these *heavy codes*. I won't compare these with the "chess referee" here...
  - chapter2 gets *all possible moves* like `summarize-move-checking-type` while here we check for one specific move.
    The former seems to have no procedure to execute the step move like `simple-move` here but just `initial-pieces-generator` in `make-chess*`.
  - chapter2 uses `(define-evolution-rule 'simple-move ...)` to calculate all one-step moves while here we uses pattern path.
    The former uses `(define-aggregate-rule 'promotion ...)` to do post operations while here I changed the internal procedure (see `SDF_exercises/chapter_4/4_23_graph_match_lib/promotion_lib.scm`) to implement that (maybe also can be done by changing the interface of `simple-move`).
    - IMHO "pattern path" is *more elegant*.
## difference from SICP logic programming
- one-sided matching
  adds (see `algebra-2`)
  1. segment variable
  2. predicate like `(? x ,number?)`.
  3. extension in exercises.
  4. ...
- unification
  - doesn't consider recursive unification.
    The implicit renaming in SDF_exercises/software/sdf/unification/type-resolver.scm is not used for unification but for the *general* `type:...` var is used many times.
  - again has segment variable.
  - SDF_exercises/software/sdf/unification/type-resolver.scm
    - still uses counter to differentiate the same var *name* in different unrelated locations.
      env is to connect var with types but not 2 vars which is done by unify.
      - Similarly 4.7, 4.9 also don't connect 2 vars but connect var with actual non-var value.
        - The above is different from SICP 4.79 which connect *2 vars*.
          Then `depends-on?` needs special manipulation.
          e.g. `(?x ?y)` -> `(?y (+ ?y 1))` should work since after renaming we have `(?x ?y)` -> `(?y1 (+ ?y1 1))`, so ?y->(+ ?y1 1) doesn't fail for `depends-on?`.
          - IGNORE: But with env where we add one new frame for each application, so when adding to that frame in `unify-match` we fail for `depends-on?` due to ?y->(+ ?y 1). We may assume we just always add these bindings but that is not that case for the book example `(?x ?x) and (?y <expression involving ?y>)`.
            ~~More specifically, we need to use env to differentiate these 2 ?y's.~~
            - Maybe we can change `unify-match` so that `(unify-match (binding-value binding) val frame)` will check depends-on? while the `unify-match` in `unify-match` won't.
              Also for `equal? p1 p2` checking where if p1 and p2 are on different sides, we should not skip binding them.
              - Anyway we can change `unify-match` to add one arg to denote which side each of `p1` and `p2` belongs to. So we add one idx implicitly.
                **But this is not done by env...**
          - See my comments in http://community.schemewiki.org/?sicp-ex-4.79 where we need to "uses environments rather than renaming".
            So maybe store each var seq in one application in different frames to *differentiate*, then why not use the straightforward index method.
            - My comments are not archived in https://web.archive.org/web/20220520045055/http://community.schemewiki.org/?sicp-ex-4.79 when schemewiki is again down on 2024 Dec 25.
            - This differentiation problem **doesn't hold** for the above cases *not connecting 2 vars*.
# chapter 5
Recommended time to read Sections 5.1 and 5.2: 12/2=6 days (/2 is considering the time to read the related SICP part vaguely) based on the starting time of the next ps and the finished time of the former ps (i.e. `Date(2024, 4, 3)-Date(2024, 3, 22)=12` in Coda).
- > We explored this idea in limited contexts in chapters 2, 3, and 4. Here we will pursue this idea in full generality.
  IMHO "this idea" means "domain-specific language" which is trivial for chapters 2, and 4 where the latter focuses on "pattern matching".
  In chapter 3, all blocks of each program are just based on one specific arithmetic which just means "domain-specific language".
- > An interpreter is just such a mechanism.
  [compared](https://www.geeksforgeeks.org/difference-between-compiler-and-interpreter/) with Compiler
  > A compiler translates *the whole program* at once, which can make it run faster but takes more time to compile. An interpreter translates and runs the code *line by line*, making it easier to catch errors and debug, though it may run slower.
## code comparison description with SICP
```scheme
;;; difference
;; no abstraction compared with SICP

;; different from SICP
;; different from SICP due to

;;; similarity
;; similar to SICP but uses the different structure.
;; similar comments to ...

;; almost same basic ideas as SICP

;;; better than SICP ...
;; better than SICP due to the compliance with the standard
;; better than SICP with abstraction
;; better than SICP due to using the internal definition for the procedure used only by something.

;; more robust than SICP

;;; IMHO worse than SICP ...

;;; addition
;; extra things added besides SICP
```
## @% TODO for the preface of chapter 5
- > These declarations will allow a procedure to defer evaluation of the corresponding argument to when its value is actually needed, providing for lazy evaluation, with or without memoization of the value.
  similar to SICP Exercise 4.31.
- > So we next separate the interpretation into two phases, analysis and execution. ... The execution procedures all have the same form, and constitute a system of combinators.
  IMHO just same as exercise_codes/SICP/book-codes/ch4-analyzingmceval.scm where all `exp` args are moved from `lambda`.
  - "combinators" just means something like ~~recursive calls~~ `analyze-definition` may be based on `analyze` for subparts.
    > a thing that combines subparts together into a larger part.
    - > It is possible to create *combinator languages*, in which the components and the composite all have the same interface specification.
      > A combinator language defines primitives and means of combination
      See 2.2.1 where "means of combination" are ~~just procedure calls~~ special `r:seq` etc
      > the means of combination are the combinators compose , parallel-combine, spread-combine , and *others we may introduce*
- > Remarkably, this requires no change to the analysis part of the evaluator.
  See exercise_codes/SICP/book-codes/ch4-ambeval.scm which needs small addition for `(analyze exp)`.
- > it turns out that all we need is call/cc to implement amb directly in Scheme, so we conclude by showing how to do this.
  in http://community.schemewiki.org/?LisScheSic but it is down when I wrote this. The archive https://web.archive.org/web/20241114023648/http://community.schemewiki.org/?LisScheSic doesn't have the contents I wrote about `amb`.
## code misc description
- [rtdata meaning](https://model-realtime.hcldoc.com/help/topic/com.ibm.xtools.rsarte.webdoc/pdf/ModelRealTime%20Services%20Library.pdf)
  Here it is about runtime procedures like `apply-primitive-procedure` etc.
## 5.1
- > But because our eval is a generic procedure, the set of symbols that are defined by eval may be changed easily and even dynamically
  i.e. adding more handlers by `add-handler!` in `SDF_exercises/software/sdf/common/generic-procedures.scm`.
- > In our interpreter we will pass the *unevaluated* operands and the environment for their evaluation to apply to make it possible to implement a variety of evaluation strategies
  This is different from exercise_codes/SICP/book-codes/ch4-mceval.scm where it uses `list-of-values` (also exercise_codes/SICP/book-codes/ch4-analyzingmceval.scm where `analyze-application` will call `(aproc env)` for `args`).
  It is similar to exercise_codes/SICP/book-codes/ch4-leval.scm.
- > We inherit the Scheme reader, so our syntax is very simple
  i.e. we have primitive accessor procedures for "syntax" (see SICP for what "syntax procedure" means).
  > we inherit tail recursion, so we don't need to pay special care when implementing procedure calls
  [tail-call optimization](https://en.wikipedia.org/wiki/Tail_call), so even if we didn't call at last, the optimization may do that.
- > some of which start with distinguished keywords
  ~~i.e. tagged list.~~
- > The implementation will be organized as a set of rules for each expression type
  for example, `let` may have the named version or not.
- > We define g:eval as a generic procedure with two arguments.
  so just one replacement for `cond` in exercise_codes/SICP/book-codes/ch4-leval.scm
- > given meanings from the lexical context (where the lambda expression appears textually)
  See SICP for more. In a nutshell, just based on the parent env(s) when *created* instead of the runtime.
- > allow for side-effecting actions, such as assignment, or I/O control actions
  [relation with I/O](https://softwareengineering.stackexchange.com/a/258668)
- > Scheme hygienic macro systems
  is said in one of my SO questions.
- > input/output operations are usually implemented in hardware by assignment to particular sensitive locations in the address space.
  - "sensitive locations in the address space" [see](https://stackoverflow.com/questions/3215878/what-are-in-out-instructions-in-x86-used-for/3215958#3215958)
    > I/O devices share the address space with memory
  - "in hardware" [see](https://c9x.me/x86/html/file_module_x86_id_139.html)
- footnote 9 see SDF_exercises/chapter_5/tests/recursive_define.scm
- "syntactic construct" [see](https://www.sciencedirect.com/science/article/pii/S0957417422024162#:~:text=For%20Java%2C%20we%20identified%20seven,constructs%20used%20by%20Java%20programmers.)
  > Each AST node represents a syntactic construct
- > remember Alan Perlis's maxim on page 159
  See sicp_notes.md
- > call by need
  See SICP Exercise 3.57 and https://en.wikipedia.org/wiki/Evaluation_strategy#Call_by_need
  - (based on exercise_codes/SICP/book-codes/ch4-leval.scm which probably shares the same basic ideas here due to being both by Sussman) Here the thunk value can be reused due to their values are just *delayed*, more specifically each of they just one value which is based on `env` arg due to *lexical scope*.
    - Notice each call of one procedure will create *new* thunks by `delay-it` which can't be used when calling this procedure with the same arguments and *`env`*.
      - How to reuse, see
        ```scheme
        (define fibs
          (cons-stream 0
                       (cons-stream 1
                                    (add-streams (stream-cdr fibs)
                                                 fibs))))
        ```
        where `fibs` *object* is reused, therefore its sub-objects are also reused.
- > The environment argument also makes it possible to accommodate non-lexically scoped variables
  based on exercise_codes/SICP/book-codes/ch4-leval.scm, just use `(extend-environment ... env)` for `apply` which then will use the dynamic `env` which may be changed during runtime by `add-binding-to-frame!` etc.
  - > it is generally a bad idea.
    See SICP_SDF/sicp_notes.md "dynamic_scope_disadvantage_...".
- > like arithmetic addition (usually named by the + operator), are strict: they need all of their arguments evaluated before they can compute a value
  because *primitive* `+` will need the argument values *immediately* after the call.
- > including primitive procedures (implemented in the system or hardware below the level of the language)
  see OSTEP where `lock` etc is implemented "in the system" which may be just implemented by assembly based on "hardware".
- > For lexical scoping, that extended environment is built on the environment *packaged* with the procedure by the evaluation of the lambda expression that *constructed* the procedure.
  Better to see [wikipedia](https://en.wikipedia.org/wiki/Scope_(computer_science)#Lexical_scope_vs._dynamic_scope_2) instead of other  references in SICP_SDF/sicp_notes.md etc.
  - this implies the above "packaged" (i.e. `make-compound-procedure`).
    > In languages with lexical scope (also called static scope), name resolution depends on the location in the source code and the lexical context (also called static context), which is defined by *where the named variable or function is defined*.
    - Compared with *dynamic scope*, see the following.
  - > In practice, with lexical scope a name is resolved by searching the local lexical context, then if that fails, by searching the *outer* lexical context, and so on
    implies `extend-environment`, i.e. "built on ...".
    - Compared with *dynamic scope*, lexical context can be just seen as `env` var here not depending one "*execution*" (same for the former quote).
  - implied by 1st quote.
    - > Importantly, in lexical scope a variable with function scope has scope only within the lexical context of the function: it goes *out of context when another function is called within* the function, and comes back into context when the function returns—*called functions have no access* to the local variables of calling functions
      lexical context definition (see the above for "Compared with *dynamic scope*")
      - implied by ...: see the following where it is also about the definition of the called procedure. Anyway these 2 quotes mean the same thing.
      - also see
        > function g does not have access to f's local variables (assuming the *text* of g is not inside the text of f)
        - "Compared with *dynamic scope*"
          > since g is *invoked* during the invocation of f
        - IGNORE: implied by ~~`env`~~ static analysis where we can't associate g and f at all.
          implied by that `g` can't know "f's local variables" when manipulated by `lambda?`-eval. Then when extended, it still can't.
    - > In lexical scope (or lexical scoping; also called static scope or static scoping), if a variable name's scope is a certain function, then its scope is the *program text* of the function definition: within that text, the variable name exists, and is bound to the variable's value, but *outside that text, the variable name does not exist.*
      "Compared with *dynamic scope*"
      > then its scope is the time-period during which the function is *executing*
      - ~~implied by `make-compound-procedure` using `env` corresponding to the time when *defined* by `lambda`~~
        implied `g:apply` with `strict-compound-procedure?` where extended env is *only* used for that body.
      - same as
        - "Compared with *dynamic scope*" implicitly
          > With lexical scope, a name always refers to its lexical context. This is a property of the program *text* and is made independent of the *runtime* call stack by the language implementation.
  - > In languages with lexical scope and nested functions, local variables are in context for nested functions
    implied by `env` *passed along* during calls and `define` etc modifies `env` in place.
    - No "Compared with *dynamic scope*".
  - > If the language of this program is one that uses lexical scope ...
    trivial if understanding the above.
  - > Correct implementation of lexical scope in languages with first-class nested functions is not trivial, as it requires each function value to *carry with it a record* of the values of the variables that it depends on (the pair of the function and this context is called a closure).
    i.e. `make-compound-procedure`
    - No "Compared with *dynamic scope*".
  - > *Deep binding*, which *approximates static (lexical) scope*, was introduced around 1962 in LISP 1.5 (via the *Funarg* device developed by Steve Russell, working under John McCarthy).
    - how "approximates", see [this](https://stackoverflow.com/a/1753505/21294350) where we doesn't use the *recent* value for `x` possibly (better based on [this](https://stackoverflow.com/questions/1753186/dynamic-scoping-deep-binding-vs-shallow-binding#comment56763368_1753505)).
      - The ideas can be just [*directly* ported](https://softwareengineering.stackexchange.com/questions/331885/differences-between-deep-and-shallow-bindings-for-static-scoping?newreg=74f6eae1cad541f58127f3f3ea189cdc#comment1009473_331885) to "static scoping".
      - [ad hoc binding](https://www.oreilly.com/library/view/programming-languages-concepts/9781284222739/xhtml/086_Chapter06_11.xhtml), so it will uses `second`'s env which just has no introduction of the "dynamically created" `x, y`, therefore outputting `1+2=3`. See SO_1.
      - trivially [Scheme uses Deep binding](https://stackoverflow.com/a/4383122/21294350) which is more like "static scoping".
        - TODO see [SO_1](https://stackoverflow.com/q/79469121/21294350)
      - IMHO Deep means the distance from the callee to the used env if searching from the most recent frame to the least.
    - Funarg
      - see `downward_funarg.c` for the normal behavior where we can't access caller stack.
      - Also see [this](https://stackoverflow.com/a/44575491/21294350) for why we uses closure and [this](https://stackoverflow.com/questions/44574946/difference-between-a-closure-and-the-funarg-problem#comment140150976_44574946).
        - http://dmitrysoshnikov.com/ecmascript/chapter-6-closures/#funarg-problem
          - > We see that in systems with dynamic scope, variable resolution is managed with a dynamic (active) stack of variables.
            This is [not for C](https://stackoverflow.com/q/71282687/21294350).
      - [Funarg device](https://stackoverflow.com/a/34889366/21294350): IMHO just means closure above.
      - Also see https://stackoverflow.com/a/587670/21294350 for the comparison with upward version
        - deleted comment
          > Thanks for your patience. Maybe I have said too much and a bit distracting, what I want to know is that why "downward funarg" is easy while "the general case" (i.e. upwards funarg) is hard for "a traditional Lisp". Do your "shadow" mean "dynamic scope" so that "downward funarg" is easy as the above "Sorry for my neglect. ..." shows and then "upwards funarg" is hard due to lacking one direct mechanism to *carry on necessary information around*?
  - [Dynamic binding](https://softwareengineering.stackexchange.com/a/331902/466148) better to see wikipedia [late binding](https://en.wikipedia.org/wiki/Late_binding)
    > early binding ... This is usually stored in the compiled program as an offset in a virtual method table ("v-table")
- [S-expression](https://en.wikipedia.org/wiki/S-expression) (i.e. `list` in Scheme)
  TODO "like-named notation"
### @% TODO
- > we also enable the implementation of *declarations on the formal parameters*, and perhaps some other options.
- > with generic hooks for extension.
  IMHO i.e. generic-procedure. I only got one exact definition from google AI
  > A "generic hook" refers to a *reusable* piece of code, often a function, that can be applied to *various types of data or scenarios*. It's like a general-purpose tool that can be adapted to specific needs by providing appropriate input or parameters.
  or [see](https://graphite.dev/guides/typescript-generics#:~:text=TypeScript%20generic%20function,length%20property%2C%20so%20no%20error)
  > Generic interfaces allow you to define a contract that can be applied to various types.
## 5.2
- > We could have many kinds of declarations on formal parameters, describing how to handle *operands and arguments*.
  the former is [specific to operator](https://stackoverflow.com/a/32554318/21294350)
  > you are analyzing its *execution* then in 2 + 3 you have operands and when looking into *operator method body*, you just received arguments. So look into context.
  > If analyzing *expression tree*, you can speak about operators and their operands.
  which is [also one procedure](https://math.stackexchange.com/a/2842453/1059606) where IMHO Function<=Operator<=Procedure where <= means $\subset$.
  > Operator: usually in higher math and physics contexts is a function whose domain includes other functions. Computer Scientists call these *“higher order functions*”
  > Procedure: a super set of Algorithm, procedures don’t have a connotation of *mapping inputs to outputs, although they can if you want*.
  - See codes `g:handle-operand` part in `g:apply` for `general-compound-procedure?`.
    so for the interpreter, `operand` is that input symbol list which is then interpreted as arguments.
- > In the original implementations of *by-name parameters* in Algol-60 these combinations of *expression and environment* were called *thunks*.
  [see](https://gtoal.com/languages/algol60/jff-algol-60-compiler/doc/jff-manual.pdf) p20 where `value l, u;` implies only `a,b` are "by name parameter"s.
  "the value thunk" and "the address thunk" are just like ~~accessor~~ selectors and mutator said in SICP.
  > in addition to selectors and constructors, operations called mutators
  - The details of compiler implementation for how to implement that env and then the related thunks is beyond the doc.
- > allowing that environment to be garbage-collected if there are *no other pointers to it*.
  IMHO This only works for Reference counting which is [limited](https://en.wikipedia.org/wiki/Garbage_collection_(computer_science)#Reference_counting), [see](https://docs.python.org/release/2.5.2/ext/refcounts.html)
  > even though there are no further references to *the cycle itself*.
  also see [the figure](https://en.wikipedia.org/wiki/Reference_counting#Advantages_and_disadvantages) where "all counts remain >0." means all 1s.
  - see [one tracing strategy](https://en.wikipedia.org/wiki/Tracing_garbage_collection#Na%C3%AFve_mark-and-sweep)
    "The frequent updates" can be avoided by "run on a time schedule" etc.
    "reference cycles" can be avoided as the example shows (You can assume object-7 and object-8 constitutes one cycle).
    "concurrent" see https://en.wikipedia.org/wiki/Tracing_garbage_collection#Real-time_garbage_collection (TODO check the paper).
  - Escape analysis isn't ~~based on the former 2~~ one separate *independent* strategy for garbage collection.
  - All in all, all 3 strategies IMHO are based on pointer.
- > An ancient but important paper by Dan Friedman and David Wise, entitled “Cons should not evaluate its arguments”[40], showed how *lazy functional programming* can be powerful, but is *easily obtained using kons* rather than cons.
  ~~https://legacy.cs.indiana.edu/ftp/techreports/TR44.pdf is not selectable.~~ [see](./references/papers/TR44.pdf)
  - see https://www.reddit.com/r/lisp/comments/3w6lf1/comment/cxu19ro/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button, i.e. https://help.luddy.indiana.edu/techreports/TRNNN.cgi?trnum=TR44
    - > Landin's streams are subsumed into McCarthy's LISP merely by the *redefinition of elementary functions*
      i.e. that in [SICP](https://sarabander.github.io/sicp/html/3_002e5.xhtml#FOOT186)
      > In their implementation, cons always delays evaluating its arguments, so that lists *automatically behave as streams*.
      - also in [SRFI](https://srfi.schemers.org/srfi-41/streams.pdf)
        - [signature](https://web.cs.dal.ca/~nzeh/Teaching/3137/haskell/first_steps/basic_types/signatures/)
      - also in https://dtai.cs.kuleuven.be/projects/ALP/newsletter/archive_93_96/comment/streams.html
        - > Streams can provide *modularity without the need for state variables*. Landin proposes lazy evaluation for processing streams.
          [i.e.](https://www.xfront.com/stream/streams.pdf)
          > Stream models can provide an equivalent modularity *without the use of assignment*. Stream functions are *stateless*.
          see [SICP](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-24.html#%_sec_3.5.5)
          where *state* is implicit in the stream sequence *steps* (compare `random-numbers` with `rand` or other comparisons).
    - TODO
      > This new insight into the role of constructor fdunctions will do much to ease the interface between recursive programmers and iterative programmers, as well as the interface *between programmers and data structure designers.*
      - Also [see](https://www.reddit.com/r/lisp/comments/p693hi/comment/h9c6d1c/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) although that video doesn't say that specifically.
    - > The main results are ...
      shows SDF
      > showed how lazy functional programming can be powerful
  - Also see SDF
    > but the fact that the kons pairs are memoized reduces this to a linear problem.
- > Some streams are finite, so it is useful to choose a representation for the empty stream.
  here it uses [odd stream](https://srfi.schemers.org/srfi-41/srfi-41.html)
  if using even, it should be "even stream" by induction.
- > The usual *doubly recursive* Fibonacci program is *exponential*
  [see](https://understanding-recursion.readthedocs.io/en/latest/10%20Fibonacci%201.html)
- 
## 5.5
### @%TODO
- https://groups.csail.mit.edu/mac/users/gjs/6.945/evaluator-pages.pdf
# chapter 6
## 6.5
- https://groups.csail.mit.edu/mac/users/gjs/6.945/better-layering.pdf
# Appendix B
## concepts not covered in SICP up to now
- > In MIT/GNU Scheme we can use the sugar recursively, to write:
- > Here, the symbol factlp following the let is locally defined to be a procedure that has the variables count and answer as its formal parameters.
  [See](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_6.html#IDX99)
  > "Named `let'" is a variant on the syntax of let which provides a more general looping construct than `do' and may also be used to *express recursions*
  since it allows "variable" naming.
- > These names are accidents of history
- > There is a constructor vector that can be used to make vectors and a selector vector-ref for accessing the elements of a vector.
- [`define-record-type`](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/define_002drecord_002dtype-_0028SRFI-9_0029.html)
- TODO how `*:binary`, etc. are implemented.
  - https://groups.csail.mit.edu/mac/users/gjs/6.5150/dont-panic/#orgf57d50a
    `(pp *)` seems to only give one brief description since `(pp complex:*)` throws errors.
    ```scheme
    (case number-of-arguments
      ((0) (named-lambda (nullary-*) 1))
      ((1) (named-lambda (unary-* z) (if (not (complex:complex? z)) (error:wrong-type-argument z "number" '*)) z))
      ((2) (named-lambda (binary-* z1 z2) (&* z1 z2)))
      (else (named-lambda (* self . zs) (reduce complex:* 1 zs))))
    ```
- > A symbol may not normally contain whitespace or delimiter characters, such as parentheses, brackets, quotation marks, comma, or #
- Here all quotation is implicitly list, so [`pair?` returns `#t`](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_8.html#IDX271).
- > Lisp systems provide a mechanism called quasiquotation that makes this easy.
  See [quasiquotation](https://docs.scheme.org/schintro/schintro_129.html)
  > quasiquote is much more powerful than quote, however, because you can write expressions that are mostly literal, but leave holes to be filled in *with values computed at runtime*.
  - > Consult the Scheme Report [109] for a more detailed explanation of quasiquotation.
    [See](https://standards.scheme.org/unofficial/errata-corrected-r7rs.pdf) 4.2.8. Quasiquotation with the list summarizing what it says.
- > For example, we can use set! to make a device that increments a count every time we call it:
  Here `let` make `set!` appear no use. [See](https://stackoverflow.com/q/78762534/21294350).
  ```scheme
  (define (make-counter)
          (let ((count 0))
              (lambda ()
                (set! count (+ count 1))
                count)))
  1 ]=> ((make-counter))

  ;Value: 1

  1 ]=> ((make-counter))

  ;Value: 1
  ```
- [Dynamic binding][R7RS]
  > This sections introduces parameter objects, which can be *bound to new values* for the duration of a dynamic extent.
- > A bundle is sometimes called a message-accepting procedure, where the message type is the delegate name and the message body is the arguments
  This is not recorded in [R7RS]
  also not related with https://srfi.schemers.org/srfi-29/srfi-29.html (since no relation with `locale`) (also see https://wiki.call-cc.org/eggref/5/srfi-29#documentation) and https://srfi.schemers.org/srfi-114/ searched by "bundle" in https://srfi.schemers.org/?q=bundle.
  "guile language "bundle"" also has no related results.
  - IMHO this is similar to SICP tagged data in p238 and Message passing in p252.
    Actually this combines these 2 together in some way that we can use predicate different from `procedure?` on "Message passing" data.
    - "the message type is the delegate name" is ~~like `'point` in `(make-bundle-predicate 'point)`~~ `point?`, i.e. predicate *procedure*.
  - > the rest of the arguments are passed to the specified delegate.
    may mean *using* delegate precedures like `get-x get-y` etc.
    > The bundle macro creates a bundle procedure, for which those procedures are the delegates.
    > The remaining arguments to the bundle macro are the names of the delegate procedures
    e.g. `(p13 'get-x)` will *call* (i.e. delegate later things to) `get-x` in that bundle to manipulate later things.
  - > containing an association from each name to its delegate procedure.
    similar to srfi-29
    > (time . "Its ~a, ~a.") ... 
    > The list contains associations between *Scheme symbols and the message templates* (Scheme strings) they name.
    Here "Scheme symbol" is just `message-name`.

# References
## common
- [109] R7RS

---

<!-- [109] -->
[R7RS]:https://standards.scheme.org/unofficial/errata-corrected-r7rs.pdf 
[MIT_Scheme_Reference]:https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref.pdf
[SDF_original_book]:https://mitpress.ublish.com/ebook/software-design-for-flexibility-preview/12618/110