SICP says "One key idea in dealing with compound data is the notion of
closure —that the glue we use for combining data objects should allow
us to combine not only primitive data objects, but *compound data ob-jects* as well." and "The use of the word “closure” here comes from *abstract algebra*". So you are right SICP uses https://en.wikipedia.org/wiki/Closure_(mathematics) instead of https://en.wikipedia.org/wiki/Closure_(computer_programming).

@adabsurdum Thanks. I understand now.
# Notice
- I won't read many reference papers except when they are *specifically about programming*.
- I don't have time to test all possible *types* of inputs. I will only give some types of inputs which IMHO are all possible types without the review from others.
  Any review of this repo is appreciated.
- I skipped digging into
  - the complexity of internal functions like `remainder` since by modularity this is unnecessary. 
  - the details of `testing.scm` since it is not covered in the book.
  - mathematical formulae unknown when reading SDF since it is off-topic.
  - `make-unit-conversion` implementation since it uses functions not covered when  introducing this function.
    - similar for `register-predicate!`.
- contract meaning. See SICP
  > together with specified conditions that these procedures must fulfill in order to be a valid representation
  or https://htdp.org/2003-09-26/Book/curriculum-Z-H-35.html#node_idx_1852 from https://stackoverflow.com/a/9035697/21294350
# miscs
- cph: Competitive Programming Helper
# *How to learn
## Check p14, 23~27 (chapter 1 underlined words by searching "section"/"chapter" as what I did when learning SICP) *after reading each chapter*.
- chapter 2 checked.
## *Check the preface of each chapter and section same as SICP.
- done up to section 2.5 included.
## *Chapters to check
Updated up to section 3.1 included.
### chapter 2
- ~~> In the implementation of section 2.4.1, we used the terms jumping and capturing interchangeably.~~
### chapter 3
- > but they have limitations, which we will discuss in section 3.1.5.
- > In section 3.2 we will see how to add new kinds of arithmetic incrementally
### chapter 4
- > We will see this technique again in chapter 4, where we use it to compile combinations of pattern-matching procedures from patterns.
- > (We will explore algebraic simplification in section 4.2.)
### chapter 5
- > In chapter 5 we will transcend this embedding strategy, using the powerful idea of metalinguistic abstraction.
### chapter 6
- > This is a kind of layering strategy, which we will expand upon in chapter 6.
# func description
## code base
- [`n:...`](https://stackoverflow.com/questions/78815439/weird-definition-of-close-enuf-in-software-design-for-flexibility)
- `(default-object)`
  - ~~maybe just returns `#t` for `default-object?` implied by `(remove default-object? ...)`.~~
    > The procedure default-object produces an object that is *different from any possible constant*. The procedure default-object? *identifies* that value.
## scheme internal
- `make-parameter` see https://srfi.schemers.org/srfi-39/srfi-39.html and common/predicate-counter.scm
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
  I didn't dig into the arity implementation `(hash-table-ref/default arity-table proc #f)` since it is related with data structure which should be learnt in CRLS, i.e. [`procedure-arity`][MIT_Scheme_Reference].
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
  "lexically scoped" implies [no env propogation](https://qr.ae/p2pjwk) different from "Dynamic Scoping".
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
## comparison with SICP
Here I is mainly based on SICP "Data-Directed Programming" since that is more structural than explicit dispatch and based on data instead of proc dispatching (similar to `operation-applicability` dispatching in `operation-union-dispatch` here).
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
- > a well-specified and coherent entity.
  IMHO "coherent" -> closely related.
- > the use of combinators to build complex structures by combining simpler ones
  i.e. `bases` in `make-arithmetic`
  or `(extend-arithmetic extender base-arithmetic)`, etc.
- > A program that depends on the exactness of operations on integers may not work correctly for inexact floating-point numbers.
  TODO IMHO it means we need to check whether we manipulate with "integers" or "floating-point numbers"?
### 3.1.1 A simple ODE integrator
- what arithmetic operations are used in `evolver`?
  1. `stormer-2`: `+,*,/,expt,` and what is used in `F`.
  2. `stepper`: `+`
  3. `make-initial-history`: `-,*`.
### 3.1.5
Problems with combinators:
1. > add-arithmetics prioritized its arguments, such that their order can matter
  See `constant-union` from `add-arithmetics`
1. > means that it's impossible to augment the codomain arithmetic after the function arithmetic has been constructed.
  implied in `(arithmetic-domain-predicate codomain-arithmetic)` in `function-extender` by `extend-arithmetic` which calls `add-arithmetics`.
1. > we might wish to define an arithmetic for functions that return functions.
  IMHO `pure-function-extender` has done this by `(lambda args (apply-operation ...))`.
  - The key problem may be "self reference" implying nested recursion.
1. TODO
  > One problem is that *the shapes of the parts* must be worked out ahead of time
1. > Other problems with combinators are that the behavior of any part of a combinator system must be independent of its context.
  IMHO this is due to that they don't need global variables.
  This is also shown in `add-arithmetics`.
## 3.2
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
# TODO
- > We will examine a very nice example of this optimization in chapter 7.
## SDF code base
- `define-load-spec` seems to be [only one instruction](https://groups.csail.mit.edu/mac/users/gjs/6.945/psets/ps02/ps.pdf) but does nothing.
  >  The instructions for which files to load
### not in MIT_Scheme_Reference, saved-total-index and the book
- `#!default`
- `bundle?`
### skipped due to small relations with where it is referred to.
- ~~`package-installer`~~
- temporarily
  - ~~`arithmetic->package`~~
  - ~~`combined-arithmetic`~~
  - ~~`get-constant` in `make-arithmetic`~~
### after reading related chapters
- generic-procedure
  - `equal*?`
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
# [project](https://github.com/bmitc/mit-6.945-project) (it only has https://github.com/bmitc/the-little-schemer but not solutions for SDF exercises)
- Also see https://ocw.mit.edu/courses/6-945-adventures-in-advanced-symbolic-programming-spring-2009/pages/projects/
  - kw: free software
  - See Suggestions for Projects
  - TODO
    interchangeable parts, proposal.

---

[R7RS]:https://standards.scheme.org/unofficial/errata-corrected-r7rs.pdf
[MIT_Scheme_Reference]:https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref.pdf