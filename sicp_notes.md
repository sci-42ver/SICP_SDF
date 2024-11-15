# Notice
- I am using Ryzen 4800H which is related the test result in this repo.
- I won't dig into all *complexity computation* in this book since this is *not the target* of learning this book although I will do that sometimes.
- My edits to *schemewiki* is shown with nickname LisScheSic
```
----
<<<LisScheSic
Review history comments:
LisScheSic's review the top solution based on LisScheSic's implementation.

My implementation shares the same basic ideas with x3v's. This is better than the  solution at the top location since it will throw error earlier.

review woofy's comment and the comment sequence after Shade's comment

review the top 3 comment seq's.
>>>
Review of the solution at the top:
review history comments.
Review one history comment
Review the top comment and the 2 tests. Give one sample implementation.
remove one wrong comment contents and add one notice
review the top 2 comment seqs.
add one description based on the reference from the book 
```
  - IMHO wiki always have many redundant comments for some easy exercises
    like 2.1, etc.
  - [When to use quote in plural](https://english.stackexchange.com/a/36048)
    > The marking as plural of written items that are *not words established in English orthography*
- Although 6.001 lect06 recommends the comment doc, I don't have time to write that for each function. I will do that when working for one company.
- I may probably skip some obscure words like "the plethora of declarable data structures" since it doesn't influence understanding programming.
- https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/errata.html seems to be already contained in sicp.pdf by "Page 112, line 2 of exercise 2.30" is already contained.
## whether it is needed to read *course lecs/notes* after reading the SICP book and doing its exercises
### lacked by the book but included in 6.001 lec
- lec11
  - Stack example
# Scheme func notices
- `atan`
  > the value returned will be the one in the range minus pi (exclusive) to pi (inclusive).
- comparison of `eq?,eqv?` etc: see ~/SICP_SDF/lecs/6.001_fall_2007_recitation/r08.pdf.
- `(read)` returns one symbol.
- [`fluid-let`](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Dynamic-Binding.html#index-fluid_002dlet)
  > but fluid-let *temporarily rebinds* existing variables
# Some abbr's used by CS 61A and MIT 6.001
- abstract data type -> ADT
# What we should achieve
- > ey should know *what not to read*, and what they need not understand at any moment.
- > different approaches to dealing with time in *computational models*: objects with state, concurrent programming, functional programming, lazy evaluation, and nondeterministic programming.
- > including *static scoping for variable binding* and permiing functions to yield functions as values.
- > e simple structure and natural applicability of lists are reflected in functions that are amazingly *nonidiosyncratic*
## skip
- Due to that they are related with Pascal
  > In Pascal the plethora of declarable data structures in-duces a specialization within functions that inhibits and penalizes ca-sual cooperation.
  > To illustrate this difference, compare the treatment of material and exercises within this book with that in any first-course text using Pascal.
# reading order recommendation with other books
- better read *pure* "Computer Architecture" (So not csapp) before SICP if having learnt other programming languages like C.
  Also read maths before SICP although not needed to be as deep as mcs.pdf.
  - maths will help understand something like 
    1. Figure 1.5
  - It may be better to have learnt *abstract algebra* since exercise 2.38 needs it.
# @%book reading order
(@ means we need to check this regularly. @% means that check is about SICP book instead of CS61A notes. @%% means that check need to be done more frequently.)
- The reading order:
  book with footnotes -> em -> exercise -> check "to reread after reading later chapters" and update this section in this doc *after reading each section*. -> check whether *underlined* words in the *chapter and section prefaces* have been understood.

  After reading the book, check "What we should achieve".
## @%Recheck 
- ~~https://stackoverflow.com/a/78626541/21294350 https://stackoverflow.com/questions/78597962/1-01e-100-1-in-mit-scheme/78626541#comment138620089_78597962~~
  ~~> "*streams* of decimal digits"~~ (finished)
- https://stackoverflow.com/questions/78762534/how-to-make-set-change-the-variable-in-let-scheme/78762839#comment138867441_78762839
  > "lexical *environment*", "*garbage* collected"
  - ~~> "lexical *environment*"~~
    Here `cont` is just one local variable.
    See [`(define W1 (make-withdraw 100)) (define W2 (make-withdraw 100)) ...`](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-20.html)
  - "*garbage* collected"
- section 3.1
  - TODO
    - ~~Also see~~
      > In Lisp, we consider this “identity” to be the quality that is tested by eq?, i.e., by equality of pointers.
      ~~IMHO “identity” just means not decomposable.~~
      - ~~> we are “solving the problem” of defining the identity of objects by stipulating that a data object “itself ” is the information *stored in some particular set of memory locations* in the computer.~~
        is same as CS61A notes
        > so that mutating one also changes the other
        and 6.001 lec11
        > Yes, if we retain the *same pointer* to the object
        - ~~So~~
          > A bank account is still “the same” bank account even if we change the balance by making a withdrawal; con-versely, we could have two different bank accounts with the same state information.
          means the former one is same as itself, but the latter are 2 objects just with the same contents in *different locations*.
          - ~~TODO ~~
            but how to interpret 
            > We do not, for example, ordinarily regard a rational number as a change-able object with identity, such that we could change the numerator and still have “the same” rational number.
            then?
## @%%check *underlined* words in the *chapter and section prefaces*
Different from SDF, here the preface doesn't give one systematic introduction of each chapter.
- up to section 4.3 included and chapter 3.
### TODO
- chapter 3
  - > a more mechanistic but less theoretically tractable environment model of computation
    "substitution model" seems to be "more mechanistic but less theoretically tractable"...
## @%%*em* tracking when reading the book (Read *before doing the related exercises*)
- up to section 4.3 (included).
## @%%to reread after reading later chapters (strikethrough to mark already read)
tracked up to section 2.5 (included) by searching "chapter", "section" and "*exercise*" (*the 3rd*  began from chapter 3 since in the former chapters I will just do the exercises when they are referred to. But that may probably lack some background knowledge when doing exercises a bit earlier).
### ~~1.2~~
- ~~> You may wonder why anyone would care about raising numbers to the 1000th power. See Section 1.2.6.~~
### ~~1.3~~
- ~~chapter 1 footnote 12~~
  > to create procedures without naming them, and to give names to procedures that have already been created. We will see how to do this in Section 1.3.2.
  ~~footnote 21~~
  > In Section 1.3.4 we will see how to implement Newton’s method in general
- ~~> Notice that we have used *block structure (Section 1.1.8) to embed* the definitions of pi-next and pi-term within pi-sum, since these procedures are unlikely to be useful for any other purpose. We will see how to *get rid of them altogether* in Section 1.3.2.~~
### 2
- ~~> In Chapter 2, when we investigate how to implement rational-number arithmetic, we will need to be able to compute s in order to reduce rational numbers to lowest terms.~~
- ~~chapter 1 footnote 23.~~
  ~~> We will learn how to implement arithmetic on rational numbers in Section 2.1.1~~
- ~~> We will return to these ideas in *Section 2.2.3* when we show how to use sequences as interfaces for *combining filters and accumulators* to build even more powerful abstrac-tions.~~
- ~~> We’ll see examples of this aer we introduce data structures in Chapter 2.~~
  i.e. func in data structures
  See
  > Section 2.1.3 also showed how pairs could be implemented as *procedures*. Painters are our second example of a procedural representation for data.
- ~~> In *Section 2.2* we will see how this ability to combine pairs means that pairs can be used as general-purpose building blocks to create all sorts of complex data structures.~~
  e.g. list and then tree.
- ~~> *Section 2.2.3* expands on this use of sequences as a framework for organizing programs~~
  i.e. transform sequences to sequences.
- ~~> ese are simple examples of generic procedures (procedures that can handle more than one kind of data), which we will have much more to say about in Section 2.4 and Section 2.5.~~
- ~~> In Section 2.5 we will show how to use *type tags and data-directed style* to develop a generic arithmetic package.~~
  > In Section 2.5.3, we’ll show how to use generic arithmetic in a system that performs *symbolic algebra*.
- ~~> Nevertheless, it provides a *clear illustration* of the design of a system using generic operations and a good *introduction* to the *more substantial systems* to be developed later in this chapter.~~
- ~~> Section 2.4.2 will show how both representations can be made to coexist in a single system through the use of type tags and generic operations.~~
- ~~> although it does lead to coercion problems, as discussed below~~
  See exercise 2.92.
- ~~> We’ve also already mentioned *(Section 2.2.3) that this is the natural way* to think about signal-processing systems.~~
  compare Figure 2.7 with Figure 3.32 where we all let input go through a sequence of operations to get the final output.
### 3
checked up to section 3.5.5 (included) and exercise checking up to 3.5.5 (included)
- ~~Check how this chapter explains "Modularity".~~
  - In a summary, "Modularity" ->
    1. implemented by 
      objects with local state, e.g. "local procedure"
      or
      stream
    2. limited information
    4. less "timing constraints".
    5. "specific function" for each "specific purpose" but can be still be "general".
    - also see "sequences".
    - from section 2.2
      > The value of expressing programs as sequence operations is that this helps us make program designs that are modular, that is, designs that are constructed by *combining relatively independent pieces*.
  - > For such a model to be modular, it should be *decomposed into computational objects*
  - > One can make a system more modular and robust by protecting parts of the system from each other; that is, by providing *information access only* to those parts of the system that have a ``*need* to know.''
    > The key modularity issue was that we wished to *hide the internal state* of a random-number generator *from programs that used* random numbers.
  - > The environment model thus explains the two key properties that make *local procedure definitions* a useful technique for modularizing programs:
    >> The names of the local procedures do *not interfere* with names *external* to the enclosing procedure
    >> The local procedures can *access the arguments of the enclosing procedure*, simply by using parameter names as free variables.
  - > as if they were to be executed concurrently forces the programmer to *avoid inessential timing constraints* and thus makes programs more modular.
  - > On the other hand, the stream framework raises difficulties of its own, and the question of *which* modeling technique leads to more modular and more easily maintained systems *remains open*.
  - > sequences can serve as standard interfaces for *combining program modules*
  - > The program he wrote is not modular, because it intermixes the operation of smoothing with the zero-crossing extraction.
    so one specific purpose -> one specific function leading to "modular".
  - > There is considerable modularity in this approach, because we still can formulate a *general* monte-carlo procedure that can deal with *arbitrary* experiments.
  - > e functional model does not modularize along object boundaries
    i.e. stream, see
    > The stream approach can be illuminating because it allows us to build systems with *different module boundaries* than systems organized around assignment to state variables.
- ~~chapter 1~~ 
  - ~~footnote 9~~
    > Chapter 3 will show that this notion of environment is crucial
  - ~~16(also with *Chapter 4*)~~
    > On the other hand, *normal-order evaluation* can be an extremely valuable tool, and we will investigate some of its implications in Chapter 3 and Chapter 4
    see stream -> "Normal-order evaluation", which becomes natural when "Normal-order evaluation".
    > In Chapter 3 we will introduce stream processing, which is a way of handling *appar-ently “infinite” data structures* by incorporating a *limited form* of normal-order evalu-ation.
  - ~~27~~
    > that is, they are looked up in *the environment in which the procedure was defined*. We will see how this works in detail in chapter 3 when we study environments and the detailed behavior of the interpreter.
    i.e. "the *environment part* of the procedure object being applied" / "a pointer to the environment in which the procedure was *created*" in section 3.2.
    - > detailed behavior of the interpreter
      see `(procedure-environment procedure)` in `(apply procedure arguments)`.
  - ~~31~~
    > who explained it in terms of the *“message-passing” model* of computation that we shall discuss in Chapter 3.
- ~~> As we shall see in Chapter 3, the general notion of the environment as *providing a context* in which evaluation takes place will play an important role in our understanding of program execution.~~
- ~~> In practice, the “substi-tution” is accomplished by using a *local environment for the for-mal parameters*. We will discuss this more fully in Chapter 3 and *Chapter 4* when we examine the implementation of an interpreter in detail.~~
  IMHO Chapter 3 is enough.
- ~~> In particular, when we address in Chapter 3 the use of procedures with “mutable data,” we will see that the substitution model breaks down and *must be replaced by a more complicated model* of procedure application.~~
- ~~> We’ll see how to use this as the basis for some fancy numerical tricks in Section 3.5.3.~~
  i.e. Euler acceleration and "recursively accelerate".
- ~~> This style of programming is often called message passing, we will be using it as a basic tool in chapter 3 when we address the issues of modeling and simulation~~
  See "Exercise 3.11" and `(make-wire)`.
- ~~> Additionally, when we uniformly represent structures as sequences, we have localized the data-structure *dependencies in our programs to a small number of sequence operations*.~~
  i.e. based on functional programming, we can only use these "a small number of sequence operations" to get one new "sequence", this is "data-structure dependencies".
  > By *changing these*, we can experiment with *alternative representations of sequences*, while leaving the overall design of our programs intact. We will exploit this capability in Section 3.5, when we generalize the sequence-processing paradigm to admit *infi-nite* sequences.
  i.e. `map` -> `stream-map` etc.
- ~~> include many computations that are commonly expressed using *nested loops*.[18] ... find all ordered pairs of distinct positive integers i and j, where *1 ≤ j < i ≤ n, such that i + j is prime*~~
  > Section 3.5.3, we’ll see how this approach generalizes to infinite sequences.
  see "Infinite streams of pairs".
- ~~> Section 3.3.4 describes one such language.~~
- ~~> Such a definition skirts a deep issue that we are not yet ready to address: the meaning of “sameness” in a programming language. We will return to this in Chapter 3 (Section 3.1.3).~~
- ~~> In Chapter 3 (Section 3.3.3) we will see how to implement these and other operations for manipulating tables.~~
- ~~> In Chapter 3 we will return to message passing, and we will see that it can be a powerful tool for structuring simulation programs.~~
- ~~> or that change data structures, as we will see in Section 3.3~~
  IMHO See ~~Figure 3.22, Figure 3.23 ~~ Exercise 3.25 where the tree depth will be changed, so "data structures" are "change"d.
- ~~> substitution is no longer an adequate model of procedure application. (We will see why this is so in Section 3.1.3.)~~
- ~~> develop a new model of *procedure ap-plication*. In Section 3.2 we will introduce such a model, together with an explanation of set! and local variables.~~
  See Figure 3.7~9 where 7 creates "local variables" and 8~9 do `set!`.
- ~~> since formal parameters are already local. is will be clearer aer the discussion of the environment model of evaluation in Section 3.2. (See also *Exercise 3.10*.)~~
  Exercise 3.10 has `initial-amount`, `balance` and `amount` "formal parameters".
- ~~> Now a variable somehow refers to a *place where a value can be stored*, and the value stored at this place can change. In Section 3.2 we will see how environments play this role of “place” in our computational model.~~
  i.e. frame -> bindings.
- ~~> e complexity of imperative programs becomes even worse if we consider applications in which several processes execute concurrently. We will return to this in Section 3.4~~
- ~~> In Section 3.3 we will see much more complex examples, such as “distinct” compound data structures that share parts~~
  IMHO see the codes after Figure 3.16 where `(car z1)` and `(cdr z1)` "share parts".
- ~~> (For example, see Ex-ercise 3.30.)~~
- ~~> See Exercise 3.31.~~
- ~~> We will explore applications of streams to signal processing in Section 3.5.3.~~
- ~~> Physicists sometimes adopt this view by introducing the *“world lines”* of particles as a device for reasoning about motion. ... We will discuss this point further at the end of Section 3.5.4.~~
- ~~> we end up forcing the *same delayed object many times*. is can lead to serious inefficiency in recursive programs involving streams. (See Exercise 3.57.)~~
- ~~section 3.5.3~~
  - > Streams with delayed evaluation can be a powerful modeling tool, pro-viding many of the benefits of local state and assignment. 
    I don't find "assign" later in section 3.5.3. So IMHO "Streams as signals" implies their similarity.
  - > Moreover, they avoid some of the theoretical tangles that accompany the intro-duction of assignment into a programming language.
    see
    > But the stream formulation is particularly elegant and *convenient* because the *entire sequence of states is available* to us as a data structure that can be *manipulated with a uniform set of operations*.
### 4
checked up to section 4.3 (included) and exercise checking up to 4.3 (included)
- > On the other hand, *normal-order evaluation* can be an extremely valuable tool, and we will investigate some of its implications in Chapter 3 and Chapter 4
- ~~> In Section 4.2 we will modify the Scheme interpreter to *produce a normal-order variant* of Scheme.~~
- > nondeterministic evaluation in Chapter 4.
- > for their contributions to the exposition of nondeterministic evaluation in Chapter 4.
- chapter 1 footnote 20
  > e idea is to make interpreters sophisticated enough so that, *given “what is” knowledge specified by the programmer, they can generate “how to”* knowledge auto-matically. is cannot be done in general, but there are important areas where progress has been made. We shall revisit this idea in Chapter 4.
  see 4.3.
- ~~> is can serve as a framework for ex-perimenting with evaluation rules, as we shall do later in this chapter.~~
  see section 4.2
- ~~> It makes perfect sense, for instance, to *compute the length of a list without knowing the values* of the individual elements in the list. We will exploit this idea in section 4.2.3 to implement the streams of chapter 3 as lists formed of non-strict cons pairs.~~
  based on
  ```scheme
  ; https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-15.html#%_sec_2.2
  (define (length items)
    (if (null? items)
        0
        (+ 1 (length (cdr items)))))
  ```
  If `(cdr items)` is `(cons ...)` (one procedure in lazy evaluator, so "without knowing the values ..."), then keep cdr.
  Or `'()-thunk`, so 0.
  ~~As [lazy_cdr] implies, all the actual values are encapsulated in thunk without evaluating (i.e. only `(actual-value (cdr ...))` can get the val).~~
- ~~> The successful evaluation of the try expression discussed in section 4.2.1~~
  It obviously needs `force-it` later for `(= a 0)`.
- ~~> Sometimes we can use internal definitions to get *the same effect as with let*.~~
  ```scheme
  (let ((x 3)
    (y (+ x 2)))
    ...)
  ```
  won't since `(y (+ x 2))` must be 5 for `define` but may throw error for `let`.
  - > We prefer, however, to use let in situations like this and to use *internal define only for internal procedures*
    - > Understanding internal definitions well enough to be sure a program means *what we intend it to mean* requires a more elaborate model of the evaluation process than we have presented in this chapter.
      i.e. env model
      > More generally, in block structure, the scope of a local name is the *entire procedure body* in which the define is evaluated.
      but for `define`
      > the body of f *starting at the point where the define* for odd? occurs.
    - > e subtleties *do not arise with internal definitions of procedures*, however. We will return to this issue in section 4.1.6, after we learn more about evaluation.
      Since the lambda val can always be evaluated.
      > Hence, odd? will have been defined by the time even? is executed.
      So *later defined* `odd?` proc can be used by `even?` before. But for values that is impossible for applicative order (~~see Exercise 4.19 which doesn't allow using external definitions to ensure "scope" above, i.e. `b` should use the latter `a`~~). All these are based on "obey these restrictions".
      - Also see [r7rs](https://standards.scheme.org/corrected-r7rs/r7rs-Z-H-7.html#TAG:__tex2page_sec_5.3.2)
        > The variables defined by internal definitions are *local to the <body>*
        > ... equivalent to ...
        - > without assigning or referring to the value of the corresponding <variable>
          i.e. `foo` defined by itself?
- ~~> *requires reserving storage for a procedure’s free variables* even while the procedure is *not executing*. In the Scheme implementation we will study in Section 4.1, these variables are stored in the procedure’s environment.~~
  i.e. ["free variables"](https://en.wikipedia.org/wiki/Free_variables_and_bound_variables#:~:text=A%20free%20variable%20is%20a,this%20or%20any%20container%20expression.) (not formal parameters and locally defined variables) in env.
- > otation is powerful because it gives us a way to build expres-sions that manipulate other expressions (as we will see when we write an interpreter in Chapter 4)
- >  us, we would type (quote a) instead of 'a, and we would type (quote (a b c)) instead of '(a b c). is is precisely how the interpreter works. e quotation mark is *just a single-character abbreviation* for wrapping the next complete expression with quote to form (quote ⟨ expression ⟩). is is important because it maintains the principle that any expression seen by the interpreter can be manipulated as a data object.
  see 4.1 where (read) will transform `'` to `quote` automatically.
  "data object": list where almost all data in Scheme is *connected* by *just* `cons`.
- > For the interpreter we implement in Chapter 4, the code is in fact shared
- > In Chapter 4 we shall see how this model can serve as a blueprint for implementing a working interpreter
- > For the interpreter we implement in Chapter 4, the code is in fact shared.
- ~~> at is, they are described not by single-valued functions, but by functions whose results are sets of possible values. In Section 4.3 we will study a language for expressing nondeterministic computations.~~
  Better see Exercise 4.45 etc. Here it just means the sequential order is (amb)iguous.
- ~~> In Section 4.2, we’ll develop a framework that unifies lists and streams.~~
- ~~> The problem has to do with subtle differences in the ways that Scheme implementations handle internal definitions. (See section 4.1.6.)~~
  Also see the above "section 4.1.6" quotes. They are all about the scope of `define`.
  For here, i.e. whether `(delay dy)` can use the latter `(define dy ...)`.
  If not, that means
  > extending the environment frame one definition at a time
  the frame can be only based on the *already existing* ones, although MIT/GNU Scheme doesn't do that as the standard requires.
- ~~> Converting to *normal-order evaluation* provides a uniform and elegant way ... In Section 4.2, aer we have studied the eval-uator, we will see how to transform our language in just this way~~
- ~~> Observe that, for any two streams, there is in general more than one acceptable order of interleaving. ... The merge relation illustrates the same essential nondeterminism, from the functional perspective. In Section 4.3, we will look at nondeterminism from yet another point of view.~~
  See "stream_implies_functional".
  - > more than one acceptable order
    See above
  - > illustrates the same essential nondeterminism, from the functional perspective.
    means "we can see *time-related problems* creeping into functional models as well." where time-related problems mean "constraining *the order of events* and of synchronizing multiple processes".
    i.e. "functional" still has "nondeterminism" when meeting
    > In such a language, all procedures implement *well-defined mathematical functions* of their arguments, whose behavior does not change.
  - > we will look at nondeterminism from yet another point of view.
    where we have no functional since `try-again` make the original procedure maybe having one different result.
    IMHO that nondeterminism just means alternative implied by `amb`.
- ~~> This allows a user to add new types of expressions that eval can distinguish, without modifying the definition of eval itself. (See exercise 4.3.)~~
  - i.e. use one table inside. So just `put` and then `get` can automatically work.
- ~~> We will see what the problem is and how to *solve it* in section 4.1.6.~~
  ~~IMHO just change `(eval (definition-value exp) env)` to incorporate `eval-definition`.~~
  "problem" is about "simultaneous scope".
- ~~> We will support the use of the variables true and false in expressions to be evaluated by binding them in the global environment. See Section 4.1.4.~~
- ~~> He used *this framework* to demonstrate that there are well-posed problems that cannot be computed by Turing machines (see exercise 4.15)~~
  maybe here "framework" is used to "cannot be computed" -> "can be formulated as a [program](https://en.wikipedia.org/wiki/Halting_problem#Proof_concept)" failure.
- ~~> so that sequential definition isn't equivalent to simultaneous definition, see exercise 4.19.~~
- ~~> ere are also languages (see Exercise 4.31) that give programmers de-tailed control over the strictness of the procedures they define.~~
- ~~> we can build our evaluator to memoize, not to memoize, or leave this an option for programmers (exercise 4.31). As you might expect from chapter 3, these choices raise issues that become both subtle and confusing in the presence of assignments. (See exercises 4.27 and 4.29.)~~
  Same problems shown also in Exercise 3.51, 52.
- > By incorporating a search mechanism into the evaluator, we are eroding the distinction between purely declarative descriptions and imperative specifications of how to compute answers. We'll go even farther in this direction in section 4.4.
- ~~> Section 4.3.1 introduces amb and explains how it supports nondeterminism through the evaluator's automatic search mechanism. Section 4.3.2 presents examples of nondeterministic programs, and section 4.3.3 gives the details of how to implement the amb evaluator by modifying the ordinary Scheme evaluator.~~
  - > explains how it supports nondeterminism through the evaluator's automatic search mechanism
    search "search".
  - 
- > Similar ideas, arising from logic and theorem proving, led to the genesis in Edinburgh and Marseille of the elegant language Prolog (which we will discuss in section 4.4).
- ~~> Alyssa's technique ``falls into'' one of these recursions and gets stuck. See exercise 4.50 for a way to deal with this.~~
### 5
- > culminat-ing with a complete implementation of an interpreter and com-piler in Chapter 5
- > When we discuss the implementation of procedures on register machines in Chap-ter 5
- > e imple- mentation of Scheme we shall consider in Chapter 5 does not share this defect.
- > We will discuss tail recursion when we deal with the control structure of the interpreter in Section 5.4.
- > we will not dwell on how these *returned values are passed from call to call*; however, this is also an important aspect of the evaluation process, and we will return to it in detail in Chapter 5.
- > We will see in Section 5.3.2 that Lisp memory-management systems include a garbage collector
- > get-new-pair is one of the operations that must be implemented as part of the memory management required by a Lisp implementation. We will discuss this in Sec-tion 5.3.1.
- > how these returned values are passed from call to call; however, this is also an important aspect of the evaluation process, and we will return to it in detail in Chapter 5.
- > We will address these issues in chapter 5, where we take a closer look at the evaluation process by implementing the evaluator as a simple register machine.
- > They are introduced as mnemonic names for the basic list operations in order to make it easier to understand the explicit-control evaluator in section 5.4.
- > One way to avoid this inefficiency is to make use of a strategy called lexical addressing, which will be discussed in section 5.5.6.
- > However, we will see in section 5.5.6 that moving to a model of simultaneous scoping for internal definitions avoids some nasty difficulties that would otherwise arise in implementing a compiler.
- > This technique is an integral part of the compilation process, which we shall discuss in chapter 5.
- > As we will show in section 5.5.6, one can determine the position in the environment structure where the value of the variable will be found
- > allows this structure to be garbage-collected and its space recycled, as we will discuss in section 5.3.
# miscs
## blogspot comments left
- https://billthelizard.blogspot.com/2010/02/sicp-exercise-126-explicit.html?showComment=1719034722891#c6043924970819337247
# projects recommended by [course_note] to be done.
> Examples include an event-driven object-oriented simulation game, a conversational program that uses rules and pattern matching, symbolic algebra of polynomials and rational functions, interpreters for various languages, and a compiler with register optimization.
I skipped [Problem Sets](https://github.com/abrantesasf/sicp-abrantes-study-guide?tab=readme-ov-file), Exam, homework and Quizzes because IMHO those numerous exercises in the book is enough and most of courses pay more attention for projects when grading. Also 
- see [this](https://github.com/junqi-xie-learning/SICP-Projects?tab=readme-ov-file) (Here [one fork](https://github.com/junqi-xie-learning/SICP-Projects/forks) may be itself)
- I will only does 6.5151 ps and projects skipping
  1. [sample projects](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/psets/index.html)
  2. 6.037 IAP
  3. 6.001 fall 2007
- TODO add the corresponding solutions for ~~the new [IAP](https://elo.mit.edu/iap/) [course 6.037](https://web.mit.edu/6.001/6.037/)~~ the 
# ~~6.001,037~~ courses (6.9550 Structure and Interpretation of Computer Programs newer without one website) (better read [6.945](http://computationalculture.net/a-matter-of-interpretation-a-review-of-structure-and-interpretation-of-computer-programs-javascript-edition/) whose [project uses sicp as the reference][AI_preq_sicp])
[6.001 fall 2007](https://web.archive.org/web/20160306110531/http://sicp.csail.mit.edu/Fall-2007/) which seems to be the last 6.001 course based on sicp as [this][mit_End_of_an_Era_comment] and 6.037 reference imply. (But 6.037 uses 6.001 spring 2007 ~~which~~ ~~may be preferable~~ because fall 2007 lecture notes aren't public)
## 6.001 spring 2007
- ~~From Lect 10 (excluded),~~ ~~I won't read lecs and recs in this course if it is *just rephrasing* of the book contents although it actually doesn't take much time to read these (at most one day each for lec and rec). ~~ ~~I will read lec by viewing its structure without detailed reading since it  probably is the duplicate of the book contents.~~
  lec: This is because from the former reading experience it is just duplicate without anything new except "Lecture 6 *Programming methodology*" which doesn't have the corresponding section with the same name. And it is enough to read CS 61A notes which has *something new* based on the book.
  rec: these are always *easier* than book exercises.
Also see [this TA's site][6_001_sp_2007_rec] besides sicp.csail.mit.edu.
- > You can use the lecture based "text book" by going to the tutor
  I can't access tutor since I am not one MIT student.
- TODO see Some minor "bugs" in Project 4 (where?)
- trivially I can't use [6.001 Lab – 34-501](https://groups.csail.mit.edu/mac/classes/6.001/FT98/lab-use.html), [outer door combination 94210, inner door combination 04862*](https://people.csail.mit.edu/dalleyg/6.001/SP2007/solutions01.pdf)
### lecture
- lecture corresponding chapter see 6.037 description.
- > These online lectures will generally cover the same material, but are *NOT guaranteed to be identical to the material covered in the live* lectures, and in some cases there may *not be a corresponding online version of the live* lecture.
- As [this](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/syllabus.html) shows, both book and lectures have contents that the other doesn't have. So we need to read them all.
### [comparison](https://stackoverflow.com/a/10251655/21294350) between MIT Scheme and DrScheme
### [recitation](https://people.csail.mit.edu/dalleyg/6.001/SP2007/) (not include the 1st recitation by Eric Grimson)
## [6.001 fall 2007](https://web.archive.org/web/20160306110531/http://sicp.csail.mit.edu/Fall-2007/)
### The following are mainly from https://web.archive.org/web/20160415073756/http://sicp.csail.mit.edu/Fall-2007/generalinfo_ft07.htm where "(*)" means it needs to be done.
https://web.archive.org/web/20070501000000*/http://sicp.csail.mit.edu/SchemeImplementations/index.html is not archived.
https://web.archive.org/web/20160629180214/http://sicp.csail.mit.edu/Fall-2007/SchemeImplementations/ is skipped since I don't use DrScheme.
#### lecture (*)
- where is link in [calendar](https://web.archive.org/web/20080908062550/http://sicp.csail.mit.edu/Fall-2007/calendar.txt)?
- partial lecture is [not archived](https://web.archive.org/web/20080908062839/http://sicp.csail.mit.edu/Fall-2007/lectures/)
- [This](https://github.com/abrantesasf/sicp-abrantes-study-guide?tab=readme-ov-file) only has [2005 "lecture notes"](https://ocw.mit.edu/courses/6-001-structure-and-interpretation-of-computer-programs-spring-2005/pages/lecture-notes/), [96~98 notes](https://groups.csail.mit.edu/mac/classes/6.001/).
It seems to only have video lectures
> we have engaged in a major educational experiment in which the lectures were replaced with online lectures, to which students were *expected to listen*, either in the 6.001 lab, or on their own computer. ... but that material will *not be identical to the live* lectures.
#### recitations (*)
~~I~~ ~~don't have time to find that difference and also the lecture is old.~~ ~~will only do the~~ [recitations](https://people.csail.mit.edu/jastr/6001/fall07/) which is based on the video lecture.
Better read this if possible because this course is [taught by Gerald Jay Sussman](https://web.archive.org/web/20160415061035/http://sicp.csail.mit.edu/Fall-2007/staff.txt).
> Lectures are the primary vehicle for introducing and motivating new material, some of which is *not in the book*. It is essential that you *listen to the lectures* (whether live – which we prefer – or online), as the *recitations will assume you have already heard the material*, and will *build upon it*. ... Recitations *expand* upon the material currently being introduced in lecture, as well as introducing supplementary material that is *not directly covered in lecture*. ... your attendance at recitation is *essential to good performance* in this class.

I can't find those recitations corresponding to "Out of Town" by '6.001 Fall 2007 Recitation "Local State"'.
#### problem set
I can't find by "6.001 fall 2007 Problem set site:mit.edu" which may be implied by
> Problem sets are released, typically on a weekly basis, onto the 6.001 *online tutor* system
#### tutorial
*skipped* due to
> to obtain *individual help*, to *review homework* assignments, and to have your *progress in the subject* checked
#### Assignments (i.e. [project](https://web.archive.org/web/20160415060551/http://sicp.csail.mit.edu/Fall-2007/projects/index.html)/~~Problem set~~)
> *failing to prepare ahead* for programming assignments generally ensures that the assignments will *take much longer* than necessary
#### collaboration (this is similar to one description I read before)
> For example, your partner has a bug on one part, and you are able to point out where the bug is and how to fix it.
inappropriate
> this is inappropriate collaboration because you were *not both involved in all aspects* of the work
#### Workload
> In addition, please be aware that prolonged computer usage combined with *poor posture or improper typing habits* can result in conditions such as *repetitive strain injury*.
#### bible (See the bold text)
#### grades
- homework
  > This applies to the weekly problem sets and to the *programming projects*.
  tutorials (skipped due to the following)
  > You may be asked to explain or to *expand upon your written homework solutions* in order to demonstrate your mastery of the material.
#### tutor
They are for tutorial's.
> If you are unable to attend a tutorial, you should contact your tutor in advance to make alternate arrangements for that week.

To join this it seems that we *must be one mit student* and [request a form (this is from the chemistry department)](https://chemistry.mit.edu/academic-programs/undergraduate-programs/tutoring/). This is also implied in spring 2007 6.001 lec01 p2.
### Complete Announcements
- not archived
  > GROWL! For those of you who did not show up in lecture on Tuesday, 2 October 2007, the essential handout you missed is here.
  > Code for the lecture given on Tuesday, 2 October 2007, has been placed here
  > GROWL! For those of you who did not show up in lecture on Tuesday, 6 November 2007, the essential handout you missed is here.
## 6.037 (notice [IAP may be not reliable](https://www.wisdomandwonder.com/link/2110/why-mit-switched-from-scheme-to-python#comment-365) and the instructor website [seems to not exist](https://web.archive.org/web/20120121084033/http://web.mit.edu/alexmv) different from [Gerald Jay Sussman](https://groups.csail.mit.edu/mac/users/gjs/gjs.html))
TODO who is the instructor Mike Phillips, is [him](https://en.wikipedia.org/wiki/Mike_Phillips_(speech_recognition))?
- See R5RS although sicp books uses R4RS as the reference.
  The newest is [R7RS](https://standards.scheme.org/official/r7rs.pdf) from [this](https://standards.scheme.org/) although racket seems to [not support](https://web.archive.org/web/20231208093804/http://community.schemewiki.org/?scheme-faq-standards#implementations) and has [one unofficial implementation](https://github.com/lexi-lambda/racket-r7rs)
  - R7RS [official](https://r7rs.org/) [errata](https://github.com/johnwcowan/r7rs-work/blob/master/R7RSSmallErrata.md) / [this](https://small.r7rs.org/wiki/R7RSSmallErrata/)
  - IEEE is [old](https://standards.scheme.org/formal/) also [see](https://conservatory.scheme.org/schemers/Documents/Standards/)
    > In colloquial use, “Scheme standard” usually refers to the latter.
  - scheme [doc](https://docs.scheme.org/) 
    - [cookbook](https://cookbook.scheme.org/)
    - [man](https://man.scheme.org/)
  - If using Racket, then [R5RS may be better](https://stackoverflow.com/a/3358638)
### **what to do**
- From 
  > 6 units of P/D/F credit are available; *only the projects* are graded.
  only "projects" need to be done after reading the lectures.
  But as the above says, I will skip that.
  So I will only read lectures and recitations which are not contained in its reference course 6.001 SP/Fall 2007.
### comparison
- > which Spring 2007 6.001 lectures we've drawn the material from, in case you *want to delve deeper, get a second opinion*, read ahead, etc.
  > we are mostly *tracking the 6.001 lectures*
  > Since this course is a *heavily condensed* version of 6.001
- newer 6.037 uses Racket but [6.001 uses DrScheme](https://web.archive.org/web/20161201164940/http://sicp.csail.mit.edu/Spring-2007/dont_panic_ft06.html#SEC1). [See](https://stackoverflow.com/questions/13003850/little-schemer-and-racket)
### [DON'T PANIC](https://web.archive.org/web/20161201164940/http://sicp.csail.mit.edu/Spring-2007/dont_panic_ft06.html#SEC6)
- > the basic things that occur when you use the computer to write and evaluate code written in Scheme.
  - Flow of Control (trivial without saying much about more basic things like assembly)
    window manager -> the application (DrScheme window: one text editor 1. with "definitions window" and "interaction window" 2. can "Save Interactions as Text" 3. clicking on the Run tab similar to *python*) -> 
    > each subprogram is typically a definition
- Skip "Editing Your Code"
- TODO
  > Did I remember to evaluate all the changes that I made?
  > It's a good idea to *comment the transcript* after each problem, while the details are still in your mind.
  > How Can I Reach a *"Steady State?"*
  Debugger
- Debugging
  - > Only experience can help you become a master debugger. However, good discipline in trying to debug code can be very valuable experience.
    > Another handy tool provided by DrScheme is a syntax checker.
  - This should *not be used arbitrarily* because that will cause mess by my history experience.
    > If the debugger doesn't give you the needed information, sometimes it is useful to put a *display* or display expression into your code to gather information.
  - > It is often *easier to avoid bugs* than to find them so use a *clear* design *instead of clever or tricky* code
# course besides 6.001,037 in mit
- teachyourselfcs recommends [cs61a 2011](https://teachyourselfcs.com/#programming) which is [the last course](https://www.reddit.com/r/berkeley/comments/hl9rxt/comment/fwxonlz/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) to teach with scheme (See [this](https://github.com/theurere/berkeley_cs61a_spring-2011_archive/tree/master) for all resources [unavailable directly](https://web.archive.org/web/20110306121705/http://wla.berkeley.edu/~cs61a/sp11/lectures/) from university)
  See also [CS61AS](https://www.reddit.com/r/berkeley/comments/hl9rxt/comment/fwxpxo4/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) [mainly based on labs](https://www.reddit.com/r/berkeley/comments/38my8j/comment/cry702u/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) which is also said in its page
  - [comparison said by Brian Harvey](https://web.archive.org/web/20160304013558/https://www.cs.berkeley.edu/~bh/61a.html) from [this](https://www.reddit.com/r/berkeley/comments/38my8j/differences_between_cs_61a_and_cs_61as/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
    > Nevertheless, I *prefer* my own proposal for how to preserve 61A after my retirement: a self-paced version, CS 61AS, using SICP.
    > But also, I wish *I'd invented the self-paced structure* of the course years ago, before the issue of changing 61A came up. We've always had a pretty *high 61A dropout rate* because students can't keep up. It turns out, from our 61AS experience, that many of those students are perfectly capable of learning the ideas *if they're given more time*
    - > If you take the extra 5th unit, it will be called CS 98. (Despite what Brian wrote, the "H61AS" course description never actually happened.)
      may [mean (crawled by google)](https://inst.eecs.berkeley.edu/~cs61as/su12/)
      > Credit for Unit 5 will be assigned through a CS 98 course
      [CS 98](https://www2.eecs.berkeley.edu/Courses/CS98/)
    - maybe "problems" mean "high 61A dropout rate"
      > There is a plan afoot to *eliminate some of these problems* by recasting 61AS as a two-semester course
    - course design
      > Their solution was giving a unit of 61A credit for Unit 0, so students could take either Units 0-3 or Units 1-4.
      So we decide
      > for a constant four units (namely, Chapters 1-4 of SICP) ... Unit 0 will be offered as a separate one-unit CS 3S.
    - TODO
      I didn't find corresponding chapter description in [schedule](https://docs.google.com/spreadsheets/d/11If2HTqhRgMOAwqs4dWVV4ceRDJlj3orRnMkYJmMBBc/edit?pref=2&pli=1#gid=0)
      > And I can't give anyone a fifth unit of 61AS, even an optional one, for Chapter 5.
    - OP [decides to choose CS61A](https://www.reddit.com/r/berkeley/comments/38my8j/comment/crzsn72/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) because
      > My concern was not that CS61A going fast but slow. If it's going fast enough, I don't think there is much need for taking 61AS.
      learn both
      > I think one option I'm considering now is to self-study SICP in summer and take CS61A in fall.
      - TODO
        DeNero doesn't teach these 2 courses.
        > Also there is DeNero factor for 61A, I know.
## 2011 [hw, project etc. solution](https://github.com/zackads/sicp/tree/main)
~~TODO ""CS61AS" lab solution github" seems to not have CS61AS solutions. I will try that.~~
[video with Transcript to help search](https://www.youtube.com/watch?v=JAFUtlTrTHA&list=PL-4wJVBe4rQVeITP7acgaX86ukMKtOS3C)
A&S means "Abelson & Sussman" book.
interestingly inst.eecs.berkeley.edu [doesn't need one account before](https://web.archive.org/web/20120120151042/https://inst.eecs.berkeley.edu/~cs61a/su11/) and can be indexed by google.
- [cs61a 2011](http://wla.berkeley.edu/~cs61a/sp11/)
  [useful](http://wla.berkeley.edu/~cs61a/reader/vol2.html)
  - Weiner Lecture Archives seems to [*only* contain videos](https://web.archive.org/web/20120104033822/http://wla.berkeley.edu/main.php?course=cs61a) without others.
  - solutions [aren *unavailable*](https://web.archive.org/web/20111001000000*/https://inst.eecs.berkeley.edu/~cs61a/sp11/solutions)
    - maybe [this](http://wla.berkeley.edu/~cs61a/su11/solutions/) from https://github.com/fgalassi/cs61a-sp11?tab=readme-ov-file
  - https://web.archive.org/web/20110306121705/http://wla.berkeley.edu/~cs61a/sp11/lectures doesn't contain subdir's.
  - Simply Scheme by "Brian Harvey and Matthew Wright" online is like [the prerequisite of sicp](https://people.eecs.berkeley.edu/~bh/ssch26/preview.html) although as mit course says it is *not necessary*.
    > The *next step* is to read Structure and Interpretation of Computer Programs
  - Discussion group is piazzza which only university students can access.
  - ~~STk seems to be one derivative of Scheme which can be ignored.~~
- [Course Reader, Volume 2](http://wla.berkeley.edu/~cs61a/reader/vol2.html)
  - [online lectures](https://web.archive.org/web/20120104011702/http://wla.berkeley.edu/main.php?course=cs61a) only have videos
- See [lecture notes](http://wla.berkeley.edu/~cs61a/reader/notes.pdf) for project schedule time and corresponding book Section.
- [readers](https://me.berkeley.edu/readers/)
- [OBSOLETE Homework, projects, lab](http://wla.berkeley.edu/~cs61a/reader/vol1.html)
- Course information (I only read bold text and the first sentence in each paragraph to get the main idea.)
  - recommends "You should try to complete the *reading assignment* for each week *before the lecture*.".
    - Although for mit OCW, it may [be not that case](https://qr.ae/psxpwo) written by one MIT student.
      > I will rarely read the textbook unless some combination of the following is true: (1) I am very confused or lack the requisite background, (2) I am specifically told to do so by the professor, (3) the textbook is *highly recommended* by people I know who *took the class* before, (4) I have *time* on my hands.
      > When I’m not taking the corresponding class in person, I take a similar approach to reading the book, but *only after I’ve watched the lectures and read through the notes*. ... I’d resort to notes from *other professors* (sometimes not from MIT) before I’ll read the book.
      for exam
      > , reading the textbook first would *help immensely*, but it’s *not as efficient* because I’ll learn a lot more about *what the professor thinks is important* by reading/watching material directly produced by him or her.
    - It [depends on the student habits](https://www.reddit.com/r/mit/comments/11d9ap0/comment/ja7d7a5/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button).
      > If a class requires readings before the lecture, it's usually *redundant* to the lecture and annoying (khm 6.031 khm)
      > I have a friend who enjoys reading textbooks at the end of the day to better understand and *digest the material from lectures*. Most of my friends and I do readings (mostly class notes *because usually there is no textbook*) while doing *psets/labs* if there are concepts we forgot/didn't understand/need a deeper understanding of for the assignment.
  - help
    > Your *first and most important* resource for help in learning the material in this course is your *fellow students* ... You are responsible for helping each other learn.
    self-study in campus
    > Instead, come see a faculty member to discuss *sponsorship of a non-class account* for independent study
  - Homework and Programming Assignments
    > The purpose of the homework is for you to learn the course, not to prove that you already know it
  - https://web.archive.org/web/20080514204601/http://www.swiss.ai.mit.edu/projects/scheme/index.html -> https://groups.csail.mit.edu/mac/projects/scheme/
    Etc. doesn't have much valuable.
    Answers to frequently asked questions (last updated in 1997). is skipped.
    Programming Language Research is skipped due to it is too detailed.
  - book
    > We have listed an optional text for the course, Simply Scheme, by Harvey and Wright. It *really is optional*! Don’t just buy it because you see it on the shelf.
  - think better than writing mere notes.
    > What this means is that you should be able to *devote your effort during lecture to thinking*, rather than to frantic scribbling.
### TODO
- Course information handout
  - > Unlike the homework and projects, the *tests* in this course (except for the parts specifically designated as group parts) must be your own, individual work
- why bh homepage has links to [Marxism](https://web.archive.org/web/20170225101107/https://www.anu.edu.au/polsci/marx/marx.html)??????
### comparison between scheme and python
- [1](https://news.ycombinator.com/item?id=9844181)
  >  You almost certainly *missed out on things* that you could very well *never see again*, or even know the existence of (at least for a very long time)
  kw: metaprogramming, macros, 
  > This is something you can't even dream of doing in most (all?) languages that *aren't dialects of LISP*.
  - [2](https://news.ycombinator.com/item?id=9843053)
    > The first 1/3 of CS61A in scheme had *no mutation*. That is almost impossible in Python to do, and is not the way the language is used in industry
    Python is to help the majority of struggling students
    > but perhaps fail to grasp some of the more complex concepts ... 80% of the material hasn't changed but you've gained the above benefits
    > If you understood the intricacies of what *was* taught in CS61A, you will find it very easy to *generalize* those concepts to *new languages* - and new concepts.
So I skip [this python lesson 6.100](https://introcomp.mit.edu/spring24/information)
### lab
recommended since the course general information shows (more detailed see 1.md)
> Laboratory exercises are short, relatively simple exercises designed to *introduce a new topic*.

[lab solutions](https://people.eecs.berkeley.edu/~bh/61a-pages/)
- Also [see](https://github.com/nirvanarsc/CS-61A/blob/master/mt1/mt1.scm) (TODO mt -> meeting?)
### update [Course Reader vol 1](https://people.eecs.berkeley.edu/~bh/61a-pages/)
### **what to learn**
- [lecture and lab](https://www.reddit.com/r/learnprogramming/comments/1daa41z/comment/l7nwqbp/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
  since we drop the others
  1. > all book exercises which cover the homework
  2. > I prefer doing the project assignments from MIT 6.5151
  3. > it is a bit overkill to do all these sample exams
  - [notes](https://people.eecs.berkeley.edu/~bh/61a-pages/Volume2/notes.pdf) (originally I accessed it from [this](http://wla.berkeley.edu/~cs61a/reader/notes.pdf) where both have the same page count) and [lab](https://people.eecs.berkeley.edu/~bh/61a-pages/Volume1/labs.pdf)
## cs61as
The latest should be CS "61AS" spring 2016 since 'CS "61AS" fall 2016' has nothing.
I only check labs without checking Homework, Quizzes and Retakes

I skipped https://cs.brown.edu/courses/cs017/content/docs/racket-style.pdf since this is not the main part to learn for SICP.
- Syllabus
  - uses Racket
  - > Lessons also link to external readings drawn from *SICP and old CS 61A lecture notes*'
  - "Units" shows the corresponding book chapters.
- Suggested Schedule & All Deadlines don't give project corresponding chapters
  So by Syllabus and textbook, maybe project x corresponds to chapter x.
- FAQ doesn't have much about what to be learnt.
- the following needs university student account
  - Discussion Worksheets and Solutions
- Webcasts fails now.
- Legacy Resources -> Lecture Notes may point to cs61a
- [Environment Diagram Drawer](https://cs61a.org/assets/pdfs/reverse-ed.pdf)
### reading
- > Lessons also link to external readings drawn from SICP and old CS 61A lecture notes. It is highly recommended that you complete *these readings before starting the lesson* material.
# How to learn
## project
- "lab exercises, computer examples" may [be important](https://academia.stackexchange.com/a/151857)
## book vs lecture
- better [not drop the textbook with only lectures left](https://www.physicsforums.com/threads/which-is-more-effective-for-learning-textbook-or-lecture-notes.467145/post-3105007) after *considering time*
  Also [see](https://www.physicsforums.com/threads/which-is-more-effective-for-learning-textbook-or-lecture-notes.467145/post-3105014)
  > The only thing I feel professors are good for is *answering questions* which are *not fully answered* in the textbook.
  - Also see [this](https://www.reddit.com/r/math/comments/13jq1b8/comment/jkgkcee/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) which means *book & exercises* is better with its following comments. (Also see [this](https://www.reddit.com/r/math/comments/13jq1b8/comment/jkgozm5/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) which recommends the book and Roneitis's comment)
- [~~This lecture~~](https://news.ycombinator.com/item?id=19887732) means live lectures
## video
- what video [actually needs to do](https://academia.stackexchange.com/a/52758)
  > The advantage of the human teacher is that I *can ask questions*, but of course a video teacher cannot answer. There are cases, of course, where a video is superior to a printed book: a video can *show action* that a book can only describe or perhaps show still photos. So if you want to learn how to *perform some physical action*, like how to play golf or replace a transmission filter or whatever, a video might be able to show you in ways that *a book could not.*
- video lectures should [not be dependent more than the book](https://qr.ae/psJ39d). 
  Also [see](https://www.reddit.com/r/learnprogramming/comments/8tn6pv/comment/e18s63p/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
  - [this](https://qr.ae/psJBAi) and [this](https://www.reddit.com/r/PhysicsStudents/comments/oll49b/comment/h5g0fel/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) says video is *only as one companion* but not the main part.
## summary
- [detailed][academia_se_tips]
  1. not drop one part artificially.
  2. better read the *lecture before* the book to get the *main idea*
  3. spend "~90% of their time working problems". (Although ~90 may be too high for actual course learning.)
- choose [the favorable method](https://mitili.mit.edu/news/compared-reading-how-much-does-video-improve-learning-outcomes) to learn
  > Likewise, those who *preferred to read and did read* scored nearly 10 percent *higher* on the post assessment than participants in the video group who would have preferred to read.
# Emacs
- [reference card](https://www.gnu.org/software/emacs/refcards/pdf/refcard.pdf)
- [brief intro to run scheme](https://languageagnostic.blogspot.com/2011/05/mit-scheme-in-emacs.html?m=1) from [this](https://www.reddit.com/r/scheme/comments/grnz6o/comment/fs248nv/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
# (misc)
## How to write emails to TA, etc
- see [comics](https://advising.yalecollege.yale.edu/how-write-email-your-instructor) or [example](https://www.purdue.edu/advisors/students/professor.php)
  - 1
    - a clear subject line
    - *Do your part in solving* what you need to solve.
    - Be aware of concerns about entitlement. (i.e. respectful)
    - *shaping* your words in light of *whom you are writing to* and why.
      > share information regarding an event the professor *might want to know* about or pass on an article from your news feed that is *relevant to the course*
  - 2
    - correct grammar and spelling
- https://qr.ae/p2IvyZ
  - > In the case you described, I would be *formal in the first e-mail*.
  - > If I plan for this relationship to be *short* and entirely professional or businesslike, I would sign *both my personal and family name* at the end of the e-mail.
- [more general](https://sparkmailapp.com/formal-email-template)
- [should I add period at the end in the brackets](https://proofed.com/writing-tips/punctuate-brackets/#:~:text=However%2C%20we%20have%20a%20few,case%20the%20period%20goes%20inside.)
  > I ate the whole cake. (And now I am full.)
## grading curve
- https://www.bestcolleges.com/blog/curved-grading/#:~:text=What%20Is%20Grading%20on%20a%20Curve%3F,A%20grades%20and%20failing%20grades.
  > they can grade on a curve. That means *modifying each student's grade* to *raise the average*.
# MIT-scheme miscs
- [exit message meaning](https://github.com/search?q=repo%3Abarak%2Fmit-scheme%20term_halt_messages&type=code) https://github.com/barak/mit-scheme/blob/56e1a12439628e4424b8c3ce2a3118449db509ab/src/microcode/term.c#L111C5-L111C30
# html book searching tips
- select by the specific emphasized text
  [XPath](https://scrapfly.io/blog/how-to-select-elements-by-text-in-xpath/) ([no corresponding CSS selector](https://stackoverflow.com/a/4561376/21294350))
  - better use `//em` instead of `em` to avoid mere text searching.
  - [CSS](https://www.freecodecamp.org/news/css-selectors-cheat-sheet/)
- following-sibling
  [XPath -> selector](https://devhints.io/xpath#using-axes)
# scheme style
- [1](https://web.archive.org/web/20240117063034/http://community.schemewiki.org/?scheme-style)
  - preface says about the indentation.
  - Rule 1: not "Don't put closing (or opening) parens on a line of their own", i.e. one line with only one paren.
    > Notice how the closing parens are all on a line of their own, *indented so to mark* where the expression will continue. Remember, it's *an exception - use this rarely*.
  - For the rest I only read their titles.
- [naming](http://community.schemewiki.org/?variable-naming-convention)
  - TODO
    *Name
  - From RnRS is same as [1.3.5 in R7RS](https://standards.scheme.org/official/r7rs.pdf)
- [comment convention](https://web.archive.org/web/20220526005605/http://community.schemewiki.org/?comment-style)
- I skipped "Scheme Tips from Dartmouth" since format is not that important but needs to be consistent when cooperation.

---

# Foreword
- [predicate calculus](https://github.com/sci-42ver/Discrete_Mathematics_and_Algorithm/blob/f515bc30a45a6a97c8a92641296a717d980441a0/Discrete_Mathematics_and_Its_Applications/mcs.md?plain=1#L764)
- > composed of . . .
  i.e. again "physical switching element ..." because MOS is one type of switching element.
- > It would be difficult to find two languages that are *the communicating coin of two more different cultures* than those gathered around these two languages.
  From [this](https://ell.stackexchange.com/a/133661), "those gathered around" (i.e. "the communicating coin" of Lisp and Pascal) may mean their shared components in Algol60.
- > e discretionary exportable functionality entrusted to the individual Lisp programmer is more than an order of magnitude greater than that to be found within Pascal enterprises
  i.e. Lisp can [generate languages](https://www.reddit.com/r/learnprogramming/comments/vluzqf/comment/idxrcoe/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
- > ese languages tend to become less primitive as one approaches the boundaries of the system where we humans interact most oen. As a result, such systems contain complex language-processing functions replicated many times
  may mean some primitives are called by multiple other funcs.
## TODO (Foreword may need some background knowledge)
- read after finishing the book
  > Lisp changes. ...
  and other green underlined words
# Preface to the First Edition (I read this first)
- > not just a way of geing a computer to perform oper-ations but rather that it is a novel formal medium for expressing ideas about methodology
  it means not ... but rather ... .
- > the foundations of computing,
  at least ["data structures and formalisms"](https://cics.unt.edu/node/41)
- > have very few ways of forming compound expressions,
  by multiplication principle, the component number is small.
- > All of the formal properties can be covered in an hour, like the rules of chess.
  This is also said in [ucb_sicp_review] (Also see Discrete_Mathematics_and_Algorithm repo).
- > Underlying our approach to this subject is our conviction that “com- puter science” is not a science and that its significance has lile to do with computers. e computer revolution is a *revolution in the way we think* and in the way we express what we think.
## TODO
- check "Our goal ..." after reading the book.
- > we can use higher-order functions to capture common paerns of usage, ...
- > the relationship of Church's lambda calculus to the structure of programming languages
  [1](https://news.ycombinator.com/item?id=40056166) [2](https://users.cs.utah.edu/~mflatt/past-courses/cs7520/public_html/s06/notes.pdf)
# Preface to the Second Edition
- http://mitpress.mit.edu/sicp is [invalid now](https://web.archive.org/web/20230916001533/http://mitpress.mit.edu/9780262510875/structure-and-interpretation-of-computer-programs/#tab-5)
- [supplementary material](https://web.archive.org/web/20000817004328/http://mitpress.mit.edu/sicp/) is contained in Instructor's Manual
  But there is [no pdf](https://www.yumpu.com/en/document/read/67770071/download-instructors-manual-t-a-structure-and-interpretation-of-computer-programs-2nd-edition-full) by '"Instructor"'s Manual t/a Structure and Interpretation of Computer Programs pdf'.
- 
# [A note on our course at MIT][course_note]
- > to separate specification from implementation
  similar to [ucb_sicp_review]
  > a diversity of major programming paradigms: data abstraction, rule-based systems, object-oriented programming, functional programming, logic programming, and constructing embedded interpreters.
  > Students are encouraged to regard themselves as *language designers and implementors* rather than only language users.
  > 6.001 differs from typical introductory computer science subjects in using Scheme (a block-structured dialect of Lisp) *rather than Pascal* as its programming vehicle.
  > they consider *top-down hierarchical design*, so often emphasized as a central theme in computer programming subjects, to be a *minor and relatively simplistic* strategy
  > introducing two different techniques for maintaining modularity: object-oriented programming with encapsulated local state; and functional programming with *delayed evaluation*.
  > is recommended for other majors where *computation pays a major role* ... taken by over 500 students each year -- *half to two-thirds* of all MIT undergraduates ... more than three-quarters have had *previous programming experience*, although hardly any at the level of sophistication of 6.001.
  > MIT students regard 6.001 as an *extremely challenging*, but highly successful subject
  > There are also regular *weekly tutorials*, where students meet in groups of three with a graduate TA to *review* homework and other course material.
- TODO
  > shifting modes of linguistic description
  > *Beyond that, there is a central concern* with the technology of implementing languages and linguistic support for programming paradigms.
  > It discusses substitution semantics, the evolution of processes, orders of growth, and the use of higher-order procedures. ... symbol manipulation, including data abstraction and generic operations.
  > It presents a full interpreter for Scheme, and, for comparison, an interpreter for a logic programming language similar to pure Prolog.
- [RTL](https://web.archive.org/web/20240414035412/https://ars.els-cdn.com/content/image/3-s2.0-B9780750689748000053-gr20.jpg) -> [Register Transfer](https://www.geeksforgeeks.org/register-transfer-language-rtl/#)
  It is one ["design abstraction" method](https://en.wikipedia.org/wiki/Register-transfer_level)
- So we need to do [*projects* (See Grades)](https://ocw.mit.edu/courses/6-001-structure-and-interpretation-of-computer-programs-spring-2005/pages/syllabus/)
  > but the *crucial learning* done by students is through *substantial weekly programming assignments*. These focus on reading and modifying significant systems, rather than writing small programs from scratch.
- [new book site](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/index.html) same as the [old one](https://web.archive.org/web/20160306140516/https://mitpress.mit.edu/sicp/) from [this](https://web.archive.org/web/20160303050117/http://groups.csail.mit.edu/mac/classes/6.001/abelson-sussman-lectures/) where "excerpts from the book" may mean "Full text!"
  > This includes excerpts from the book, a collection of sample assignments, and information on where to obtain implementations of Scheme.
# Acknowledgments
- > Our subject is a *clear intellectual descendant* of ``6.231,'' a wonderful subject on programming linguistics and the lambda calculus taught at MIT in the *late 1960s* by Jack Wozencraft and Arthur Evans, Jr.
  6.231 uses [one different language](https://www.cl.cam.ac.uk/~mr10/PAL.html).
  [new Lambda Calculus course](https://ocw.mit.edu/courses/6-820-fundamentals-of-program-analysis-fall-2015/pages/syllabus/)
  1960s seems to be [too old to be archived](https://ocw.mit.edu/about/) (Also see [wikipedia](https://en.wikipedia.org/wiki/MIT_OpenCourseWare))
## [scheme official](https://www.scheme.org/) migrated from [Schemers.org](http://www.schemers.org/) (I seems to search R4RS and met this website)
- what is [newsgroup](https://www.wikihow.com/Access-Newsgroups) Also [see](https://comp.lang.scheme.narkive.com/)
- [faqs.org](http://www.faqs.org/faqs/by-newsgroup/comp/comp.lang.scheme.html)
- https://chat.scheme.org/ seems to be same as https://community.scheme.org/
- https://books.scheme.org/ doesn't give one order
  - Not use [commercial EdScheme](https://gustavus.edu/academics/departments/mathematics-computer-science-and-statistics/max/concabs/schemes/edscheme/win/) related with book Concrete Abstractions by Mike Eisenberg.
### [community.schemewiki](https://web.archive.org/web/20240228152042/http://community.schemewiki.org) (notice the following link may be not latest for the schemewiki link, they are just for reference.)
- [code](https://web.archive.org/web/20240228135155/http://community.schemewiki.org/?category-code)
- [learning scheme](https://web.archive.org/web/20230730151321/http://community.schemewiki.org/?category-learning-scheme) although sicp doesn't intend to teach that.
- [manual](https://web.archive.org/web/20230923095649/http://community.schemewiki.org/?category-manuals)
- [different faq's](https://web.archive.org/web/20220117101744/http://community.schemewiki.org/?category-scheme-faq)
  - scheme-faq-general
    - > *Development time and maintenance effort* are often much *more important than execution speed* and memory resources
      TODO
      > The design of Scheme makes it quite hard to perform certain common types of optimisations. For instance, one cannot normally inline calls to primitives (such as + and car) because Scheme allows the re-binding of their names to different functions
    - [debugger](https://web.archive.org/web/20231208093804/http://community.schemewiki.org/?scheme-faq-standards#debuggers)
      > it also imposes some limitations, e.g. the debugger *cannot catch runtime errors* and some tail-recursive calls may *become non-tail-recursive*. PSD is therefore *no substitute for a native debugger* but an extension for Schemes with no debugger at all.
  - TODO [scheme-faq-programming](https://web.archive.org/web/20230923102638/http://community.schemewiki.org/?scheme-faq-programming) and https://web.archive.org/web/20231122105715/http://community.schemewiki.org/?scheme-faq-misc
    also other scheme-faq-...
### https://conservatory.scheme.org/schemers/
- https://conservatory.scheme.org/schemers/Education/
  The TeachScheme! Project (now https://programbydesign.org/) is targeted for "middle-school, high-school and university levels"
- TODO 
  - check program
  - [Functional Programming FAQ](https://web.archive.org/web/20090524191417/http://www.cs.nott.ac.uk/~gmh//faq.html)
- old	[Schemers Inc. page](https://web.archive.org/web/20051229151833/http://www.schemers.com/)

---

# How Do I learn SICP
- I read
  - lectures (I skipped Recitation because they are only review with no new knowledge to teach) first as [academia_se_tips] point 2 shows.
    - 6.037 (not read "With slide transitions" which is for lecture ppt instead of self-study)
    - 6.001 2007
  - read the book
  - use video when unable to understand
- When learning OSTEP, I read almost the book word by word since there is not many formulae or programs in it. But when reviewing briefly what I have got from this learning method now, I found there is not much.
  So I will read SICP cover to cover by reading the 1st sentence for each paragraph and decide whether to read more about that paragraph by whether that paragraph matters and I can get the idea merely from the 1st sentence.
  But I will read footnote and quotes word by word since they may imply something important.
- For SICP book, I *didn't revisit the book back* for something like
  > who explained it in terms of the “message-passing” model of computation that we *shall discuss in Chapter 3*
# CS 61AS chapter 0
## 0.1
- https://web.archive.org/web/20150601000000*/http://start.cs61as.org/ doesn't work
- > Computer scientists are like engineers: we build cool stuff, and we solve problems.
  the links are interesting.
- > your browser has to determine which server to contact, ask that server to give it the webpage you're looking for, download the webpage, interpret the webpage, and display it on your screen.
  DNS -> communication -> network transfer -> interpreter -> GUI
- `(+)` just adds nothing -> 0.
- kw
  > This so-called "textbook" consists of 17 lessons, *most of which are based on the classic text* Structure and Interpretation of Computer Programs, which gives this course its name.
  programming languages
  > That's because in the grand scheme of things, *programming languages don't matter*. They only matter because, for any given problem, one language might let us solve the problem *in fewer lines* of code over another, or one language might let us solve the problem *more efficiently*, and so on.
  > As you learn more computer science, we'll *incrementally show you more of the language*.
  Interpreters
  > Interpreters: We go into how an interpreter works, and we'll even write our own. We'll also consider a few other interpreters and see *what they all have in common*.
  CS 61A
  > CS 61A is the sister course to CS 61AS. It is offered in the traditional *lecture-lab-discussion* format,
  > CS 61AS is a lab-centric class—there are no lectures. Students learn by working *through guided readings and participating in discussions*.
- [detailed comparison](https://docs.google.com/document/d/1htUkJJHXnXnDVMLq4avHsCbIAWFfki_hxuLumtYz6Os/edit)
  > In CS 61A, we are interested in teaching you about programming, *not about how to use one particular programming language*. ... Mastery of a particular programming language is a very useful *side effect* of studying these general techniques.
  Comparison of Courses
  > A bit of Python (build a Python interpreter)
  - What if I've never programmed before? -> Unit 0
  - Do I have to go to lab/discussion?
    > You are highly encouraged, but *not required to attend discussions*.
    > In CS 10 and CS 61AS, lab is the only place in order to *take quizzes*.
  - [L&S](https://guide.berkeley.edu/courses/l_s/) [Breadths](https://lsadvising.berkeley.edu/seven-course-breadth#:~:text=An%20exception%20to%20this%20limitation,wish%20for%20Seven%2DCourse%20Breadth.) may be targetted more at Letters
    > introducing them to *a multitude of perspectives and approaches to research and scholarship*.
  - Why does 61AS use Scheme/Racket when 61A uses Python?
    This is almost same as the preface about syntax.
    Also same as about "Python" as "The End of an Era" says.
    > It should be said that both 61A and 61AS staff consider Python and Scheme to be good programming languages to learn (hence they *show up in both* courses),
  - TODO 
    my facebook account is always banned due to the IP problem.
    "Berkeley Facebook group"
  - General Info of CS 61AS
    - > You learn by working through short readings and guided labs and participating in discussions
      "short readings and guided labs" is almost same as MIT 6.5151 (6.905).
    - > 61AS Uses SICP, which is The Best Computer Science Book. This is the book that the *61A lecture notes are based off of*.
      Here probably mean the new 61A using Python as indicated by the above "detailed comparison".
    - This is probably for [CS 61AS 2015](https://www.alicialuengo.com/Resume.pdf)
### Homework
- > Why is and a special form? Because it evaluates its arguments and stops as soon as it can, returning false as soon as any argument evaluates to false.
  ~~TODO can `cond` implement `and` correctly?~~
  Same reasons as `if` in Exercise 1.6 where applicative-order causes the evaluation order to be wrong.
  See summary in 0.2
  > quote is different from most other procedures in that it *does not evaluate its argument*. Functions that exhibit this type of behavior are special forms.
  And https://berkeley-cs61as.github.io/textbook/special-forms.html#sub2
- [`[,bt for context]`](https://github.com/racket/xrepl/issues/6#issuecomment-271360651)
- > Why did the Walrus cross the Serengeti?
  https://www.expertafrica.com/tanzania/info/serengeti-wildebeest-migration
  > They migrate throughout the year, constantly seeking fresh grazing and, it's now thought, better quality water.
- 0.1-Exercise 4 is same as book exercise 1.6.
- Recommended Readings is 
  CS61a 2011 notes and the book
- TODO
  - scheme require file diff load in `racket -t` vs `-f`.
- `sudo racket -tm grader.rkt -- hw0-1-tests.rkt hw0-1.rkt` to run all tests.
## 0.2
- > "the greatest single programming language ever designed" -- Alan Kay
  See https://qr.ae/psmZZR. At least "operators" differ.
  This also implies Scheme can define other lanugages.
- Readings are from "Simply Scheme: Introducing Computer Science".
- `'61AS` in newer Racket at least has the value.
- Use `(require (planet dyoo/simply-scheme))` to use `butlast`.
- See "The Empty Sentence" and "The Empty Word".
- [`.` usage](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_6.html#SEC29)
  - Also see [`define`](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_7.html#IDX135)
    > the value of the definition is completely evaluated before being assigned to its variable.
    [same](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_7.html#SEC45) as [`set!`](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_6.html#IDX77)
    > If <variable> is not bound, however, then the definition will bind <variable> to a new location before performing the assignment
    i.e. it will init while `set!` won't.
    - [letrec](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_6.html#IDX93)
      > the <init>s are evaluated in the resulting environment (in *some unspecified order*)
      implies
      > it must be possible to evaluate each <expression> of every internal definition in a <body> *without assigning or referring to* the value of any <variable> *being defined*.
    - > An important property of procedure definitions is that the body of the procedure is not evaluated until the procedure is called.
      I didn't fine it in the R5RS doc.
      This is reasonable because the `body` may contain argument.
      ```scheme
      (define (foo sent word)
        (word sent word)) ; Here word will be local. If pass in `'a`, then it is not one procedure.
      ```
- TODO
  > The period and comma also have special meaning, so you cannot use those, either.
- https://berkeley-cs61as.github.io/textbook/special-forms.html#sub2
  - Test Your Understanding
    `(and #f (/ 1 0) #t)`
    `(or #t #f (/ 1 0))`
  - > *Simple code is smart code*, and will make complex programs much more readable and maneuverable.
## 0.3
- > One of its arguments must be a number that tracks the stage of computation for the current recursive call.
  this is not necessary always because we can [use *global* variables](https://stackoverflow.com/q/51682848/21294350).
- > Back in Lesson 0-2, we stated an important property of defining procedures, where the procedure body is not evaluated when it is definted. This is the technical reason why recursion can work.
  So when define `(factorial n)`, `(factorial (- n 1))` doesn't need to be valid.
  > Thus, define is a special form that does not evaluate its arguments and keeps the procedure body from being evaluated. The body is only evaluated when you call the procedure outside of the definition.
  i.e. "not evaluate"d when `define` but "evaluate"d when invoked.
- > Which of these expressions cause an error in Racket? Select all that apply.
  Notice
  https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_6.html#SEC29
  > When the procedure is *later called* with some actual arguments, the environment in which the lambda expression was evaluated will be extended by binding the variables in the formal argument list to fresh locations, the corresponding *actual argument values will be stored* in those locations, and the expressions in *the body of the lambda expression will be evaluated sequentially* in the extended environment.
  https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_6.html#SEC31 (See the above `set!`)
  > <Expression> is *evaluated*, and the resulting value is stored in the location to which <variable> is bound.
- > Think about what happens if the word contains no vowels.
  The endless loop.
- > we have to decide whether or not to keep the first available element in the return value. When we do keep an element, we keep the element itself, not some function of the element.
  i.e. no need to call "some function of the element" recursively.
  IMHO here obviously we need to manipulate with "the element", so not "the element itself".
- Comparing "The "Accumulate" Pattern" with "The "Every" Pattern",
  the former has "a single result" while the latter will have a list like "a sentence".
- `(pigl wd)` doesn't iterate all elements although it follows "the accumulate pattern".
# CS 61A Unix_Shell_Programming
- `tr -d '.,;:"![]()' < summary` is enough.
- `tr ’[A-Z]’ ’[a-z]’ < oneword > lowcase` See `info tr`.
- [`[=e=]` (See macOS tr)](https://www.davekb.com/browse_computer_tips:linux_tr_equiv_chars:txt)
- Also see `info join` example
# CS 61A lab
Up to Week 3, they are much easier than the book exercises 
or more specifically they are easy after having done exercises.

https://people.eecs.berkeley.edu/~bh/61a-pages/Solutions/week4 has no corresponding lab.
## Week 1 part 1
- I won't check `emacs`.
- I [don't have 32-bit system](https://people.eecs.berkeley.edu/~bh/61a-pages/Scheme/source/linux.html), so I won't install stk
  > Use a 32-bit computer to 'alien STk-4.0.1-ucb1.3.6.i386.rpm'
## Week 1 part 2
[sol](https://people.eecs.berkeley.edu/~bh/61a-pages/Solutions/week1)
- 3 is already done in Exercise 1.3.
  - > The way I like best, I think, is a little tricky:
    Here it just sort the 1st 2 items and then sort the latter 2 items.
    Then the 2 bigger are put at first.
  - > This hardly seems worth the effort, but the attempt to *split the problem into logical pieces* was well-motivated.
  - https://code.google.com/archive/p/jrm-code-project/wikis/ProgrammingArt.wiki
    > Consider this solution: (define (sum-square-largest x y z) (cond ((and (< x y) (< x z)) ;; x is smallest (+ (* y y) (* z z))) (else (sum-square-largest y z x))))
    i.e. filter the smallest number step by step.
    https://web.archive.org/web/20080723104814/http://programming.reddit.com/info/1nb8t/comments not with much valuable comments about "art".
## Week 2
[sol](https://people.eecs.berkeley.edu/~bh/61a-pages/Solutions/week2) with the different order from the lab pdf.
- `((lambda (x) (+ x 3) 7)` notice the bold text which implies the unpaired parentheses.
- [x] 2
  - sol
    - TODO
      meaning of "PL-SENT", ENDS-E.
- [x] 3
  - 0, procedure.
- [x] 4
  ```scheme
  (define f 2)
  ; f should be one procedure for `(f)`
  ; (f 3): one procedure taking one number as the argument
  ; ((f)): one procedure taking zero argument and return one procedure
  (define (f)
    (lambda () (lambda (x) (+ x 2))))
  (((f))3) ; 5
  ```
  - sol
    > Again, these definitions are *shorthand for lambda* expressions:
    - > As a super tricky solution, for hotshots only, try this:
      ~~endless loop~~
      Here `f` has no meaning at all.
    - kw:
      > you could use `(define (f . args) f)` as the answer to *all* of these problems!
- [x] 5
  `((t 1+) 0)` -> 3
  `((t (t 1+)) 0)` -> 3*3=9
  `(((t t) 1+) 0)` -> `(((lambda (x) (t (t (t x)))) 1+) 0)` -> `((t(t(t 1+))) 0)` $3^3$
  - sol
    - kw:
      > but what's important is the function, not the expression that produced the function
- [x] 6 trivial same as 5
- [x] 7
  ```scheme
  (define (make-tester x)
    (lambda (y)
      (equal? x y)))
  ((make-tester 'hal) 'hal)
  ((make-tester 'hal) 'cs61a)
  ```
## [Week 3](https://people.eecs.berkeley.edu/~bh/61a-pages/Solutions/week3)
- [x] 1 reverses the order of `(= kinds-of-coins 1)`... or `(first-denomination (- 6 kinds-of-coins))`
- [x] 2 should be almost ~~1:50.~~
  - sol
    > match *a small amount of money with a large coin* ... When the coins are tried in the book's order, by the time we are thinking about four cents, we have already *abandoned the idea of using nickels*
- [x] 3
## Week 4
https://people.eecs.berkeley.edu/~bh/61a-pages/Solutions/week5
- [x] 5 trivial which has been stated in the book `add-rat`.
- [x] 6,8 See `sicp_exercise.md`.
## [Week 5](https://people.eecs.berkeley.edu/~bh/61a-pages/Solutions/week6)
- 2.27 same as wiki
  > A solution that uses reverse to do the work:
  and the other one solution is almost same as tf3's.
  - > But the deep-reversal of the sublists is an inherently recursive problem
    i.e. we need to keep recursion until we get the base case.
  - time and space depends one how the tree is constructed
    IMHO
    space is the worst when totally unbalanced binary tree (see exercise 2.71)
    TODO time complexity is skipped.
- [ ] 4
  - > what test cases were most and least helpful in revealing the definitions.
    not same and same.
  - I skipped trying different implementations and guess ... since that is not closely related with programming.
## Week 6
See https://people.eecs.berkeley.edu/~bh/61a-pages/Solutions/week7
- [x] 1a. `(pair? exp)` -> `(eval-1 (car exp))` -> keep lambda
                   |-> `(constant? exp)`
      -> `apply-1` -> `substitute` -> `(map (lambda (subexp) (substitute subexp params args bound)) exp)` -> `(symbol? exp)` (for + and x) and `(lookup exp params args)` -> `(+ 5 3)`
  - sol
    > APPLY-1 recognizes that the addition procedure is primitive
    i.e. `(procedure? proc)`
- [x] 1b the example is just one "higher-order procedure".
  - sol
    to have consistent changes, we should use `((lambda (pred seq)`.
- [ ] 1c TODO I can't run due to incompatible `eval` due to `(the-environment)`.
  - > STk's MAP function requires an *STk* procedure as its argument, not a Scheme-1 procedure!
  - Here we needs STk but although I can [extract rpm in Arch Linux](https://unix.stackexchange.com/a/125703/568529), I can't [install it](https://unix.stackexchange.com/a/598074/568529).
- [x] 1d
  See https://people.eecs.berkeley.edu/~bh/61a-pages/Solutions/week6
  - similar to 1a `(+ 5 3)`, so `(symbol? exp)` gets the internal `and` proc.
  - sol
    - TODO
      - why
        > (symbol? exp) (error "Free variable: " exp)
    - IMHO if trying to implement `add` manually, then just loop until encountering one `#f` or having iterated through the arg list.
- [x] 2 trivial
- [x] 3
  > the constraint is that each node must be added before any node below it.
## [Week 7](https://people.eecs.berkeley.edu/~bh/61a-pages/Solutions/week8)
- [ ] 1 wrong
  - notice here all functions will call `say` at last.
    So we should just change `say` instead of `greet`.
- [ ] 2
  - TODO I didn't find [`double-talker.scm`][CS61A_lib].
  - > Determine which of these definitions work as intended.
    the 1st
    - The 2nd won't work if parent changes its implementation.
      The 3rd is with the same reasons. If `say` of `person` does `(se say stuff)`, then this will only have one "say".
    - sol
      kw
      > One is that it *assumes* that the two arguments to SE are evaluated *left-to-right*
      > But if we ask this double-talker to REPEAT, it won't say anything at all,
      - > therefore, if we ask this double-talker to repeat, it'll only say the thing once.
        i.e. only "OLD-TEXT".
      - > This one works as desired.
        i.e. `(ask mike ’say ’(hello))` -> `(hello hello)`
        then `(ask mike 'repeat)` -> `(hello hello)`
## [Week 8](https://people.eecs.berkeley.edu/~bh/61a-pages/Solutions/week9)
- [x] 1 this is same as SICP Exercise 3.10.
- [x] 2 trivial by using `init-amount` and `balance` correspondingly.
- [x] 3 trivial by adding one local variable `transactions` and update it when necessary.
- [ ] 4 trivial
  - sol
    > substitute into an unevaluated part of a special form.
    i.e. `⟨name ⟩` in SICP p299.
## [Week 9](https://people.eecs.berkeley.edu/~bh/61a-pages/Solutions/week10)
- [x] 1
  - > Append (without the !) makes copies of the two pairs that are part of the list x.
    "that are part of the list x" should be "including x"
- [x] 2 
  - since that means `(set! 3 y)` and 3 [doesn't meet](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Assignments.html#index-set_0021-1)
    > in the location to which variable is bound
    see sol
    > its first argument must be a symbol, not a compound expression.
  - > The book says, correctly, that the two are *equivalent* in the sense that you can use one to implement the other.
    So "The semantic explanation" is *not strictly right*.
  - kw
    > SET! is about the *bindings* of variables in an environment.  SET-CDR! is about pointers within *pairs*.
- [x] 3a
  - `(set-cdr! (car list1) (car list2))`
    `(set-cdr! (car list2) (cdr list1))`
    IMHO due to ~~using pointers~~ that `(car list2)` is list and changing it later will also influence what points to it, the order is fine by setting `list2` after `list1`.
- [x] 3b similar to "Figure 3.17", both points to `'y` symbol with garbage `'b`.
- [x] 4 
  - 3.13 same as wiki
  - 3.14 is less detailed.
## Week 10
- skipped as https://people.eecs.berkeley.edu/~bh/61a-pages/Solutions/week11 says and it needs multiple-person cooperation.
  > There aren't really any answers; this is all a *try-it-out* kind of lab.
## [Week 11](https://people.eecs.berkeley.edu/~bh/61a-pages/Solutions/week13)
- [x] 1 trivial
- [ ] 2 since no implicit `the-empty-stream` at the end.
  - see sol
- [ ] 3 the 1st only has one `delay` while the 2nd has one for each element.
  - sol views from the different perspective.
- [x] 4 
  - a. just `stream-map` based on self.
  - b. use `(iter stream idx)` where `idx` starts from 1.
## [Week 12](https://people.eecs.berkeley.edu/~bh/61a-pages/Solutions/week12)
[logo manual](https://people.eecs.berkeley.edu/~bh/usermanual)
- [x] 1
  `list-of-values` (just one different naming but the goal is same to eval), `eval-...` and `(driver-loop)`
- [x] 2
  only `eval`.
- [ ] 3
  just derived expression.
  - see sol for the better explanation.
- [x] 4
  - 4.1 same as wiki krubar's.
  - 4.2 same as wiki but more detailed.
  - 4.4 ~~better to use `'true`.~~
    Compared with `4_4.scm` "see wiki woofy better to pass env down.", the order of the latter 2 exp's before `else` doesn't matter since either they can't both exist or both orders do the same when both conds are met.
    - `eval-or` is similar but uses `let` to avoid duplicate calculation.
      - `(null? (cdr tests))` is dropped since at that time either `(true? result)` or not where the latter can be *also* captured by `(null? tests)` then.
    - > This version is elegant but has the disadvantage that you end up computing the first true value twice.
      Just the same structure as the primitive ones.
      Also see wiki LisScheSic's implementation which just substitutes with the evaluated value and also with short circuit. They have the same structure.
  - 4.5
    using `lambda` to solve "duplicate calculation" problem although we can use `eval` inside to solve that just as 4.4 LisScheSic's and Unknown's.
    Same structure as `4_5.scm`.
- [ ] 5
  - 5a just view `output.pdf, full-text-output.pdf`.
    I won't dig into syntax definition and usage for `logo`.
  - 5b just see `to greet :person` where lexical scope will throw errors.
    - similar to sol
  - 5c
    ",[] both implies quote but the latter has list func.
    - > in Logo you don't need any punctuation to call a procedure!  You just give the procedure name and its arguments.
      for sum just 2 args when used without parentheses.
    - > The reason this doesn't work in Logo is that in Logo procedures aren't just another data type, and a procedure name isn't just the name of a variable whose value happens to be a procedure.  (In other words, Logo procedures are not first-class.)
      TODO "Logo procedures aren't just another data type"
      - "procedure" can't be assigned to "variable".
    - Sol says about differences but just similarities with Scheme.
## Week 13
no corresponding solution
Most of them have been shown in notes Week 12.

No related doc for stk by googling 'stk "get-last-mapreduce-output"'.
- [ ] 1 see [line_count_parallel]
- [ ] 2a see notes Week 12 `wordcount-mapper`.
  - This implies `mapreduce` will automatically combine all results of `reduce` to one stream. 
- [ ] 2b `(stream-accumulate find-max-reducer ...)`
- [ ] 2c 
  ```scheme
  ;; modified based on notes
  (define (my-mapper input-kv-pair)
    (if (= 1 (kv-value input-kv-pair))
      (list input-kv-pair)
      '()))

  ;; since each word will only have one count, so + 0 does nothing at all.
  (define used-only-once (mapreduce my-mapper + 0 wordcounts))
  ```
- [ ] 3
  - a
    ```scheme
    (define (match-mapreduce pattern dir-name)
      (define (filter-pattern input-kv-pair)
        (if (match? pattern (kv-value input-kv-pair))
          input-kv-pair
          '()))
      (mapreduce filter-pattern cons '() dir-name))
    ```
  - b
    pomp * etc.
# @CS 61A notes
## skipped underlined words
- p2
- p11
- p41
- p44
- p54
- p58
- p68
## @TODO
### @underlined words checked up to p88
- ~~p24 MapReduce~~
  > (accumulate reducer base-case (map mapper data))
  See p26 where we actually combine related kv-pairs sharing the key into one *bucket*. Then `(reduce reducer base-case (map kv-value subset)` only for *value*s. Same as p85
  > Since all the data seen by a single reduce process have the same key, the reducer doesn’t deal with keys at all.
- ~~p56~~
  ~~> how the Scheme *interpreter* uses mutable pairs to *implement environments*~~
- ~~p60~~
  > This idea of using a *non-functional implementation* for something that has functional behavior will be very useful later when we look at *streams*.
  here it just means Memoization, so see "Memoization of streams" at page 77.
- [p80~82](https://stackoverflow.com/q/79130435/21294350)
## Week 1
- > reminder about quoting
  IMHO this means we first get the value of `hello` and then do `first` on that.
## Week 2
- > We haven’t really talked about aggregates yet
  based on the search results in the following contents, "aggregate" means compound data structure like `pair`.
  > except for the special case of sentences
  i.e. "sentence" is composed of words.
## Week 4
Weirdly, `MapReduce` is used in Week 13 Lab but introduced in Week 4.
I think these functions are almost covered by "6.001_fall_2007_recitation/r07.pdf".

It is really hard to understand these codes since we don't know the detailed implementation of `accumulate`, `reduce`, etc.
- [`nth`](https://stackoverflow.com/a/50332810/21294350)
- > when you’re dealing with lots of data types, but don’t get religious about it
  i.e. don't know about their detailed implementation.
- > You’ll see that this is a little tricky using cons, car, and cdr as the problem asks, but it’s easy for sentences:
  See schemewiki sicp-ex-2.18 which uses iter.
- > Only after you’ve drawn the backbone should you worry about making the cars of your three pairs point to the three elements of the top-level list.
  i.e.
  ```
  ->[inst_1,p_1]->[inst_2,p_2]->[inst_3,nil]
      |                 |         |
     [a,p_1_1]->[b,nil] |         |
                       [c,nil]   [d,p_3_1]...
  ```
- `(groupreduce (lambda (new old) (+ 1 old)) 0`
  This is very similar to `fold-right`, etc.
- > We could combine these in the obvious way to get the average score per student, for exams actually taken
  just divide the 2 lists already got.
- 
```scheme
(define (file->linelist file)
  (map (lambda (line) (make-kv-pair (filename file) line))
      (lines file)))

(define (wordcounts files)
        ; Almost same as `(groupreduce + 0 (sort-into-buckets (append mt1 mt2 mt3)))`
        (groupreduce + 0 (sort-into-buckets
                          ; flatmap: https://stackoverflow.com/a/63732689/21294350
                          (flatmap (lambda (kv-pair)
                                    (map (lambda (wd) (make-kv-pair wd 1))
                                          (kv-value kv-pair)))
                                    files))))
```
- Here `reducer` manipulates with "value" in kv pairs.
- > Therefore, the reducer doesn’t need to look at keys at all; its two arguments are a *value* and the result of the *partial accumulation* of values already done
  same as `fold`.
## Week 5
- > Notice that read and print are not functional programming; read returns a *different* value each time it’s called, and print *changes something* in the world instead of just returning a value.
  See https://en.wikipedia.org/wiki/Pure_function and https://stackoverflow.com/a/903126/21294350.
- > In functional programming, it doesn’t make sense to have more than one expression in a procedure body, since a function can *return only one value*.
  This is implied in Scheme. [Advantages](https://stackoverflow.com/a/36724/21294350).
- > I’ve said that the calculator language doesn’t have variables, and yet in calc-eval we’re using a variable named exp.
  i.e. "the calculator language" -> `(calc)`.
  - > get confused about whether some expression you’re looking at is *part of the interpreter, and therefore an STk expression*, or data given to the interpreter
    i.e. part of `calc.scm` here.
- > But in calculator language, the first sub-“expression” is always the name of the function, and there are only four possibilities: +, -, *, and /.
  i.e. we can't redefine `+`, etc.
- > I put “expression” in quotes because these symbols are not expressions in calculator language.
  i.e. it doesn't know the value of `+` which can be verified by inputting `+` and have errors thrown.
- > By contrast, apply works entirely in the world of values;
  since all are evaled.
- > Mapping over trees
  This is different from the book "Mapping over trees" since they are using different basic data types (See "Figure 2.6").
  > SICP does not define a Tree abstract data type; they use the term “tree” to describe what I’m calling a deep list
- > Since a forest is just a list, we can use map (not treemap!) to generate the new children.
  i.e. `(map treemap forest)`.
- > Mutual recursion is what makes it possible to explore the *two-dimensional* tree data structure fully
  i.e. children of tree are one forest which consists of many trees.
- > One advantage of this approach is that it works even for improper lists:
  since `(list? lol)` fails for pair.
- two-dimensional meaning
  > This is what makes the difference between a sequential, one-dimensional process and the two-dimensional process used for deep lists and for the Tree abstraction.
- **Notice**
  > The program is a little more complicated because the order in which we want to visit nodes *isn’t the order* in which they’re connected together.
  > To solve this, we use an *extra* data structure, called a queue
- > For binary trees, within the general category of depth-first traversals, there are three possible variants:
  already learnt in DMIA. [See](https://en.wikipedia.org/wiki/Tree_traversal#Pre-order,_NLR)
- TODO
  - ~~I didn't find `scheme1.scm` in https://people.eecs.berkeley.edu/~bh/61a-pages/Lectures/~~ 2.1, 2.2, 2.4.
- `scheme1.scm` may be similar to [`racket1.rkt`](https://web.archive.org/web/20220915000000*/http://inst.eecs.berkeley.edu/~cs61as/library/racket1.rkt) but the latter can't be accessed now.
- > It illustrates a big idea: universality.
  [See](https://introtcs.org/public/lec_08_uncomputability.html) or DMIA universal Turing machine.
  > One of the most significant results we showed for Boolean circuits (or equivalently, straight-line programs) is the notion of universality: there is a single circuit that can evaluate all other circuits
- [tail recursion elimination (2nd paragraph and `function_tail_optimized`)](https://stackoverflow.com/a/1240613/21294350)
  - [relation with tail call elimination](https://stackoverflow.com/a/1240560/21294350)
  - https://en.wikipedia.org/wiki/Tail_call#Tail_recursion_modulo_cons
    > But prefixing a value at the start of a list on exit from a recursive call is the same as appending this value *at the end of the growing list* on entry into the recursive call, thus building the list as a side effect, as if in an implicit accumulator parameter.
    i.e. "growing list" -> `head` in Scheme.
    just similar to [this](https://stackoverflow.com/a/310980/21294350) but `cons` -> `*`
    - [accumulator parameter](http://homepages.math.uic.edu/~jan/mcs275/mcs275notes/lec08.html#:~:text=An%20accumulating%20parameter%20accumulates%20the,the%20input%20parameter(s)%3B)
  - https://en.wikipedia.org/wiki/Tail_call#Relation_to_the_while_statement
    IMHO mainly due to *recursive* calls which is just like one `while`.
    Also see "This Julia program gives an iterative definition fact_iter of the factorial:" which just changes the accumulating arguments as what tail-recursive does.
- > And yet these three procedures exactly parallel the core procedures in a real Scheme interpreter:
  ~~IMHO~~ "parallel" means "are similar to".
## Week 6
- > Don’t get the idea that DDP just means a two-dimensional table of operator and type names!
  "table of operator and type" implies "Orthogonality of types and operators".
## Week 7
There are 10 pages in `aboveline.pdf`, so same as SICP book I will only read the first sentence of each paragraph.
For `aboveline.pdf` I will just focus on the concepts instead of how the lib `obj.scm` implements that (This is also implied by the pdf contents).
- > If a class and its parent class both have initialize clauses, the parent's clause is evaluated first
  See SDF `chaining-generic-procedure`
  - So in note
    > Also, when the parent’s ask method says (ask self ’say ...) it uses the say method from the pigger class, not the one from the person class.
- the note contents are just rephrasing `aboveline.pdf`...
## Week 8
- TODO
  - from "Week 7"
    > Notice that an object can refer to itself by the name *self*; this is an *automatically-created* instance variable in every object whose value is the object itself. We’ll see when we look below the line that there are some complications about making this work.
- > Another new thing is that a procedure body can *include more than one expression*. In functional program-ming, the expressions don’t do anything except compute a value, and a function can *only return one value*, so it doesn’t make sense to have more than one expression in it.
  Emm... IMHO we can since we only return the *last* value.
- > The secret is to find a way to call let only once, when we create the count function
  See [LisScheSic's comment](http://community.schemewiki.org/?sicp-ex-3.2)
- > We now forget about the substitution model and replace it with the environment model:
  This is same as SICP book p326.
  - point 2 ~~corresponds to~~ is ~~similar to but it has only one env (See Figure 3.3)~~
    > e new frame has as its *enclosing* environment the environment part of the procedure object being applied.
    - ~~same for~~
      > But in more complicated situations there may be several environments available. For example:
      See SICP Figure 3.11
      - See 
        > We use that frame to extend the global environment (call it G), creating *a new environment E1*
        so the frame is just what E1 points to without the pointer outwards and the pointer inwards.
    - > So we’d better make our new environment by extending E1, not by extending G.
      Even if "The body of g" is just `y`, we should also do as the above.
    - ~~> applied~~
      ~~TODO this may be *not strict*~~
      ~~See~~
      > Rather, we extend the *environment in which* the function was *created*,
      ~~But IMHO `3+` *implicitly* has already in E1.~~
      is same as the book <a id="procedure_application_environment_rule"></a>
      > as its enclosing environment the *environment part of the procedure object* being applied.
      > a pointer to the *envi-ronment in which the procedure was created*.
      and 6.001 lec14
      > goes to the same frame as the *environment pointer* of P
      > Useful to link the environment pointer of each new frame to the *procedure that created* it
      (see Figure 3.8 for how 2 args are nested.)
      - Also see 6.001 lec14 where "evaluated" means "created"
        > was evaluated in E1
      - > Scheme’s rule, in which the procedure’s *defining* environment is extended, is called lexical scope. The other rule, in which the *current environment* is extended, is called dynamic scope.
        ~~So the book is dynamic scope? (also see SDF_notes)~~
        <a id="Lexical_scoping_vs_Dynamic_scoping"></a>
- > to the current environment at the time the lambda is seen.
  i.e. ["created"](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-21.html)
  > The resulting procedure object is a pair consisting of the text of the lambda expression and a pointer to the environment in which the procedure was created.
- `(define count-1 (instantiate count))` (see aboveline `(define Hal-Account (instantiate checking-account 1000))`) does the same as `(make-count)`.
  Then `(ask count-1 'local)` does the same as `((make-count) 'local)`.
### belowline
- > The overall structure of a class de nition looks something like this:
  See `class-variable-methods` (TODO I won't dig further since the note even just give one abstraction)
- > Each method is a procedure de ned within the scope of one or the other class procedure, and Scheme's lexical scoping rules restrict each method to the variables whose scope contains it.
  ~~Based on `make-checking-account-instance` code, `(lambda (message) ...)` can access `MY-ACCOUNT` but only `MY-ACCOUNT` can access ~~
  TODO Since I didn't check the details of the code implementation, I won't dig into the above.
  - > The technical distinction between inheritance and delegation is that an inheritance-based OOP system does not have this restriction.
    At least [C++ can do that](https://stackoverflow.com/a/6187813)
- > But if an instance is the my-whatever of some child instance, then self should mean that child.
  i.e. parent should do `initialize` for child instead of itself.
- > It is provided by the instantiate procedure.
  TODO I won't dig into it.
- > If you do this, you will see the complete translation of a define-class, including all the details we've been glossing over.
  Just see
  > On the next page we show the *translation* of the banana-holder class de nition into ordinary Scheme.
  - TODO
    1. what will be passed as `value-for-self`?
    2. 
  - > Each object has a send-usual-to-parent method that essentially duplicates the job of the ask procedure
    So `'send-usual-to-parent` does `(apply method args)`.
## Week 9
- > They aren’t special forms!
  IMHO this is due to that they can be defined in `lambda`.
- > They’re different from set!, which changes the binding of a variable.
  See book `(define (set-x! v) (set! x v))`, so `set-car!` also "changes the binding of a variable".
  > the book shows how to use local state variables to simulate mutable pairs
  i.e. formal parameters as "local state variables"
  - > Each can be implemented in terms of the other;
    IMHO to define `set!` in terms of `set-car!`, we can use one temporary pair, i.e. `(set-car! (cons x '()) val)`.
- "functional programming" definition [see](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-20.html#footnote_Temp_339)
  > Programming *without any use of assignments*, as we did throughout the first two chapters of this book, is accordingly known as functional programming.
  So 
  > If we look inside the box, memo-fib works non-functionally.
  is right.
- > (Append a b) shares storage with b but not with a. (Why not? Read the append procedure.)
  See Exercise 3.12 where we returns one variable whose right subpart is `b`.
- > The reason is that Scheme implementations are allowed to share storage when the same quoted constant is used twice in your program.
  See Figure 3.17.
- > In a subtable, the key-value pair from the top-level table plays that role
  i.e. `keyI` pair.
  > That is, the entire subtable is a value of some key-value pair in the main table.
  see the figure bottom-right part.
- > in many other languages it’s called an array, but it’s the same idea. Finding the nth element of a vector takes Θ(1) time.
  > But there are no vector analogs to the list constructors cons and append
  ~~probably~~ due to they are in *consecutive addresses* and the former and latter locations are all occupied by others.
  > Since a vector is one contiguous block of memory
- > In STk, vectors are self-evaluating, so you can omit the quotation mark, but this is a nonstandard extension to Scheme.
  Same for MIT/GNU Scheme.
- `(vector-cons value vec)` does something like `(cons value vec)`.
- > Note, though, that if you want to select all the elements of a sequence, one after another, then lists are just as fast as arrays.
  i.e. `map`.
  See `vector-map` where if `make-vector` and `vector-length` has complexity better than or same as $O(n)$ (`vector-set!` and `(vector-ref vec n)` have `O(1)`), then both structures "to select all the elements of a sequence" have complexity $O(n)$.
- > because it takes Θ(n) time to find one element at a randomly chosen position, and we have to do that n times
  ~~i.e. `(random (length lst))`.~~
  > But we can improve the constant factor by avoiding the copying of pairs that append does in the first version:
  Based on `append`, we *avoid doing `index` times `car`* by `((repeated cdr index) lst)`. Then we swap 2 elements by `(set-car! lst (car pair)) (set-car! pair temp)` by just using `O(1)`  operations. Then iter `(shuffle2! (cdr lst))`.
  "find one element at a randomly chosen position" -> `pair`.
  > This could be improved still further by calling length only once,
  i.e. same as what `loop` does.
  - `shuffle3!` also swaps.
## Week 10
### Client/server paradigm (I don't know why CS 61A teaches this here...)
- ~~TODO~~ I don't find "~cs61a/lib/im-client.scm" in [CS61A_lib]
  maybe [this](https://git.sr.ht/~codersonly/wizard-book-study) (got by googling 'cs61a im-"client".scm') work.
  - This repo is based on https://github.com/search?q=repo%3Afgalassi%2Fcs61a-sp11%20make-server-socket&type=code.
    But MIT/GNU Scheme and Racket used by that repo *doesn't support `make-server-socket`*.
- `socket` See csapp -> `man accept`.
  > *listening* on port port-number of *hostname*.
  configured by `ai_flags` (see `getaddrinfo` -> `struct addrinfo`).
  - can be seen like ["electrical cable"](https://en.wikipedia.org/wiki/Network_socket#Use)
- `make-server-socket` means create one socket endpoint at the server side.
- `(socket-output s2)` is one [output port](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Format.html#index-format)
- [thunk](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Arity.html#index-thunk_003f)
- [asynchronous](https://resources.owllabs.com/blog/asynchronous-communication#:~:text=Asynchronous%20communication%20is%20any%20type,information%20and%20offer%20their%20responses.)
  > then there is a time lag before the recipients take in the information and offer their responses.
- `eof-object?` [see](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Input-Procedures.html#index-eof_002dobject_003f)
  > The precise set of end-of-file objects will *vary among implementations*
- `when-port-readable` implies "asynchronous" delay.
### Concurrency (skipped reading `concurrent.scm` since I don't use STK)
- TODO [simulated parallelism](https://www.princeton.edu/~rblee/ELE572Papers/SMT_Eggers.pdf)
- > operating system input/output device handlers
  Here it means [the ordering implied by input/output](https://blog.risingstack.com/concurrency-and-parallelism-understanding-i-o/) relation.
- "critical section" is also said in csapp p1036.
- > Over the years I've seen mutexes implemented about *20 different ways*
  > Note that when you can't acquire a mutex *the kernel is told* not to give your task any CPU time until the mutex is released
  > In other words; the code to acquire and release a mutex typically isn't even in one place - it's *two pieces*, with one piece is in user-space and another piece is in the kernel.
  [see](https://stackoverflow.com/a/49978238/21294350). Emm... in my memory this is related with scheduler.
- > Since a serializer isn’t a special form, it *can’t take an expression as argument*.
  More specifically, this is [due to](https://www.gnu.org/software/emacs/manual/html_node/elisp/Special-Forms.html) <a id="special_form"></a>
  > A special form is a primitive specially marked so that its *arguments are not all evaluated*.
- > What if we check the value of in-use, discover that it’s false, and right at that moment another process sneaks in and grabs the serializer?
  So we need atomic `test-and-set!` to ensure `set` immediately.
  > That underlying level must provide a guaranteed atomic operation with which we can test the old value of in-use and change it to a new value with no possibility of another process intervening
- > Look up “Peterson’s algorithm” in Wikipedia if you want to see the software solution.
  Also see OSTEP
  [here](https://en.wikipedia.org/wiki/Peterson%27s_algorithm#The_algorithm) the different treats of `turn` implies these 2 processes *can't both* in "critical section".
## Week 11
- > time-varying information (versus OOP)
  i.e. "OOP" has "time-varying information".
- `prime1.scm`: i.e. based on chapter 2.
- `prime0.scm`: ~~too naive by checking from 2 up to n, see section 1.2 up to $\sqrt{n}$.~~
  see notes in the parentheses
- `stream-range` i.e. book `stream-enumerate-interval`.
- `prime2.scm` is just one simpler example than the book "The stream implementation in action".
- > letting us write programs in language that reflects the problems we’re trying to solve instead of reflecting the way computers work.
  i.e. doing like `prime0.scm` instead of `prime1.scm`.
- "lazy evaluation" is just ["call-by-need"](https://en.wikipedia.org/wiki/Lazy_evaluation).
- > Why isn’t it a problem with let?
  since `let` is just application of `lambda` whose argument calculation order doesn't matter since they have *no dependency with each other*.
  [see][scheme_operand_ordering_undetermined] <a id="scheme_operand_ordering_undetermined"></a>
  > and the order of evaluation is unspecified.
- > Time-varying information.
  see
  > We can describe the time-varying behavior of a quantity x as a function of time x(t). If we concentrate on x instant by instant, we think of it as a changing quantity. Yet if we concentrate on the *entire time history* of values, we do not emphasize change -- the function itself does not change.
  although here `(read)` is not strictly one function.
  - > purely functional programming languages can handle user interaction
    Here `(read)` has no argument, so its varying output is fine for ["purely functional programming language"](https://en.wikipedia.org/wiki/Purely_functional_programming).
    > Purely functional programming consists of ensuring that functions, inside the functional paradigm, will *only depend on their arguments*, regardless of any *global or local state*.
    but "remember the effect of each thing the user type" will need "local state".
## Week 12
- > Here’s a reminder of the reasons ...
  See p40
- > universality
  i.e. Universal Turing machine
- see book
  > e key idea of *data-directed programming* is to handle generic opera-tions in programs by dealing explicitly with operation-and-type tables,
  so "data" -> "table".
- > You might want to compare it to the one-screenful substitution-model interpreter you saw in week 6.
  i.e. highlighted words. In a nutshell, just add `env`.
- > they’d still be teaching you where the semicolons go.
  i.e. maybe analogy to [basic syntaxes](https://www.isu.edu/media/libraries/student-success/tutoring/handouts-writing/editing-and-mechanics/semicolons.pdf).
- "get away with" means [succeed](https://dictionary.cambridge.org/us/dictionary/english/get-away-with) with
- > as we did in week 7
  TODO that is about OOP...
- > data structures that are both hierarchical and circular.
  i.e. recursive definition where if we keep expand the lambda, then [Circular buffer](https://en.wikipedia.org/wiki/Circular_buffer#:~:text=In%20computer%20science%2C%20a%20circular,circular%20buffer%20implementations%20in%20hardware.)
- [homogeneous sequence](https://stackoverflow.com/a/17765013/21294350), i.e. [same *category*](https://doc.sagemath.org/html/en/reference/structure/sage/structure/sequence.html).
  see https://docs.python.org/3/library/functions.html#enumerate for heterogeneous.
  similar to [wikipedia reference](https://web.archive.org/web/20160304035925/http://www.wseas.us/e-library/conferences/2006lisbon/papers/517-481.pdf) about homogeneous recurrence relation definition
- [name capture](https://www.computer-dictionary-online.org/definitions-n/name-capture#:~:text=In%20beta%20reduction%2C%20when%20a,spuriously%20bound%20or%20%22captured%22.) same as [this](https://en.wikipedia.org/wiki/Lambda_calculus#%CE%B1-conversion)
  > it would result in a variable getting captured by a different abstraction
  i.e. the original free variable for the inner lambda is now bound (i.e. captured).
  - different from [Variable_shadowing]
- > That is, a procedure that has a local state variable must be defined within the scope where that variable is created
  maybe `(let ((local ...)) (define proc1 ...))` like ["We can make balance internal to withdraw by rewriting the definition as follows:"](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-20.html#%_sec_3.1.1)
- how lexical scope Prevents “name capture” bugs
  see `(area rad)` example where the original free variable `pi` is captured by the context caller when using dynamic scope.
- > because the variable x is not bound in any environment lexically surrounding while.
  this is due to we pass quote by `[:x > 0]`, so we need the value of `x`.
- TODO
  > complaining about an empty argument to first
  here the `:list` is always the sublists of `:ranks` or `:suits`, so how this error is thrown?
  ```
  ? hand [10h 2d 3s]
  ten of hearts
  first doesn't like [] as input  in assq
  [if equalp :thing first first :list [op last first :list]]
  ? pons
  Make "ranks [[a ace] [2 two] [3 three] [4 four] [5 five] [6 six] [7 seven] [8 eight] [9 nine] [10 ten] [j jack] [q queen] [k king]]
  Make "suits [[h hearts] [s spades] [d diamonds] [c clubs]]
  ```
  > This will include the variable cards
  not shown in my downloaded version.
- > because the environment contains procedures and each procedure contains a pointer to the environment in which it’s defined
  e.g. `(define (foo x) ...)`.
### Mapreduce
- `mapreduce` is just like the book Figure 2.7.
- > write mapper functions that combine these three patterns for more complicated tasks
  e.g. by `cond`
- [bucket sort](https://hasty.dev/shorts/sorting/bucket-vs-merge) ([also](https://hasty.dev/blog/sorting/bucket-vs-merge))
  - [K-way Merge Sort](https://www.javatpoint.com/k-way-merge-sort)
    > While the traditional merge sort algorithm merges *two subarrays* at a time
  one iter to get min,max
  and then one more to create bucket with ordered *sublist*s.
  Then `insertionSort` or ... for each bucket.
  - `result.concat(left.slice(l)).concat(right.slice(r))` is to combine the rest un-compared elements.
  - > in which each map process is responsible for sending each of its output kv-pairs to the proper reduce process
    if with min, max and bucket predefined which is implied by
    > The mapreduce program takes care of it
- `ss` may mean `show-stream`
- [data-driven computation](https://thesis.library.caltech.edu/10431/8/Kirchdoerfer_Trenton_2017_Thesis.pdf)
  > Data Driven Computing is a new field of computational analysis which *uses provided data* to directly produce *predictive* outcomes
- > `(ss (mapreduce list cons-stream the-empty-stream "/beatles-songs"))`
  how `mapreduce` combines the final key-result depends on the implementation.
- > in this case, map will call list with one argument and so it’ll return a list of length one.
  i.e. `map list kv-pairs`, so for each `kv-pair` it just outputs `(list kv-pair)`
  Compare this with `document-line-kv-pair`.
- ~~TODO we should use `(stream-accumulate find-max-reducer (make-kv-pair ’foo 0) frequent)` since `frequent` is already one list of key-value pairs~~
  `(stream-map kv-value frequent)` is to get the actual useful data, e.g. `(back . 3)` from `(b . (back . 3))`.
- > A better way would be to count each play separately
  i.e. `(lambda (kv-pair) (list (make-kv-pair (kv-key kv-pair) 1)))`
  > then add those results if desired
  `(stream-accumulate + 0 (stream-map kv-value will))` <a id="line_count_parallel"></a>
- > The Scheme interface to mapreduce recognizes the special cases of cons and cons-stream as reducers and does what you intend, even though it wouldn’t actually work without this special handling, both because cons-stream is a special form and because the iterative implementation of mapreduce would do the combining in the wrong order.
  I can't get the `mapreduce` code, so skipped understanding this block.
  same for
  > Streams you make yourself with cons-stream, etc., can’t be used.
### @TODO check underlined words (1 in each of page 80~82 all about first-class expressions)
- all contexts of "first-class expression".
## Week 13
- > Software *doesn’t degrade like hardware*
  [See](https://en.wikipedia.org/wiki/Software_rot#Onceability) Online connectivity (so "has much greater complexity") and Onceability which may probably not happen for "hardware".
  > the quality in a technical system that *prevents a user from restoring* the system
  - > In particular, when a program contains multiple parts which function at arm's length from one another, failing to consider how *changes* to one part that affect the others may introduce bugs.
    IMHO this is more about *Dependency* instead of update. See "Action at a distance"
    > varies wildly
  - > cf. Star Wars (birth of CPSR)
    TODO what is [the relation](http://cpsr.org/prevsite/publications/newsletters/old/fall96news.html/)?
- > analyze invariants
  [see](https://blog.trailofbits.com/2023/10/05/introducing-invariant-development-as-a-service/#:~:text=Invariants%20are%20facts%20about%20the,robust%20in%20the%20long%20term.)
- > correctness proof impossible due to halting theorem
  i.e. some problem [can't have the correct algorithm](https://en.wikipedia.org/wiki/Halting_problem#:~:text=Turing%20proved%20no%20algorithm%20exists,and%20therefore%20cannot%20be%20correct.).
- > black box vs. glass box
  [see](https://www.geeksforgeeks.org/differences-between-black-box-testing-vs-white-box-testing/#)
- > Debug by subtraction
  https://bjc.edc.org/March2019/bjc-r/cur/programming/2-complexity/4-abstraction/5-debugging-recap.html?topic=nyc_bjc%2F2-conditionals-abstraction.topic&course=bjc4nyc.html&novideo&noassignment
- > introduce bugs *on purpose* to analyze results *downstream*
  [See](https://www.reddit.com/r/SoftwareEngineering/comments/1gepi0y/why_do_we_introduce_bugs_on_purpose_to_analyze/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
  - https://en.wikipedia.org/wiki/Dependency_injection
    where injector is similar to constructor in SICP.
- 
# chapter 1
Since I was to learn programming, so for paragraphs not intensively with programming knowledge I only read their first sentence.

No underlined words in the chapter and section prefaces.
## 6.037 ~~(dropped for future reading except this one already read)~~ (may read as one quick review after reading the book)
- [web.mit.edu/alexmv/6.037/](https://web.archive.org/web/20200113183359/http://web.mit.edu/alexmv/6.037/)
- [Graduate P/D/F](https://registrar.mit.edu/classes-grades-evaluations/grades/grading-policies/graduate-pdf-option) is *not one standard* option
- TODO
  - [TR](https://kb.mit.edu/confluence/display/glossary/TR) meaning in "TR, 7-9PM"
- Newton's method (i.e. approximation based on derivative) -> Heron's method [proof](https://math.stackexchange.com/a/1733394/1059606)
  notice here we can't use $f(x)=\sqrt{x}-\sqrt{2},x\mapsto x-\frac{\sqrt{x}-\sqrt{2}}{\frac{1}{2\sqrt{x}}}=2\sqrt{2x}-x$ where the mapped result contains $\sqrt{2}$ which is what ~~since~~ we want to calculate~~$\sqrt{2}$~~.
  - Also see chapter 1.3
    > When we first introduced the square-root procedure, in section 1.1.7, we mentioned that this was *a special case of Newton's method*.
    > For instance, to find the square root of x, we can use Newton's method to find a zero of the function y  y2 - x starting with an initial guess of 1.
- [shire album book series](https://www.somethingunderthebed.com/CURTAIN/SHIRE_ALBUM.html)
  - TODO does the author have one website (search by "Calculating Machines and Computers Geoffrey Tweedale page")?
- TODO what is silicon well, Higgs field?
- TTODO which means it must be understood for further study.
  - `#<procedure:+>`
- I installed mit-scheme using aur which is [updated](https://groups.csail.mit.edu/mac/users/gjs/6.945/dont-panic/#org1107e7f)
- > Why can’t "if" be implemented as a regular lambda procedure?
  because lambda is [*sequential*](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Lambda-Expressions.html)
  > the exprs in the body of the lambda expression are evaluated sequentially in it
  - `expr expr` in the above link may be no use. But `define` [may use that](https://stackoverflow.com/a/47166401/21294350).
  - I don't find "regular lambda" in [the video transcript](https://ocw.mit.edu/courses/6-001-structure-and-interpretation-of-computer-programs-spring-2005/resources/1b-procedures-and-processes-substitution-model/)
  - Also see exercise 1.6 where even `cond` can't implement it *with the `define` syntactic sugar for `lambda`*.
- > How do we know it works?
  It only shows one big iteration step where 2 in `(lambda (a b) (/ (+ a b) 2)) 1.0 2` should be ` (/ x guess)`.
- > But, it only solves a smaller version of the problem
  may mean the false `(fact 0)`. p53 is same as Figure 1.3.
- > Better idea: count up, doing one multiplication at a time
  compared with "recursive algorithms", the latter only manipulates with the stack without doing the arithmetic.
- > output value
  may be "output*s* value".
- > express in tabular form
  See p57.
## 6.001 sp07 lec
IMHO 6.037 is the condensed (as its main page says) of 6.001 lectures by removing many figures.
*Seriously* 6.037 drops "Proving that our code works" in lec 3 which is important although this will be learned in the future.
### 1
- TODO
  - > Could just store tons of “what is” information
- kw:
  - robustness and [flexibility](https://www.geeksforgeeks.org/flexibility-vs-security-in-system-design/) which may be probably said in COD.
- [higher order procedure](https://people.eecs.berkeley.edu/~bh/ssch8/higher.html#:~:text=A%20function%20that%20takes%20another,%E2%80%94a%20higher%2Dorder%20procedure.)
- > Use a language to describe processes
  See [this (I only read the context of "process")](https://cs.stackexchange.com/a/142870/161388)
  >  figure the most *important elements to formalize* and how they interact with each other
- > This creates a loop in our system, can create a complex thing, name it, treat it as primitive
  then one complex thing based on that new primitive ... primitive ...
### 2
- Rumplestiltskin effect just means [naming](https://en.wikipedia.org/wiki/Rumpelstiltskin#Rumpelstiltskin_principle).
- > Next lecture, we will see a formal way of tracing evolution of evaluation process
  in lec 3 p4 it is not that formal but just listing all stages.
  induction is more formal.
### 3 Procedures, recursion
- > E.g. keep trying, but bring sandwiches and a cot
  This may mean it will take a long time.
  Also see [similar words with the different meaning (3 Hots & A Cot)](https://www.urbandictionary.com/define.php?term=3%20hots%20and%20a%20cot)
### SP2007 handout2
- `( " error " )`
  trivially this is one wrong syntax.
```scheme
; Here lambda calculation -> #t which has no argument passed in.
( cond (( lambda (x) (= 2 x))" two " )
        (else" not two " ))

; Here lambda calculation -> #f which has one argument passed in.
( cond ((( lambda (x) (= 2 x)) x)" two " )
        (else" not two " ))
```
### 4 Orders of growth
- See p3 for estimation of Fibonacci complexity.
- > A little more math shows that
  more specifically, it is $2^{\lfloor n/2\rfloor}$
  - Also approximation for
    > If n is odd, then 2 steps reduces to n/2 sized problem
    since
    > Usually, the order of growth is what we really care about:
- > O(f(n) means t(n) ≤ k2f(n) “big-O”
  This is different from [the wikipedia notation](https://en.m.wikipedia.org/wiki/Big_O_notation#Family_of_Bachmann%E2%80%93Landau_notations).
- TODO "Orders of growth for towers of Hanoi" move-tower meaning.
  The tree structure has been learnt for Fib.
  - See p9
- > and has at most n deferred operations, which is also linear in space
  This is based on applicative order where `(fact n)` is calculated first.
- > why not just do the computation directly?
  ~~i.e. without one extra call to `ifact`.~~
  It directly calculates [$n^{\underline{j}}$](https://en.wikipedia.org/wiki/Factorial#Related_sequences_and_functions).
### 7 (~~I don't know why~~ it is put after Lecture 5 Data abstractions since it uses `map`, etc.)
- p2 `pi-sum` is a bit different from the book one.
  [proof](https://math.stackexchange.com/a/2348996/1059606)
- `((incrementby 3) 4)` ~~-> `(incrementby 7)`~~
```scheme
(define incrementby (lambda (n) (lambda (x) (+ x n))))
((incrementby 3) 4)
```
- Quick Quiz is trivial.
- `(compose < square 5)` works by `<` [definition](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_8.html#IDX189).
## 6.001 sp07 rec
### rec2 (naming follows 6.001 fall 2007)
- > Names may be made of any collection of characters that doesn’t start with a number.
  [See](https://www.scheme.com/tspl2d/intro.html)
  > Identifiers normally cannot start with any character that may start a number, i.e., a digit, plus sign ( + ), minus sign ( - ), or decimal point ( . ).
### rec3 recursion
1. [ ] count1 from n to 0 and count2 from 0 to n.
  - `0` is not displayed by `our-display`.
```bash
1 ]=> (count1 4)
4321
;Value: 0 # here is output by the last (= x 0) 0

1 ]=> (count2 4)    
1234
;Value: 4 # here is output by the last (our-display 4)
```
2. [x] is solved by the lec
3. [ ] use $\lim_{n\to \infty^+}(1+\frac{1}{n})^n$?
  Then $n=1e^{input}$ where `input=-100`, etc.
  - See [this QA](https://stackoverflow.com/q/78597962/21294350)
    We should better read the book first before the recitation since
    1. floating precision problem is said in exercise 1.7.
    2. Shawn's comment is implied in [one footnote](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-10.html#footnote_Temp_35).
    - Also see 3_58.scm
1. [x] see code
2. [ ] I originally planned to use base case for `n=1,2`.
  The solution is more elegant to use implicitly the 0th number being 0 although in the actual series that doesn't exist.
1. [ ] See https://www.mathsisfun.com/numbers/golden-ratio.html. See the approximation formula said in mcs p1005.
### rec1 from SP2007 (put at the end since I read this after reading the above)
- > Missing ore than a couple of the homework assignments
  i.e. "more than"
- > Stupidly follow the rules
  i.e. book
  > e evolution of a process is directed by a paern of rules called a program.
- > Any collection of characters that doesn’t start with a number.
  [see](https://docs.scheme.org/schintro/schintro_104.html#:~:text=There%20is%20a%20slight%20restriction,%2C%20and%20so%20is%20...)
- > Evaluate the subexpressions in any order
  https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_6.html#SEC28
- homework
  - `(double double)` will be wrong since
    > ;The object #[compound-procedure 14 double], passed as the second argument to integer-multiply, is *not the correct type*.
  - `(* + -)`
    This [depends on the implementation](https://docs.scheme.org/surveys/redefining-special-forms/).
  - > How are they similar and how do they differ?
    both is about addition but with different possible argument number.
  - > Side-effect: In relation to an expression or procedure
    [See](https://docs.scheme.org/schintro/schintro_13.html#:~:text=Expressions%20Return%20Values%2C%20But%20May,variables%20or%20objects%20by%20assignment.)
    > They return values, but they can also have *side effects*---i.e., they can change the state of variables or objects by assignment.
  - sol
    - wrong
      > (cannot multiply two procedures)
### rec4
- > Searching all possibilities usually results in expo-nential growth
  [See](https://www.reddit.com/r/math/comments/1cg4j6u/comment/l2akaoi/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
- Problems
  trivial: 1~3,6~7
  4,5 are fast-expt and fast-expt-iter.
  7 is just one small variation of the book first `(prime? n)`.
  8 is Exercise 1.18.
  1. > Space: Θ(log n)
      approximately $\log n/2$ due to `else`.
## book reading
### 1.1
- > an integration of the motion of the Solar System
  [See](https://en.wikipedia.org/wiki/Stability_of_the_Solar_System)
- > A second advantage of prefix notation is that it extends in a straight-forward way to allow combinations to be nested
  i.e. enforced parentheses which has much less ambiguity.
- > Expressions such as these, formed by *delimiting* a list of expressions within *parentheses* in order to denote *procedure application*, are called combinations
- > paraphrasing Oscar Wilde
  [See](https://www.edge.org/response-detail/10765#:~:text=What%20is%20value%3F,and%20the%20value%20of%20nothing%22.)
- > operators are themselves compound expressions
  [See](https://stackoverflow.com/q/57091377/21294350)
- > Syntactic sugar causes cancer of the semicolon
  [See](https://stackoverflow.com/questions/547710/why-is-syntactic-sugar-sometimes-considered-a-bad-thing#comment138572595_547760)
  https://eli.thegreenplace.net/2009/02/16/abstract-vs-concrete-syntax-trees
  > The pointer is now clearly below the array
  i.e. [array of pointers](https://stackoverflow.com/q/6130712/21294350) as expected.
- > e problem arises from the possibility of confusion between the names used for the formal parameters of a procedure and the (possibly identical) names used in the expressions to which the procedure may be applied
  i.e. local compared with global
```scheme
(define (f x) (* x x))
(define x 10)
(f (+ x x))
```
- TODO
  - > Indeed, there is a *long history* of erroneous definitions of substitution in the literature of logic and programming semantics.
  - > prove for procedure applications that can be modeled using substitution (includ-ing all the procedures in the first two chapters of this book) and that yield legitimate values, normal-order and applicative-order evaluation *produce the same value*.
  - https://softwareengineering.stackexchange.com/a/186255
    > because normal-order evaluation becomes much more complicated to deal with when we leave the realm of procedures that can be modeled by substitution.
    notice "special form" may be [neither of applicative or normal][how_special_form_is_special].
- [clause](https://www.merriam-webster.com/dictionary/clause) different from that in logic.
- [so-called very high-level languages](https://en.wikipedia.org/wiki/Declarative_programming) which seems to be learned in COD.
- [antilogarithm](https://mathworld.wolfram.com/Antilogarithm.html) is just exp
- > Such a name is called a bound variable, and we say that the procedure definition binds its formal parameters.
  i.e. its value [has range](https://en.wikipedia.org/wiki/Free_variables_and_bound_variables)
  > if the value of that variable symbol has been bound to a specific value or range of values in the domain of discourse or universe.
- [consistent_renaming]
  - [capture-avoiding substitution](https://stackoverflow.com/a/11332661/21294350)
    i.e. as the book says
    > It would have changed from free to bound
  - An5Drama's question
    2: here $z$ won't exist in $t,e,y$, so it is safe to replace (i.e. "a *fresh* name"). More detailed about "free" see the book.
- [lexical scoping](https://www.shecodes.io/athena/9740-what-is-lexical-scoping-and-how-does-it-work-in-javascript#:~:text=Lexical%20scoping%20is%20a%20way,interact%20with%20examples%20in%20JavaScript.) just means child scope can use all variables defined in the parent scope but not vice versa.
  > > For example, lexical scoping determines that when a variable is *declared inside a function*, it is local to that function and *cannot be accessed outside* of it. This means that variables *declared outside of the function can be accessed* by the functions defined within it.
- > the simplest name-packaging problem
  i.e. to [package the function](https://stackoverflow.com/a/20520767/21294350).
  > better structuring a procedure, not for efficiency
  - Also see [this with one ASCII figure](https://veliugurguney.com/blog/post/sicp_7_-_sections_1.1.6_1.1.7_1.1.8)
#### 1.1.4
- "Compound Procedures" is compared with *primitive* procedures.
### 1.2 (Here I read it first to check why CS 61A Week 2 chooses Section 1.3)
IMHO it is fine to read 1.2 without reading 1.3 first.
- footnote 30 is trivial if having learnt computer architecture.
- tail-recursive
  - [naming source](https://stackoverflow.com/a/33930/21294350)
    > In tail recursion, you perform your calculations first, and then you execute the recursive call,
    Also see comment [1](https://stackoverflow.com/questions/33923/what-is-tail-recursion#comment18950582_37010) which is same as book
    > In this case there is some additional “hidden” information, maintained by the interpreter and *not contained in the program variables*, which indicates “where the process is” in negotiating the chain of deferred operations
    - TODO what does [this](https://stackoverflow.com/questions/33923/what-is-tail-recursion#comment30739771_37010) mean since with `else` removed then the call disappears.
      > It would have been more clearly a tail call, if the "else:" were omitted. Wouldn't change the behavior, but would place the tail call as an independent statement
      [tail call](https://stackoverflow.com/questions/12045299/what-is-difference-between-tail-calls-and-tail-recursion#comment16081995_12045299)
- > us, the process uses a number of steps that grows exponentially with the input.
  See [this][Fib_complexity] 
  If seeing it as the binary tree, $O(2^n)$ is trivial. More specifically, the deepest leef is the path following $(fib (- n 1))$ up to 1. So the maximum node number is the maximum time complexity (trace back from the leaf, due to `+ O(1)` each node contributes `O(1)` time. Then the time complexity is `O(1)*node_num`) $(2^0+\ldots+2^{n-1})\cdot O(1)=(2^n-1)\cdot O(1)$.
  More strictly, we can let $k=O(1)$, then just solve the recurrence relation.
  - TODO
    - meaning of
      > If you could *reach out toward infinity* it would get close to O(golden_ratio^n). That is what an asymptote is, the distance between the two lines must approach 0.
      - "the distance between the two lines must approach 0" may mean the tree is so big so that the edge distance is samll if put the tree on the paper.
    - Here depth should be [$n-1$](https://stackoverflow.com/a/2603707/21294350) since the tree is from n to 1.
- > because we need keep track only of which nodes are above us in the tree at any point in the computation.
  Here is based on applicative order. See Figure 1.5.
  In a summary for each node, we only keep the path from it to the root as the stack and will pop & push the stack when moving from the left leaf to the right.
- In summary of the previous 2 points
  > In general, the number of steps required by a tree-recursive process will be propor-tional to the number of nodes in the tree, while the space required will be proportional to the maximum depth of the tree.
- > one linear in n, one growing as fast as Fib(n) itself
  Compared with Figure 1.3, here we duplicately calculate many terms so `Fib(n)` with exponential time complexity.
  But the space complexity of these 2 problems are same due to no **redundancy**.
  Also see [Fib_complexity]
  > This is assuming that repeated evaluations of the same Fib(n) take the same time
  - > An example of this was hinted at in Section 1.1.3. e interpreter itself evaluates expressions using a tree-recursive process.
    TODO Here no redundancy, so we need to always use one tree to represent the data.
- > To formulate the iterative algorithm required noticing
  should be "requires" by [this](https://qr.ae/pslucp)
  > To do what needs to be done, regardless of what one wants to do, *depends* upon discipline, not motivation.
- > e number of ways to change amount a using n kinds of coins equals
  This has been learned in DMIA.
  - > changing smaller amounts using fewer kinds of coins
    here should be "or using ...".
    where the former corresponds to $a-d$ and the latter corresponds to "all but the first kind of coin".
  - > For example, work through in detail how the reduction rule applies to the problem of making change for 10 cents using pennies and nickels.
    let $A(n)$ -> only use pennies
    $B(n)$ -> use pennies and nickels.
    Then $B(10)=A(10)+B(5)=A(10)+A(5)+B(0)=A(10)+A(5)+A(0)+B(-5)$
    Here $B(0)=1$ because it already chooses 2 nickels.
    Trivially, to choose 0 cents, using what kinds of coins doesn't matter.
    - > If n is 0, we should count that as 0 ways to make change.
      This is trivial since we have no money so impossible "to make change".
  - "first-denomination" chooses the biggest to accelerate the recursion.
  - > count-change generates a tree-recursive process with redundancies sim-ilar to those in our first implementation of fib
    Here either the 1st param (unfixed decrease amount) or the 2nd (fixed decrease amount) is decreased, so reordering the decrease sequence and then add some decreases due to "unfixed decrease amount" *may* cause the same state.
- > the analysis of a process can be carried out at various *levels of abstraction*.
  See CS 61A notes.
- > We can compute exponentials in fewer steps by using successive squaring.
  This is already said in DMIA "ALGORITHM 4 Recursive Modular Exponentiation.".
  Iterative see "ALGORITHM 5 Fast *Modular* Exponentiation." and mcs "6.3.1 Fast Exponentiation".
  Although they are for *Modular* Exponentiation.
  - In a summary `xy` in mcs just counts the corresponding $1000\ldots 0$. 
    Or we can see each `x` as the *minimum unit* after `quotient(z,2)`. So `xy` will count that minimum unit.
    `z = 0` means we have counted all bits.
- See **footnote** 37 for a *precise* calculation of the complexity.
  - > equal to 1 less than the log base 2 of n
    IMHO here should be $\lfloor \log_2 n\rfloor$ instead of $\log_2 n - 1$.
    For example, $10\xRightarrow{s(quare)}1\xRightarrow{*}0$ so $2=\log_2(0b10)$ multiplications
    Then $11\xRightarrow{*}10\ldots$ so add 1 due to one 1 for the *odd* case.
    > is total is always less than twice the log base 2 of n.
    the num of 1 is at most $\lceil \log_2 n\rceil$.
    So total is $\lfloor \log_2 n\rfloor+\lceil \log_2 n\rceil<2(\log_2 n+1)$.
    Notice if $frac(\log_2 n)<0.5$, then the above is bigger than $2\log_2 n$.
    - $\lfloor \log_2 n\rfloor$ can be intuitively seen as square-rooting the number until the leading 1 is left.
      While $\lceil \log_2 n\rceil$ will go one more step to count the bit digit number.
    - since $R(n)\in [\overbrace{\lfloor \log_2 n\rfloor+1}^{1000\ldots 000},\lfloor \log_2 n\rfloor+\lceil \log_2 n\rceil]\Rightarrow R(n)=\Theta(\log n)$
    - Also see "Exercise_1_16.rkt" comment.
    - ~~Notice we ignores the multiplication in `square`.~~
- > For example, fast-expt for n = 1000 re-quires only 14 multiplications
  See fast-expt.scm the above should be `15=import math;bin(1000).count('1')+math.floor(math.log(1000,2))`.
- [Chandah-sutra by Áchárya Pingala](https://rarebooksocietyofindia.org/postDetail.php?id=196174216674_480588701674)
- > is generates an iterative process, whose number of steps grows as the logarithm of the numbers involved.
  See [this](https://stackoverflow.com/a/3981010/21294350)
  - Tiny A: `b % (a % b)=b%a<a`
    to prove $\frac{\frac{b}{2}}{a+b}>\frac{1}{4}$, i.e. prove $2b>a+b\Rightarrow b>a$ which is trivial.
  - > Input size N is lg(A) + lg(B)
    strictly "the number of input digits" is $\lceil\log A\rceil$
  - I skipped the last 2 sentences since they are not directly about gcd.
- > because it appears in Euclid’s Elements (Book 7, ca. 300 ..)
  [See](http://aleph0.clarku.edu/~djoyce/java/elements/bookVII/propVII2.html)
- > since q must be at least 1
  because $a_k>b_k$
- Lamé’s Theorem is already proved in mcs.pdf (TODO location)
- > Hence, the order of growth is Θ(log n)
  [see](https://stackoverflow.com/questions/3980416/time-complexity-of-euclids-algorithm#comment138640494_3980416)
- > r will have order of growth √Θ( n)
  i.e. consider the worst case.
- `(expmod base exp m)` is based on [modulus multiplication](https://math.stackexchange.com/q/2416119/1059606) which is also said in footnote 46.
- > Considering an algorithm to be inadequate for the first reason but not for the second illustrates the difference between mathematics and engineering.
  [See](https://stackoverflow.com/questions/78641848/when-can-we-safely-use-the-randomized-algorithm-considering-probability#comment138650510_78641848)
- > if n passes the test for some random choice of a, the chances are better than even that n is prime. If n passes the test for two random choices of a, the chances are better than 3 out of 4 that n is prime.
  This [only holds when $P(A)=\frac{1}{2}$](https://math.stackexchange.com/a/3363464/1059606)
  - I skipped the [more precise calculation](https://math.stackexchange.com/questions/3363141/probability-that-a-number-passing-the-fermat-test-is-prime#comment6922489_3363141) and [this](https://t5k.org/prove/prove2_3.html) (SkipMath).
    > It has been proven ([Monier80] and [Rabin80]) that the strong probable primality test is wrong no more than 1/4th of the time (3 out of 4 numbers which pass it will be prime)
- "information retrieval" is mainly about private information.
- > ``probabilistic'' algorithm with order of growth $\Theta(\log n)$
  It only counts `expmod` and if for `fast-prime?` we use `n-1` times then the "order of growth" is worse $\Theta(n\log n)$.
### 1.3
- [footnote 49](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-12.html#footnote_Temp_90)
  [proof](https://math.stackexchange.com/a/14817/1059606) using [Taylor series](https://en.wikipedia.org/wiki/Taylor_series#Trigonometric_functions) which is the most trivial.
  Also see [wikipedia](https://en.wikipedia.org/wiki/Leibniz_formula_for_%CF%80#Proof_2) where I skipped studying about "Stolz angle".
- > e variables’ values are computed outside the let
  See [R5RS](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_6.html#IDX89)
  > The <init>s are evaluated *in the current environment* (in some unspecified order), the <variable>s are bound to *fresh locations* holding the results
  "fresh locations" implies the above
  - This is also implied its equivalence with `lambda` where `exp` trivially should *not influence with each other*.
#### 1.3.3
- > the number of steps required grows as Θ(log(L/T ))
  trivial by counting how many times we divide by 2.
- > f (x), f (f (x)), f (f (f (x))), ...,
  This can also find the "fixed point" if it exists.
  [See](https://math.stackexchange.com/a/9181/1059606)
  - [proof][Banach_fixed_point_proof]
    - Here T is continuous is due to https://en.wikipedia.org/wiki/Contraction_mapping -> https://en.wikipedia.org/wiki/Uniform_continuity#Definition_of_uniform_continuity
      notice "uniformly continuous" is for $(x,y)$ while (ordinary) continuity is for $x$
      - compared with [normal function](https://en.wikipedia.org/wiki/Continuous_function)
        > Continuity of real functions is usually defined *in terms of limits*. A function f with variable x is continuous at the real number c, if the *limit* of ${\displaystyle f(x),}$ as x tends to c, is equal to ${\displaystyle f(c).}$
        https://en.wikipedia.org/wiki/Limit_(mathematics)#In_functions is same as the above "Definition of (ordinary) continuity" where $d$ becomes absolute function $d(x,y)=|x-y|$.
    - The above is similar to the QA answer.
    - In summary it first
      > This proves that the sequence ${\displaystyle (x_{n})_{n\in \mathbb {N} }}$ is *Cauchy*
      then "completeness" (with Cauchy, we get the limit) -> "Furthermore" (existence) -> "Lastly" (unique)
      So we *only* need to prove "Cauchy sequence" and the rest all *follows*.
  - This question has one good wikipedia reference ([link at that time](https://en.wikipedia.org/w/index.php?title=Banach_fixed-point_theorem&oldid=363078964) proof is almost similar to the current one) but it asks how to calculate limit which is easy as the [top answer](https://math.stackexchange.com/a/9158/1059606) says.
- TODO
  - > not as far from y as x/y
    Here "average" should be "as far".
    - So interestingly and subtly, This intuitive average *still* holds one *reasonable* "fixed point" definition
    $\frac{1}{2}(y+x/y)=y\Rightarrow y=x/y$
      Then I read
      > (Note that y = 12 (y + x/y) is a simple transformation of the equation y = x/y; to derive it, add y to both sides of the equation and divide by 2.)
- > With this modification, the square-root procedure works.
  Here $y_0=1>0$ then $y_n>\sqrt{x},n\ge 1$
  Then 
  $$
  \begin{align*}
    y_{n+2}-y_{n+1}&=\frac{1}{2}[(y_{n+1}-y_{n})+\frac{x}{y_{n+1}}-\frac{x}{y_{n}}]\\
                   &=\frac{1}{2}(y_{n+1}-y_{n})(1+x\cdot(-\frac{1}{y_{n}y_{n+1}}))\\
                   &<\frac{1}{2}(y_{n+1}-y_{n})
  \end{align*}
  $$
  So it is one Cauchy sequence as [Banach_fixed_point_proof] shows (Here $||$ meets the 1st inequality $d(x_{m},x_{n})\leq d(x_{m},x_{m-1})+d(x_{m-1},x_{m-2})+\cdots +d(x_{n+1},x_{n})$).
  - Here the inequity is inappropriate to catch with python since no program knows where to stop scaling (even for human, we only at the last step know how to scale).
    ```python
    from sympy import symbols
    x, y = symbols('x y')
    from sympy import simplify
    next_y=lambda x,y: 1/2*(x/y+y)
    y_n=next_y(x,y)
    y_nn=next_y(x,y_n)
    for i in range(10):
      print(simplify((y_nn-y_n)/(y_n-y)))
      y=y_n
      y_n=y_nn
      y_nn=next_y(x,y_nn)
    ```
- > a technique we that we call average damping
  [See](https://stackoverflow.com/a/3863467/21294350) with one interesting analogy.
  > a brake to a pendulum
  - > But not every function has this property.
    since one is oscillating while the other is strictly decreasing.
  - Also see [this](https://math.stackexchange.com/a/3518585/1059606) for why choose average function.
- > to derive it, add y to both sides of the equation and divide by 2
  See exercise 1.45 zhihu link.
  Here although these 2 functions are not same, they have one shared intersection point.
#### 1.3.4
- `fixed-point` similar to `good-enough?` where the former cares about `(- y (/ x y))` and the latter is about `abs (- (square guess) x)`
  `average-damp` -> `average`
  `(/ x y)` -> `(/ x guess)`
- footnote 62
  - See [1](https://math.stackexchange.com/q/247567/1059606) and the [answer](https://math.stackexchange.com/a/247575/1059606) (similar to [this](https://math.stackexchange.com/questions/4268181/total-bits-of-accuracy-gained-per-iteration-with-newtons-method#comment8879730_4268181))
    - Notice libretexts only shows *the upper bound* have "double" relation. But $f'',f'$ are  dynamic, so the *exact* mapping process may not hold that property.
- > Now we’ve seen how higher-order procedures permit us to *manipulate these general methods* to create further abstractions.
  See
  1. > Procedures that *manipulate procedures* are called higher-order procedures.
  2. > We have here a compound procedure, which has been given the name square
     i.e. "compound procedure" -> `(define (⟨name⟩ ⟨formal parameters⟩) ⟨ body⟩)` in Scheme.
  3. 1.3.3 preface.
- > ey may be included in data structures.
  ~~This is not included in [wikipedia](https://en.wikipedia.org/wiki/First-class_citizen)~~
  ~~maybe it [means](https://en.wikipedia.org/wiki/First-class_citizen#History)~~
  - > There are *no other expressions involving procedures* or whose results are procedures
    [i.e.][First_class_citizen]
    > they always have to appear in person and can never be represented by *a variable or expression*
    - Notice this is a bit different from Robin Popplestone's definition.
  - The definition is shown in [this wikipedia entry with SICP as the reference](https://en.wikipedia.org/wiki/First-class_function)
    - TODO
      > type theory also uses first-class functions to model associative arrays and similar data structures.
    - notice there is [no strict definition][First_class_citizen]
      > He did not actually define the term strictly
### TODO
- > should note the remarks on “tail recursion” in Section 1.2.1.
## cs61a (read the *related reading* before reading the lecture as the above advises)
### 1.1
- [recursion equation](https://www.geeksforgeeks.org/recursion-in-lisp/)
- [quote diff list](https://stackoverflow.com/a/34984553/21294350) (I only read "A rule of thumb").
- the codes (e.g. 1.1/plural.scm) are pseudocode.
  - `bl` may probably mean butlast.
- >  the clauses aren’t invocations.
  i.e. not procedures.
- > BASIC doesn’t scale up
  maybe [due to](https://qr.ae/psm2OD)
  > More modern versions of BASIC are a lot more powerful, but they’ve lost sight of the original intent of the language. It *wasn’t even a structured language originally*.
- plumbing diagrams See COD FIGURE A.6.2.
- `se ` means [sentence](https://people.eecs.berkeley.edu/~bh/ssch5/words.html)
- map is [more general than function](https://en.wikipedia.org/wiki/Map_(mathematics)#:~:text=Maps%20as%20functions,-Main%20article%3A%20Function&text=In%20many%20branches%20of%20mathematics,%22%20in%20linear%20algebra%2C%20etc.)
- NOTICE 
  - `(zero (random 10))` differs for "Applicative order" and "Normal order".
    > Because it’s not a function
    i.e. `(random 10)` will output different values each time.
  - > But later in the semester we’ll see that sometimes normal order is more efficient.
    TODO
### 1.2
- Here as CS61AS says, we assume `sort` can sort the sequence from low to high correctly.
  ```scheme
  (insert (first sent)
    (sort (bf sent)) )))
  ```
  Then `(insert num sent)` -> `(insert num (bf sent))` just inserts the number at the correct position.
- > Well, if there are K numbers in the argument to insert, how many comparisons does it do? K of them.
How many times do we call insert? N times. But it’s a little tricky because each call to insert has a
different length sentence. The range is from 0 to N − 1.

  Here it means `sent` in `(insert num sent)` has K numbers.
  Based on the context of "The range is from 0 to N − 1.", here it means `sort` is called N times.
  And each `sort` calls `insert` which in turn calls smaller `insert`.
- kw
  This is not said explicitly in the book
  > That constant factor of 12 isn’t really very important, since we don’t really know what we’re halving—that is, we don’t know exactly how long it takes to do one comparison. ... but for an overall sense of the nature of the algorithm, what counts is the N 2 part.
- > ∃k, N | ∀x > N, |f (x)| ≤ k · |g(x)|
  This is wrong when
  > ${\displaystyle g(x)}$ be strictly positive for all large enough values of ${\displaystyle x}$.
  since it denotes $\mathcal{O}$
- Θ(1) time to search
  See [CLRS](https://stackoverflow.com/q/73218786/21294350)
- > Many other problems that are not explicitly about sorting turn out to require similar approaches
  IMHO as DMIA says, first sort then search.
- >  if the speed of your computer doubles, that just adds 1 to the largest problem size you can handle
  This is for $2^n$, $n!$ is much worse.
- > This program is very simple, but it takes Θ(2n) time! [Try some examples. Row 18 is already getting slow.]
  ~~becuase `else` part has the binary tree form.~~
  - See [this](https://stackoverflow.com/a/22026052/21294350)
    if we consider addition number instead of call,
    then `F(0, m) = F(n, 0) = 0`.
    Then `F(n, m) = f(n, m) - 1` which is guessed first and then verified.
    - "finite difference equation" -> `F(n, m) = 1 + F(n - 1, m) + F(n, m - 1)`
    - I didn't dig into the simplification using *Stirling approximation* which is a bit tedious but the steps hew to the line.
  - Also see [link2](https://stackoverflow.com/a/26229383/21294350)
    - > until k reaches 1 or n reaches n/2 in any recursive call
      it should be "k reaches 0"
      and these 2 cases mean the same when n is even.
    - > The value of C(n,k) and the number of calls of C(n,k), that return the value 1, are the same,
      This can be proved using induction where the hypothesis is just the above statement.
    - The above $C(n,k)\neq T(n,k)$.
  - Also see [this](https://stackoverflow.com/q/43232800/21294350) which calculates complexity *row by row*.
    - > This means that all the coëfficients in the Pascal triangle are formed by adding 1 as many times as the value of that coëfficient.
      same as link2.
    - [answer](https://stackoverflow.com/a/43239200/21294350)
      - > Big problem
        I think it is solved in question which gets the correct result 2^n as the comments indicated.
        > This results in a geometric series, which computes the sum of all 2^r for r going from 0 to n-1.
- ~~TODO here `(empty? (bf in))` may not work since `(bf '())` is invalid.~~
- `(se 1 (iter old-row ’(1)))` and `(se (+ (first in) (first (bf in))) out)`
  will put the 2nd to left at the the 2nd to right position since `out` are the rightmost elements.
  Due to symmetry, it works.
  - `(empty? (bf in))` will break when `in='(1)`
  - More readable one [see](http://community.schemewiki.org/?sicp-ex-1.12)
    > Off on a tangent having misread the question & skipping ahead a few chapters:
    1. `(null? (cdr prev)) (list 1)` -> ending 1
    2. `(= 1 (car prev)) (cons 1` starts with 1
    3. `else` the middle part
  - Assume `(nth col (pascal-row row))` is $\Theta(1)$ complexity as ["Θ(1) time to search" says](https://stackoverflow.com/a/37350500/21294350).
    - > This was harder to write, and seems to work harder, but it’s incredibly faster because it’s Θ(N 2 ).
      for each row $n$ indexed from 0, we calculate the middle part ($n-1$ additions)
      So we have $1+\ldots+n-1=\Theta(n^2)$ (Here we ignore the call expense since as csapp says the compiler may combine calls to avoid that expense) (Here trivially we only consider *large* $n$ by complexity)
      similar to [this](https://stackoverflow.com/a/32498795/21294350)
      ```java
      tempList.add(1);
      for(int j = 1; j < i; j++){
          tempList.add(pyramidVal.get(i - 1).get(j) + pyramidVal.get(i - 1).get(j -1));
      }
      if(i > 0) tempList.add(1);
      pyramidVal.add(tempList);
      ```
- > computes a few unnecessary ones
  i.e. at least the *other* terms at the target row.
### 1.3
- > the formal parameter list obviously isn’t evaluated, but the body isn’t evaluated when we see the lambda, either—only when we invoke the function can we evaluate its body.
  See exercise 1.6 notes where the arguments are evaluated first.
- If using [this definition](https://rosettacode.org/wiki/First-class_functions#:~:text=Since%20one%20can't%20create,C%20has%20second%20class%20functions.), C  doesn't have first-class functions since
  > Create new functions from preexisting functions *at run-time*
  is not met.
- > you’ll learn more about this in CS 164.
  It's about ["the design of programming languages and the implementation of translators"](https://web.archive.org/web/20200129153230/https://inst.eecs.berkeley.edu/~cs164/sp11/)
# chapter 2
TODO up to 2.3.3 as CS 61A notes require.
6.001 Spring-2007 lec8 needs 2.2.4 to be finished.
## book
- > Another key idea is that compound data objects can serve as conventional interfaces for combining program modules in mix-and-match ways
  Also see SDF, here "mix-and-match" IMHO means using appropriate procedures to construct one signal-flow (see Figure 2.7).
  - > We illustrate some of these ideas by presenting a simple graphics language that exploits closure.
    See Levels of language for robust design and Exercise 2.52 for hierarchy.
- > We will investigate *these ideas* in the context of symbolic differentiation, the representation of sets, and the encoding of information.
  IMHO it mainly talks about "time" complexity for "the representation of sets".
### 2.1
- > We now come to the decisive step of mathematical abstraction: we forget about what the symbols stand for. ...[The mathematician] need not be idle; there are many operations which he may carry out with these symbols, *without ever having to look at the things they stand for*.
  [original paper](https://sci-hub.se/https://www.jstor.org/stable/1666589). 
  TODO IMHO Here it just means we can manipulate with data without knowing about it.
  See
  > it is irrelevant what a, b, x, and y are and even more *irrelevant how they might happen to be represented in terms of more primitive data*
- > is will further blur the distinction between “procedure” and “data,” which was already becoming tenuous toward the end of chapter 1
  Since procedure can be the argument and the returned value.
- [closure](https://en.wikipedia.org/wiki/Closure_(mathematics)), i.e. codomain $\subseteq$ domain.
  Also see footnote 6.
- data-directed programming is different from [Data-driven programming](https://en.wikipedia.org/wiki/Data-driven_programming)
  TODO how it is implemented?
- > e names car and cdr derive from the orig-inal implementation of Lisp on the  
  See [this](https://www.iwriteiam.nl/HaCAR_CDR.html) and [wikipedia](https://en.wikipedia.org/wiki/CAR_and_CDR) "does not quite match the IBM 704 architecture"
  - [manual](https://www.softwarepreservation.org/projects/LISP/book/LISP%201.5%20Programmers%20Manual.pdf)
    TODO "as parts of trees"
- > wishful thinking
  i.e. as CS61AS says we also use this in induction for hypothesis.
#### 2.1.3
The key is "procedures plus *conditions*".
> is use of procedures corresponds to nothing like our intuitive notion of what data should be.
- `(error "Argument not 0 or 1: CONS" m)` is a bit ambiguous since `cons` needs 2 arguments
  Here it means `car/cdr` is used wrongly.
- [Message passing](https://en.wikipedia.org/wiki/Message_passing#:~:text=In%20computer%20science%2C%20message%20passing,and%20run%20some%20appropriate%20code) Here index is the message.
### 2.2
#### 2.2.1
- TODO [closure in lisp](https://www.gnu.org/software/emacs/manual/html_node/elisp/Closures.html#:~:text=A%20closure%20is%20a%20function,use%20the%20retained%20lexical%20environment.)
- > In Pascal the plethora of declarable data structures induces a specialization within functions that inhibits and penalizes casual cooperation.
  This may be due to "declarable" which implies the type restriction.
- > e names car and cdr persist *because* simple combinations like cadr are pronounceable. 
  relation may be [due to primitives](https://ell.stackexchange.com/a/116218)
  > CA, CD, AR and DR
- `null? items` is one wrapper of `(equal? items '())`.
- > In effect, map helps establish an abstraction barrier that isolates the implementation of procedures that transform lists from the details of how the elements of the list are extracted and combined
  i.e. `proc` and `cons, car`, etc.
#### 2.2.3
- > higher-order procedures, can capture common paerns in programs
  See `(sum term a next b)`.
- > the accumulation is found partly in the tests
  more appropriately: tests are done first to filter then we do "the accumulation".
  - > mingling it with the map, the filter, and the accumulation
  i.e. `(square tree)`, `(odd? tree)`, `+ ...`.
- > for each pair (i, j) that passes through the filter, produce the triple (i, j, i + j).
  IMHO it is ok to be still pair.
- > We’re representing a pair here as a list of two elements rather than as a Lisp pair.
  Since this is more convenient for `accumulate`, etc.
#### 2.2.4
- Here `frame` defines where we are allowed to draw (see Figure 2.15).
  And `painter` defines ~~what~~ how to draw (see `segments->painter`).
  We should call ~~`((painter frame) segment-list)`~~ `((segments->painter segment-list) frame)` based on definitions here.
- > new end of edge1
  See Figure 2.15
- > Observe how the painter data abstraction, and in particular the repre-sentation of painters as procedures, makes beside easy to implement.
  i.e. we don't need to care about the detailed implementation (if using pure data structure, we at least needs constructor and selectors for further complexer manipulation).
- > We could work at the lowest level to change the detailed appearance of the wave element; we could work at the middle level to change the way corner-split replicates the wave; we could work at the highest level to change how square-limit arranges the four copies of the corner.
  So it just means using *nested* function calls.
### 2.3
This is more appropriate to be put in one data structure course especially for 2.3.3.
- > as a way of isolating the *abstraction* of a “binary tree” from the particular way we might wish to *represent* such a tree in terms of list structure.
  See
  > isolate how a compound data object is *used* from the details of how it is *constructed* from more primitive data objects.
- Huffman trees
  - See DMIA 11.2.4 Prefix Codes although it doesn't say in detail.
- > We will not prove this optimality of Huffman codes here
  See DMIA 11.2 Exercise 32 for proof.
- > and the element being added to the set is never already in it.
  This is already ensured in Exercise 2.61.
### 2.4
- [principle of least commitment](https://pages.cs.wisc.edu/~dyer/cs540/notes/pop.html#:~:text=The%20principle%20of%20least%20commitment,later%2C%20hence%20avoiding%20wasted%20work.)
  >  never making a choice *unless required* to do so
- >  these definitions are now internal to different procedures (see Section 1.1.8),
  See "Local names"
- `(get op type-tags)` implies using `list` for `type-tags`.
  ~~so what if type is `'polar`?~~
  so we need to separately manipulate cases of `'polar` by `(get 'make-from-real-imag 'rectangular)`, etc.
  - we don't use list similar to `(put 'angle '(polar) angle)` for make-from-real-imag since the latter can accept ~~merely scheme internal data~~ many arg types like `(real real)` or `(rat rat)`.
  - For section 2.5, `(put 'make 'polynomial (lambda (var terms) (tag (make-poly var terms))))`
    considers *many term types*, so which is similar. ~~different from the above.~~
- > To design such a system, we can follow the same data-abstraction strategy we followed in designing the rational-number package in Section 2.1.1
  i.e. constructor and selector.
  > using the “abstract data” specified by the constructors and selectors, just as we did for rational numbers in Sec-tion 2.1.1
- > by having each operation take care of its own dispatching.
  i.e. `cond` in `real-part`, etc.
- > We have already seen an example of message passing in Section 2.1.3
  See `dispatch`.
- `(put 'make-from-real-imag 'rectangular (lambda (x y) (tag (make-from-real-imag x y))))`
  Here type doesn't means arg types, so we can't use `apply-generic`. We should use `((get 'make-from-real-imag 'rectangular) x y)`.
### 2.5
- > Notice how the underlying procedures, originally defined in the rectangular and polar packages, are exported to the complex package
  ~~i.e. just put them in `install-complex-package`.~~ See `(get 'make-from-real-imag 'rectangular)`.
  - notice here it restrict `make-from-real-imag` to use the convenient type.
- > we can have it search the “graph” of relations among types and automatically generate those coercion procedures that can be inferred from the ones that are supplied explicitly.
  See SDF Exercise 2.11
- knowledge representation
  [see](https://en.wikipedia.org/wiki/Knowledge_representation_and_reasoning#:~:text=%22A%20knowledge%20representation%20(KR),than%20taking%20action%20in%20it.%22)
  > determine consequences by thinking rather than acting
- TODO
  > we need to write only one procedure for each pair of types rather than a different procedure
  ~~shouldn't 2 for 2 directions?~~
  Here it may mean we shouldn't write all in one func with multiple cond cases.
- [syntactic form](https://cs.brown.edu/courses/csci1730/2008/Manual/reference/syntax.html#:~:text=Each%20syntactic%20form%20is%20described,%2Dform%20id%20...)) -> BNF for example.
- `(adjoin-term term term-list)` assumes join one higher-order term at the head of the list.
  > so long as we guarantee that the procedures (such as add-terms) that use ad-join-term always call it with a *higher-order term than appears in the list*
- > Neither of these types is “above” the other in any natural way,
  since one polynomial like `y^2*x` may be thought as both types.
- > Our own discussion of computational objects in Chap-ter 3 avoids these issues entirely. Readers familiar with object-oriented programming will notice that we have much to say in chapter 3 about local state, but we do not even mention “classes” or “inheritance.”
  inheritance -> "interrelated types".
## lec
### lec05
It says about `list` which has not been said up to the book corresponding chapter.
- ~~TODO~~ cast in "Typecasting" means
  > the arguments are *mapped* to the return value
- > The following expressions evaluate to values of what type?
  trivial: number, string, number.
- > basis for many analysis and optimization algorithms
  TODO after algorithm:
  choose the correct type like floating precision?
- > the result obtained by creating a compound data structure can itself be treated as a *primitive object* and thus be input to the creation of another compound object
  [See](https://en.wikipedia.org/wiki/Closure_(computer_programming)#History_and_etymology)
  > adds data to a data structure to also be able to add *nested* data structures
  Here type implies ["subset"](https://en.wikipedia.org/wiki/Closure_(mathematics))
  See `(cons (cons 1 2) 3)` where `(cons 1 2)` input generates the *same type* `cons`.
- > Note that lists are closed under operations of cons and cdr.
  ~~TODO why not have car.~~ See p6.
- > relies on closure property of data structure
  i.e. `(rest lst)` has the same type of `lst`.
- > Schizophrenia can be a solid foundation for good programming style
  i.e.
  > Frequently the same person/people
### lec06 (This seems to have no corresponding book chapter) very helpful with Debugging introduction
- `(prime? temp1 temp2)` has worse complexity $O(n)$
  - B doesn't have 2, 3 and 4.
- > Why is optimization last on the list?
  i.e. it can be achieved partly by hardware. So software optimization may be unnecessary.
- `d,n` -> denominator, numerator.
- DrScheme is now [DrRacket](https://linguisticlogic.wordpress.com/2010/06/15/plt-scheme-is-now-racket/).
- p4 
  Here the last code does point 2 and 4. It also does partially for point 1.
- `(cons "a" (cons "b" '()))` is list by list definition.
  - `(lambda (x) (if x 1 0))`: any -> number.
- p5~7 as the title says they are reviews and have much overlap with the former lec.
- > f the operands have the specified types, the procedure will result in a value of the specified type
#### 6.037 lec 5 (almost same as the above but uses Drracket)
- Differences start from "Dealing with bugs in your code" until "Documenting code".
  Then 
  - See "Choosing good test cases", “What will this change break?” to "How to write tests".
- "Questions to ask" is almost same as GitHub issue request templates.
- "Make no assumptions?" is wrong.
- > You can keep maybe about 50k LOC in your head at once
  crazy (LOC: line of codes).
- ["continue to this point"](https://docs.racket-lang.org/drracket/debugger.html#(part._.Definitions_.Window_.Actions))
### lec08 (no corresponding rec)
- > creating a new task-specific language
  i.e. "Levels of language for robust design"
- `(y-axis rect)` in `(rotate90 pict)` ~~seems to be wrong. (see `(make-vect 1.0 1.0)` in book `rotate90`).~~ is correct since `make-frame` calculates the relative coordinates based on origin.
### lec09
Not said in SICP book ("A better implementation" same as the book)
> The direct implementation works, but...
not use
> nested if expressions
- > The object pi, passed as the first argument to integer->flonum, is not the correct type.
  it seems that the interpreter manipulates data from right to left.
- > Clues about “guts” of Scheme
  i.e. details
- > We say that the new binding for y “shadows” the previous one
  [See](https://docs.racket-lang.org/rebellion/Association_Lists.html#:~:text=Duplicate%20keys%20are%20allowed%2C%20and,are%20in%20the%20same%20order.)
- > Do not allow rest of program to use list operations
  i.e. give one interface to modify data.
- > Isolating changes to improve performance
  Here `make-sum` can be simplified at least to the book one which contains the former 4 cases of `simplify-sum`.
### lec10
- > 1. Eval for sums of numbers
  based on section 2.3 but will eval.
  - It also gives one *step-by-step process* of how we get one good implementation.
- TODO
  - `range-add-2` seems to be learned somewhere in the book.
- notice
  > when checking types, use the else branch *only for errors*
## recitation
### 5
- See Problem 1-(a) and (c).
- I don't know why in Problem 1 printing, (d) has no `.` but (a) has.
  Maybe by `(cons 1 (cons 2 (cons 3 ’())))` we have no `.` when we *link* to one object.
- Problem 1-(d) has the same form as `(list 0 (list 1 2))` but the latter prints `(0 (1 2))` to distinguish between them.
- 5 See answer
  - `(zero? d)` checks parallel condition.
  - See [this](https://stackoverflow.com/a/565282/21294350) and [this](https://www.nagwa.com/en/explainers/175169159270/) for 2d cross product.
    Here $p$ is the 1st segment starting point and $s$ is the 2nd segment line vector.
    $$
    \begin{align*}
      q-p&=(x3-x1,y3-y1)\\
      s&=(x4-x3,y4-y3)\\
      r&=(x2-x1,y2-y1)\\
      (q-p)\times s=(y4-y3)\cdot(x3-x1)-(x4-x3)\cdot(y3-y1)=(x4-x3)\cdot(y1-y3)-(y4-y3)\cdot(x1-x3)=n1\\
      (p-q)\times r=(x1-x3)\cdot(y2-y1)-\ldots
    \end{align*}
    $$
### SP 7
- correction to some codes. See `rec07.scm`.
- > "know" that the real representation is (2 5 2 2), and depend on it
  i.e. may throw error.
  ~~Here `pf1` can be ~~
- > (that makes the operators readable and efficient)
  IMHO "efficient" depends on the application.
  - Also see lec p2 and p4.
- > Error Checking is Your Friend
  See lec p6 and p7 Testing.
### 7 (no corresponding SP lec with the related name. But Lec07 may be appropriate here)
- `fold-right` See SP Lec07.
- [ ] 3 calls 3 `map`.
  - See sol. The above is not general.
- [ ] 4
  1. `map`
  2. `filter`
  3. `map`
  4. `filter` then iter.
  5. I don't know. Probably `fold-right` since it is one number.
  6. `(fold-right (lambda (a b) (if (= (length b) 1) b)) 0 x)`
  7. sol `append` has $\Theta(n)$, so totally $\Theta(n^2)$.
  8. See sol.
### 8
- > like eq? except it “works on” numbers as well.
  I won't dig into details in [R7RS](https://standards.scheme.org/corrected-r7rs/r7rs-Z-H-8.html#TAG:__tex2page_index_314)
- [x] 4 trivial by mimicking
- [ ] 5
- [ ] 6 see ans
### 11
- `poly-get-terms` is better to be similar to `poly-get-var`.
- [x] 2 it is better to check types and throw errors appropriately.
- [x] 3 trivial
- [x] 4 (here the answer assumes using "represented as lists of the coefficients")
- [ ] 5 see book
  - Here it still uses the assumption in 4. So it is different from the book but easier.
  - `(cons (add (car (poly-get-terms p1))` may assume `p2` must be constant.
- [x] 6 trivial
- [x] 7 just 4 `cond` cases.
- [x] 8 all to `(->poly (find-var e1 e2) exp)`, then `add-poly`.
  - sol avoid const->poly when both exp's are const.
# chapter 3
## book
### 3.1
- > Until now, all our procedures could be viewed as specifications for comput-ing mathematical functions.
  By searching "!" backwards, it is true at least for procedures the book taught.
- > We have already used begin implicitly in our programs
  [See](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Sequencing.html#index-begin)
- `make-account` uses "message-passing style" since adding op will be so easy (see exercise 2.76)
- > Our pro-gramming language can no longer be interpreted in terms of the sub-stitution model of procedure application that we introduced in Section 1.1.5.
  Since value is time-variant.
  - See `((make-simplified-withdraw 25) 20)` example.
- > e issue surfacing here is more profound than the mere breakdown of a particular model of computation.
  i.e. the issue in the preface of section 3.1.3.
- > A language that supports the concept that “equals can be substituted for equals” in an expression without changing the value of the expres-sion is said to be referentially transparent.
  IMHO i.e. not use `set!` etc. here -> `(make-decrementer 25)`
- > But this view is no longer valid in the presence of change, where a com-pound data object has an “identity” that is something different from the pieces of which it is composed.
  See `~/SICP_SDF/lecs/6.001_spring_2007_lec/Lect15-oops-1.pdf`
  > Each instance has its own identity *in sense of eq?*
  [and](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Equivalence-Predicates.html#index-eq_003f) (i.e. book "In Lisp, we consider this “identity” to be the quality that is tested by eq?, i.e., by equality of *pointers*.")
  > obj1 and obj2 are *pairs*, vectors, strings, bit strings, *records*, cells, or weak pairs that denote *the same locations* in the store.
  Here "identity" means *unique identifier* of one object.
  - > A bank account is still “the same” bank account even if we change the balance by making a withdrawal; con-versely, we could have two different bank accounts with the same state information.
    here we can use location to understand or just think account as being someone's where we use the *owner* to identify.
    > is complication is a consequence, not of our program-ming language, but of our perception of a bank account as an *object*.
    - > We do not, for example, ordinarily regard a rational number as a change-able object with identity, such that we could change the numerator and still have “the same” rational number.
      IMHO it is more appropriate to say "could change the numerator" but have different rational number. Compare this with "... “the same” bank account even if we change the balance ..."
- cost
  1. > Moreover, no simple model with ``nice'' mathematical properties can be an adequate framework for dealing with objects and assignment in programming languages.
    since "Assignment" makes "functional programming" fail.
    > A language that supports the concept that ``equals can be substituted for equals'' in an expresssion without changing the value of the expression is said to be referentially transparent. Referential transparency is *violated* when we *include set!* in our computer language.
  2. > In general, programming with assignment forces us to *carefully consider the relative orders of the assignments* to make sure that each statement is using the correct version of the variables that have been changed.
  - > *First*, however, we will address the issue of providing a computational model for expressions that involve assignment
    IMHO environmental model since that is taught in section 3.2 immediately after 3.1. 
### 3.2
- Figure 3.3:
  "the text of the lambda expression" -> "parameters" and "body".
  "a pointer to the environment" -> the right dot circle.
  "binding the formal parameters of the procedure to the arguments of the call" -> "x:5".
- > is is convenient because it allows redefinition of symbols;
  For racket this doesn't hold.
  > Because of this, some people prefer redefinitions of existing symbols to signal errors or warnings.
- Compare Figure 3.8 with Exercise 3.9, ~~the former will use `set!` to *set* local variable but the latter just *passes* the result of `(- n 1)`. So the former will make `E2` be based on `E1` while the  latter doesn't.~~
  > because this is the envi-ronment that is specified by the W1 procedure object.
  The former ~~has `W1` as one new procedure.~~ `(W1 50)` is actually `((lambda (amount) ...) 50)` which is in `(make-withdraw balance)`, i.e. `E1`.
  But the latter does `(factorial (- n 1))` which is just creating one new `factorial` and the caller is also `factorial`. So all of them are in "the global environment".
- `(define (make-withdraw initial-amount) (let ((balance initial-amount)) ...))` is similar to `(define new-withdraw ...)`.
- > simply by using parameter names as free variables.
  i.e. they are [*defined externally*](https://en.wikipedia.org/wiki/Free_variables_and_bound_variables#Formal_explanation) <a id="free_variable_def"></a>
  > In computer programming, the term free variable refers to variables used in a function that are *neither local variables nor parameters* of that function.
  parameters:
  > In the lambda calculus, x is a bound variable in the term M = λx. T and a free variable in the term T. We say x is bound in M and free in T.
  [local variables](https://en.wikipediba.org/wiki/Local_variable#Local_variables_in_Perl)
  - Here `x` is not "parameters" of `good-enough?`.
    There is no `(define x ...)` in `good-enough?` so it is also not "local variables".
    See how "local variables" work:
    ```scheme
    (define (test-1 x)
      (define (test-2)
        (define x 2)
        (display (list "inner" x)))
      (test-2)
      (display (list "outer" x)))
    (test-1 1)
    ```
  - Also see https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-10.html#%_sec_1.1 "For example, in the square-root problem we can write"
    when running `(sqrt 5)` we creates one new frame with x->5 binding, then all later `define`s are also added to that frame.
    So "local" and "parameter" are thought *similarly* for Scheme, probably also for other languages.
    - https://en.wikipedia.org/wiki/Lambda_calculus#Free_and_bound_variables doesn't think about "local variable" since it has no something similar to `define`.
### 3.3
- IMHO Figure 3.16 is wrong since although `(car z1)` is right, `(cdr z1)` is `(b)`.
  See xxyzz/SICP Exercise 3.15.
- > Since Scheme provides no way to mutate a symbol, this *sharing* is undetectable.
  TODO we can detect this by `(eq? (caar z2) (cadr z2))`.
- `(define (set-car! z new-value) ...)` defined the returned value as `z` but that is [not necessary](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Pairs.html#index-set_002dcar_0021).
- > we mentioned in Section 2.3.3 the task of maintaining a table of records in-dexed by identifying keys.
  ~~It should be 2.4.3.~~ See "Sets and information retrieval".
- > we build the table as a headed list
  Here "headed list" just means [Linked List](https://www.andrew.cmu.edu/course/15-121/lectures/Linked%20Lists/linked%20lists.html)
- > In order to have a place that we can change when we add a new record to the table, we build the table as a headed list. A headed list has a special backbone pair at the beginning, which holds a dummy “record”
  See `(insert! key value table)` which inserts at the *head of actual records* for efficiency.
  and CS61A notes
  > That is, even in an “empty” table we have a pair to set-cdr!
- Why use `(list key-1 ...)` for `(insert! key-1 key-2 value table)`: see Figure 3.23 math part.
  - See book p135
    > e entire sequence is constructed by nested cons operations: ...
    Here we adds the nil at the end to ensure base case `((null? records) false)` in `assoc` work (same for `(list '*table*)` in `(make-table)`).
- > These gluing pairs are called the backbone of the table
  For Figure 3.22, i.e. the 1st row.
- TODO
  - > event-driven simulation
  - When is `(propagate)` run?
- [half adder](https://en.wikipedia.org/wiki/Adder_(electronics)#Half_adder) where [XOR](https://en.wikipedia.org/wiki/XOR_gate#AND-OR-Invert) is different from book.
  Here D gets 3 cases (0,1) or (1,1) and the AND-invert removes (1,1) then. This is similar for wikipedia where the 1st OR-Invert allows (1.0) or (1,1) and then the AND gate needs 0 which  excludes (1,1).
- > Figure 3.28
  IMHO this is so similar to "circuit".
  Also see the `celsius-fahrenheit-converter`, `probe` etc codes.
- > e connector complains that it has sensed a contradiction
  This is similar to that we are trying to update one output but that will be *also* generated by some inputs.
  - > is new value, when propagated through the network, forces C to have a value of 100, and this is registered by the probe on C.
    notice this is *bidirectional* due to "relation".
- `forget-value!` may set to one symbol `?` so `(process-new-value)` will reset then.
- `(eq? request 'I-have-a-value)` etc correspond to `inform-about-value` etc.
- As the example `(forget-value! C 'user)` shows, `forget-value!` for *one* value will also make other related values forgotten.
- > This is useful if we wish to extend the system with new operations that communicate with constraints directly rather than only indirectly via operations on connectors.
  IMHO this may mean in `(celsius-fahrenheit-converter c f)` abstraction, `adder` can be directly manipulated but in `(celsius-fahrenheit-converter x)` this is abstracted in `c+`.
  > Although it is easy to implement the expression-oriented style in terms of the imperative implementation, it is very difficult to do the converse.
  By seeing `(adder a1 a2 sum)` implementation, `(- (get-value sum) (get-value a1))` can be done by `(c+ sum (- a1))`. Others are all operations of "connector".
- > it is used only to speed up the execution of a sequential instruction stream, while retaining the behavior of the sequential program.
  As COD shows, `pipelining` is just one strategy for one CPU core. Multi-core needs more complex sync strategies.
- > Most computers have interlocks on the primitive *memory-write* operations
  [interlock](https://en.wikipedia.org/wiki/Interlock_(engineering)#Microprocessors) -> https://en.wikipedia.org/wiki/Hazard_(computer_architecture)#Write_after_write_(WAW)
### 3.4
- > the loss of referential transparency
  [See](https://www.baeldung.com/cs/referential-transparency#:~:text=Referential%20transparency%20is%20a%20property,get%20the%20same%20returning%20value.)
  This corresponds to footnote 33.
  > giving rise to a thicket of questions about sameness and *change*
  > the need to abandon the substitution model of evaluation in favor of the more intricate environment model.
  since we may change "local state"
- > Each process repeatedly changes its value to the average of its own value and its neighbors’ values. is algorithm converges to the right answer independent of the order in which the operations are done;
  By physics, this is easily proved by "law of conservation of energy".
  I won't prove this by mathematics.
  > there is no need for any restrictions on concurrent use of the shared val-ues.
- > Peter might compute the difference in the balances for a1 and a2, but then Paul might change the balance in a1 before Peter is able to complete the exchange.
  If Peter does before Paul, then Paul should calculate "difference" based on a2 and a3 instead of a1 and a3.
- > e test-and-set! operation must be performed atomically. 
  As csapp and COD shows, this is done by one instruction (this [may be](https://stackoverflow.com/a/1091448/21294350) atomic).
  "atomically" just means "serialize".
- > one cannot physically construct a *fair* arbiter that works 100% of the time
  see ostep 28.4 Evaluating Locks where absolutely fair is impossible.
  > because it is incapable of deciding which to go to first.
  Here it just shows equality makes "fair" decision impossible.
- > Suppose that Peter’s process reaches the point where it has entered a serialized procedure protecting a1 and, just aer that, Paul’s process en-ters a serialized procedure protecting a2.
  ~~IMHO this can't happen for `serialized-exchange` since both mutexes are acquired when using args `account1 account2` by `(serialized-p . args)`.~~
  is related with the solution
  > a process will always aempt to enter a procedure protecting the lowest-numbered account first.
  which is same as what csapp says.
- > Situations where deadlock can-not be avoided require deadlock-*recovery* methods, which entail having processes “back out” of the deadlocked state and try again.
  This is said in OSTEP 32.3 "Detect and Recover", but not in detail.
- > where due to optimiza-tion techniques such as pipelining and cached memory, the contents of memory may not be in a consistent state at every instant.
  See COD (same for footnote 49) and csapp.
- See ["Note: The eieio instruction ..."](https://www.ibm.com/docs/en/aix/7.2?topic=set-eieio-enforce-in-order-execution-io-instruction) for the difference between eieio and sync.
- TODO serializer diff "barrier" concurrency
  IMHO the former inhibits concurrency while the latter doesn't (at least partly allow).
- > when should we say that the account balance has changed—when the balance in the local branch changes, or not until aer the synchronization?
  this is similar to cache and main memory.
- TODO footnote 50 about economics.
### 3.5
- [worldline](https://web.physics.ucsb.edu/~fratus/phys103/LN/SR3.pdf) (notice Figure 1,2 are about "*one-dimensional* trajectory")
  i.e. ["space-time"](https://phys.libretexts.org/Bookshelves/Relativity/Spacetime_Physics_(Taylor_and_Wheeler)/05%3A_Trekking_through_Spacetime/5.04%3A_Worldline)
- > If the consumer attempts to access a part of the stream that has *not yet been constructed*, the stream will automatically construct just enough more of itself to produce the required part
  see [doc][scheme_stream_doc]
  > except that the *tail* of a stream is *not computed until it is referred to*.
  > Returns a newly allocated stream pair. Equivalent to (cons object (*delay* expression)).
- > e fact that we are defining such similar procedures for streams and lists indicates that we are missing some underlying abstraction.
  IMHO this means we should have one option to choose between `stream-ref` and `list-ref` instead of just mimicking with the *same structure*.
- > the cdr of a stream to be evaluated when it is accessed by the stream-cdr procedure rather than when the stream is constructed by cons-stream.
  see [scheme_stream_doc]
  > Returns the *first tail* of stream. Equivalent to (*force* (cdr stream))
  notice here `force` can only [force one `delay`][scheme_promise_doc] (see `(force (cdr (list->stream '(1 2 3))))`)
  - i.e. the book
    > stream-cdr selects the cdr of the pair and evaluates the delayed expression
- > evaluating (cons-stream ⟨a⟩ ⟨b ⟩) would automatically cause ⟨b ⟩ to be evaluated
  due to (see [applicative-order](https://rivea0.github.io/blog/applicative-order-vs-normal-order))
  > Lisp uses applicative-order evaluation
- `(delay ⟨exp⟩)` implementation implies why *thunk* is always used.
- > In other words, we implement delay as a special-purpose memoized procedure similar to the one described in Exercise 3.27
  just as the [scheme_promise_doc] says
- `(memo-proc proc)` only works for the case where one specific delay is called multiple times.
  But if there are 2 distinct `(delay proc1)`, then we can't memoize when calling the 2nd as expected.
- call-by-name [diff](https://softwareengineering.stackexchange.com/a/194713) "Normal order evaluation"
  > Thus normal order evaluation leaves open the possibility of memoizing the arguments as an optimization (sometimes called call-by-need), while call-by-name does not. Thus one could say that call-by-name evaluation is a *special case of normal order* evaluation.
  so call-by-need, call-by-name < normal order evaluation < Non-strict evaluation (< means "is included in") which also containes (same as book "e memoizing optimization is also known as call-by-need.")
  > Boolean expressions in many languages use a form of non-strict evaluation called *short-circuit evaluation*, where evaluation evaluates the left expression but *may skip the right expression* if the result can be determined
  - also see
    > Normal order evaluation uses complex structures such as *thunks* for unevaluated expressions, compared to the call stack used in applicative order evaluation.
    "stack" is to help return back to the caller.
  - https://cs.stackexchange.com/a/7703/161388 is similar to Exercise 1.5.
    $\lambda x.(x \  \ x) \  \lambda x.(x \ \  x) \to \lambda x.(x \  \ x) \  \lambda x.(x \ \  x)$ -> (p) to (p)
    normal-order: both drops the evaluation of the above loop in some way although not same.
- [Sieve of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes#Overview)
  here "Sieve" means being *not one multiple* of some number.
- TODO
  - > We have named these figures after Peter Henderson, who was the first person to show us *diagrams* of this sort as a way of thinking about *stream processing*
    google image "Henderson diagram Peter Henderson stream" has no related results
- > (define (prime? n) ...)
  This is different from section 1.2.6 `prime?` definition since it only checks for *prime* smaller.
  - `(divisible? n (stream-car ps))` ~~should be `(divisible? (stream-car ps) n)` if using `divisible?` in section 1.2.6.~~ is based on `divisible?` in this section.
- > either n is not prime (in which case there is a prime already generated that divides it)
  based on "Prime Factorization"
- > pro-viding many of the benefits of local state and assignment.
  IMHO i.e. only calculate the current element and 
  assignment: `force` in the future
- I skipped proving [Leonhard Euler's "sequence accelerator"](https://en.wikipedia.org/wiki/Series_acceleration#Euler's_transform)
- > e tableau has the form
  Here $s_{i\cdot}$ is the $i$th stream.
- > appear as element number f (i, j)
  i.e. not infinite.
- > We began our discussion of streams by describing them as computa-tional *analogs of the “signals”* in signal-processing systems. 
  See "Figure 3.31".
- > if Sn is the nth term of the original sum sequence, then the accelerated sequence has terms
  this term corresponds to $S_{n-1}$ in the new sequence, so we need $n\ge 1$
- > we can implement an integrator or summer that ...
  IMHO this is one "partial sum" "integrator".
  - so `int` recursive call in `int`.
- > we could try to model this system using the procedure
  notice here `(stream-map f y)` is actually `dy/dt`, then we have $\int \frac{dy}{dt}\cdot dt=\int dy=y$ where the last step is based on `y0`.
- > One way of dealing with this problem is illustrated by the language ML
  [See](https://courses.cs.washington.edu/courses/cse341/02wi/functional/basics.html)
  > In fact, functions in ML can *only take one argument*. We can write functions which take multiple arguments by having them take *tuples of arguments*
- TODO [ML type-inferencing](https://en.wikipedia.org/wiki/Hindley%E2%80%93Milner_type_system)
- > Even the single delay in cons-stream can cause great confusion, as illustrated by Exercise 3.51 and Exercise 3.52. As far as anyone knows, mutability and delayed evaluation do not mix well in programming lan-guages
  see Exercise 3.52 where the result of stream depends on each other and the order, which may be  inappropriate since stream is one sequence as one *single object* (i.e. "world line").
- [Cesàro experiment](https://www.perlmonks.org/?node_id=1200927)
  also see section 3.1 "monte-carlo".
  - > There is considerable modularity in this approach, because we still can formulate a general monte-carlo procedure that can deal with arbitrary experiments. Yet there is no assignment or local state.
    See section 3.1 "monte-carlo" -> `cesaro-test` which uses `rand` with "assignment" and "local state".
#### 3.5.5
- > We constructed computational objects with local state variables
  see
  > we make computational objects (such as bank ac-counts ...
- > there is no assignment, no local state variable
  just iter (see "Formulating iterations as stream processes" and "Pitfalls of imperative programming" where stream is more appropriate to substitute iter).
- > However, from the perspective of the particle’s world line in space-time there is no change involved.
  IMHO the space-time graph actually change although it is the "same" object if thinking of its stored location.
- > raise thorny problems of constraining the order of events and of synchronizing multiple processes
  See "Pitfalls of imperative programming" for "the order of events" and section 3.4 for "synchronizing multiple processes" where *at least these* use "assignment".
  - also see
    > all procedures implement well-defined mathematical functions of their arguments
- > gave high *visibility* to functional programming
  i.e. [prospective](https://softwarefordays.com/post/fp-advantages-synopsis/#:~:text=John%20Backus%20%E2%80%9Cgave%20high%20visibility,%2B%2B%20and%20thirteen%20before%20Java.)
- > Observe that, for any two streams, there is in general more than one acceptable or-der of interleaving
  maybe due to that we only ensure "meeting" results are reasonable.
- > Thus, technically, “merge” is a relation rather than a function—the answer is not a deterministic function of the inputs.
  [see](https://qr.ae/p2Usss) and [many-to-many relation](https://www.cuemath.com/algebra/relations-in-math/)
  > many-to-many mappings
- > e merge rela-tion illustrates the same essential nondeterminism, from the functional perspective
  i.e. although this function has one deterministic result when rerun, but this result can be nondeterministic.
- > Each view has powerful advantages, but neither view alone is completely satisfactory
  - advantage of stream but disadvantages of assignment:
    > Part of the power of stream processing is that it lets us *ignore the order in which events actually happen* in our programs. Unfortunately, this is precisely what we cannot afford to do in the presence of assignment, which forces us to be concerned with time and change.
    due to `delay`.
  - disadvantages of stream:
    > Unfortunately, including delays in procedure calls wreaks havoc with our ability to design programs that depend on the order of events, such as programs that use assignment, mutate data, or perform input or output.
    i.e. make the *original reasonable programs* difficult to understand and possible with different results based on the context (see exercises 3.51 and *3.52*).
    - advantage of assignment
      maybe better to constrain the running order.
  - TODO summary of more comparisons.
- > Yet the system has state!
  Here "Yet" means "the system has state" but "the stream version" to simulate that system doesn't have.
- > so that we *decouple time in our simulated world from the sequence of events* that take place during evaluation. Indeed, because of the presence of delay there may be *little relation between simulated time* in the model and the *order of events* during the evaluation.
  compare this with
  > By doing this we make the *time of execution* of a computation model *time in the world* that we are part of, and thus we get ``objects'' in our computer.
  "simulated time" -> "time in the world".
  Here if we run the program, it is unknown when `cdr` of `cons-stream` will be calculated, so "decouple".
  - > On the other hand, if we look closely, we can see time-related problems creeping into *functional models* as well ... it must interleave the two transaction streams in some way that is constrained by *``real time''* as perceived by Peter and Paul
    Here stream "do not include any provision for assignment or mutable data.", so functional. <a id="stream_implies_functional"></a>
    > If the user could step back from the interaction and think *in terms of streams* of balances rather than individual transactions, the system would appear *stateless*.
- > Unifying the object view with the functional view may have little to do with programming, but rather with fundamental epistemological issues.
  object -> assignment -> not functional.
## lec
~~TODO read stream lec since [wayback machine is hacked temporarily](https://www.theverge.com/2024/10/11/24268040/internet-archive-data-breach-outage-hacked).~~
I skipped Message Passing rec since 1. up to now I haven't get more knowledge from recalculate beside what the book taught ~~2. these rec are much ~~.
### 11
- > operations
  See book
  > We could imagine an *operation add-rat* that takes two rational numbers and produces their sum.
- `set!` is special form since as the book says
  > Each special form has its *own evalu-ation rule*
  here this means `x` is not evaluated at all.
- `(define b (list 1 2))` [See](https://standards.scheme.org/corrected-r7rs/r7rs-Z-H-8.html#TAG:__tex2page_index_616), so `b` is not influenced by changing `a`.
- > (set-car! x y)
  `((1 2) 4)`
  > (set-cdr! y (cdr x))
  `((1 4) 4)`
- > Stack does not have identity
  i.e. have multiple locations.
  - > Provides an object whose identity remains even as the
    See "3.3.3  Representing Tables"
  - > User should know if the object mutates or not in order to use the abstraction correctly.
    i.e. IMHO it mutates the original stack.
- > We’ll attach a type tag as a defensive measure
  ensure doing operations on *the appropriate type*
  See [Defensive programming](https://en.wikipedia.org/wiki/Defensive_programming)
  - So this is better than SICP "3.3.2  Representing Queues".
### 12 (bst is introduced in chapter 2)
- > Sort & *merge*
  [See](https://www.scaler.com/topics/merge-two-list-in-python/) where "merge" means concatenate
- `(define (list-ref lst n)` similar to 2.2.1 p138 assuming lst is not nil.
  So `(or (null? lst) (zero? n))` is better.
- `(list-head! lst n)` better to check len.
- `append!` is better than Exercise 3.12 due to considering the case where x is nil.
- `Reverse` also [see](http://community.schemewiki.org/?sicp-ex-2.18)
- `Reverse!` see http://community.schemewiki.org/?sicp-ex-3.14
- See `filter.scm` where we can also make `filter` with `S(n)=\Theta(1)`.
- `fold-left` is same as [MIT/GNU Scheme](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Folding-of-Lists.html#index-fold_002dleft) (notice `fn` arg order)
- "Sorting a list" i.e. [merge sort][merge_sort]
- `(merge x y less?)` is ~~same~~ similar to [`adjoin-set`](http://community.schemewiki.org/?sicp-ex-2.61).
- [GIGO](https://en.wikipedia.org/wiki/Garbage_in,_garbage_out)
- merge!
  - `(reverse! (cdr yroot))` is implied by `(set-cdr! current ans)`
    so `ans` is the reverse of the temp result.
  - IMHO `merge!` is less intuitive since we don't know how `!` mod does for x and y which may influence the later recursion.
  - The latter 2 conditions
- > Finding midpoint of list is expensive
  we use `list-tail` and `length` (see SICP p138) where both are Theta(n).
  > Instead, nibble away from left
  interesting by not using splitting idea.
- Trees See "2.2.2 Hierarchical Structures".
- `tree-fold` may use `init` multiple times since each `fold-right` will use once.
  So it does `fold` for subtrees of the root and recursively for each subtree ...
- `make-leaf-set` See SICP p226 which will sorts in parallel.
### 13
I skipped reading context of biology.
- > Want to evaluate likelihood of path to a leaf of the tree, and compare to other paths to leaves
  TODO leaf -> match?
- It's gotta -> It's got to -> It has got to -> has to.
- kw
  Distance Metric
- 2-D Table same as [@meteorgan Most astute](http://community.schemewiki.org/?sicp-ex-3.25)
- "Non-Abstract but Compact!" same as the book for "2-D Table".
- "Table2 is a table of Table1’s" see "Figure 3.23".
- `table2-set!` is more structural than book p365 `insert!`.
- `omitted` means omitted by x.
- see p6 figure for why $3^n$ where i has depth n and all d -> all m has depth 2n.
  it must have $O(3^{2n})$ (TODO why $\Theta(3^n)$).
- `(- new score)` is due to the same reason as `(+ old score)` that we get the score based on history (see recursive calls of `helper` in `(match0 one two)`).
- `(bestfsearch start-state)`
  first selects `0.3` and then `0.5` from `(0.6 0.8 1.0 ...)`.
- > Have we reached “goal”?
  search for one specific element
- > Motivations
  See
  "Let's Play Games..."
  - > Play with the Web
    i.e. link tree.
### 14
- > any other environment: it is an error
  For MIT/GNU Scheme, this is fine.
  ```scheme
  (define test 1)
  ((lambda (x) (define test 2) test) 2)
  ```
- p4
  > environment pointer points to E1
  is implied by the book
  > evaluating the body of the proce-dure in the context of the new environment constructed
### 15
- > Can use procedure to encapsulate (and hide) data, and provide controlled access to that data
  i.e. message passing.
  > accessors, mutators, predicates, operations
  all can be done in `dispatch`.
- > in scheme, a <type> procedure
  See SDF adventure game `(type-instantiator avatar?)` etc. which is so similar to project 4.
  > an instance is a message-handling procedure made by a create-<type> procedure
  in SDF `(create-avatar name place)` is one tagged data.
  Then operations are all generic.
- torp -> TORPEDO.
- > Keep track of things that can move (the *universe*)
  SDF `clock-things`
  > Clock sends *‘ACTIVATE* message to objects to have
  SDF `clock-tick!`
  > Coordinating with a clock
  SDF `tick!` -> `for-each`
  > (clock-callback ‘moveit me ‘MOVE)
  `clock-tick!` just define a sequence of operations for each object.
- > Inheritance
  - method Inheritance <a id="SDF_Inheritance"></a>
    SDF `predicate<=` -> `tag<=`.
    Then `make-chaining-dispatch-store` will use all handlers sorted by `rule<` where we first did child operations (but see `set-up!` -> `(super exit)` etc. where we *actually* run parent operations first), so Inheritance.
    This is just
    > *Specializes* a TYPE method
  - private variable Inheritance
    See `type-instantiator` -> `type-properties`.
- TODO
  > we will clean this up to insert handlers inside each class
- > Make and add the message handler for the object
  i.e. based on inherited methods by `get-method`.
- `(define some-method (get-method <instance> ‘<MESSAGE>))` by `(define (get-method message . objects) ...)` should be `‘<MESSAGE> <instance>`.
- `(ask c-instance ‘IS-A ‘C)` is probably done by checking `(ask c-instance ‘TYPE)`.
### 16
- TODO after reading the codes
- `named-object-part` see lect15 `(define (book self name copyright) ...)`
  - Since root has no superclass, so no corresponding part for this.
- `handler` arg: see `(SET-HANDLER!)` ~~which makes it possible that multiple instances sharing one ~~ which uses one new instance of the *class* handler.
- subpage 6
  all self are passed among recursive calls.
- > self is a pointer to the entire instance
  Due to `(set-instance-handler! instance handler)`.
- > This mostly matters when we have subclass methods that shadow superclass methods, and we want to invoke one of those shadowing methods *from inside the superclass*
  i.e. we can call `'YEAR` message in `named-object` handler.
- > *Inheritance* of methods
  by `get-method`
  > *Explicit* use of superclass methods
  e.g. `(ask named-object-part ‘CHANGE-NAME ‘mit-sicp)`
  > Shadowing of methods to over-ride default behaviors
  implied by the ordering of explicit funcs before `get-method`.
- > Use of TYPE information for additional control
  e.g. `is-a` uses that and then uses `is-a` to dispatch like `(ask whom 'is-a 'student)`.
- > to inherit structure and methods from superclasses
  structure: e.g. `prof-part` which can get private variables there if having available APIs.
  methods: e.g. `(get-method message prof-part)`.
- > Just look through the supplied objects from left to right until the first matching method is found.
  corresponds to SDF `make-most-specific-dispatch-store` but the latter will sort beforehand.
  SDF also supplies [SDF_Inheritance]
- > Default methods for all instances:
  See `(root-object self)` where `'TYPE` is implied in `'IS-A`.
- > Inheritance of state and behavior from superclass
  i.e. private variables and methods.
- p8 subpage1
  IMHO here 
  1. E1-GE: create-person
  2. E2-E1: create-instance
  3. E3-E2: `instance, handler` ...
  - > E2:
    i.e. `(lambda () name)`
  - > (lambda () name) | E1 
    | means "enclosing env"
  - > (#[proc 9]) | E55
    IMHO E55 should be E2.
- > Have a starting “instance” (self) object in env. model
  i.e. `(make-instance)`
  > Instance contains a series of message/state handlers for each class in *inheritance chain*
  `get-method` in `handler` of `(set-instance-handler! instance handler)`
### lec20 (stream)
This doesn't say much beyond what the book says. Also for the former lecs but this one has more overlap.
- > by primitive procedure (that is, primitive procedures are *"strict" in their arguments*)
  [see](https://sicp.sourceacademy.org/chapters/4.2.1.html)
  > If the *argument is evaluated before the body* of the procedure function is entered we say that the procedure function is strict in that argument.[2] In a purely applicative-order language, all procedures functions are strict in each argument. In a purely normal-order language, all compound procedures functions are non-strict in each argument, and primitive procedures functions may be *either strict or non-strict*.
- `(d lazy-memo)` is not supported directly in scheme.
  see sicp section 4.2 https://eng.libretexts.org/Bookshelves/Computer_Science/Programming_and_Computation_Fundamentals/Structure_and_Interpretation_of_Computer_Programs_(Abelson_Sussman_and_Sussman)/04%3A_Metalinguistic_Abstraction/4.02%3A_New_Page.
- 100000000, i.e. 100,000,000 should be 100M.
- compare Exercise 3.59 with "An example: power series", here it incorporates the symbol variable `x`.
- notice `(sqrt-stream x)` has recalculation.
- `trapezoid`
  [see](https://en.wikipedia.org/wiki/Trapezoidal_rule)
  > the formula can be simplified for calculation efficiency by factoring
- > a powerful way to structure and think about computation
  see "Using streams to decouple computation".
## rec
I will skip rec10 since that is one review for exam probably introducing no new contents.
also skip https://people.csail.mit.edu/jastr/6001/fall07/r14.pdf since it has no sol and just still draws env diagrams.
### rec15 for lec11
- [x] 1 trivial. See Exercise 3.13
  - sol
    better with `(or (pair? ring-list) (error "cannot ringify ()"))`
- [x] 2 just cdr
- [ ] 3 keep the first element and cnt in iter.
  - sol 
    the above is *wrong* since we can have duplicate elements in the ring.
- [x] 4 do `rotate-left` with times `(- (ring-length ring) 1)`.
  - sol
    `repeated` -> Exercise 1.43
### rec09 for lec12
- [x] 1 see SICP Exercise 2.66.
- [x] 2 see SICP p212 `adjoin-set`.
  - sol assumes no duplicate nodes are inserted.
- [x] 3 trivial
  - > there are never any left children,
    Since we inserts n,n-1... it should be "never any *right* children".
- [x] 4
  - > ;return the last k elements of l
    should be `(- (length l) k)`
- [ ] 5
### sp rec13 for lec12
- > With list data structures, we think of having elements linked on to the end of other elements.
  See lec p5 "represents the tree"
- > if A 6< B and B 6< A, then it’s okay to think A ≡ B
  due to [Irreflexivity](https://en.wikipedia.org/wiki/Partially_ordered_set#Strict_partial_orders)
  - Here just think of the tree has no duplicate elements.
- `bst/insert` trivial same as SICP p212 `adjoin-set`.
- [ ] `set-node-value !` trivial by using `(set-car! (cdr tree) val)`. Similar for others.
  - sol
    - with check.
    - > Note : cannot use set ! ( think why )
      See CS61A Week 9 Lab 2.
- [ ] `binary-tree/depth0` See `~/SICP_SDF/lecs/6.001_fall_2007_recitation/codes/rec9/4.scm`
  - sol with check and avoiding duplicate `+1`.
- [ ] 
  - `Theta ( log n )`
  - Theta ( log n )
  - Theta (1)
  - Theta (1)
  - "Worst case" same as "the order of growth".
    - see sol where we iterates through the whole list.
      IMHO space should be Theta(1).
- [ ] `( list->bst lst )` -> `(fold-left (lambda (elt acc) (bst/insert! elt acc)) lst)`.
  - This is different from Exercise 2.64 and ~~CS61A notes~~ rec09 since it has no ordering assumption.
- [ ] based on lec12 where `fold-left` has T(n)=O(n), S(n)=O(1).
  - $\Theta(n \log{n})$
  - $\Theta(1)$
    - TODO
      sol  space Θ(n)
      iter and fn both can have $\Theta(1)$, so how "Θ(n)"?
  - Time $\Theta(n)$ (see the next point)
    - sol we should multiply...
  - $\Theta(n)$ due to `bst/insert!` 1st sol may have $\Theta(n)$ for one totally unbalanced tree.
- [ ] `sort-via-bst` just uses bst as the transform medium (I skipped checking complexity due to  triviality).
### sp rec14 https://web.archive.org/web/20071221030700/https://people.csail.mit.edu/psz/6001/search.html for lec13
I only read the context of "Search" and codes.
- > In particular, the simple tree-growing procedures we presented have the problem that if you feed them inputs that are already sorted, they produce trees that are very list-like and therefore searching for an element takes O(n) time rather than O(log n).
  i.e. always keep going to one specific branch.
- > Eric introduced a general framework for searching, and applied it to searching for the best evolutionary explanation of the differences between two nucleotide sequences.
  i.e. tree See lec p6.
- > an abstract space of beliefs, goals and plans.
  IMHO i.e. hypothesis, search goal and paths for tree.
- > The path that got us there, as a list of cities in reverse order from how we traversed them.
  i.e. `(cons city path)` (`(cons here ...)` in page).
- ~~`(search start-state done? successors merge)` -> DFS.~~
- kw
  > for best-first and beam search, we need a comparison predicate that tells us which of two states is better
- best-first-search
  lec just uses `sort`. Here it do this inherently by recursion.
- > Note that priority-merge is just like merging procedures that we have seen in our earlier discussion of merge-sort.
  - [merge_sort]
    ~~when ~~`TopDownSplitMerge(B[], iBegin, iEnd, A[])`~~ (IMHO for consistency, here it should be `TopDownSplitMerge(A[], iBegin, iEnd, B[])`) is finished, `B[]` is the sorted `A[]` by "// sort data from B[] into A[]".~~
    - > // sort data from B[] into A[]
      ~~then back to "B[]" which "is a work array" implied by "merge both runs from B[] to A[]".~~
    - > The copy back step is avoided with *alternating the direction of the merge* with each level of recursion
      i.e. `TopDownSplitMerge(A, iBegin,  iMiddle, B)`.
      > (except for an initial one-time copy, that can be avoided too).
      ~~IMHO i.e. `TopDownSplitMerge(B, 0, n, A);`~~ TODO
      - > The elements are copied to B[], then merged back to A[].
        since `TopDownSplitMerge(A, iBegin,  iMiddle, B)` will match `(iEnd - iBegin <= 1)`.
        - > single element runs from A[] are merged to B[], and then at the next higher level of recursion, those two-element runs are merged to A[].
          `TopDownSplitMerge(A, 0, 4, B)` -> `TopDownSplitMerge(B, 0, 2, A)` (here modify to use the global `A,B`) -> `TopDownSplitMerge(A, 0, 1, B)` doing nothing.
    - In *summary*
      > array B[] is a work array.
      means it is one temporary variable which actually holds sorted array which *sorts for each half* implied by `TopDownSplitMerge(A, iBegin,  iMiddle, B); TopDownSplitMerge(A, iMiddle,    iEnd, B);`.
      > This pattern continues with each level of recursion.
      i.e. `TopDownSplitMerge(B[], iBegin, iEnd, A[])` first copys to A the sorted half which in turn may copys to B the sorted one quarter ...
      So we actually *don't need to synchronize `A,B`*.
    - TODO
      > // Split A[] into 2 runs, sort both runs into B[], merge both runs from B[] to A[]
      based on `TopDownMerge(B, iBegin, iMiddle, iEnd, A);` it should be "Split B[] into 2 runs, sort both runs into A[], merge both runs from A[] to B[]" (here A,B are local to `TopDownSplitMerge`).
      similar for "// recursively sort both runs from array A[] into B[]".
      > // merge the resulting runs from array B[] into A[]
      by `TopDownMerge` it should be "from array A[] into B[]" by `B[k] = A[i];` etc.
  - `priority-merge` is similar to `TopDownMerge` ~~which changes only `B`~~.
- > but simply limit the output of the local definition of priority-merge to just the first beam-width queue elements.
  See lec, i.e. `(list-head n ...)`.
- > Of course if the order of the road network had been different, the search might have rushed off toward Miami, from which there are no outgoing paths; in that case, it would have *gone back* to some other state on the queue and continued from there.
  implied by `merge`
  >  If you've ever driven across the USA, however, you are likely to recognize that this is *not the shortest route* to follow, though in this case, we got lucky and it's not very bad, either.
- > Best-first search searches over even more states, but yields a slightly better result.
  See lec p7 where we may do both of DFS and BFS partly.
  > though in this case those distances are actual road miles, not just steps
- > best-first search is more efficient if we have a *better better?* function. For example, if we could estimate not how far we have already traveled from the origin of the trip but *how far we are from the destination*, then best-first search would laser in on the best paths. A search technique called A* search guarantees the optimum answer if the score of each node is *a sum of the distance traveled to there and an underestimate of the remaining distance*, such as "as the crow flies" distance between cities
  ["as the crow flies"](https://en.wikipedia.org/wiki/As_the_crow_flies) -> shortest possible distance.
  - A*: See [$f(n)...$](https://en.wikipedia.org/wiki/A*_search_algorithm#:~:text=A*%20is%20an%20informed%20search,shortest%20time%2C%20etc.).)
    - [optimal proof][A*_optimal]
      >  This is because the ⁠${\displaystyle g}⁠$ values of open nodes are not guaranteed to be optimal
      since it is based on `tentative_gScore` by `gScore[neighbor] := tentative_gScore` instead of the actual one. (I didn't dig into checking the codes)
- > just because our cost function is *not a very good predictor* of the final worth of each path. Beam search was first developed in *speech understanding* research, to find the best match of a sequence of words to the phonetic signal recorded from a microphone, and in that application it worked dramatically well. There, unlike in our example, the goodness of *local matches does yield valuable information about the overall* match.
- > However, both depth and breadth-first search techniques are "blind", in that they have no notion of the relative values of different states
  i.e. only check depth instead of actual distance.
- > However, assuming that we don't ever want to revisit a city on a worthwhile path, we can change the implementation of next-states by doing the map not over all reachable destinations from here, but only *those that are not already on our previous* path:
  Also see `/home/czg_arch/SICP_SDF/SDF_exercises/chapter_2/graph-lib/DFS_tests.scm` -> `visited` although not structural.
- > Breadth and best-first searches both find solutions the same as in the case of the asymmetric road network, but do more work along the way.
  ~~For Breadth, we are just adding some extra nodes at each ~~level~~ recursion (With proof by contradiction, we can't add goal before the level of goal).~~
  This is not always true. Counterexample: 1->2->3->4, 5->1, 5->4.
  Then 1->4 has one better path 1->5->4 if bidirectional.
- > Search is often made more efficient by adding techniques based on *memoization* (so we need not re-evaluate partial paths that we have already explored) and by using much more insightful *estimates* of the value of partial solutions.
  "estimates" -> what A* used.
### sp rec15 for lec14
~~I don't know what "cone" is to do for~~ https://people.csail.mit.edu/dalleyg/6.001/SP2007/hats.pdf see rec p6.
- > when using other languages like C++ I miss them immensely for their elegance and compactness
  ~~C++ [only supports "higher-order function"](https://stackoverflow.com/a/26369869) which "takes one or more functions as arguments".~~
  > C++ does have HOPs, but they are not nearly as convenient nor as powerful.
  because that is based on *pointer*.
- [x] 1 trivial by creating one new env for each `fact` with enclosed env GE.
  - `*,-` etc are primitive so no new env.
- [x] 2
  - 15,0,15,15
  - `(f 5)` -> E1 binding one new `x` (Shadowing)
  - `(g 5)` just modifies `x` in GE.
- [ ] 3
  - `( lambda ( z ) (+ x 2))` is in GE, so `5`, then res -> 9.
    This creates E1
    - *wrong* since `z` is not used.
    - sol
      notice `x` is binded to one lambda func.
  - Then `( x y )` -> E2.
- [x] 4
  - 1
    - GE: `x` binding
    - E1-GE (-GE means having enclosing env GE): `x,y` binding
      return ...
      - E2-GE: arg of square is binded to `x`
        returned value is passed to `y`
  - λ-let
    - GE: `x` binding
    - E1-GE: x -> lambda
      `( set ! x ( x 7))` sets `x` in E1 to `13`.
    - sol
      notice both lambda and its application `(x 7)` has GE as the "enclosing env".
- [ ] 5
  - GE: `a,foo,bar`
    - E1-GE: `a` -> 10
      return `( lambda ( x ) ...)` to `foo`
    - E2-GE: `a` -> 100
    - E3-GE: `x` -> 20
      210
      - wrong, should E3-E1.
- [x] 6
  - trivial 2,1,16,1
  - GE: `make-count-proc,sqrt*,square*`
  - `sqrt*`
    - E1-GE: `f->sqrt`
      - E2-E1: `count->0`
        - E3-E2: `x->4`
          `set!,+` etc. are all primitive.
    - E4-GE by `(f x)`: ...
  - similar for `square*`
- > Each binding associates a name (must be a sym-bol) with a value.
  so
  ```scheme
  (define (square 2) 2) ; error
  (define square sqrt)
  (square 2)
  ```
- > Link these two pointers together with handcuffs.
  See lec p4 the purple horizontal link and [procedure_application_environment_rule].
- > Drop a new frame A that points to F
  IMHO i.e. "Create a new frame A" "into an environment" F which is env of the implicit lambda.
### sp rec16
- [ ] `stack`
  - See "; any additional initialization , parameter checking , etc .".
- > The first is a predicate that tells DrScheme ... If #f is returned , the next
  > ; enclosing with-handlers is looked at.
  same as https://practical-scheme.net/wiliki/schemexref.cgi?with-handlers but the latter allows multiple *pred*s.
- > I had trouble finding documentation on the data type of an error
  > ; object . (raise ...) is a more flexible way of generating the objects .
  IMHO `error` [calls `raise` in the end](https://standards.scheme.org/corrected-r7rs/r7rs-Z-H-8.html#TAG:__tex2page_index_912)
### sp [rec17](https://ocw.mit.edu/courses/6-001-structure-and-interpretation-of-computer-programs-spring-2005/resources/st05project4/)
1. https://github.com/psholtz/MIT-SICP/tree/master/Projects-S2005 https://github.com/yangchenyun/learning-sicp/tree/master/solutions/projects lacks some solutions for project including project 4.
2. https://github.com/junqi-xie-learning/SICP-Projects/blob/main/4%20The%20Object-Oriented%20Adventure%20Game/objsys.scm just copys the lib...
3. https://github.com/nrosiello/MIT-6.001/blob/master/project-4/project-4.scm have *some valid solutions*.
- > Our object instances are thus procedures which accept messages.
  more specifically, one tagged data.
- typo's
  - > which will be useful in following the code
    "the following code"
- TODO
  - > This set of code is a slightly modified version of what was presented in lecture
    no "make-methods" in 2 lecs
  - ~~> (eq? object (ask cb 'OBJECT))~~
    Why this doesn't need to call `object` method?
    - See the reasons of the following
      Here `clock-callback` has no class to inherit it, so no ambiguity.
  - ~~> It turns out just using location would be a bug in this case; you'll be able to see why after doing the warm-up exercises!~~
- > Thus, we may think of a thing as a kind of named object except that it also handles the messages that are *special* to things.
  SDF use `predicate<=` to share operations between the superclasses and self. This also manipulates with `(root-part (root-object self)` etc related with superclass.
  - > 'INSTALL
    `thing` overloads this method. For SDF this is done by `make-most-specific-dispatch-store`.
    But it calls `(ask named-part 'INSTALL)`, so here it corresponds to `make-chaining-dispatch-store`.
    This is similar to `set-up!`.
    - similar to
      > You'll note that named-object and container only share one method of the same name, TYPE , and place *overrides* it.
- > (ask screen 'TELL-ROOM (ask self 'LOCATION) ...)
  i.e. SDF `send-message!`. But here `server-port` is static while SDF has `screen:port`.
- > The thing class overrides two methods on named-object explicitly (as well as two implicitly);
  explicitly (trivial): `'INSTALL, 'DESTROY`
  implicitly (in `make-handler`): ...
- > This allows the class of an instance to be discovered at run time
  IMHO this means checking "instance" most specific type.
- `(things '())` done in SDF by `property`.
  - `(root-object ...)` corresponds to SDF `object?`
- > they are only meant to be used internally by other objects to gain the capability of adding things
  In SDF this is done by "inheritance".
  Same here with `(container-part (container self))`.
- > we can say the place class establishes a "has-a" relationship with the exit class
  `has-a` is not implemented.
- > ; This shadows message to thing-part!
  Since `(set! location new-location)` only changes the local `location` instead of that in `thing-part`.
- > thus the location contains a reference to the instance not the handler
  "handler" is also fine since
  ```scheme
  (eq? (named-lambda (test1 x) x) (named-lambda (test1 x) x)) ; #f
  (eq? (lambda (test1 x) x) (lambda (test1 x) x)) ; #f
  ```
- > A person is a kind of mobile thing that is also a container.
  SDF uses `bag` for `container`.
- > 'MOVE-AND-TAKE-STUFF
  Here it may do multiple moves but SDF will only do once.
- > non-muggles
  [See](https://harrypotter.fandom.com/wiki/Non-magic_people)
#### solution
Warmup Exercise (only 1,2,4 have sample-implementation)
- [x] 1
  - `place`
    `'EXITS` etc
    - see `sample-implementation.scm` for the detailed info's.
- [x] 2
  - > Also look through the code in setup.scm to see what the world looks like
    `create-world` is almost same as SDF `create-mit`.
  - See lec16 p6
    Here `person` has no nested `has-a list` etc.
    For `autonomous-person`, no such 3 arrows outside exist.
  - "see `sample-implementation.scm` for detailed" relations between types.
- [x] 3
  - > How are they interconnected?
    by exit.
  - > Draw a map.
    routine... so I won't do that.
- [x] 4
  See `create-world` and `populate-players`.
  > How is it determined which room each person and thing starts out in
  by deity
- [ ] 5
  - `(thing ‘foo some-location)` (This should be `create-thing`) creates 
    E1: `name location`
    E2-E1: `thing name location`
    E3 ... (routine I have done many env exercises...)
  - > For the bindings associated with methods,  just  leave  the  actual  value  blank.
    `()` in `(lambda () ...)`?
  - > draw boxes around the structures that correspond to each of the superparts of the object created.
    See lec16 p1 subpage 3.
- [x] 6
Project (see https://github.com/nrosiello/MIT-6.001/blob/master/project-4/project-4.scm)
summary of general requirement (also see highlighted words)
> Note that we do this with the *INSTALL* method of a thing, where we *explicitly ask the superpart* to also install, as well as doing some specific actions. This is *the only situation in which you should be asking your superclass-part*!
> You should *not* need to *change the setup* code to do simple tests.
test
> a brief transcript indicating *how you tested* the procedure
> Never use *thing-named* in object code, only for testing; this is a corollary to never using "*me*" except in *testing*.
- sample-implementation.scm checked up to 11.
- IMHO up to exercise 11, the code exercises are just how to use the lib. But the basic OOP ideas are still same as what lec's say.
  So if you have done SDF adventure game exercises, then IMHO there is no need to do this project.
#### comparison with SDF for some operations
- > (ask (ask self 'LOCATION) 'DEL-THING self)
  SDF gives `remove-thing!` which is *not one internal* function for any instance.
  Similar for `find-exit-in-direction`, `ENTER-ROOM`.
- > 'ADD-EXIT
  SDF defines this for exit by `create-exit` instead of `place`, so conflict is less possible.
- > 'CHANGE-LOCATION
  Done in SDF by checking type in `generic-move!`.
- > 'CREATION-SITE
  Done in SDF with one different naming property `origin`.
### rec16
almost same as spring lec20
- [ ] `memoization_check.scm`
  > Problem: Write an expression that will return true ...
  sicp uses `display` in Exercise 3.51~~, but how to check that by code?~~
- `define-macro` doesn't exist in MIT/GNU Scheme and Racket.
- `(define ints ...)` has already been shown in the book.
  same for `map2-stream, scale-stream`.
### sp rec22
Emm... still duplicate of much book contents but relates with env model...
- > ; Returns the value of exp in the original environment
  see env-test.scm.
- > How many cases can you think of?
  ~~based on sol, this doesn't mean "everything is implicit" but means "values are forced".~~
  - > Used as an argument to a primitive procedure.
    ~~should be `and` etc.~~
    > Used as an operator.
    Here it doesn't mean necessarily delay, but means they *must be evaluated*. So applicative order is same as normal order.
    see lec20 "Remember our Lazy Language?".
- > We’ll use the following notation to graphically represent various Scheme objects
  Thunk is just one special procedure with *no argument*.
- [ ] `ones` I didn't draw the representation of thunk.
- [ ] `( stream-cdr ones )` I thought $[1,]->[1,]->thunk$ but that will have no memorization.
- [x] `( define ( ints-from-n x ) ...` just creates one lambda.
- [ ] 
  - `stream-cdr` is primitive, so no frame is created.
  - better to have one frame for `display`.
- Cartography ... this term for `map` here is inappropriate IMHO
- [x] `map-streams` see Exercise 3.50.
- [x] 
  - TODO
    - `define-syntax` (where is this?)
      Anyway, [see](https://stackoverflow.com/q/79098453/21294350)
  - same as book but use `(map-streams + ...)`.
    > We can define the Fibonacci numbers in the same style:
#### @@TODO "Bonus Problem"
# chapter 4
## book
- > with the same general techniques used by designers of all complex systems
  e.g. physical system.
- > preserve modularity by adopting appropriate large-scale views of system structure
  e.g. stream?
- > for constructing computational data objects and processes
  see chapter 1
  > e evolution of a process is directed by a paern of rules called a pro-gram
  so "computational process" can be seen just as the running behavior of one program
- electrical system filters and amplifier is related with [Frequency Response ](https://www.electronics-tutorials.ws/amplifier/frequency-response.html#:~:text=Amplifiers%20and%20filters%20are%20widely,an%20upper%20and%20lower%20band.)
  > Only the *functional* behavior of the modules is relevant, and signals are manipulated *without concern* for their physical realization as *voltages and currents*
- > the stratified design technique illustrated by the picture language of section 2.2.4.
  see "Levels of language for robust design"
  > For example, in computer engineering, *resistors* and transistors are combined (and described using a language of analog circuits) to produce parts such as *and-gates* and or-gates, which form the primitives of a language for *digital-circuit* design.
- Formal logic [vs](https://en.wikipedia.org/wiki/Logic#Informal_logic) Informal logic
  > Formal logic can only examine them indirectly by translating them *first into a formal language* while informal logic investigates them in their *original form*.
### 4.1
- Figure 4.1
  the texts besides the arrows are just arguments.
- [Metacircular](https://stackoverflow.com/a/1481132/21294350) Evaluator
  > in a (possibly more basic) implementation of the *same* language
- > Contemplation of the meaning of true? here yields expansion of consciousness without the abuse of substance.
  i.e. using the same "substance"/`eval-if` but allows different values for `(eval (if-predicate exp) env)` so "expansion of consciousness"?
- notice `(definition? exp)` doesn't ensure the correct usage of `define`.
- > A procedure application is any compound expression that is not one of the above expression types.
  So it is put at last and uses `(pair? exp)`.
- name-conflict problem due to "macro" (i.e. [name collision](https://en.wikipedia.org/wiki/Name_collision#Avoiding_name_collisions). Also see [name shadowing](https://en.wikipedia.org/wiki/Free_variables_and_bound_variables#Formal_explanation) (i.e. [this][Variable_shadowing]). The latter 2 are similar as [this](https://stackoverflow.com/q/62051936/21294350) implies.)
  see [c++ solution](https://nimrod.blog/posts/how-to-resolve-macro-name-collisions/#isolating-third-party-headers-with-forwarding-files-recommended) for example
  - [`push_macro`](https://gcc.gnu.org/onlinedocs/gcc/Push_002fPop-Macro-Pragmas.html)
    here `#pragma push_macro("CHECK")` will save the definition in lib B, then `#include "A.h" // And other A's headers` will only use `CHECK` in the file lib A itself. Then "prefer to retain B’s definition of CHECK" -> `#pragma pop_macro("CHECK")`.
    - [`#pragma once`](https://en.wikipedia.org/wiki/Pragma_once)
    - TODO
      > Cons: Requires additional maintenance; may obscure some problems leaking from the library.
  - > This trick will shine when B’s CHECK is essential within a single class, and the class’s implementation is independent of A.
    so it means `MyClass.cc` uses A's CHECK while `MyClassImpl.h` uses B’s CHECK?
    see name-conflict.cpp.
- > adds to the first frame
  see section 3.2.2 Figure 3.5
  > We first look in the first frame of ... en we proceed to the enclosing environment, i.e. the global environment
  i.e. based on the "enclosing environment" sequence, "first" means the most inner.
- > or signals an error if the variable is *unbound*.
  ~~IMHO `set!` in GE is implicitly enclosed by "the top level".~~
  - https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-26.html
    > Variable *must be bound* either in some region enclosing the set! expression, or at the top level.
    "or at the top level" is implied by `(define the-empty-environment '())`.
- > Frames are not really a data abstraction in the following code
  i.e. `set-variable-value!` uses env which uses frame.
- > If no such binding exists, we adjoin one to the first frame.
  since we *only* define in that frame/env, so won't check "the enclosing environment".
- > change the binding if it exists (just as in set-variable-value!)
  i.e. allow redefinition although racket doesn't.
- > to distinguish the value of the expression from other output that may be printed.
  "other output" possibly in `(eval input the-global-environment)`.
- > types 'x, read returns a two-element list containing the symbol quote
  see `(car (read))` when typing `'x`.
- > or may even contain cycles
  i.e. binding in `env` may contain the binding pair `(foo env)`.
  - `compound-procedure` is just the `lambda` structure taught in environment model.
- > In a similar way, we can regard the evaluator as a very special machine that takes as input a description of a machine.
  i.e. one expression "as input"
- > ``what can in principle be computed'' (ignoring practicalities of time and memory required) is *independent of the language* or the computer
  - "independent of the language": due to "any evaluator can emulate any other".
  TODO "or the computer"
- > See Hodges 1983 for a biography of Turing.
  [see](https://cstheory.stackexchange.com/questions/1139/turing-machines-and-subroutine-simulation#comment1968_1139) which same as C assembly code implementation by stack.
- > From this perspective, our evaluator is seen to be a universal machine. It *mimics other machines* when these are described as Lisp programs.
  see
  > a Turing machine that behaves as *an evaluator for Turing-machine programs*
- > In fact, our *sequential* evaluation mechanism will give the same result as a mechanism that directly implements *simultaneous* definition for any procedure in which the *internal definitions come first* in a body and *evaluation of the value* expressions for the defined variables *doesn't actually use any of the defined variables*.
  so it means
  ```scheme
  ;; > doesn't actually use any of the defined variables
  (define foo (not-have-bar...))
  (define bar (not-have-foo...))
  ;; > internal definitions come first
  (program-using-foo-or-bar)
  ```
  trivial since we don't need "simultaneous definition" in this case. So same.
- `(let ((u '*unassigned*) ...) ...)` is very similar to [fake_let_assignment] in sicp_exercise.md.
- > Wanting programs to not depend on this evaluation mechanism
  i.e.
  > By insisting that internal definitions come first and do not use each other while the definitions are being evaluated
  so that
  > sequential evaluation mechanism will give the *same result* as a mechanism that directly implements simultaneous definition
  - IMHO
    > do not use each other while the definitions are being evaluated
    ~~isn't needed as `(f x)` here shows.~~
    is needed for the possible implementation like Exercise 4.18, i.e. "sequential evaluation".
    > this enforces the restriction that the defined variables' *values can be evaluated without using any of the variables' values*.
    - But if not using `delay` there, "would be transformed into" implementation will also not work since it still uses sequential implementation as `test-sequential-and-simultaneous-evaluation.scm` shows.
  - > management is not responsible
    i.e.
    > the  standard for Scheme *leaves implementors some choice*
- > where *unassigned* is a special symbol that causes looking up a variable to signal an error if an attempt is made to use the value of the not-yet-assigned variable.
  ~~not internally implemented in MIT/GNU Scheme and M-Eval.~~
  See Exercise 4.16 a.
- > Performing it repeatedly is wasteful.
  maybe due to `eval` and `apply` are in different memory locations. So keeping running one part is much faster than *reading* 2 memory locations alternately.
- > *evaluation of the value* expressions for the defined variables doesn't actually use any of the defined variables
  so `even?` example is fine since `lambda` can be evaluated even if its body implies mutual recursion.
  [similar to](https://standards.scheme.org/corrected-r7rs/r7rs-Z-H-7.html#TAG:__tex2page_index_284) but not consider Exercise 4.19 Eva's
  >it is an error if it is not possible to evaluate each <expression> of every internal definition in a <body> *without assigning or referring to* the value of the corresponding <variable> or the <variable> of any of the definitions that *follow* it in <body>.
### 4.2
- > The delayed arguments are not evaluated; instead, they are transformed into objects called thunks.
  This thunk is not exactly same as [MIT/GNU Scheme version](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Arity.html).
- > One design choice we have available is whether or not to memoize thunks, as we did with delayed objects in section 3.5.1.
  Here we incorporate that into the data structure while section 3.5.1 uses local states.
- > With lazy evaluation, streams and lists can be identical, so there is no need for special forms or for separate list and stream operations.
  Notice here `cons` as one procedure is not same as `cons-stream` since the latter will always evaluate car part.
  "identical": i.e. all arguments are delayed.
- > In terms of these basic operations, the standard definitions of the list operations will work with infinite lists (streams) as well as finite ones, and the stream operations can be implemented as list operations.
  if `cons...` are used as compound procedures, the list is `(lambda (m) (m thunk1 thunk2))`
  then `(car z)` will *force* `z` (i.e. the above `(lambda (m) ...)`) and then apply `z` to one argument where `m` (i.e. `(lambda (p q) p)`) is again *forced*. Then return thunk1 `(thunk y env)` which may be forced when `driver-loop`. i.e.
  > In fact, even accessing the car or cdr of a lazy pair *need not force the value of a list element*.
  - cdr is similar, returning thunk2. <a id="lazy_cdr"></a>
  - So "work with infinite lists (streams) as well as finite ones".
  - `scale-list` is from ~~`scale-stream`~~ p144.
  - `add-lists`: similar to Exercise 3.50.
- > This permits us to create delayed versions of more general kinds of list structures, not just sequences. Hughes 1990 discusses some applications of ``*lazy trees*.''
  ~~Since one can put one infinite thing at `car`.~~
  IMHO if tree can be stream, then all work fine.
  > Higher-order functions reptree and *maptree* allow us to construct and manipulate game trees with ease. More importantly, *lazy evaluation permits* us to modularize evaluate in this way. Since gametree has a potentially infinite result, this program would *never terminate* without lazy evaluation.
  So `maptree` can be `stream-map`.
  - How to implement `prune`, see `lazy-tree-test.scm`.
- > For instance, we can implement procedures to integrate lists and solve differential equations as we originally intended in section 3.5.4:
  https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-24.html#%_sec_3.5.4
  see
  > when it is required to generate more than the first element of the output stream:
- [lazy vs eager](https://stackoverflow.com/a/75682308/21294350)
  - When lazy is worse
    > Lazy evaluation is generally regarded as worse for performance than eager evaluation; it usually involves *allocation of memory structures* that "remember" the operation for later
    > if the *operation is very small* and would only produce an immediate value (things like a machine integer, rather than a heap-allocated object), then the overhead of laziness is still only a constant factor but that constant factor is *quite large relative to the "intrinsic"* cost of the operation; ... if your program is mostly doing this kind of thing then lazy evaluation does make a significant *negative difference*.
    - > Lazy evaluation also makes it very easy to lose track of the exact *order* various operations will be executed in
      > If two pieces of code will be executed and *both change a shared variable*, you need to be able to easily and *accurately predict the order* ... impure code
      said in book Exercise 3.51, 52.
  - lazy advantages
    - > eager evaluation may encounter errors or infinite loops that lazy evaluation would avoid.
      when "errors or infinite loops" won't happen due to `if` etc.
    - > lazily evaluated code might be able to process this whole data set *without* ever needing it *all to be resident in memory* at once;
      > Code that produces a data structure can be written in a simple direct style to produce "all" of it, even if that is *infinite*. Code that consumes the data structure simply examines *as much of the structure as it wants* to
      > might need the producer to be capable of *resuming production from a previous partial* result, etc. This can easily *add a lot of complexity to code implementing a fairly simple* idea
      > lazy evaluation can be particularly ergonomic in cases where an eager algorithm needs a lot more code to explicitly manage *when and how much of a very large data set is in memory* at once.
    - > move-tree for analysis of a game like chess
      IMHO same as [this](https://stackoverflow.com/q/79150263/21294350)
    - > You can design good solutions to this problem that still leave the *eager* producer and eager consumer reasonably *decoupled*, but designing a good interface that is flexible enough for *all uses while still being performant* can be a tricky problem
      OP doesn't say about that solution for "eager producer and eager consumer".
    - TODO
      > in a language where everything is lazy you can make your own control structures. In Haskell things analogous to while loops and for-each loops can be simply implemented as ordinary library code
      maybe just as the book Exercise 4.9 says.
#### TODO
- ~~> Notice that we can install these definitions in the lazy evaluator simply by typing them at the driver loop.~~
  Not in `primitive-procedures` since that will implicitly evaluate arguments.
  - ~~TODO~~
    ~~footnote 40~~
### 4.3
Better to read following the order 4.3.1->3->2 where 4.3.2 is put at last to ensure the comprehension of amb (Here I just check all `(amb` contexts in the book and exercises before 4.3.3 have been understood for their underlying logic after reading 4.3.3). See amb review.
- > We saw how to handle this with finite sequence operations in section 2.2.3 and with infinite streams in section 3.5.3.
  See `prime-sum-pairs`
  ```scheme
  (stream-map make-pair-sum
    ;; from book
    (stream-filter (lambda (pair)
                 (prime? (+ (car pair) (cadr pair))))
               ;; incorporated with the latter contents
               (pairs integers integers)))
  ```
  - notice the pattern for `(pairs integers integers)` (i.e. `(1,1),(2,1),(2,2),...`) in section 2.2.3 is by constructing a list of row lists and then get one matrix form same as [lower triangular matrix](https://math.stackexchange.com/q/4994400/1059606). So `flatmap`
    But the pattern (i.e. upper triangular matrix) here is different, where we `interleave` between 2 *infinite* lists to ensure both can be visited. We also uses *induction* to get one bigger triangle from one smaller triangle (This can't be done in section 2.2.3 since we needs to add one *diagonal*).
  - > Whether we actually generate the entire sequence of pairs first as in chapter 2, or interleave the generating and filtering as in chapter 3, is immaterial to the essential image of how the computation is organized.
    As the above shows ~~the *basic programming structure*~~ computation process for *each number* are same for both, i.e. "Sequences as Conventional Interfaces" filter and then map.
    - > e nondeterministic approach evokes a different image.
      Based on 4.3.3 implementation and `prime-sum-pairs-amb.scm`, it traverses same as section 2.2.3 and also does "generating and filtering as in chapter 3" since we will abort when finding one (next) valid candidate.
      So here different means:
      1. "choose (in some way) a number" and return *one pair* instead of one list of pairs.
      2. > It might seem as if this procedure *merely restates the problem*, rather than specifying a way to solve it.
          The main logic is *hidden* in amb-eval which actually combines chapter 2 and 3 as the above says.
- > our programs have different possible execution histories
  i.e. `try-again` always backtrack and get one different result, so the different "execution history".
- > declarative descriptions and imperative specifications
  So "Nondeterministic Computing" is [totally *declarative*](https://codefresh.io/learn/infrastructure-as-code/declarative-vs-imperative-programming-4-key-differences/#:~:text=In%20declarative%20programming%2C%20state%20is,hand%2C%20requires%20explicit%20state%20management.).
- > we reach a dead end, we can revisit a previous choice point and proceed along a different branch.
  i.e. [backtracking](https://en.wikipedia.org/wiki/Backtracking#Pseudocode)
  where `s ← first(P, c)` and `backtrack(P, s)` implies DFS due to `s` being "extension", i.e. next depth.
  and `reject(P, c)` implies prune, i.e. "whole *sub-tree* rooted at c is skipped (pruned)".
  - > If a choice results in a failure, then the evaluator automagically46 backtracks to the most recent choice point and tries the next alternative. If it runs out of alternatives at any choice point, the evaluator will back up to the previous choice point and resume from there.
    i.e. `reject(P, c)` -> caller's `backtrack(P, s)` where `s` is one subtree of caller's `c` -> `s ← next(P, s)`
    "runs out of alternatives at any choice point": `while s ≠ NULL do` is finished, so return to caller.
- > This objection should be taken in the context of history.
  i.e. now CPU is not expensive, so that's fine to "require millions of processors" maybe (at least more reasonable than before).
  > It is hard to underestimate the cost of mass-produced electronics.
  just means the contents before *overestimates* "the cost of mass-produced electronics".
- > with search and automatic backtracking
  this can ensure visiting all possible cases due to [the relation with spanning tree](https://cs.stackexchange.com/a/101145/161388)
- > Edinburgh and Marseille of the elegant language Prolog
  i.e. [dialect](https://en.wikipedia.org/wiki/Prolog)
- > an-element-of fails if the list is empty.
  ~~So `amb` will adds one `'()` for that place in `(amb (car items) (an-element-of (cdr items)))`?~~
  Then
  > The computation *aborts* and no value is produced.
  i.e. not continue running.
- > our amb evaluator must undo the effects of set! operations when it backtracks.
  this is actually only needed when that value, i.e. `*unparsed*` here, is used later for *another amb traversal*. But here we just does `(require (null? *unparsed*))` which is only worked when *all previous `require`s* in `parse-word` are met and then `(set! *unparsed* (cdr *unparsed*))`. So if no "undo", here `(require (null? *unparsed*))` is *also* not met.
  But for one *general* case, we should do that just like restoring the stack when back to the caller.
  - See
    > Automatic search and backtracking really pay off, however, when we consider more complex grammars where there are *choices* for how the units can be *decomposed*.
- > a verb may be followed by any number of prepositional phrases
  [See](https://www.brandeis.edu/writing-program/resources/faculty/handouts/prepositions.html#:~:text=This%20sentence%20has%20two%20prepositional,that%20begins%20%E2%80%9Cin%E2%80%9D).)
  > adverb, modifying the verb “look.” The phrase answers the *adverb* question *where*
  > *adjectival* phrase, modifying the noun “drawer.”
- > the professor is lecturing with the cat
  i.e. "The professor lectures with the cat to the student"
- > flexible command languages
  maybe due to "interpretation of meaning".
- > applications of simple grammars to command languages.
  BNF or [creation](https://www.amzi.com/manuals/amzi/pro/ref_dcg.htm#:~:text=DCG%20can%20be%20used%20to,exit.)
#### 4.3.3
- > data-representation procedures
  i.e. 4.1.3
- > the success is propagated:
  just as `fail` may undo something, we *may* do some extra thing in `succeed` besides `(lambda (value fail) value)`.
- > since we can assume that internal def-initions are scanned out
  IMHO here why we don't need to undo (internal) def-initions is not due to "``scan out'' and eliminate all the internal definitions" by transforming them to 
  one `let` equivalent form, but due to this is *automatically* done by *env model*.
  ```scheme
  (define (global-foo)
    1)
  (define (global-bar)
    ;; actually local. This won't influence the outer global-foo value.
    (define (global-foo)
      2)
    (global-foo))
  (global-bar) ; 2
  (global-foo) ; 1
  
  ;; set!
  (define global-foo 1)
  (define (global-bar)
    ;; actually local. This won't influence the outer global-foo value.
    (define global-foo 2)
    global-foo)
  (define (global-bar-with-set!)
    ;; Will change the outer global-foo value.
    (set! global-foo 2)
    global-foo)
  (global-bar) ; 2
  global-foo ; 1
  (global-bar-with-set!) ; 2
  global-foo ; 2
  ```
- why we need `fail2` for `sequentially` (others should be similar)
  This will matter like when `a` is assignment, then `succeed` there is used when `(succeed 'ok ...)`. Assume `fail` is same as `fail2'` in assignment. Then `fail2` (i.e. `do-restoration... (fail)` where `fail` is that in `sequentially`) is different from `fail`.
- > The failure continuation that is passed along with the value of the assignment ... *restores the old value*
  "the value of the assignment": i.e. `'ok`
  This is used when
  > Along with that value, the success continuation is passed another failure continuation, which is to be called subsequently if the use of that value leads to *a dead end*.
- > That is, a successful assignment provides a failure continuation that will intercept a subsequent failure; whatever failure would otherwise have called fail2 calls this procedure instead
  subsequent failure -> fail2
  intercept -> undo the assignment *before* actually calling fail2.
- `succeed` is called when the value can be *decided* like Simple expressions, `(succeed 'ok fail2)`, `(succeed (cons arg args) ...)`, `(succeed (apply-primitive-procedure proc args) ...)`.
- > Along with that value, the success continuation is passed another failure continuation, which is to be called subsequently if the use of that value leads to a dead end.
  See `(fail)` in `(analyze-amb exp)` which means this amb has failed, so we need to call `(fail)` which is passed by the caller (that caller decides the callee's `fail` implies DFS).
  > It is the job of the failure continuation to try another branch of the nondeterministic process.
  > Together with this value, the evaluator constructs and *passes along a failure continuation* that can be called later to choose a *different alternative*.
  > The failure continuation in hand at that point will cause *the most recent choice point* to choose another alternative.
  > Failure continuations are also invoked by the driver loop in response to a try-again request, to find *another value* of the expression.
  see fail000 in amb-process-demo.scm.
  > If there are no more alternatives to be considered at that choice point, a failure at an earlier choice point is triggered,
  > in order to propagate the failure back to the previous choice point or to the top level.
  see fail00
- > Failures are initiated only when a dead end is encountered.
  i.e. called.
#### amb review after reading 4.3.3
what amb should achieve (for how is achieved, please check codes...)
- just trying all possible candidates combination
  - `(list (amb 1 2 3) (amb 'a 'b))`
    the rest book codes
    `grep \(amb -r ./[^4a]*` in ~/SICP_SDF/exercise_codes/SICP/4
    - [see](https://unix.stackexchange.com/a/572040/568529) or `man uniq`
      > 'uniq' does not detect repeated lines *unless they are adjacent*.  You may want to sort the input first, or use 'sort -u' without 'uniq'.
      4.35~4.49 by `grep \(amb -r ./4_[^5]* --color=never | awk '{$1="";print $0}' | sort -u` (see [awk related](https://stackoverflow.com/a/2961994/21294350)) and `grep "(amb $" -r ./4_[^5]* --color=never`.
- do fail when necessary
  - > we can think of (amb) as an expression that when evaluated causes the computation to ``fail''
#### @%%TODO
- ~~How footnote 51 is done?~~
  See `old-value` in `analyze-assignment`.
  - See the 2nd example in `amb-process-demo.scm` which shows
    > undoes the side effect and *propagates* the failure.
    > The failure continuation that is passed along with the value of the assignment (marked with the comment ``*2*'' below) restores the old value of the variable *before continuing the failure*. ... intercept a subsequent failure
- ~~> The evaluators in sections 4.1 and 4.2 do not determine what order operands are evaluated in. We will see that the amb evaluator evaluates them from left to right.~~
  4.1 and 4.2 are all based on `apply`->`list-of-values/list-of-arg-values...` which uses `cons` for operand evaluation which [has no  ordering imposition][scheme_operand_ordering_undetermined].
  - > the amb evaluator evaluates them from left to right.
    done by `((car aprocs) env ...)`.
  - Also see the 1st example in `amb-process-demo.scm`
- ~~> the analyzing evaluator of section 4.1.7, because the execution procedures in that evaluator provide a *convenient framework for implementing backtracking.*~~
  - See `Lazy_Evaluation_analyze_lib.scm`.
    After all, "analyzing" is used for its effefficiency due to avoiding duplicate analyze's, so lazy can be also combined with that.
  - Here since we need 2 more continuation args, just changing `(lambda (env) ...)` to `(lambda (env continuation1 continuation2) ...)` is really easy.
    But if using the initial version evaluator, (take `eval-assignment` for example which has no anonymous procedures, others should be similar) the *non-anonymous* proc `set-variable-value!` needs to change the interface.
- ~~> In summary, failure continuations are constructed by...~~
  IMHO This means new failure continuations instead of just passing most of time like `fail000` from `(succeed000 '() fail000)` back to succeed.
- ~~> Failure continuations are also called during processing of a failure:~~
  1. See `(lambda () (set-variable-value! ...) fail-y)` in amb-process-demo.scm
  2. See fail000 -> fail00.
- ~~> as the execution procedures call each other.~~
  e.g. `sequentially`
- ~~when this occurs?~~
  > If the execution of pproc *fails*
  - the most trivial case will be `(if (amb) ...)`.
- > whatever failure would otherwise have called fail2
  may mean the other exp's in `(analyze-sequence exps)` which probably *just* does `(fail2)`.
- ~~> Here we see the essence of the interpretation process and *the reason for keeping track of the continuations*.~~
  "essence of the interpretation process": "cycles through the execution procedures for *all the possible* values".
  - "the reason for keeping track of the continuations": i.e.
    > in order to propagate the failure back to the previous choice point or to the top level.
    Also see 
- ~~> In this case, however, we have completed a successful evaluation, so we can invoke the ``failure'' alternative branch in order to search for *additional successful evaluations*.~~
  > The intent is that calling try-again should *go on to the next untried alternative* in the nondeterministic evaluation.
  see fail000.
## lec
### 17
- From this, SICP just uses ["Interpretation" ("a way of implementing the evaluation")](https://stackoverflow.com/a/61497305/21294350).
- > Names
  i.e. name in name collision.
- [Lexical analyzer see "The lexical analysis of this expression yields the following sequence of tokens:"](https://en.wikipedia.org/wiki/Lexical_analysis#Lexical_token_and_lexical_tokenization), Parser: ~~analyze~~ where () is implicitly implied in Scheme implementation in 4.1.
  Printer: ~~`user-print`~~ `display` in the underlying scheme.
  - Parser also see book "Parsing natural language" and the [corresponding parse tree, i.e. "like diagramming sentences in elementary school"](https://en.wikipedia.org/wiki/Parse_tree#Constituency-based_parse_trees).
    > attempting to parse the input, that is, to match the input *against some grammatical structure.*
    ~~IMHO This is just what syntax procedures like `definition-variable` does.~~
    ~~is done by `(read)`~~
    "grammatical structure" -> [nonterminal](https://stackoverflow.com/a/3614928/21294350) (I only checked point3) <a id="lexer_vs_parser"></a>
    - Then we can recognize `list` in Evaluator.
- > Arithmetic calculator
  already shown in `(application? exp)` case of `eval`.
- > How many times is eval called in these two evaluations?
  - `define*` 1 + `plus*` 2
    - wrong see p3, 1+3.
  - 2
  - totally one more (i.e. `define*`) than ~~same as~~ "1. Arithmetic calculator".
- > What are the argument and return values of eval each time it is called in the expression above?
  list
- ~~`(eq? test #t)` better to be `true? ...` as the book for ADT.~~
  `(eq? test #t)` is just based on ADT `true*`.
- "some-other-environment" means extended GE with `plus*`?
- > no pending operations on either call
  i.e. not lazy evaluation.
- > an iterative algorithm if the expression is iterative
  see book `factorial` problem in 4.1.7.
- > Writing a precise definition for what the Scheme language means
  e.g. [BNF](https://standards.scheme.org/corrected-r7rs/r7rs-Z-H-9.html#TAG:__tex2page_chap_7)
- > Describing computation in a computer language forces precision and *completeness*
  [see](https://www.cs.cmu.edu/afs/cs/user/clamen/OODBMS/Manifesto/htManifesto/node9.html#:~:text=From%20a%20programming%20language%20point,for%20instance%20is%20not%20complete.)
  so at least more primitive operations.
- > Sets the foundation for exploring variants of Scheme
  i.e. section 4.2, 4.3.
### 18
IMHO lexical vs. dynamic scoping is the only one concept up to now not taught in the book but in lecs
- [Semantics vs. syntax](https://stackoverflow.com/a/17931183/21294350)
- see [Lexical_scoping_vs_Dynamic_scoping] same as p6
- [Syntactic Abstraction](https://wiki.c2.com/?SyntacticAbstraction) -> https://wiki.c2.com/?LispMacro -> [`syntax-rules`](https://www.gnu.org/software/guile/manual/html_node/Syntax-Rules.html)
  - TODO [Lisp macros versus Rust macros and C](https://simondobson.org/2024/06/14/lisp-macros-versus-rust-macros/#:~:text=Lisp%20has%20only%20one%20kind,are%20basically%20just%20string%20expanders.)
- > Separation of syntax and semantics
  semantics -> `eval/apply`
- [`let?` (see Hertz's which is same as here p4)](http://community.schemewiki.org/?sicp-ex-4.6)
- [Syntactic transformation](https://people.eecs.berkeley.edu/~bjoern/papers/rolim-refazer-icse2017.pdf)
  >  a program transformation is defined as a sequence of *distinct rewrite rules* applied to the abstract syntax tree
- > How does our evaluator achieve lexical scoping?
  i.e. `extend-environment` in `(apply procedure arguments)`.
- when will Dynamic Scoping help
  [see](https://www.geeksforgeeks.org/static-and-dynamic-scoping/#)
  > such as recursive functions or code with complex control flow
### 19 lazy
- Eager evaluation and
  > Why is normal order useful?
  see above "lazy vs eager".
- > Normal Order Example
  when not using lazy-memo.
- > Remember – this is just tree structure!!
  i.e. one tree with only right children~~totally right~~?
- > Can have problems if mutation is allowed
  since the value foo that mutation procedure may have different values when called with different times like `(begin (set! val (+ val 1)) val)` defined as `(inc val)` (see `thunk-no-mutate.scm`).
- `(memoize proc)` is from Exercise 3.27 p369 with the same basic ideas.
  - `foo` is `(lambda (arg) ...)` inside 2 levels of `lambda` with the 2nd implied by `let`.
- > don't need actual value in assignment...
  since that `(assignment-variable exp)` has not been used.
- > Need to force evaluation on branching operations (e.g. if)
  Here `true?` is the *underlying* Scheme procedure, so need manual `actual-value`.
- > What if we want evaluation on each use?
  [Here](https://stackoverflow.com/a/3242990/21294350) the getter procedure for one real-life environmental object has *no mutation*, but "evaluation on each use" may be better.
  > 
  - TODO #2?
  - > 16 potential inputs
    i.e. 
    > the *"furthest" ADC read from the most recent* is discarded ... cached 0x210 to 0x21F, and then I read *0x222*, I drop the 0x210 result
    ~~here may mean timestamp.~~
    - > The drawback here is that if environmental conditions change a lot, that already-slow calculation runs a little slower.
      As the above shows, the drop may be done frequently, so the advantages are amortized by that frequent insertion and drop overhead.
  - > Creating a lookup table *ahead of time is ridiculous*.
    since that may be more conservative unnecessarily where "(a large range of floating point values)" may be only used *partly*.
  - > But no user requires or expects the device to work well when conditions change rapidly, and they'd much rather it works better when things are steady. So I make a *tradeoff* in computational behaviour that reflects these requirements: I want this calculation to be nice and fast when things are *stable*, and I *don't care about when they aren't.*
## rec
skip Analysis & Quiz II Review due to no related lecs and also just has `analyze-let` which is already done in the book exercise for Analysis.
https://people.csail.mit.edu/jastr/6001/fall07/r17.pdf is skipped due to that is just OOP IMHO, i.e. project4
### sp rec19
With lec17, both overlap too much with the book (almost already contained)...
- [`setf` implementation](https://stackoverflow.com/a/44700342) skipped due to about Common LISP.
- [6.035](https://web.archive.org/web/20080503094255/http://web.mit.edu/6.035/www/index.html) is about compiler
- [ ] 2
  - ~~TODO diff~~
- [x] 3 just see the book.
- [x] 4
  - both will redefine `quote`.
### rec18
This is less appropriate here. But [6_001_sp_2007_rec] doesn't have one corresponding one.
This is much more trivial than the book exercises.
### rec20 since "6.001 Spring 2007 Lazy Evaluation recitation" has no valid results
# Colophon
- > is image of the engraving is hosted by J. E. Johnson of New Goland.
  [See](https://www.pinterest.com/newgottland/mechanisms/) -> [this](https://www.pinterest.com/pin/116108496617565759/)
- > e typefaces are Linux Libertine for body text and Linux Biolinum for headings, both by Philipp H. Poll
  [See](https://www.fontsquirrel.com/fonts/list/foundry/philipp-poll)
- [Inconsolata](https://fonts.google.com/?query=Raph+Levien) (Also see Alegreya) [LGC](https://online-fonts.com/fonts/inconsolata-lgc)
# TODO about the earlier chapters after reading later chapters
- > by incorporating a limited form of normal-order evaluation
# TODO after lambda calculus
- [consistent_renaming] An5Drama's question 3.
# TODO after numerical analysis (Most of applications in SICP are about numerical analysis)
- Why Newton’s method [only get to the local root](https://math.stackexchange.com/a/961171/1059606) but not global although intuitively it is that case.
  - Also see [one interesting problem](https://qr.ae/psBzi8)
# TODO after differential equations
- SICP 2.16
## See TODO in exercise
- 1.45
# TODO after algorithm
- > There are also other ways to solve this problem, most of which involve designing new data structures for which searching and insertion both can be done in (log n) steps.
- AVL Tree in `~/SICP_SDF/lecs/6.001_fall_2007_recitation/codes/rec9`.
- [A*_optimal]
# TODO after abstract algebra
- exercise 2.93 footnote.
# TODO after c++
- the [3 comments](https://stackoverflow.com/questions/79011368/is-environment-model-necessary-for-higher-order-procedures/79028978#comment139349156_79028978)
# TODO after distributed systems
- footnote 51 in section 3.4.
# TODO after compiler
- Why is [dynamic scope implementation](https://stackoverflow.com/a/1048531/21294350) harder as CS 61A notes p81 says?
  > With dynamic scope you have to defer the name-location correspondence until the program actually runs
- CS 61A notes 
  - paragraph "recursive descent compiler ...".
  - automatic analysis in compiler
- [left recursion elimination](http://community.schemewiki.org/?sicp-ex-4.47)
- lexer_vs_parser above.

# @%TODO read Lecture 5,6 & 6.001 in perspective & The Magic Lecture in 6.037 which *don't have corresponding chapters in the book*. Also read [~~Lectures without corresponding sections~~](https://ocw.mit.edu/courses/6-001-structure-and-interpretation-of-computer-programs-spring-2005/pages/readings/) ([6.001 2007](https://web.archive.org/web/20161201165314/http://sicp.csail.mit.edu/Spring-2007/calendar.html) is almost same as 2005 and they are both taught by [Prof. Eric Grimson](https://orgchart.mit.edu/leadership/vice-president-open-learning-interim-and-chancellor-academic-advancement/biography)).

<!-- in-page link -->
[SDF_Inheritance]:#SDF_Inheritance
[procedure_application_environment_rule]:#procedure_application_environment_rule
[special_form]:#special_form
[Lexical_scoping_vs_Dynamic_scoping]:#Lexical_scoping_vs_Dynamic_scoping
[free_variable_def]:#free_variable_def
[line_count_parallel]:#line_count_parallel

[ucb_sicp_review]:https://people.eecs.berkeley.edu/~bh/sicp.html

[course_note]:https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/course.html

[academia_se_tips]:https://academia.stackexchange.com/a/163476

[AI_preq_sicp]:https://functionalcs.github.io/curriculum/sicp.html

[mit_End_of_an_Era_comment]:https://mitadmissions.org/blogs/entry/the_end_of_an_era_1/#comment-31965

[how_special_form_is_special]:https://softwareengineering.stackexchange.com/a/137437

[consistent_renaming]:https://cs.stackexchange.com/a/97700/161388

[Fib_complexity]:https://stackoverflow.com/a/360773/21294350

[evernote_proof_1_13]:https://www.evernote.com/shard/s100/client/snv?noteGuid=6a4b59d5-e99f-417c-9ef3-bcf03a4efecd&noteKey=7e030d4602a0bef5df0d6dd4c2ad47bf&sn=https%3A%2F%2Fwww.evernote.com%2Fshard%2Fs100%2Fsh%2F6a4b59d5-e99f-417c-9ef3-bcf03a4efecd%2F7e030d4602a0bef5df0d6dd4c2ad47bf&title=Exercise%2B1.13

<!-- wikipedia -->
[Banach_fixed_point_proof]:https://en.wikipedia.org/wiki/Banach_fixed-point_theorem#Proof
[First_class_citizen]:https://en.wikipedia.org/wiki/First-class_citizen#History
[merge_sort]:https://en.wikipedia.org/wiki/Merge_sort#Top-down_implementation
[A*_optimal]:https://en.wikipedia.org/wiki/A*_search_algorithm#Admissibility
[Variable_shadowing]:https://en.wikipedia.org/wiki/Variable_shadowing

[CS61A_lib]:https://people.eecs.berkeley.edu/~bh/61a-pages/Lib/

<!-- gnu scheme doc -->
[scheme_stream_doc]:https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Streams.html#index-cons_002dstream
[scheme_promise_doc]:https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Promises.html#index-force
[scheme_operand_ordering_undetermined]:https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Procedure-Call-Syntax.html

[6_001_sp_2007_rec]:https://people.csail.mit.edu/dalleyg/6.001/SP2007/