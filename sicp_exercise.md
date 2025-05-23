# @notice
- *Comment style* I follow [this](http://community.schemewiki.org/?comment-style)
- I always give *tests* but sometimes I didn't since tests actually don't ensure the correctness.
## what is skipped
- I *didn't prove those theorems* which are not proved before when learning DMIA and mcs since I am not reading SICP to learn maths. (SkipMath)
- I won't dig into *complexity analysis* like exercise 2.64.
## @wiki and repo solutions checking state
- I mainly follow the wiki (from about sicp-ex-2.53 I only read codes first and then possibly the description if not understanding the solution for *code exercises*).
  Then I read repo xxyzz/SICP codes.
  - *repo read up to* (notice from about 2.42, I only gives a glimpse of these solutions and  probably they are already in schemewiki).
    I have read repo solution chapter 1,2,3,4.1~4.64,4.70~79 (This line is kept to avoid forgetting to check this repo solution). repo solution may be better like 1.7.
    - I assumed the solution is *either in the code or README* but splitted into 2 parts where one is in the code and the other is in README.
# misc clipboard
sci-42ver/SICP_SDF
# racket notes
- [cond](https://docs.racket-lang.org/reference/if.html#%28form._%28%28lib._racket%2Fprivate%2Fletstx-scheme..rkt%29._cond%29%29) uses `[]`
# book lib locations
- `reverse`: Exercise 2.18
- `map`: Mapping over lists.
- `accumulate` is [almost same as ~~`reduce`~~ `fold-right`](http://community.schemewiki.org/?sicp-ex-2.33)
- `append`: p139
- `memq`: p195
- `apply-generic`: p247
# scheme func description
- `error`
  - > is can be accomplished using error, which takes as arguments a number of items that are printed as error messages.
    [i.e.](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Condition-Signalling.html#index-error-2)
    > In this case a condition of type condition-type:simple-error is created with the message field containing the reason and the *irritants* field containing the arguments.
    [See](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Taxonomy.html#index-condition_002dtype_003asimple_002derror) (I won't dig into format func `format-error-message`)
    > irritants contains a list of objects
# TODO if wanting to learn how to write tests?
- ./3_25_nttest.perl
# exercises
Same as my former exercise solution repos, `- [ ]` means my solution is at least partly wrong. It doesn't mean I skipped this exercise except when I explicitly say that.
## skipped exercises (also see exercises with * before the number possibly)
Also see https://gitlab.com/Lockywolf/chibi-sicp/-/blob/master/Experience_Report.org for what exercises are very hard.
- 2.92
- 4.79
## chapter 1
Up to 1.28 I mistakenly use 20220522214709 (verified by viewing the saved page link colors which has the most *orange* count in my browser history. Its adjacent saved pages [1](https://web.archive.org/web/20220605020839/http://community.schemewiki.org/?SICP-Solutions) [2](https://web.archive.org/web/20220516112916/http://community.schemewiki.org/?SICP-Solutions) all have only the *red* link color) wiki archive instead of 20240228133955 which is latest at that time.
To compare them, I only give one *brief* comparison after inspecting they are mostly similar in  exercise 1.6. And I skip comparing all pages "Last modified" before 20220522214709.
- [Ben Bitdiddle](https://academickids.com/encyclopedia/index.php/Ben_Bitdiddle)
- [x] 1.1, 1.2, 1.4 trivial
- [x] 1.3
  ```scheme
  (cond ((and (<= x y) (<= x z)) (squareSum y z)))
  ```
  - schemewiki has solutions using `min`, etc.
  - jfr just splits into 2 if's.
    - gr should be 
      ```scheme
      (+ 
       (sum-of-square a b) 
       (square c)) 
      ```
      which means same as jfr.
  - bthomas just excludes min and keep 2 numbers.
- [x] 1.5
  - "applicative-order" endless loop due to expanding `(p)`.
    "normal-order" -> `(if (= 0 0) 0 (p)))` -> `0`.
    detailed see schemewiki
  - Also see https://stackoverflow.com/a/61307130/21294350.
- [ ] 1.6 I don't know why "Aborting!: maximum recursion depth exceeded"
  - wiki
    - the key
      > an interpreter follows *applicative substitution*
      so
      > it only evaluates one of its parameters- not both.
      > it never stops calling itself *due to the third parameter* passed to it in sqrt-iter.
      ~~i.e. it will always expanding the 3rd without ending.~~
      > such that any expressions within the consequent or alternate portions are evaluated regardless of the predicate
      > the iteration procedure is *called without return*
      Also see emmp
      > That includes sqrt-iter which is extended to new-if which *again* leads to the evaluation of all the sub-expressions including *sqrt-iter* etc.
      which is same as jhenderson.
    - See R5RS [Conditionals](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_6.html#SEC30)
      and [lambda](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_6.html#SEC29)
      > by binding the variables in the formal argument list to fresh locations
    - jsdalton is same as the main part.
    - book link https://web.archive.org/web/20160603160145/https://mitpress.mit.edu/sicp/full-text/sicp/book/node85.html from 2018 https://web.archive.org/web/20180101000000*/http://mitpress.mit.edu/sicp/full-text/sicp/book/node85.html (I don't read it when learning chapter 1 since they are from chapter 4)
      Also see 1.1.5 for one brief intro.
    - dft
      - without reading his 2nd comment, here `if` is nested in `lambda` so `(/ 1 0)` is evaluated.
        This corresponds to
        > The reason the above example generates an error is because (1 / 0), the second parameter to try, is evaluated before the try is even called.
        And `try` has the same problem as `new-if` indeed.
      - > The applicative vs. normal explanation made sense until I saw the try example above.
        Does him read the 1st version book? See emmp who read the book more carefully.
    - andersc
      - > And I guess for a certain interpreter, maybe it should use a consistent way for all processes?
        As [how_special_form_is_special] says, "special form" is just exception as expected.
    - See uninja's commment which is what I thought after reading dpchrist's comment for how dpchrist's comment is different from the exercise.
    - srachamim's comment is trivial
      See student's comment for where trevoriannguyen is wrong about understanding others' comments although his thoughts are right:
      > Indeed, the new-if procedure *body (which contains the cond special form) is never even applied* to the resulting 3 arguments as the 3rd argument never stops evaluating itself!
    - cypherpunkswritecode says right about if but a bit wrong about `cond`
      See R5RS
      > A 'cond' expression is evaluated by evaluating the <test> expressions of successive <clause>s in order *until one of them evaluates to a true* value (see section see section Booleans). When a <test> evaluates to a true value, *then the remaining <expression>s in its <clause> are evaluated in order*, and the result(s) of the last <expression> in the <clause> is(are) returned as the result(s) of the entire 'cond' expression.
      means same as ["Conditional expressions are evaluated as follows. ..."](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-10.html#call_footnote_Temp_24)
  - 2024 wiki
    - diff
      ```bash
      $ diff sicp-ex-1.6.html sicp-ex-1.6_new.html | grep -v /web | grep -v /\? | less_n
          # only the last comment is added with other misc links updated
      ```
    - what poxxa says about "a sequence of expressions" doesn't influence this exercise's result.
- [x] 1.7
  - wiki
    - TODO
      - > a relative tolerance of 0.001 times the difference between one guess and the next
        Here should be "a relative tolerance of 0.001" by [definition](https://www.mathworks.com/matlabcentral/answers/26743-absolute-and-relative-tolerance-definitions#answer_34847)
      - > This is not the case at all — the original programme checks that the *guess squared* is within 0.001 of the *radicand*, whereas the algorithm described by "random person" checks that the *new guess* is within 0.001 of the *former guess*.
        ~~Weird in the archive link, it "checks that the *new guess* is within 0.001 of the *former guess*" same as this [oldest archive](https://web.archive.org/web/20111211154013/http://community.schemewiki.org/?sicp-ex-1.7)~~
        Maybe he wants to mean
        > because, 0.001 being by definition *smaller than the thousandth of any number larger than 1*, the *lower tolerance* forces the algorithm to continue refining the guess. It is indeed, however, *inferior for very small numbers* because 0.001 is by definition a larger tolerance than the thousandth of any number smaller than 1.
      - Maggyero
        - TODO 
          - after numerical analysis [1](https://math.stackexchange.com/a/3526215/1059606)
            the proof of the 1st formula, "can be written as", Sterbenz lemma, why $\delta$ disappears after Sterbenz lemma, something which we can easily verify.
          - I skipped the proof of the 1st formula
            then the key is
            > 4×10−3 which is larger than the (absolute) tolerance which we are currently using.
            Then "relative error" becomes $\frac{1}{2}\tau$ which is `epsilon` in the code.
            We choose the number maybe due to $|\epsilon|\le u$.
            - [$\lesssim$](https://math.stackexchange.com/q/1793395/1059606)
          why 3/2 and 9/4
        - `(< (abs (- (square guess) x)) (if (= x 0) min-float (* tolerance x)))`
          `min-float` instead of `0` because `<`.
        - notice `(* tolerance guess)` corresponds to the difference with `guess`
          while `(* tolerance x)` is with `x`.
        - [`min-float`](https://en.wikipedia.org/wiki/Double-precision_floating-point_format#Exponent_encoding)
    - Here root should be `sqrt` by [R5RS](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_8)
    - notice those solutions using `abs (- (square guess) x)` in comparison is wrong when that condition can't be met by the precision.
    - Owen
      > because of the *limitation of bits*, the "improved guess" will simply be *equal* to "old guess" at some point, results in (- y^2 x) *never changes* and hence never reach inside the tolerance range. ... This situation applied to the small number case as well --- if *the threshold is to be set extremely small*.
      i.e. 0.001 is no use at all.
      > should never care about a specific precision value (or percentage) at all
      > simply reference to GWB's solution, which I believe is the *best solution*, *guaranteeing to stop* and at the same time, with the *best accuracy*.
    - Thomas
      > I should've read the whole discussion before posting — my mistake!
    - berkentekin is same as solution 1, 2.
    - Maggyero
      QUESTION is same as the problem
      kw: scale, relative error, scaled to the radicand/guess
  - new wiki
    - KoiCrystal
      here C++ is to tune the precision (I didn't dig into the code because the basic idea is probably  same)
    - > so I think the best way is mentioned above by Maggyero: iterating until guess and the next guess are equal
      Maggyero is still based on relative ratio `(* tolerance guess)`.
- [ ] 1.8
  I didn't notice the special case of $x=-2$
  - if we solve $y=x^3\Rightarrow f(y)=y-x^3$
    then $y-\frac{y-x^3}{1}=x^3$ ~~says nothing useful.~~ implies directly calculating $x^3$.
  - Newton's method [may not work](https://scholarworks.utep.edu/cgi/viewcontent.cgi?article=2421&context=cs_techrep#:~:text=Interestingly%2C%20the%20simplest%20example%20on,the%20Newton's%20method%20works%20perfectly.&text=desired%20extension.,%E2%88%92F(%E2%88%92x).) at least when $x_2=x_0$ and ad infinitum.
    > when we have x0, x1 6= x0, and then again x2 = x0, etc.
    This also relates with the init guess. See the code 1_8.scm from wiki.
    - Also see footnote 62 in 1.3.4.
  - wiki
    - See the 2nd solution
      >  ;; Fix: take absolute cuberoot and return with sign 
      which ensures positive -> no weird zero.
      And it directly takes improve instead of `1.0 0.0`
    - the 3rd solution is similar to the original solution in the book for `sqrt`.
    - the 4th is similar to the 2nd.
    - > This solution makes use of the fact that (in LISP) procedures are also data.
      the 5th
      i.e. use func as the param, e.g. `sqrt-improve`.
    - Chan's `if (< x 0)` is said in the 2nd solution
      and `good-enough?` is just same as the 5th.
      - > But I just made this procedure with low precision. I think you can fix this
        one solution is to change from `0.001` to one smaller number.
- [x] 1.9
  - trivially the first is recursive while the second is iterative.
- [ ] 1.10
  This definition is same as DMIA 5.4 exercise 50-57 and mcs p227.
  but not same as [wikipedia](https://en.wikipedia.org/wiki/Ackermann_function#Definition:_as_m-ary_function), [GeeksforGeeks](https://www.geeksforgeeks.org/ackermann-function/#), [wolfram](https://mathworld.wolfram.com/AckermannFunction.html)
  - `(A 0 n)=(* 2 n)`
  - `(A 1 n)=(* 2 (A 1 (- n 1)))` -> $2^n$ by DMIA 5.4 exercise 52 since `(A 1 1)=2`.
  - similarly [$2\uparrow\uparrow n$](https://en.wikipedia.org/wiki/Knuth%27s_up-arrow_notation) i.e. `F(4,n)` in Buck's definition.
  - Based on the above, they are similar to [Buck's definition](https://en.wikipedia.org/wiki/Ackermann_function#History) where the recursive definition is similar to [Hyperoperation](https://en.wikipedia.org/wiki/Hyperoperation) but with ending at y=1 instead of y=2 here.
  - See wiki the above lacks considering $n=0$
  - new wiki
    I don't check the detailed values of $A(3,3)$ since that is a bit useless.
    - > Alternatively, (h n): 0 for n=0, g^{n-1}(2) for n>0
      i.e. $2^{2(n-1)}$ which is wrong.
- [x] 1.11
  - wiki
    - TODO
      meaning of
      > n >= 3 and not n >= 3.0 it is *sufficient*
      > As it is decimal values evaluate to the next whole value. ie *3.2 -> 4*
    - > Here is another iterative version that the original poster called "a little bit different".
      - TODO
        `(+ b a) (+ c (* 2 a)) (* 3 a))`
      - I skipped
        > To see where those calculations come from, consider this example of how (f 5) calculates 25.
        since it can be proved more formally.
      - > Heres another iterative solution, counting up
        (with no relation with the adjacent `(f-iter n a b c)`) is similar to `(f-iter 2 1 0 3)`.
  - new wiki
    - > Note that this solution's use of cond and else is optional. Since there are only two alternatives, you could use if instead of cond, without any else clause.
      trivial
    - the last comment
      - > treat the input variable and the counter as separate variables;
        This seems to be unnecessary since the solution locationed top doesn't mix them
      - > keep the input variables in the same order they appear in the specification.
        already done in "the solution locationed top"
      - > Neither version does any unnecessary calculations
        i.e. exit when one of `a b c` is the result expected.
      - Solution 2 is ~~same as~~ similar to my trivial modification for `(f_iter n)`.
      - > the result of this called on a floating-point input might differ by a small amount from the result of the recursive version called on the same input.
        Their calling orders are [converse](https://en.wikipedia.org/wiki/Converse_(logic)) to each other.
- [x] 1.12 trivial by the footnote definition.
  - wiki
    - the 2nd ~~manipulates with the wrong input cases~~
      assumes all unfilled case zero which make `(= col row)` be contained in `(+ (pascal-triangle (- row 1) (- col 1)) ...`.
    - > I find this one *easier to grok*, it allows only values though:
      almost same as the 2nd but more readable.
    - > Not having to worry about zero values makes it clearer to me:
      same as the 1st
    - > If you don't consider out of bounds cases
      Just change the col and row definition. The basic idea is same as the 1st.
    - > ; Left-aligned triangale with start at row=0 and col=0 
      This weirdly changes the triangle angle although it is feasible.
    - `pas-n` counts from top to below and from left to right.
    - "Wikipedia formula" just index from 0 due to $\binom{0}{0}$ and the rest is same as the 2nd.
      - > Here's one with binomial coefficient and tail recursion:
        This is based on the binomial equation with the index starting from 1.
  - new wiki
    - > Linear recursion. Row and diagonal (column) starting from 1.
      then n row k diagonal -> $\binom{n-1}{k-1}$ as wikipedia says.
      Then `else` is based on $\binom{n-1}{k-1}=\binom{n-1}{k-2}\cdot \frac{n-k+1}{k-1}$
    - I skip checking the syntax of `raise "bad input"`.
- [x] 1.13
  - trivial using linear recurrence or as the hint says using induction.
  - ~~"the closest integer" doesn't hold for `Fib(1)`.~~
    We can use $|\varphi|<0.5$ to directly prove "the closest integer".
    Also see [this][evernote_proof_1_13]
  - [diff between $\models$ and $\vdash$ (See Examples)](https://en.wikipedia.org/wiki/List_of_logic_symbols#Basic_logic_symbols)
    They may not be same but [be same for First-order logic](https://math.stackexchange.com/a/148181/1059606)
  - [sicp-solutions](https://sicp-solutions.net/post/sicp-solution-exercise-1-13/)
    - It directly inserts into the definition and due to the unique solution property, it is proved.
    - Also see [evernote_proof_1_13] which assumes $a^n\ldots$ (although not intuitive if not using linear recurrence) and the rest is similar.
  - wiki is more formal. But the basic idea is same.
    But it
    1. uses the property of "the golden ratio".
    2. cares about "base case" (in [evernote_proof_1_13] but not in sicp-solutions).
    3. ...
  - new wiki
    - It only changes by `num=13;diff sicp-ex-1.${num}.html sicp-ex-1.${num}-new.html | grep -v /web | grep -v /\? | less_n`
      > Fib(k) + Fib(k+1) = (φᵏ⁺²-ψᵏ⁺²)/√5.
      which is already noticed in the old wiki.
- [ ] 1.14
  - wiki
    - https://web.archive.org/web/20220330050258/https://www.ysagade.nl/2015/04/12/sicp-change-growth/
      Read it in https://stackedit.io/app#
      > The analysis below is wrong
      i.e. qu1j0t3's comment.
      - Space complexity similar to the binary tree.
        > contains successive recursive calls with the amount decreased by 1.
        In this case, we first decrease "kinds-of-coins", then decrease "amount" by at least step 1 (in 11 cents, the step is 5).
        So complexity is $O(1)+\lceil n/k\lceil<O(1)+n/k+1=O(1)+n/k\overbrace{=}^{\text{check the dominating term}}O(n)$
      - > the green node is a terminal node that yields $1$ (corresponding to the first condition in the code for cc)
        i.e. $(0,1)$
      - Time complexity
        It assumes each node has time $O(1)$ then count the node number.
        - > $\lfloor {\frac {n} {5} } \rfloor \left( 2n + 2 \right) + 2 = \Theta\left(n^2\right)$
          $O(n^2)$ is got by lifting all terms to $n^2$ and floor to $\frac{n}{5}$
          $\Omega(n^2)$ is got by keeping only the $n^2$ term ~~(if there are negative terms then when $n\to\infin$ we can let it be )~~ $\lfloor {\frac {n} {5} } \rfloor\cdot 2n>(\frac {n} {5}-1)\cdot 2n>\frac {n} {10}\cdot 2n,\text{when }n>10$.
        - > Excluding the root and and the last level in this tree which contains the red-green terminal node, there will be exactly $\lfloor \frac{n}{5}\rfloor$ levels.
          See sicp-solutions
          This doesn't hold when $n=5k,k\in\mathbb{N}^+$
          We should say *"at most"*.
      - > grows *exponentially* with *the number of allowed denominations* of coins, and *polynomially* with the *amount to be changed* when the number of denominations is fixed
    - TODO 
      - 3|1 meaning
    - > since the 2nd branch is O(a), and the first branch is called O(n) times.
      i.e. `(cc (- amount (first-denomination kinds-of-coins)) ...` and `(cc amount (- kinds-of-coins 1)) `.
    - samphilipd's comment shows "stack" summarises the space complexity.
    - gollum0's comment is the summary of ysagade's answer.
    - Another wonderful explanation
      basic idea is similar to ysagade's but it doesn't differentiate between the space complexity and the time complexity.
    - voom4000
      - > both processes try to build a sum \sum_{i=1}^n k_i d_i by incrementing indices k_i
        this seems to be wrong due to 2 branches.
      - It cares about "the number of tuples" without strictly following the process of the tree.
        So it can only give one upper bound -> $O(\ldots)$.
  - repo
    - > (Note that we are not really concerned with the orders of growth as the number of kinds of coins grows, only the amount to be changed.)
      although we can as ysagade does.
    - > At any point in the computation we only need to keep track of the nodes above the current node.
      This seems to said in one wiki link.
    - It is very similar to ysagade although not that rigorous.
  - new wiki
    - Maggyero
      - `a − k × d(n) > 0` is to ensure it can branch
      - Here we have $k-1<\frac{a}{d}-1<=k$
        Then since $\lceil m \rceil -1<m<=\lceil m \rceil$
        We have $k=\lceil \frac{a}{d}-1 \rceil=\lceil \frac{a}{d} \rceil-1$
      - > The space required by the process is the height of the tree and grows as Θ(a) with a and n:
        See https://sicp-solutions.net/post/sicp-solution-exercise-1-14/#orders-of-growth-of-space
        > It is easy to see that the longest series of calls will happen when making the change of the amount n *using only pennies (1 cent)*.
        i.e. `a,n->a,n-1->...->a,1->a-1,1->...->1,1->0,1`
        So $\overbrace{n}^{\ldots a,1}+\overbrace{a}^{0\sim a-1}$
      - `R(a, 0) = 1`
        here we have no sum, so we can also say `R(a, 0) = 0`
      - $R(a, n) = \overbrace{1 + ⌈a/d(n)⌉}^{\text{The longest right branch from the root}} + Σ_{i = 0}^{⌈a/d(n)⌉ − 1} R(a − i × d(n), n − 1) = Θ(a^n).$
        eventually the main part is $Σ_{i = 0}^{⌈a/d(n)⌉ − 1} R(a − i × d(n), n − 1)=Θ(a^n)$.
    - https://sicp-solutions.net/post/sicp-solution-exercise-1-14/#orders-of-growth-of-space
      - "dark gray node" -> solution
      - > ignoring the floor that won’t impact
        since $\lfloor n\rfloor=\Theta(n)$.
      - > By simplifying a little, and ignoring the floor that won’t impact, the result when the number grows larger, it is possible to estimate the number of calls to cc as ... which are composed of two parts
        should be
        > By simplifying a little, and ignoring the floor that won’t *impact the result* when the number grows larger, it is possible to estimate the number of calls to cc as
      - > There is $\frac{n}{5}+1$ green nodes
        ~~See ysagade, it should be $\frac{n}{5}+2$ when $n\neq 5k$.~~
        Here `(cc -3 2)=0`, so it is dropped.
      - Here $T(n,2)=(\lfloor n/5\rfloor+1)\cdot (T(_,1)+1)$ which droppes the "red-green terminal node" in ysagade and uses the correct $T(_,1)$.
        when calculating complexity $T(n,1)$ is also ok since we only cares about *the leading part*.
      - https://github.com/sarabander/p2pu-sicp/blob/master/1.2/Ex1.14.scm
        - ~~TODO~~ `(= kinds-of-coins 3)` simplification
          ```python
          from sympy import symbols
          x, y = symbols('x y')
          from sympy import floor
          from sympy import simplify
          simplify(simplify((floor(x/5)+1+(x-10*floor(x/10))/5+1)*(floor(x/10)+1))) # not work
          ```
          See [this](https://math.stackexchange.com/q/4936005/1059606)
        - [mutually recursive procedures](https://www.geeksforgeeks.org/mutual-recursion-example-hofstadter-female-male-sequences/#:~:text=Mutual%20recursion%20is%20a%20variation,turn%2C%20calls%20the%20first%20one.) for `lecrec`
- [x] 1.15
  - [derivation of the formula](https://qr.ae/psq8oy)
  - `12.15/3**5=0.05`
  - depth: $\lceil \log_3 10a\rceil+1$ when considering the root.
    so space: $\Theta(\log a)$
    time: Here I assume `(p x)` has $\Theta(1)$ time complexity.
    Then we have $\Theta(\log a)\cdot \Theta(1)=\Theta(\log a)$ time complexity.
  - The above is same as wiki.
- [x] 1.16
  - wiki Solution 2 also holds $ab^n$ is constant.
    - Here `(= counter 1)` is needed since $\frac{1}{2}-1$ and $\frac{1-1}{2}-1$ both are not positive integers.
  - repo uses racket implementation where the basic idea is same.
  - ~~TODO~~ why we needs "associative multiplication".
    Because floating may not hold this property in computer See p244 in the reference book.
- [ ] 1.17
  - wiki
    - `12 * 2 + 6` corresponds to `(+ a b)` at the last step.
      Here `n` is not tracked.
    - the 1st method is trivially not iterative since `(* ...` is not at the top level of the recursive call.
  - repo trivial
  - new wiki
    - anon
      > the procedure would throw an error for b=0
      right since it will go into the infinite loop.
      > Easily solved by adding in another condition though.
      Or just as the original code, use `0` as the base.
- [x] 1.18 (See 1.17 code)
  - wiki 
    one `(- b 1)` the other `(- (halve c) 0.5)`
- [x] 1.19
  $$
  T= \begin{matrix}
  p+q&q\\
  q  &p
  \end{matrix}
  $$
  ```python
  from sympy import *
  init_printing(use_unicode=True)
  p,q,m=symbols('p q m')
  M=Matrix([[p+q,q],[q,p]])
  M*M
  Out[2]: 
  ⎡  2          2                  ⎤
  ⎢ q  + (p + q)    p⋅q + q⋅(p + q)⎥
  ⎢                                ⎥
  ⎢                      2    2    ⎥
  ⎣p⋅q + q⋅(p + q)      p  + q     ⎦
  ```
  - wiki
    Here $T^2$ has the *same form* as $T$, so the function can work.
    TODO here I didn't give one linear algebra proof of that.
    - kw of Jordan Chavez:
      Tpq(Txy(a, b))
      T is commutative
      the identity values (i.e. identity matrix)
      We had an accumulator for the "odd" factors -> accumulator goes from 1 to 12 where exp goes from 7 to 6.
    - > b <- (bp + aq) = (0p + 1q) = q   <--- this is the final value fib(n)
      to `(= n 0) q-acc`
      > Each time you replace Tpq with Tp'q', you get to halve the number of times you apply it
      to `(even? n) ...`
      `else` just apply the transformation.
- [ ] 1.20
  - ~~the tree is~~ ~~many nested `if` and keeping `remainder`.~~
    `if` expand and then most of time executes smaller `gcd`.
  - applicative-order -> 4
    ```bash
    1 ]=> (gcd 206 40)
    [Entering #[compound-procedure 12 gcd]
        Args: 206
              40]
    [Entering #[compound-procedure 12 gcd]
        Args: 40
              6]
    [Entering #[compound-procedure 12 gcd]
        Args: 6
              4]
    [Entering #[compound-procedure 12 gcd]
        Args: 4
              2]
    [Entering #[compound-procedure 12 gcd]
        Args: 2
              0]
    ```
  - normal-order (*wrong*)
    each time it will calculate in `if` and then again in `a` of `gcd(a,b)` except for the last time `b=0`.
    So `2*4-1=7`.
  - wiki
    - Notice
      > 14 when evaluating the condition and 4 in the final reduction phase.
      So we don't care `remainder` in `(gcd (remainder 206 40) (remainder 40 (remainder 206 40)))`. We will expand it and only count the `remainder` in `if` since it will again expand to `gcd ...`.
    ~~How does the expansion know ending if it doesn't calculate `(remainder 206 40)`?~~
    ~~Here although we calculate `(remainder 206 40)` but we doesn't insert the result into the corresponding `gcd`. So we have `(gcd (remainder 206 40) (remainder 40 (remainder 206 40)))`.~~
    - Then it will have the form
      ```
      if 0
        gcd 0 1
      if 1
        gcd 1 2
      if 2
        gcd 2 3 
      ...
      if 4 (Here b=0)
        a
      ```
      so we need $1+4+\ldots+(3*3-2)+4=2*(1+7)+4=20$
      - The above is *wrong*
        we should have `gcd 2 1+2+1=4`.
        So we have
        ```
        if 0
          gcd 0 1
        if 1
          gcd 1 0+1+1=2
        if 2
          gcd 2 1+2+1=4
        if 4
          gcd 4 2+4+1=7
        if 7 (Here b=0)
          4
          gcd 7 4+7+1 ; doesn't execute
        ```
        ~~Then we need `1+4+8+15+11` "remainder operations".~~ (wrong) see [repo reference link][repo_reference_1_20]
        Here we have $a_{n+1}=a_n+a_{n-1}+1,a_0=0,a_1=1$ (interestingly this is same as [the process to calculate the complexity of `Fib`](https://stackoverflow.com/questions/360748/computational-complexity-of-fibonacci-sequence/360773#comment138625034_360773))
    - > The correct count should be 1 while the formula gives 2.
      ~~this is wrong. "The correct count should be" $1+1+0=2$.~~
      ```
      if 0
        gcd 0 1
      if 1
        0
      ```
      > b(1)+b(2)+...+b(n)+b(n-1)
      ~~This is wrong because it only considers the above `if` and the ending `4`.~~
      *true* based on [repo_reference_1_20]
      - Then
        > R(n) = SUM(i from 1 to n - 1, fib(i)) + fib(n - 2) - 1
        ~~is also wrong because `fib(n)<=b(n)` then the above is less than `b(1)+b(2)+...+b(n)+b(n-1)`.~~
        - If it is true based on
          > The above formulas are wrong. The truly correct one should be:
          Then `f(n-2)=f(n)+f(n-1)-n+f(n)-1` where `f(1)=1` based on p48.
          Then `0=f(n)+2f(n-1)-n-1`
          ```python
          fib_seq=[0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233]
          for i in range(2,len(fib_seq)):
            print(fib_seq[i]+2*fib_seq[i-1]-i-1) # not all 0
          ```
    - > num_b(k) = fib(k+1) - 1
      ~~This doesn't hold since $2\neq 2-1$.~~
      ```
      num_b fib
      0     0
      1     1
      2     1
            2
      ```
      - The above index is wrong. [See][Fibonacci_variant]
    - > R(n) = SUM(i from 1 to n, num_b(i)) + num_a(n)
      ~~still wrong. Here `4+7+1` in `num_b(n)` doesn't count enough for `a` in `gcd(a,b)`.~~
      True based on [repo_reference_1_20]
    - > The correct formula above can also be written as
      This is based on [`sum(Fib...)`](https://www.cuemath.com/numbers/fibonacci-sequence/)
      Then `f(n+3)-1-n+f(n)-1-1=f(n+2)+f(n+1)-n-3+f(n)=2f(n+2)-n-3`.
    - We ca derive the formula for `num_b` and `fib`.
      ```python
      from sympy import *;init_printing(); from sympy import Function, rsolve; from sympy.abc import n; y = Function('y'); f = y(n+2)-y(n + 1)-y(n)-1;print(latex(rsolve(f, y(n), {y(0):0, y(1):1})))
      from sympy import *;init_printing(); from sympy import Function, rsolve; from sympy.abc import n; y = Function('y'); f = y(n+2)-y(n + 1)-y(n);print(latex(rsolve(f, y(n), {y(0):0, y(1):1})))
      ```
  - new wiki
    - > (It isn't obvious to me either until I looked through the results for k = 1..10. The conjecture is then easily proven by induction.)
      It is also shown in [Fibonacci_variant]
    - 
- [x] 1.21 trivial
- [x] 1.22 See code
- [ ] 1.23
  I don't know the reason.
  > how do you explain the fact that it is different from 2
  - As wiki says
    > This is mainly due to the NEXT procedure's IF test. The input did halve indeed, but we need to do an extra IF test.
    `1_23_no_extra_if.scm` will almost have ratio 2 (See `diff` of them).
    - This is also implied in csapp.
    - Also see this repo which has one more elegant modification.
- [x] 1.24
  - comment
    ```scheme
    ;;; wiki
    ;;; 1. > This exercise requires a Scheme implementations which provides a runtime primitive, such as MIT/GNU Scheme or lang sicp for DrRacket.
    ;;; Or see this repo use `current-inexact-milliseconds` which is same as
    ;;; > Another implementation also easy to understand:
    ;;; 2. > the inner procedure can be rewritten without repeating the if test:
    ;;; the original uses cond which allows multiple statements in one condition
    ```
  - double, not, *can't*. (See code)
  - > This is probably because performing primitive operations on sufficiently large numbers is not constant time, but grows with the size of the number.
    This is true. But this depends on the CPU performance.
  - > To avoid this in DrRacket add: (#%require (lib "27.ss" "srfi")) to gain access to the random-integer procedure.
    [See](https://planet.racket-lang.org/package-source/williams/science.plt/4/2/planet-docs/science/random-numbers.html#(def._((planet._random-source..rkt._(williams._science..plt._4._2))._random-integer)))
    > most likely because operations on large integers (above the normal 32/64-bit limit) are not constant in time
    But in machine code, AVX, etc., will increase the speed.
  - > it's possible that the number we use when testing 1,000,000 is not 1000 times larger than the number we use when testing 1000. Hence the difference in runtime.
    On average, it is still "1000 times larger".
- [ ] 1.25
  - correct
  - yes.
  - see wiki for time consideration although it is intuitive. So *not "fast prime tester"*.
- [ ] 1.26
  - Let $D(n)$ be the multiplication number of `(expmod base exp n)`
    Then 
    $$
    D(n)=
    \begin{cases}
      2D(n/2)+1,n\text{ is even}\\
      D(n-1)+1,\text{otherwise}
    \end{cases}
    $$
    - intuitively the above is just inserting Parentheses which doesn't decrease the multiplication count. So $D(n)=n$.
    - TODO I don't know how to solve it, so I [ask](https://math.stackexchange.com/q/4936035/1059606)
  - > grows exponentially with the depth of the tree, which is the logarithm of N.
    See footnote 37, the depth is at most $\lfloor \log_2 n\rfloor+\lceil \log_2 n\rceil$ (See ).
    So it has at most $2^{\lfloor \log_2 n\rfloor+\lceil \log_2 n\rceil}< 2^{2\lceil \log_2 n\rceil}<2^{2(\log_2 n+1)}=4n^2$ nodes.
    similarly we have $2^{\lfloor \log_2 n\rfloor+\lceil \log_2 n\rceil}>1/4\cdot n^2$
    > Therefore, the execution time is linear with N.
    let depth start from 0
    then we have node number (i.e. multiplication count here) $2^0+\ldots+2^{\Theta(\log n)}=2^{\Theta(\log n)+1}-1=2^{\Theta(\log n)}=\Theta(n)$
  - tiendo1011
    - relation between them
      See https://sicp-solutions.net/post/sicp-solution-exercise-1-26/ last sentence.
  - google
    - https://billthelizard.blogspot.com/2010/02/sicp-exercise-126-explicit.html
      - > A *cursory* inspection of the code makes it seem like the explicit multiplication will cause *twice as many calls* to expmod because each input argument to * will be evaluated separately, instead of only once when expmod is passed as the single argument to square. This *isn't enough to account for the reported slow down*.
      - TODO
        > I should point out that this is a *worst case* scenario.
        > This causes the number of recursive calls to expmod to grow *exponentially instead of simply doubling*.
      - > This is a pretty straightforward linear recursive process
        not exactly since here is $\Theta(\log n)$ instead of $\Theta(n)$
        See book p44
  - repo
    - `3n - 1` only considers
  - [exact formula](https://math.stackexchange.com/a/4936047/1059606)
- [ ] 1.27
  - > because of the way the algorithm was implemented it is also necessary to test whether n is equal to 0 in order to *avoid division by zero*
    IMHO here when $n=0$ we will also loop infinitely.
    - `(remainder a n)` is unnecessary since we will go up from 1 until n.
    - `((not (= (expmod a n n) (remainder a n))) false)` holds when `n=0`
      so `(= n 0)) false` is unnecessary.
- [ ] 1.28 See code
  - See mcs where it uses one newer and better AKS test.
  - > have discovered a ``nontrivial square root of 1 modulo n,'' that is, a number not equal to 1 or n - 1 whose square is equal to 1 modulo n. It is possible to prove that if such a nontrivial square root of 1 exists, then n is not prime.
    See [this](https://en.wikipedia.org/wiki/Miller%E2%80%93Rabin_primality_test#Strong_probable_primes)
    > the only *square roots* of 1 modulo n are 1 and −1.
    ```scheme
    ((even? exp)
      (remainder (square (expmod base (/ exp 2) m))
                m))
    ; change to
    ((even? exp)
      (if (= (remainder (square (expmod base (/ exp 2) m))
                m) 1)
          #f))
    ```
    - Ignore the above codes
  - wiki
    - https://web.archive.org/web/20191231030706/http://wiki.drewhess.com/wiki/SICP_exercise_1.28 from wiki
      - kw
        > Note that the text states that one of the proofs *only applies to odd* numbers, so the prime test checks for even numbers (excepting 2, which is prime) before employing the Miller-Rabin test.
        *non-trival* square root
      - > Similar to ...
        means it also uses "nested functions".
    - Another solution in GNU Guile:
      - This is same as "Another solution that avoids nested functions" iterating all numbers in $[1,n-1]$ but with guile implementation.
      - tiendo1011 means the *book* is wrong instead of the code.
        [See (I only read up to "Correct claim")](https://stackoverflow.com/a/59834347/21294350)
        which means "at least half" $a<n$, we have n is not [a strong probable prime](https://en.wikipedia.org/wiki/Miller%E2%80%93Rabin_primality_test#Strong_probable_primes) to base a.
    - tiendo1011
      - [`values`](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_8.html#IDX369)
        - > A common use of `call-with-current-continuation' is for structured, *non-local exits* from loops or procedure bodies
          > Whenever a Scheme expression is evaluated there is a continuation wanting the result of the expression. The continuation represents *an entire (default) future for the computation*.
  - new wiki
    - Maggyero's answer considers the `n=1` case by `(> n 1)`.
    - I use MIT-Scheme so `(import (scheme small))` doesn't work.
- [x] 1.29
  - [Simpson’s Rule](https://en.wikipedia.org/wiki/Simpson%27s_rule#Quadratic_interpolation)
    - [Lagrange polynomial](https://en.wikipedia.org/wiki/Lagrange_polynomial) interpolation is trivial by finding several *shared points*
      - Here k+1 nodes -> degree<=k due to the form of $l_j(x)$.
    - How to use integration by substitution here -> [See](https://personal.math.ubc.ca/~CLP/CLP2/clp_2_ic/sec_Simpson.html). Then we do $\int_{-k}^k P(t+m)dt,k=m-a,t=x-m$
      Then $y_{-1}=P(-k+m)=P(a)=f(a)$, the rest is similar.
    - The book uses [Composite Simpson's 1/3 rule][Composite_Simpson_rule]
    - notice "Simpson's 1/3 rule" [corresponds to $n=2$](https://en.wikipedia.org/wiki/Simpson%27s_rule#Simpson's_1/3_rule) instead of $n=1$
  - wiki
    - > the error of that method is proportional to the fourth derivative of the function to integrate, so for cube the error is zero.
      See [Composite_Simpson_rule].
      proof [see p218,222](https://newdoc.nccu.edu.tw/teasyllabus/111648701013/Numerical_Analysis.pdf)
      - (7.10)
        - $H'(0)=0$
          since $G'(t)=F(t)+F(-t)-\frac{1}{3}[F(t)+4F(0)+F(-t)]-\frac{t}{3}\ldots$
          Then $G'(0)=0$
        - $H''(t)=G''(t)-5\cdot 4t^3G(1)$
          Let $K(t)=F(t)+4F(0)+F(-t)$
          Then $G''(t)=F'(t)-F'(-t)-\frac{1}{3}[F'(t)-F'(-t)]-\frac{1}{3}[F'(t)-F'(-t)]-\frac{t}{3}\cdot K''(t)=\frac{1}{3}[F'(t)-F'(-t)]-\frac{t}{3}\cdot K''(t)$
          Then $G''(0)=0$
        - $G'''(t)=\frac{1}{3}[F''(t)+F''(-t)]-\frac{1}{3}[K''(t)=F''(t)+F''(-t)]-\frac{t}{3}\cdot K'''(t)=-\frac{t}{3}\cdot (F'''(t)-F'''(-t))$
        - > this means that ...
          due to $\frac{dF}{dt}=\frac{dF}{dx}\cdot \frac{dx}{dt}\Rightarrow F'=f'\cdot \frac{b-a}{2}$
      - (7.18)
        - Here for each interval in m intervals, (7.8) only changes $b-a\mapsto (b-a)/m$. Then we follow [this](https://math.stackexchange.com/questions/4558680/proof-for-the-error-formula-for-composite-simpsons-rule#comment10551791_4558680)
    - > using the composite midpoint rule is not exact because the error of that method is proportional to the *second derivate* of the function to integrate
      [See](https://math.stackexchange.com/a/4327333/1059606)
      - I skipped proving "trapezoidal error".
    - `(* (/ h 3) (sum simpson-term 0 inc fixed-n)))`
      1. solve with odd $n$ case.
      2. it directly solves with composite instead of summing over all $n/2$ small intervals.
    - > This is a similar solution
      - This manipulates with factors instead of the whole term.
        ```scheme
        (* (cond ((or (= k 0) (= k n)) 1) 
              ((odd? k) 4) 
              (else 2)) 
        (yk k))
        ```
    - > There is a third way which approaches the solution by breaking the problem *into four parts*: (f y0), (f yn) and two sums,one over even k and another over odd k.
      just as it says (JAIS).
      - > Here's a version that sums over pairs of terms (2 y_k + 4 y_k+1).
        similar to the above. It just splits the sequence differently
    - `(* (/ h 3) (+ (y 0) (y n) part-value))` similar to "There is a third way" but manipulates with factor same as "This is a similar solution".
    - "GNU Guile:" just uses `let*` to replace multiple `define` which is similar to "This is a similar solution".
    - > So I tried a iterative version
      JAIS
      but as CS 61A notes say, we don't need to explicitly use "iterative version" since it is easily implemented in some language with `for`, etc.
      - `intersimp` same as the 2nd `simpson-term`.
- [x] 1.30
  ```scheme
  (define (sum term a next b)
    (define (iter a result)
      (if (> a b)
          result
          (iter (next a) (+ (term a) result))))
    (iter a 0))
  ```
  - repo uses one specific implementation for one problem.
- [ ] 1.31 See codes for where I was "wrong".
  - [Wallis product](https://en.wikipedia.org/wiki/Wallis_product#Proof_using_integration)
    I learnt the formulae for [$I(2n),I(2n+1)$](https://bitbucket.org/anom_mony/graduate_entrance_exam_simplified/src/4c6a0d7d21c9f78af8f037fde20b271f90dfe88a/textbooks/review/reinforcement/zheng_ti/README.md?at=master#README.md-689) when learning calculus.
  - wiki
    - > Another approach would be to recognize the series as 4*4*6*6*.../3*3*5*5*... The leading factor of 2 in the numerator must be dealt with.
      See wikipedia the correct derivation should start from $2/1$ where LHS is $\pi/2$.
      > as 2 numbers are skipped
      TODO IMHO only the denominator $2$ is skipped
      > which is 1 more than the upper term 
      1 less than
      > we have to divide that back out of the result 
      i.e. `(+ limit 2)`
      - > then there is no need to take into account the "stray" 2 at the start of the numerator sequence.
        - Then simplify more
          > My method is the same as the above. A clarification though, this method works by splitting the formula into:
    - > using integer arithmetic instead of the even? predicate:
      It uses the step of $\lceil (n+k)/2\rceil$ is 2.
      Then since it increases 2 at each increasing step, so we have $2\lceil (n+k)/2\rceil$
      Then we use $2\lceil (n+k_1)/2\rceil+k_2$ to solve $k_{1,2}$.
    - `pi-prod`
      1. Here `n` must be *even* to ensure ending with $1/(n+1)$ for the ~~denominator~~ 1st sequence.
      2. Its `n` is for one *new sequence* like `2 * (1/3) *4 * (1/5) ...`.
    - > Another way is to recognise that the formula for pi is composed of two separate products:
      This is same as the 1st method but with different indices.
    - > The method I used for the Wallis Product recognizes the pairs as following:
      it has map: $a/b\mapsto (a+b)/2$
- [ ] 1.32 See codes for where I was "wrong".
- [x] 1.33
  - wiki
    - the comments are almost all incorporated into the main part except that that is done selectively, i.e. "And the iterative version:" and ctz's is not incorporated directly.
    - > @poly: I don't see the point of defining accumulate in terms of filtered-accumulate.
      i.e. we should define complex from primitive instead of the other way around.
  - repo
    it uses racket library although it can be implemented using what the book has introduced.
    notice `gcd` is already implemented in MIT/GNU Scheme.
- [ ] 1.34
  - if applicative order, then
    1. apply but `f` is *a function*, so we do nothing.
    2. substitute -> `(f 2)`
    3. again do nothing but due to that `2` is one *number*.
    4. `(2 2)` syntax error.
  - wiki
    > Note that both substitution models, applicative-order evaluation and normal-order evaluation, will lead to the same expansion.
    since we do *no expansion*.
- [x] 1.35
  - trivial by dividing by $x$
- [x] 1.36
  - wiki
    > this takes 33 iterations to converge, printing out the final answer on the 34th line.
    same for MIT/GNU Scheme.
    > This converges in 10 iterations, printing the result on the 11th line.
    not same.
- [x] 1.37
  - See [this](https://math.stackexchange.com/a/907268/1059606) for proof of the relation with "the golden ratio". Also [see](https://en.wikipedia.org/wiki/Golden_ratio#Continued_fraction_and_square_root)
    - > The convergents of these continued fractions ... are ratios of successive Fibonacci numbers.
      - convergent [see](https://en.wikipedia.org/wiki/Continued_fraction#Infinite_continued_fractions_and_convergents) ([$a_i$](https://en.wikipedia.org/wiki/Continued_fraction))
      proved by induction
      if $n$th convergent 
      $G_n$ is 
      [$\frac{F_{n+1}}{F_n}$](https://en.wikipedia.org/wiki/Fibonacci_sequence#Definition)
      then $n+1$th is 
      $G_{n+1}=1+\frac{1}{G_{n}}=1+\frac{F_n}{F_{n+1}}=\frac{F_{n+2}}{F_{n+1}}$
  - [answer_2](https://math.stackexchange.com/a/986002/1059606)
    - > Note that the negative root is nicely approached from above by the even numbered terms and from below by the odd numbered terms.
      We first prove $d_n<0$ using induction.
      By induction where the negative root $k$ is the split term which satisfies $k=\frac{1}{-1+k}$.
  - wiki
    - > It takes on the order of ten terms to be accurate within 0.0001.
      I didn't check it because it is ~~no use~~ not easy to know the *exact* iteration number for one specific error bound.
    - > Making the solution recursive:
      `(/ (n k) (+ (d k) (cont-frac n d (- k 1))))` is due to $N_k=N_1$ which also holds for $D_k$.
    - > descend into each layer of denominators
      should be numerator
    - > This Is incorrect. It needs to do the last division. Like This:
      This boy is wrong and the top answer is correct.
      > If you see the text, the definition uses i=1 to i=k.
    - > The recursive solution above is incorrect also. It calculate the finite continued fraction from 1 to k-1
      TODO I don't see any above functions using `k-1` as the init condition.
      And `frac-rec` is right.
    - `(frac-iter 1 0.0)` uses the wrong direction from outer to inner.
      > you neek to work backwards, starting with (n k) and (d k) and working your way down with (n (- k 1)) and (d (- k 1)) etc.
      > For the recursive process, the fraction is built, in a way, from the outside to the inside.
      - > Note that because you start counting at 0, you need to stop the counter at k (not k + 1).
        also implied by `(- k i)` should be positive.
    - > Perhaps the discussion around this exercise is carried to too great a length.
      Yes. Many useless comments.
      > Actually, I think that the recursive version of the first comment and the iterative version of the second comment is already correct.
      For the wiki "2021-11-04 15:43:26", it should be "the recursive version of the *second* comment and the iterative version of the *first* comment" where index starts from the top answer which is seen as one comment.
- [x] 1.38
  - proof
    - [mathworld](https://mathworld.wolfram.com/eContinuedFraction.html)
      - [Olds, C. D. Continued Fractions. New York: Random House, 1963.](https://www.ms.uky.edu/~sohum/ma330/files/Continued%20Fractions.pdf) p71 doesn't prove it.
      - [(Wall 1948, p. 348).](https://archive.org/details/dli.ernet.16804/page/347/mode/2up) 
        TODO (91.3) has 1-,1+ instead of all +.
    - [paper](https://www-fourier.ujf-grenoble.fr/~marin/une_autre_crypto/articles_et_extraits_livres/Cohn_H_A_Short_proof_of_the_simple_convergent_of_e.pdf)
      - > To prove (2) (i.e., An + Bn_i + Cn_i = 0) integrate both
        This is due to RHS $F'$ has $F(1)=F(0)=0\Rightarrow F(1)-F(0)=\int_{0}^1 F'(x)dx=0$
      - > e need only verify the initial conditions A0 = e ? 1, B0 = 1, and C0 = 2 - e 
        TODO 
        - I skipped calculating this integral.
        - I also skipped "convergent" calculation.
      - (2)~(4) is probably due to $p_{3n}$ recurrence formulae, etc.
    - [This](https://www.oswego.edu/mathematics/sites/www.oswego.edu.mathematics/files/eulerdivseriescfproceedings.pdf) is skipped due to only one reference to [E953](https://math.stackexchange.com/a/3385/1059606) -> [15].
    - [This](https://arxiv.org/html/2308.02567v2) is too general
    - [QA](https://math.stackexchange.com/a/3385/1059606)
      - https://people.math.osu.edu/sinnott.1/ReadingClassics/continuedfractions.pdf
        - 40~42
          I don't know 40, $\frac{1}{e}$ expansion in 41, "that if" in 42
      - https://math.stackexchange.com/a/3387/1059606
        - implicitly use https://en.wikipedia.org/wiki/Continued_fraction#Infinite_continued_fractions_and_convergents
      - OEIS gives one proof https://arxiv.org/pdf/math/0601660 (i.e. the above paper) ~~doesn't give one proof~~ like https://oeis.org/A254077
        - https://sci-hub.se/10.2307/27641838 is almost similar to the above paper.
  - repo -> `diff ~/SICP/1_Building_Abstractions_with_Procedures/1.3_Formulating_Abstractions_with_Higher-Order_Procedures/Exercise_1_37.rkt ~/SICP/1_Building_Abstractions_with_Procedures/1.3_Formulating_Abstractions_with_Higher-Order_Procedures/Exercise_1_38.rkt`
- [x] 1.39
  - [proof](https://math.stackexchange.com/a/433857/1059606)
  - I didn't check [this](https://paramanands.blogspot.com/2011/04/continued-fraction-expansion-of-tanx.html) which is more complex.
  - See wiki for some possible optimization
    - > Another version calculating the square *only once* using let.
      > Dividing once by -x outside the call to cont-frac *obviates the need for the if* statement
    - > Here's yet another version, not defined in terms of cont-frac.
      It splits $N_1$ out and pairs $(D_i,N_{i+1})$ and then at last $D_n$.
  - repo see `diff ~/SICP/1_Building_Abstractions_with_Procedures/1.3_Formulating_Abstractions_with_Higher-Order_Procedures/Exercise_1_37.rkt ~/SICP/1_Building_Abstractions_with_Procedures/1.3_Formulating_Abstractions_with_Higher-Order_Procedures/Exercise_1_39.rkt`
- [x] 1.40 trivial
- [ ] 1.41 `5+8` is wrong See wiki
  - wiki
    ` double3 double2 = double2 (double2)` implies
    $a_{n+1}=a_n^2$ where $a_n$ is the call number.
- [x] 1.42 trivial
- [x] 1.43
  - wiki
    - `(lambda (x) x)` manipulates unusual inputs
    - kw
      > An extremely succinct solution uses the *accumulate* procedure defined in 1.32:
      The following related comments can be skipped
      > I think the following solution is more elegant.
    - > An solution with O(log n) complexity using compose:
      similar to `fast-expt`.
      Also see
      > A logarithmic *iterative* solution.
      which is similar to exercise 1.16
- [x] 1.44 very similar to 1.45 but simpler.
  - wiki 
    - "Be aware below is WRONG:" is similar to .
- [ ] 1.45
  Originally I didn't know the answer $\lfloor\log(n)\rfloor$.
  - wiki
    - `(pow b p)` just Exercise 1.16 `fast-expt-iter`.
    - the 2nd comment shares the same basic idea as the 1st.
  - my implementation
    - See https://stackoverflow.com/a/53933846/21294350
      - the key is as An5Drama's comment "In a summary ..." says
        - > my key takeaway/ah-ha moment was when you named and simplified the lambda function and *then defined h*
  - repo
    - https://deltam.blogspot.com/2015/08/sicp145ex145.html
      - TODO how it is strictly proved as [zhihu reference](https://www.zhihu.com/question/28838814/answer/42283723) does.
      - (JP) https://web.archive.org/web/20161018022729/https://sicp.g.hatena.ne.jp/n-oohira/20090207/1233979052 similar to Kaihao says in wiki
      - based on experiments
        - (JP) https://www.serendip.ws/archives/491
          "Rounding" is based on that we *at least* needs $\lfloor\log(n)\rfloor$ ~~TODO~~
        - https://ivanovivan.wordpress.com/2010/08/22/sicp-exercises-section-1-3-4/ 
        - (JP) https://tetsu-miyagawa.hatenablog.jp/entry/20130320/1363781534 which is based on $\lceil \log(n+1)\rceil-1=\lfloor\log(n)\rfloor$ (This can be proved by 3 cases $\log(n)\in\mathbb{N}$ or $\log(n+1)\in\mathbb{N}$ or neither)
        - (JP) https://snufkon.hatenablog.com/entry/2013/06/21/112209
        - http://science.kinokoru.jp/sicp-1-3-4-exercise-1-40-1-46-memo/
      - In a summary it concludes "lowest point <= fixed point" by inspecting some mapping figures although *without one strict proof*.
        Then here $1-2^k<0$, so we have "Rounding up: ...".
        - It visualizes "fixed points" as $f(x)=x$ where $f$ is the mapping compound with many average-damp's.
    - plot
      https://matplotlib.org/stable/gallery/lines_bars_and_markers/simple_plot.html#sphx-glr-gallery-lines-bars-and-markers-simple-plot-py
      ```python
      import matplotlib.pyplot as plt
      import numpy as np

      # Data for plotting
      ending=2.0
      t = np.arange(0.0, ending, 0.01)
      s = 1/2*(t+1/2*(t+2/t))

      fig, ax = plt.subplots() # https://matplotlib.org/stable/gallery/lines_bars_and_markers/stairs_demo.html#sphx-glr-gallery-lines-bars-and-markers-stairs-demo-py
      ax.plot(t, s, label="level 2 average damp to solve $y=\sqrt[2]{2}$") # https://matplotlib.org/stable/api/_as_gen/matplotlib.pyplot.plot.html
      ax.plot(t, 2/t, label="no average damp to solve $y=\sqrt[2]{2}$")
      ax.plot([0,ending],[0,ending], label="y=x") #https://stackoverflow.com/a/31993651/21294350
      ax.set(xlabel='x', ylabel='y')
      ax.set_xlim(0, ending)
      ax.set_ylim(0, ending)
      ax.legend()
      ax.grid()
      
      # axs[1].plot(t, 2/t)
      # axs[1].set(xlabel='x', ylabel='y',
      #       title='no average damp to solve $y=sqrt[2]{2}$')
      # axs[1].grid()

      plt.show()
      ```
  - ~~TODO it seems we can't use neither too large nor too small number of `average-damp`.~~
- [ ] 1.46 See codes
## chapter 2
- [x] 2.1
  - wiki
    - the 1st solution is based on the 4 cases.
    - > it will have sign depending on the number of iterations it runs and the signs of a and b
      due to [remainder implementation](https://conservatory.scheme.org/schemers/Documents/Standards/R5RS/HTML/r5rs-Z-H-9.html#%_idx_294)
      > nr has the same sign as n1
    - > Comment on how the above solution works:
      This is about the 1st solution
    - `(* n (/ d abs-d))` just uses `(/ d abs-d)` as the sign
- [x] 2.2
  - CS61A lab shares the same idea.
- [x] 2.3
  - probably trivial as 2.2. Here I give one brief implementation description
    `(make-rectangle tl_pnt br_pnt)` or `(make-rectangle tr_pnt bl_pnt)` where tl means top left and similar for others.
    Then `(x_len rect)` by `(abs (x-point (minus (top_pnt rect) (bottom_pnt rect))))` (simiar for `y_len`)
    Then `(perimeter x_side y_side)` and `(area x_side y_side)` are trivial.
  - wiki
    Same abstraction for `perimeter` and `area` as the above.
    - > they should call some kind of factory method (cf "Domain Driven Design").
      This just means [the arguments should be assumed to be known](https://en.wikipedia.org/wiki/Domain-driven_design).
      > should match the business domain
    - ~~`parallel-side` naming is a bit not readable.~~
    - cmp's comment is outdated.
    - ";; Here's another one" 
      ~~it assumes these 2 sides are perpendicular then it is same as the top solution.~~
      ```scheme
      (let ((new-x (- x1 (* height (sin theta)))) 
               (new-y (+ y1 (* height (cos theta))))) ...)
      ```
      I checked 2 cases (p1,p2: 1. bl,tr 2. tl,br) and here due to geometry (I won't give one strict proof. I lastly learned about pure geometry is when in middle high school) it can be probably generalized.
    - https://en.wikipedia.org/wiki/Domain-driven_design
  - CS61A lab Week 4
    - The 1st is same as ~~"Alternate implementation of rectangle"~~ ~~"Alternative Implementation II"~~ ~~but doesn't decide the rectangle uniquely~~ "As an alternative to this alternative".
    - kw
      > it includes the common point twice, and it doesn't take into account that the angle between the two legs must be 90 degrees
    - the 2nd is same as "Here's another one".
      - > Specifically, we need to know that if the slope of the base segment is Dy/Dx (using D for delta) then the slope of a perpendicular height should be -Dx/Dy.
        Since Dx=0 or Dy=0 is possible, here the instructor just *rotates the scaled* side.
      - > Alternatively, you might find it easier to redefine perimeter and area in terms of the new representation, and then to make them work for the old representation you'll have to define base-rectangle and height-rectangle in terms of first-leg and second-leg
        Since it is easier for `seg->length` but not vice versa.
- [x] 2.4 trivial `(z (lambda (p q) q))`.
  - wiki
    > That inner function will be passed p and q in that order, so just return the first arg, p. 
    IMHO it is better to state that "passed a and b ... the first arg, a".
  - CS61A lab Week 4
    trivial by the substitution rule.
- [x] 2.5
  - This is proved using *the fundamental theorem of arithmetic*.
  - `cons` is trivial
    `car` may be implemented by keeping checking `(remainder x 2)` after division by 2 with one state variable to check division number until `(not (= (remainder x 2) 0))`. Similar for `cdr`.
  - wiki
    - > The top example has a few more layers than are really necessary, so I flattened it out
      IMHO this is unnecessary for ";; Another way to define count-0-remainder-divisions ".
    - chekkal's is interesting
      where `(expt 3 (logb 3 x))` gets one $3^{b+k},k>=0$
      then `(gcd x (expt 3 (logb 3 x)))` will get $3^b$
      - jsdalton's uses one different implementation similar to the top by recursive calls but with *no state variables*.
- [x] 2.6
  - > Use substitution to evaluate (add-1 zero)
    `(n f)` -> `(zero f)` -> `(lambda (x) x)`
    `(f ((n f) x))` -> `(f ((lambda (x) x) x))` -> `(f x)`
    This is more detailed than wiki.
    - by induction if `(n f)` -> $\overbrace{f(f(\ldots))}^{n\text{ times }f}$
      then it is trivial `((+ 1 n) f)` is also that case.
    - Also directly implement using [wikipedia definition](https://en.wikipedia.org/wiki/Church_encoding#Church_numerals)
  - > Give a direct definition of the addition procedure +
    `(f ((n f) x)))` -> `((n1 f) ((n2 f) x)))`
  - wiki
    - > Essentially, we need to apply a's multiple calls to its f (its outer lambda arg) to b's multiple calls to its f and its x. Poor explanation.
      Yes. The to syntax is a bit messy.
      Just see codes ` (fa (fa (fa (fa ... (fa xa))))...) `, etc.
    - IMHO better to abstract the maths definition and then define all functions.
    - TODO who is Ken Dyck?
    - jsdalton's is interesting (See anonymous's for small correction).
    - alexh's is right by removing redundant `lambda`.
    - in `(define (church-mult m n) (compose m n))`, it is `n` which is transformed by `m`
      while in `(compose (m f) (n f))` it is `f`.
      - `(compose m n)` -> `(lambda (x) (m (n x)))` -> `(m (n inc))`
        while `(lambda (f) (compose (m f) (n f)))` -> `(lambda (f) (lambda (x) (m f) ((n f) x)))` -> `(lambda (x) (m inc) ((n inc) x))`
        The latter needs `lambda` to glue `(m inc)` and `(n inc)`.
      - it is also intuitive by thinking `m,n` as func data
        then `(compose m n)` just means $m\circ n$
        and `(compose (m f) (n f))` just means [$\bigcirc^{m} f\circ \bigcirc^{n}f$](https://math.stackexchange.com/a/1097075/1059606).
    - we better transform `f^n` to `(f (f .. (f` to better understand it~~ since if it is seen as one  *single* entity~~.
    - TODO [`...` semantics](http://erights.org/elang/quasi/terms/like-ellipses.html)
- [ ] 2.7 trivial by `car` -> `lower-bound`
  - wiki
    - jz doesn't assume the order of `a,b` although the book assumes that when implementing `make-rat`.
    - > The passage and the implementation indicate that lower-bound is positional rather than value dependent.
      implies the above assumption.
      We can ignore what HannibalZ says.
- [x] 2.8 `(- (lower-bound x) (upper-bound y)) ...`
  - > Specifying subtraction in terms of addition is more accurate. We also have the example of division specified in terms of multiplication in the text
    ~~This doesn't comply to *abstraction barriers*.~~
    Fine.
    - > This even works for negative valued interval, whether or not , we want to use values in that range ;-)
      trivially this is same as the original implementation. So the original implementation also "works for negative valued interval".
  - > this width of the first interval minus the second interval must equal the width of the result of sub-interval.
    trivially it should be "add" instead of "minus".
- [x] 2.9
  - See my comments for 2.8
  - when $a,b,c,d>0$ for $[a,b],[c,d]$
    then $bd-ac=a(d-c)+d(b-a)\quad(*)$
    but when $a<0<b,c,d$
    then the result is $[ad,bd]$
    $d(b-a)\neq (*)$ trivially.
  - > Give examples to show
    So wiki is enough.
- [x] 2.10 strictly the result is $(-\infty,\infty)$. Then we just signal error without manipulating with it. This is trivial.
  - wiki
    > The answer above(vi) misunderstand the question, if the interval is zero(upper-bound = lower-bound), that's alright, it won't cause any problem
    just reduced to the division by one number.
- [ ] 2.11 See codes for what I was wrong originally
  - wiki
    - > This ensures that we're never breaking any more than we need to at any given time.
      This may mean "we need at ...".
    - TODO
      - > To see how this works draw a chart of the operator
        meaning
      - > What followed was *the cond block to end all cond blocks*. My next challenge would be to make a procedure that simplifies those ands at least, but I want to move on.
        "but I want to move on": Yes. These comments are really too detailed.
    - jared-ross's shares the same logic as atomik's but use the symbolic version.
      - `(repeat-call f n)` will call `f` n-1 times.
      - The test is based on random interval between $[-2.5,2.5]$.
    - jz's is really similar to atomik's.
    - all tests are based on intervals spanning zero.
  - repo
- [ ] 2.12 See 2_11.scm
  - wiki
    here as "6.8 ohms with 10% tolerance" shows, we should use 10 as the param instead of 0.1.
    - danlucraft's is *stricter* (also see ";We are talking about percentages rather than fractions.  Therefore")
      - Also see point 2 of dxdm's to be stricter.
- [ ] 2.13
  - IMHO it is tedious to give cond for each case as 2.11 does which is also implied by 2.11 wiki comments.
    > You may simplify the problem by assuming that all numbers are positive.
  - wiki
    - it should have no $0.5$.
    - sTeven's is more rigorous.

~~TODO http://wiki.drewhess.com/wiki/SICP_exercise_2.16~~
- [ ] 2.14
  - wiki
    - > Here, for par1, R1*R2 and R1+R2 are dependent, so (div-interval R1*R2 R1+R2) got wrong answer.
      ~~TODO At least for "R1 = [1, 2]; R2 = R1 + 1=[2, 3]", we will get the *right* answer.~~
      > 1/R1 + 1/R2; they are all independent,
      ~~why? since R1 and R2 are dependent, then also for 1/R1 and 1/R2.~~
    -  for why "Lem is right".
    - TODO
      > You will get the most insight by using intervals whose width is a small percentage of the center value.
      - ~~[This](https://web.archive.org/web/20141122102312/http://wqzhang.wordpress.com/2009/06/18/sicp-exercise-2-14/) just gives the test, i.e. `(make-center-percent 10. 2.) (make-center-percent 15. 2.)`, without giving the reasons behind that.~~
    - solution
      - > Demonstrate that Lem is right
        See Tengs's comment.
        Also see pt's comment.
      - > Make some intervals A and B, and use them in computing the expressions A/A and A/B.
        See jz's comment
      - > You will get the most insight by using intervals whose width is a small percentage of the center value
        See my first comment.
      - > Examine the results of the computation in center-percent form
        See wqzhang blog.
- [ ] 2.15
  I give one intuitive instead of strict proof:
  Since one interval will increase the error bounds, no repeated intervals imply the better error bounds.
  - wiki
    The above is same as jz's.
- [ ] 2.16
  - > Can you devise an interval-arithmetic package that does not have this shortcoming, or is this task impossible?
    As the examples in 2.14 shows, it may be impossible.
    - See drewhess reference links.
  - wiki
    - jz's comment is mainly about manipulating with "identity".
      - > See the problem is our simple implementation doesn't remember things or record what has been added before
        i.e. not know C-C.
    - > Then you take the min/max of all function values (all of them were 1)
      TODO why min/max
      > analytical methods
      I skipped it
    - https://web.archive.org/web/20200128110657/http://wiki.drewhess.com/wiki/SICP_exercise_2.16
      > some of the laws of algebra that we're accustomed to don't apply to certain operations, so algebraic expressions that are equivalent in a non-interval arithmetic system are not necessarily equivalent in an interval arithmetic system.
      > Which one is "correct"? Are both?

      > There are other algebraic laws that fail in our system *as well*: try squaring the interval [-2,2], for example.
      This says the problem essence.
      - I skipped those too detailed reference links.
      - This replies
        > Explain, in general, why equivalent algebraic expressions may lead to different answers
- [x] 2.17
  - probably by iterative with one `length` state variable and the `list` variable.
    when writing the code I think checking the length is enough.
  - wiki
    - the top answer tracks the *last* without using 2 variables.
    - See otakutyrant's comment.
    - Daniel-Amariei's comment is outdated.
    - I skipped anon's comment since it is beyond the book.
- [ ] 2.18
  - concatenate the `last-pair` recursively.
  - repo same as wiki jz's.
  - CS61A lab same as my last comment.
    - kw
      > However, + is commutative; it doesn't matter whether you add a series front-to-back or back-to-front.  Cons is NOT commutative, and the pair-diagram representation of a list is NOT left-right symmetric.
    - > the first invocation adds the first term to the result and then does the second invocation.
      while recursive will do that in the most inner block by adding *the last term*. Then I read
      > it keeps doing recursive invocations, keeping pending the addition of the partial result into the larger result.
      - See the trace.
    - > but this will be really slow, O(n^2).
      This is also said in "6.001_fall_2007_recitation/r07sol".
    - DAV -> data abstraction violation.
- [x] 2.19
  - `car`, `cdr`, `null?`
  - wiki
    - > -ve
      may mean negati"ve".
    - Rptx's comment has been said in CS 61A notes.
    - I skipped Sphinxsky's comment.
- [x] 2.20
  - use `(f x . y)` then iterate `y` and check `(= (remainder (- (car y) x) 2) 0)`
    This is same as jz's comment.
  - wiki
    - > It's better simply to build the list in reverse order, and then reverse the final list at the end
      i.e. as Exercise 2.18 does. Use `cons`.
      The comment has "----" in wiki to differentiate its comment from others.
- [x] 2.21 trivial
- [x] 2.22
  - See 2.20 for why the 1st fails
    the 2nd doesn't conform to the `list` structure.
    It has something like `p_1:[nil,a], p_2:[p_1,b]` ...
- [x] 23
  - The preface is same as [R5RS](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_8.html#IDX362).
  - trivial by [mimicking](https://ell.stackexchange.com/a/338220) `map`.
  - See wiki. Here the concatenation operator depends on the returned value of `(null? items)`.
    - See simv's comment.
      - the code after it assumes `(>= (length items) 1)`.
      - See sritchie's comment for the improvement.
    - > so it can arbitrarily be the list of items in the list applied to the given procedure.
      it should be "the list of items which is got by applying the given procedure to the list".
- [ ] 24 just `(list 1 2 3 4)` (wrong)
  - See wiki. Here `(list 2 (list 3 4))` is stored as one pointer instead of beginning with 2.
    - See wiki 25 solution "(cons 5 (cons (cons 6 (cons 7 nil)) nil))" for how these `list`'s work.
- [ ] 25
  - `(car (cdar (cddr '(1 3 (5 7) 9))))`
  - `(caar '((7)))`
  - `(car (cddr (cddr (cddr '(1 (2 (3 (4 (5 (6 7))))))))))` *wrong*.
    `(cadr (cadr (cadr (cadr (cadr (cadr '(1 (2 (3 (4 (5 (6 7))))))))))))` call `cadr` ~~7~~ 6 times.
  - wiki
    - timo do the solution from inside to outside instead of from outside to inside.
    - `(error "Just cAr or cDr - -  Char Not recognized" (car oper))`
      Here `(car oper)` [can't be too large](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Error-Messages.html#index-format_002derror_002dmessage).
  - repo
    - After translating into `cons` seq also as jz shows, all is intuitive.
- [ ] 26
  - `(1 2 3 4 5 6)`, `((1 2 3) . (4 5 6))`, `((1 2 3) (4 5 6))`
    the 2nd is *wrong*.
  - wiki
- [ ] 27
  - wiki
    - jz
      - `(append (deep-reverse (cdr x)) ...` is based on `cdr` is always one list.
    - > A solution that uses reverse to do the work:
      most straightforward translating
      > the list with its ele-ments reversed and with all sublists deep-reversed as well
- [ ] 28
- [x] 29
  - [mobile](https://ell.stackexchange.com/a/234182)
- [x] 30 just similar to `scale-tree` (i.e. as wiki bishboria or meteorgan's 2nd says. Also see master's and "The map solutions implicitly handles nil trees, though.")
  - wiki
    > you're simply specifying a transformation to apply to elements of an input
    ~~IMHO both are manipulating with "elements of an input". But master ~~
    i.e. without `if` but just `square-tree` transformation.
- [x] 31 almost same as 30 (see wiki bishboria).
  - jwc's doesn't use `map` ...
- [ ] 32 why no `car`?
  - see wiki
    - > the set of all subsets excluding the first number, with the first number re-inserted into each subset.
      This implies the subset number doubles when increasing the element number by 1.
      - Also see "evolve the process manually"
- [x] 33
  - `(cons (p x) y)`
  - `seq2 seq1`
  - `(lambda (x y) (+ y 1))`
- [x] 34
  - > Horner’s rule evaluates the polynomial using fewer additions and multipli-cations than
    Horner’s: n multipli-cations and n additions
    th original: n additions but with $n+\ldots+1$.
  - `(+ this-coeff (* x higher-terms))`
- [ ] 35
  - ~~`(map enumerate-tree t)` although~~ we can directly `(enumerate-tree t)`, then do as Exercise 2.33 `(length sequence)`. (Using identity is hinted by wiki `(lambda (x) 1)`)
    - See wiki top solution for how to use iterative in `map`.
      It just incorporates "iterative" of `(enumerate-tree t)` into the map.
- [x] 36
  - `(map car seqs)`
    `(map cdr seqs)`
- [ ] 37
  ```scheme
  (lambda (w) (dot-product v w))
  (accumulate-n cons '() mat)
  (lambda (row) (map (dot-product v w) cols)) ; row-vector*matrix.
  ```
  - See wiki, here row or column vectors are assumed with the same form, i.e. list, since (column) vectors and *rows* of matrices are both lists.
   ~~ So the first form returns a list which is ~~
  - ~~So~~ the above 3rd is *wrong* and can be better.
  - repo
    - https://www.3blue1brown.com/lessons/dot-products
      - > This linear transformation function is a 1x2 matrix.
        just think of matrix as cols which are *maps* of corresponding coordinates.
        See
        > feels just like taking the dot product of two vectors.
      - > Why on earth does this *numerical process of matching coordinates*, multiplying pairs, and adding them together *have anything to do with projection*?
        what this video intends to convey.
      - Then based on *"Linear transformation"*, we first checks how Linear transformation $unit(w')*v$ works (then scale it by $|w'|/|unit(w')|$ we get the result by *scaling the basis* "each of its components gets multiplied by 3"). Then we check $unit(w')*v_x$ and $unit(w')*v_y$ (then use Linear transformation to get $unit(w')*v$). Then we check $unit(w')*unit(v_x)$ (Again we use Linear transformation to get $unit(w')*v_x$. Similar for $v_y$). This just means $\hat{u}*\hat{i}$.
        So the above just does the unit projection and then scale. But since projection meets the properties of Linear transformation, so we can just project.
        Then projection by "Linear transformation" is implied by *matrix multiplication* (i.e. dot product by *duality*).
- [ ] 38
  - Here `(op result (car rest))` corresponds to [`(lambda (acc elt) ...)` in `fold`](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Folding-of-Lists.html#index-fold_002dleft).
    - Here `fold-left` does `(kons (kons (kons knil e1) e2) … en)` which is different from `fold`.
      This is also different from MIT-Scheme `fold-left` since it does `(proc elt acc)` instead of `(op result (car rest))`.
    - Notice if mimicking
      > because it combines the first element of the se-quence with the result of combining all the elements to the right.
      `fold-left` should be defined almost same as `fold-right`
      ```scheme
      (define (fold-left op initial sequence) 
        (if (null? sequence) 
            initial 
            ;; only swap the following order.
            (op 
              (fold-left op initial (cdr sequence))
              (car sequence)))) 
      ``` 
      But that can be achieved easily by modifying `op` argument order.
      So maybe due to this `fold-left` is not defined as the above shows.
  - `(/ 1 (/ 2 (/ 3 1)))` where the last 1 is knil.
  - `(/ (/ (/ 1 1) 2) 3)`
  - property: `(kons (kons (kons knil e1) e2) … en)` (`fold-left`) is same as `(kons e1 (kons e2 … (kons en knil)))`.
    which can be done based on 3-ary Commutative property (make `e1` of the former at the most outside) and 2-ary Commutative property to swap, e.g. for `knil en` of the transformed former.
    - ~~following wiki woofy~~
      ~~`(kons (kons (kons knil e1) e2) … en)` -> `(kons (kons (kons e1 (kons e2 knil)) … en)`~~
  - wiki with the *correct detailed* description about the property the but the repo doesn't.
- [ ] 39
  - based on the above "property:"
    `fold-left` is more straightforward: `(cons x y)` (wrong order)
    `fold-right`: `(append y x)`
  - wiki
    - the above should use `(list x)`.
    - Liskov
      `(list x)` as each new `knil` does same as `reverse` (See the above "property:").
- [x] 40
  - shouldn't it just be `(flatmap ...)`?
- [ ] 41
  - generate all triples and then filter.
- [x] 42
- [ ] 43
  - I don't know since IMHO here `(queen-cols (- k 1))` in the changed case doesn't depend on the outer loop and also for `(enumerate-interval 1 board-size)` in the book original case.
  - wiki
    - jpath's assumes `enumerate-interval` has O(1) time.
    - I didn't dig into https://wernerdegroot.wordpress.com/2015/08/01/sicp-exercise-2-43/ since maths is not the main point to learn for SICP.
    - repo doesn't consider `map` count in the modified case.
- [x] 44
  - trivial since exercise already gives the solution.
  - wiki I only checked jz and aQuaYi.com.
- [x] 45
  - trivial based on 44. See jz's.
- [x] 46
  - trivial since exercise already tells how to do that.
  - wiki
    - TDD means "Test Driven Development"
    - See jz's.
- [x] 47
  - trivial
- [x] 48
  - trivial based on 46.
  - ~~wiki IMHO electraRod's is better.~~
- [x] 49 See codes
  - wiki I skipped `wave` since I can't know how to draw it by only inspecting it.
- [x] 50 rotation is trivial and also see ctz's in wiki sicp-ex-2.42.
  - `flip-horiz`: ((1,0),(0,0),(1,1))
  - See dudrenov
- [ ] 51
  - "analogous to the beside procedure given above": just change the corresponding coordinates.
    "in terms of beside and suitable rotation operations": `(rotate90 (beside painter1 painter2))`
  - wiki
    we needs `(rotate270 painter1)`, etc.
- [x] 52
  - I skipped a. since it is just adding some segments although the values depends on how we view "smile".
  - b. `(beside up up)` -> `up`.
  - c. `(square-of-four flip-horiz identity rotate180 flip-vert)` -> `(square-of-four identity flip-horiz flip-vert rotate180)`
    - wiki uses one different modification but both are fine here since we only need "in a different paern".
- [x] 53
  - trivial
- [ ] 54
  - base case is `'()` and symbols.
  - wiki `'()` is just one special symbol, so we can *simplify* the above.
- [x] 55
  - trivial
- [ ] 56 See codes "lacks".
- [ ] 57
  - `(define (augend s) (list '+ (caddr s)))` (*lacks* `singleton?`. see wiki)
    "products" is similar.
- [ ] 58 See codes "The above is wrong".
- [x] 59
  - just mimicking `intersection-set`.
- [x] 60
  - `element-of-set?` and `intersection-set` same
    `adjoin-set` just `cons`
    `union-set` just `append`
  - for efficiency where we use the latter 2 much more frequently.
    - See partj's.
- [ ] 61
  - trivial since it is just constant complexity plus `element-of-set?` complexity.
    - See wiki 
      the above is wrong since we needs to keep the increasing order.
    - Also see book "and the element being added to the set is never already in it."
- [ ] 62
  - `(or (null? set1) (null? set2))` changed to the similar forms in exercise 59
    when `(= x1 x2)` is false, `(cons x1 (cons x2 (intersection-set (cdr set1) (cdr set2))))`
  - See wiki shyam's we needs to ensure the order afterwards.
- [ ] 63
  - a. IMHO they are same using [In-order](https://en.wikipedia.org/wiki/Tree_traversal#In-order,_LNR).
  - b. still same since call right first -> entry -> left.
    - See wiki meteorgan's.
  - repo doesn't consider `append` complexity.
- [x] 64
  - based on wishful thinking where leaves are all branches with 2 `'()` child branches with leaf got by `(this-entry (car non-left-elts)`.
  - Also see `~/SICP_SDF/lecs/6.001_fall_2007_recitation/codes/rec9/4.scm`
  - complexity same as `tree->list-2`.
    - wiki
      > both of which take constant time
      I didn't check which solution is right but just follows the top.
- [x] 65
  - ~~Similar to Exercise 2.62, the former 2 cases are same.~~
    tree -> ordered lists -(2.62 etc.)> transformed lists -> tree.
    - same as hp's but use different transformation. (also see emj's)
      same as repo.
- [x] 66
- [x] 67 trivial
- [x] 68 See codes
- [ ] 69 See codes "more general"
- [x] 70 trivial by `(encode '(Get a job) (generate-huffman-tree '((A 2) (GET 2) ...)))`
  - $\log 8*8$ using "fixed-length" "for the eight-symbol *alphabet*".
- [x] 71
  - trivial by duplicating
    ```
        /   \
    2^{n-1} ...
            / \
        2^{n-2}   
      ...
    ```
    1,n-1
- [x] 72
  - $O(tree-depth)$ for `encode-symbol` due to ~~`append`~~
    so $O(n)$ for "least frequent" and $O(1)$ for "the most frequent" for 2.71.
  - see wiki jirf's "searching for the symbols in left-branch" and my comments based on repo.
- [x] 73
  - a.
    `((get 'deriv (operator exp)) (operands exp) var)`
    make-??? -> get ...
    addend, etc. -> operands
    - since no related operators for "number? and variable?".
- [x] 74
  - See repo for one complete implementation.
  - IMHO this exercise is open, so any reasonable solutions are accepted.
- [x] 75 trivial.
- [x] 76
  - generic opera-tions with explicit dispatch
    new type: new constructor, selector with new `cond` case, new predicates like `rectangular?`.
    new op: probably new selector, just writing this proc is enough.
  - data-directed style
    new type: all in one `install-foo-package` with no predicate.
    new op: add one func in all corresponding `install-foo-package`
  - Message passing
    new type: one new `make-from-foo-bar`
    new op: add one `cond` case for each `make-from-foo-bar`.
  - > new types must oen be added
    data-directed style / Message passing
    > new operations must oen be added
    generic opera-tions with explicit dispatch
    - same as jirf's.
  - wiki
    - > by adding new entries in the dispatch table
      i.e. `put`, etc.
    - jirf
      - > Might have to jump around to make sure you include each data type in the dispatch table.
        i.e. ensure we have `(rectangular? z)` etc. all included.
      - notice
        > Creating a new data type requires *only* the creation of the constructor. 
- [ ] 77
  - IMHO we also need `(define (magnitude x y) (apply-generic 'magnitude x y))`
    then we first get this func from polar, then put it. Then at the outside we again get it from `(complex)`.
    > how many times is apply-generic invoked?
    1 (*Wrong*. See the following)
    > What procedure is dispatched to in each case?
    trace back from "get it from `(complex)`".
  - See wiki jirf's for why the original fails.
    as his second to last paragraph says, we installs `(define (magnitude z) (apply-generic 'magnitude z))` by `(put 'magnitude '(complex) magnitude)`
    so `(apply-generic 'magnitude z)` -> `(apply proc (map contents args)` where proc is *still* `(apply-generic 'magnitude z)` -> `(apply-generic 'magnitude ('rectangular . (3 . 4)))` then call the primitive `magnitude`.
- [ ] 78
  - just add `number?` etc. predicates (*lacking details* like `((number? datum) 'scheme-number)`)
  - wiki IMHO top one is fine for "simply as Scheme numbers" with `(number? contents) contents`.
    `((number? datum) 'scheme-number)` is to make `get` work.
- [ ] 79
  - wiki
    > I think it's best to define equ? in each implementation of complex:
    unnecessary since `real-part` etc. are already generic.
    - This is similar to 2.77 with 2 calls for `apply-generic`.
    - > The above solution for defining equality for polar terms is incorrect.
      This is related with maths instead of how to program.
  - repo
    better with one `(install-equality-package)` combining `eqn?` together and considering  comparing different types.
- [x] 80
- [x] 81
  - > apply-generic may try to coerce the arguments to each other’s type even if they already have the same type
    when `proc` doesn't have type like `'(scheme-number scheme-number)`.
    - a. but this will cause the infinite call loop.
  - b. wrong.
  - c. 
    put the trivial check outside `(let ((t1->t2 (get-coercion type1 type2)) ...)`.
  - wiki IMHO meteorgan's is right and same as the above.
  - repo
    > both are correct
    IMHO for Louis it means we need to do c.
- [ ] 82
  - e.g. only one "suitable mixed-type operations" where the former half is the 1st type and the rest is another.
  - jirf's will fail if `after-coerced` is nil when trying coercing all the rest to the 1st type.
    2bdkid's just implements the book "One strategy" (same for repo).
  - IMHO here we have $n^n$ combinations for n args, so one straightforward but not good solution is to try all *available* combinations.
    TODO how to solve this elegantly not using "One strategy"?
- [x] 83
  - repo is better based on coercion and with `(install-real-package)`.
- [x] 84
  - if as 83 repo does, raise is based on coercion. Then just change `(t1->t2 a1)` to `(raise a1)`
    - > will not lead to problems in adding new levels to the tower.
      just let `raise` manipulate with "new levels".
    - all these are contained in `try-raise` which avoids keeping recursively calling `apply-generic`.
    - > need to devise a way to test which of two types is higher in the tower.
      repo solves this similar to Exercise 2.82. 
  - wiki
    - meteorgan's
      `(equal? s-type t-type)` won't occur since `(proc (get op type-tags))` may probably already return one value.
      `(raise-into a1 a2)` don't need 2 args since where to raise is already defined.
      - sam's is right for the unnecessary `((equal? s-type t-type) s)`.
    - I skipped Rptx's implementation since `level` is not necessary.
- [ ] 85
- [x] 86
  - > De-scribe and implement the changes to the system needed to accommodate this.
    all related operations like `(+ (real-part z1) (real-part z2))` needs to be generic.
    See YZ's for the detailed list.
- [x] 87
- [ ] 88 See codes "; wrong type"
- [ ] 89 See codes `adjoin-term`
- [x] 90
- [ ] 91
- [ ] *92
  - IMHO here what we needs to do is just make 2 poly share the same order of var's.
    - Review when reading SDF chapter 4:
      > By imposing an ordering on variables
      > One can impose a towerlike structure on this by ordering the variables and thus always converting any polynomial to a ``canonical form'' with the *highest-priority variable dominant* and the lower-priority variables buried in the coefficients.
      The basic ideas are straightforward compared with 4.79. I may skip this exercise due to "This is not easy!" and I have already got the *underlying programming ideas* which are what I learnt SICP for.
      > This strategy works fairly well, except that the conversion *may expand a polynomial unnecessarily*, making it hard to read and perhaps less efficient to work with.
      e.g. $(f_1(x)*z^2+f_2(x)*z+f_3(x)*z)$ is already one simplified form when we think of `z` as the highest-priority variable. But we will expand and re-connect when thinking of `x` as "the highest-priority variable".
      - This is ~~probably~~ the 2nd exercise with something like "This is not easy!" (the 1st is  probably SDF exercise 2.14) since I read SDF chapter 3 after SDF Chapter 2 and then SICP "sections 2.4 and 2.5".
  - wiki
    > So everything will be "raised" to a polynomial in x.
    
    this doesn't ensure the ordering by reading the paragraph (The codes are too long, I didn't dig into it.)
  - > Well, the sketch of the idea was to rearrange the polynomials to a canonical form, so that the variables are *ordered sequentially*.
    
    lockywolf may be right but I won't dig into it due to the complexity of "the net amount of hours spent is about 10" ...
- [x] 2.93
  - just change `+` etc. to `add` etc. and check tag in `make-rat`.
  - see repo which incorporates `gcd-terms`.
- [x] 94
  - `remainder-terms` trivial by `cadr`
    `gcd-poly` trivial by using `gcd-terms`
    `greatest-common-divisor` uses `apply-generic`.
  - > A Euclidean ring is a domain that admits addition, subtraction, and commutative multiplication
    [See](https://en.wikipedia.org/wiki/Ring_(mathematics))
    > satisfying properties analogous to those of addition and multiplication of *integers*.
    - ~~TODO~~ why define such a measure?
      maybe due to `y = qx + r` have the greater degree than `x` for polynomial case.
- [ ] 95
  - $$
    Q_1=11x^4\ldots\\
    Q_2=13x^3\ldots
    $$
    so $Q_1/Q_2=\frac{11}{13}x\ldots$
  - >  try tracing gcd-terms while comput-ing the 
  - TODO (maths)
    why `c 1+O 1 −O 2` where ~~dividend will have the greatest order $2O_1-O_2$~~ the 1st quotient term will be $(cx)^{O_1-O_2}$.
    - > Our answer will thus differ from the actual  by an integer constant factor
      why must remainder also scale?
- [x] 96
  - a. trivial by `(div-terms (* a factor) b)`
  - b. use `fold` with `gcd`.
    - wiki scheme internal `gcd` can accept multiple arguments. 
  - > When you obtain the , multiply both numerator and denomi-nator by the same integerizing factor before dividing through by the , so that division by the  will not introduce any nonin-teger coefficients
    maybe this is based on "Our answer will thus differ from ...".
- [ ] 97
## chapter 3
- [x] 1~5
- [ ] 6
  - IMHO we need one `base` which is inited to 0.
    then 
    generate: `(+ base (random))`
    reset: `(set! base ...)`
  - See wiki using self-defined `rand-update`
    the above can't ensure "*starting* from a given value".
- [x] 7
  - we first check the old password
    and then checks the new one by adding one new `dispatch` wrapper based on `peter-acc`.
- [x] 8
  - for simplicity, let `f` be binary func.
    so we does (`v` is the local variable)
    from left to right: `(+ (f-op v 0) (f-op (f-op v 0) 1))`
    from right to left: `(+ (f-op v 1) (f-op (f-op v 1) 0))`
    By trial we can let `v` be inited with `1` and `f-op` be `*`.
  - wiki 
    the above is same as chm's.
  - repo is based on passing arguments as one contrived sequence.
- [ ] 9
  - recursive
    create E1~E6.
    similarly for iterative but with the different bindings and body.
  - wiki
    - Notice as Figure 3.5 shows, here E1~E6 all have GLOBAL as "the enclosing environment".
    - The above "iterative" is *wrong*.
    - repo is same.
  - > e environment model will not clarify our claim in Section 1.2.1 that the inter-preter can execute a procedure such as fact-iter in a constant amount of space using tail recursion
    See wiki where the *relations between calls* are not shown explicitly.
- [ ] 10
  - For `(define W1 (make-withdraw 100))`,
    here `((lambda (⟨var⟩) ⟨body⟩) ⟨exp⟩)` will create one `E1'` in `E1`.
  - So `(W1 50)` will create one `E1''` in `E1'`.
  - > Show that the two versions of make-withdraw create ob-jects with the same behavior.
    trivial since `balance` is "alias" of `initial-amount`.
    - wiki
      See `(W1 50)` behaviors for details.
      So "alias" is *wrong*.
  - wiki
    ~~Here `E1''` is "body: (if (>= balance amount) ... )"~~
    ~~`E1'` ~~
    Here `E0` is the above `E1`.
    And `E1` is the above `E1'`
    - In a summary each new `lambda` will create one new env
      > A procedure object is applied to a set of arguments by constructing a frame
      Here actually we have 3 lambda's `(make-withdraw initial-amount)`, `(let ((balance initial-amount))` and `(lambda (amount)`.
    - ~~Compared with Figure 3.8~~
      ~~here it combines "..." and `(if (>= balance amount) ...)`.~~
      ~~And it just relocates the "a pointer to the environment" (the internal ideas are same.)~~
      `body: (if (>= balance amount) ... )` has no relations with `amount: 50 ...` in Figure 3.8 since that is related with `(W1 50)` which creates *one new env* due to "A procedure object is applied to a set of arguments" (see Figure 3.3 `E1`).
    - > How do the environment struc-tures differ for the two versions?
      See Amy's comment.
  - repo no solution.
- [ ] 11
  - `(define acc (make-account 50))`:
    `make-account` has one *pair* in global.
    when applied with arg `50`, `E1` is created.
    Similarly `withdraw-E` etc. *pairs* are created in `E1`.
  - `((acc 'deposit) 40)`
    `(acc 'deposit)` will create `E2` under `E1`, similarly `E3` for `(deposit 40)`.
  The above is similar to Figure 3.11.
  - `(set! balance (+ balance amount))` will do similarly as Figure 3.8~9.
  - `((acc 'withdraw) 60)` is similar to the `'deposit` one.
  - > Where is the local state for acc kept
    i.e. `balance` etc. in `E1`
  - > How are the local states for the two accounts kept distinct?
    one totally new `E1'`.
  - > Which parts of the environment structure are shared be-tween acc and acc2?
    The code parts of `withdraw` etc. (see Figure 3.11).
    - See wiki for what is *lacked*, i.e. "global environment".
  - wiki shares the same basic ideas as the above.
  - repo no solution.
- [x] 12 trivial `(b)` and `(b c d)`
  - I will skip all of box-and-pointer diagrams since that is routine.
- [x] 13 trivial 
  - the pointer pointing to `c` points back to the 1st pointer (see Figure 3.15 for what this means).
    - wiki 
      wrong since we are `set-cdr!` but not `set-car!`.
  - infinite loop
- [x] 14
  - based no each call we does (I assume `(set-cdr! x y)` sets `x` in `loop` instead of `mystery` which is ensured by book "That is, one finds the *first* frame in the environment that contains a binding for the variable and modi-fies that frame.")
    The following `x` are all `x` in `mystery`.
    `(x y)` -> `((cdr x) ((car x) y))` and `x` -> `((car x) y)`
    `((cdr x) ((car x) y))` -> `((cddr x) ((cadr x) ((car x) y)))` and `(cdr x)` -> `((cadr x) ((car x) y))` (notice here `x` in `mystery` doesn't change.)
    - so recursively at last we have `(nil x')` ~~where `(cdr x')` is nil.~~
      ~~so it is just `last-pair`.~~
      Then `y'` is `(reverse x)` since we pass `y` as nil in `(loop x '())`.
      And `x` is only changed in the first `loop` call so it is `(car x)`.
    - The above assumption is verified in CS61A notes.pdf p54 I-B.
  - > Draw the box-and-pointer diagram that represents the list to which v is bound
    trivial
    > Draw *box-and-pointer* dia-grams that show the structures v and w aer evaluating this expression.
    > What would be printed as the values of v and w?
    Let `v` be `(1 2 3)`, ~~then we will do `(1 nil)` -> `(2 1 nil)` -> `(3 2 1 nil)`. Here we already have . ~~
    Based on the above analysis, `v` becomes `(1)` and `w` is `(3 2 1)`.
    - ~~See wiki x3v's "box-and-pointer" is not as the pattern of the original `v`.~~
    - repo just runs *without explanation*.
- [x] 15 trivial
- [ ] 16
  - return 3: `(cons (cons 1 2) (cons 1 2))`
  - return 4: let `x` be `(cons 1 2)`, then `(cons (cons x 2) x)`
  - return 7: based on 4, we need add 3. So ... I don't know.
    - ~~based on ~~ wiki have `(cons (cons x x) (cons x x))`
      ~~we can have `(cons (cons x 2) (cons x 2))`~~
  - never return at all: ~~both `car` and `cdr` points back to `x`.~~
    `y=(cons (cons 1 2) (cons y 2))` (I don't know how to do this in Scheme)
    - wiki use `set-cdr!` after already defining one pair.
- [ ] 18
  - wiki
    - > any of your next boxes will point to the different 'a', but yours will break and claim it's an infinite loop which is not true
      TODO maybe due to `memq`.
    - > but all that stuff accumulated in the "local storage" after walking down the sublist is now a garbage and shall not be referenced anymore ... (because it's on lower level and is *finite*, which means it doesn't contain an infinite loop).
    - > in case of mutating that storage we will have all named garbage in there
      so no `set!`.
    - TODO
      > In other words, we have to throw into our "local storage" *only the pointer* to that sublist
  - IMHO DFS works for [the general case](https://stackoverflow.com/q/79155452/21294350)
  - BFS
    DMIA only has https://www.geeksforgeeks.org/detect-cycle-in-a-directed-graph-using-bfs/ related with bfs to check cycle.
    But that needs all `Nodes` which is inappropriate here.
    - https://favtutor.com/blogs/detect-cycle-in-directed-graph#:~:text=Detecting%20cycles%20in%20directed%20graphs%20can%20also%20be%20done%20using,a%20cycle%20in%20the%20graph.
      ~~is more straightforward for the case here where each car/cdr adds one level.~~
      > However, B is already in the visited set, and its parent node is not E, but A.
      is wrong.
      Think about A->B->E->D->C (here D->C is fine).
                      ->C
- [ ] 19
  since we need to track what *has been* encountered, how to achieve "a constant amount of space"?
  - TODO change "See the following."
  - https://en.wikipedia.org/wiki/Cycle_detection#Floyd's_tortoise_and_hare (*1d*)
    - cycle with $k,\lambda,\mu$ definitions <-> $x_i=x_{i+k\lambda},\forall i\ge\mu$ (i.e. we keep following the cycle.) -> $\exists i=k\lambda\ge\mu$ since k can be arbitrarily large (<- based on "cycle with $k,\lambda,\mu$ definitions") -> $x_i=x_{2i}$ (<- should be based on "$x_i=x_{i+k\lambda},\forall i\ge\mu$").
      So $v=k\lambda$.
      Then the first $x_\mu=x_{\mu+v}\leftrightarrow x_\mu=x_{\mu+\lambda}$ based on the definition of $\lambda$.
    - The above seems to only think about *1d*
      - algorithm about general graph including the ["alleged binary tree"](https://stackoverflow.com/q/7140215/21294350) here.
        - https://stackoverflow.com/a/261595/21294350 not O(1)
        - https://stackoverflow.com/q/11355382/21294350 (I only check the question title)
          ~~needs to traverse the graph TODO~~
          needs to keep table of *all* edges to check whether duplicity, so not O(1) IMHO.
      - complexity
        > O(1) storage space.
        trivial as wiki "Note that the space is constant ..." says.
        > O(λ + μ) operations of these types
        This is said in [reference p238](https://www.ush.it/team/ascii/CRC.Algorithmic.Cryptanalysis.Jun.2009.eBook-ELOHiM.pdf)
        > Once Y is defined, Floyd’s algorithm looks for the *first index t such that Yt = Xt*. Clearly, this can be done in time O(t) using a very small amount of memory
        i.e. $x_t=x_{2t}$, so $t=kλ$
        We can show if $t=λ + μ$, then turtle goes back to the loop start. So if it keeps going, then turtle can meet hare. So O(λ + μ).
  - [O(1) ~~possibly~~ for 2d](https://stackoverflow.com/q/79155452/21294350)
    - originally Matt Timmermans says about destroyed pointer which *may* mean [Dangling pointer](https://en.wikipedia.org/wiki/Dangling_pointer)
      > pointers that do not point to a valid object of the appropriate type.
      That includes [Null pointer](https://www.ibm.com/docs/en/xl-c-aix/13.1.0?topic=pointers-null), i.e. `Node<T>* root=NULL`.
      pointer pointing to NULL may mean `*root=NULL`.
    - TODO
      ~~> use the left-link~~
      ~~> 3. in the previous paragraph, we inverted...~~
    - Stef means for many nodes, node-id may be huge (i.e. `O(log(n))`) even if we have O(1) additional nodes. So space -> `O(log(n))*O(1)=O(log(n))` although Matt Timmermans disagrees.
    - Matt Timmermans's and Frigo's doesn't consider DAG which needs [back edge](https://courses.cs.duke.edu/cps130/fall17/lecture12note.pdf) to have one cycle which is learnt in DMIA/mcs.
      They all think about the tree *globally* which is wrong (see [this](https://chat.stackoverflow.com/transcript/message/57735243#57735243) and its next comment).
      - Frigo's is *possibly* right for undirected IMHO since at last all elements will be connected with inorder traversal. At least we can check cycle for that in O(1).
        Anyway Matt Timmermans's is right IMHO with recovery added.
    - https://stackoverflow.com/a/79171460/21294350
      - related states
        > We continuously track the "current node"
      - TODO
        > when *left chain* ends with T.
        > The open stack is *the chain of left links* from the current node to B.
        > its *predecessor* on the open stack (the one with a left link that points to it) is either its left or right *child*.
        - > The top-most node on the open stack has no predecessor, and its left link is overwritten to point to its parent,
          root seems to have no parent.
        - > check a discovered not to see if it's open or complete.
          now?
        - > so we need a single separate pointer to remember its actual left child.
          shouldn't it be `B` but `B` has no child?
      - > The right link will only hold a left child when the left child is complete
        implies we have inorder traversal.
      - TODO new
        - > so we need a single separate pointer to remember its actual left child.
          "The top-most node" seems to be one leaf.
- [ ] 20
  - `(define x (cons 1 2))`: binds `cons` in global
    and then creates `E1` "binding the formal parameters" with "enclosing environment" global.
    ~~Then `E1'` for `dispatch` application.~~ (see wiki here we doesn't apply, so no new env.)
    Then binds `x` in global
  - `(define z (cons x x))` is similar with `E2` and `E2'`.
  - `(set-car! (cdr z) 17)` binds `set-car!` in global
    - `(cdr z)`
      similarly `E3`
      then `(z 'cdr)` creates 1 new envs binding `m` with "enclosing environment" ~~*`E2'`*~~ (see wiki) since we are calling `dispatch`. (i.e. wiki `E5`)
    - similarly `E4` for `(z new-value)` parameters "with "enclosing environment" global" (i.e. wiki `E3`).
      then `((z 'set-car!) new-value)` creates 2 new envs binding `m` with "enclosing environment" ~~*`E1'`*~~ (see wiki *`E1`*) and then `v` with "enclosing environment" *`E1`*.
  - `(car x)` similar to ~~`set-car!`~~ `(cdr z)`.
  - repo no solution
- [x] 21
  - > Ex-plain what Eva Lu is talking about.
    > Define a procedure print-queue
    i.e. we only need to print `car`.
    - repo just iterates manually and does the same at all.
  - > show why Ben’s examples produce the printed results that they do.
    just 3 cases (2 for `insert-queue!` and else of `delete-queue!`)
- [ ] 24
  - define one internal `assoc` using `same-key?` based on "Creating local tables" implementation.
  - wiki
    > con-structor make-table that takes as an argument a same-key?
    The above is wrong for arg location.
- [ ] 25,26
  - I won't check why repo errors occur.
  - With roy-tobin's test, I finished these 2 codes by debugging.
  - wiki mainly see roy-tobin's.
- [ ] 27
  - > When the memoized procedure is asked to compute a value, it first checks the table to see if the value is *already there* and, if so, just returns that value. Otherwise, it computes the new value in the ordinary way and *stores this* in the table.
    This is same as the behavior of [`hash-table-intern!`](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Basic-Hash-Table-Operations.html#index-hash_002dtable_002dintern_0021)
  - an environment diagram
    ```
    memo-fib
    memoize
      E1: f
        E1': table
          (lambda (x) ...)
          E2 (by `(memo-fib n)`): x
            E3: previously-computed-result
              E4 (since `previously-computed-result` is #f): result
          E2' (by `(memo-fib (- n 1))`): x
            ...
    E1'' (for `make-table`):
    E3' (lookup): x
         table
    E4' (for f in `(result (f x))`): x
    E5 (insert!): x result table...
    ```
    - [See wiki](https://github.com/kana/sicp/blob/master/ex-3.27.md)
      1. better show pair for `memo-fib` and `memoize` to be more clear.
      2. Here `(lambda (n) ...)` is one anonymous func with "enclosing environment" global.
      3. "(for f in `(result (f x))`)" should be `n` to be compatible with the lambda func.
  - > Explain why memo-fib computes the nth Fibonacci number in *a number of steps* proportional to n.
    Since each will be calculated only once, ~~then if `lookup` and `insert!` is O(1) we we have ~~ `(result (f x))` will be called only `n-1` times.
  - > Would the scheme still work if we had simply defined memo-fib to be (memoize fib)?
    No since that will fail for `(lookup x table)` and then we just calculate `(result (f x))`, i.e. `(fib x)` which is exponential.
  - The above 2 explanations are *same* as wiki meteorgan's and Manu Halvagal's.
  - repo doesn't have valuable infos.
- [x] 28
- [x] 29
  - OR: only (0,0) -> 0.
    so $\overline{\overline{a}\land \overline{b}}$ to ensure only the above
    - As wiki says, i.e. [NAND](https://en.wikipedia.org/wiki/OR_gate#Alternatives)
  - > What is the delay time ...
    2 `inverter-delay` plus 1 `and-gate-delay`.
    - same as wiki squarebat's.
- [ ] 30
  I made one mistake as [this diff](http://community.schemewiki.org/?p=sicp-ex-3.30&c=hd&t=1727513415&t1=1727598537) shows.
  - I learnt "Ripple-carry adder" in COD (IMHO here it is not strictly "parallel" due to the wait of carry bit's).
    > The major drawback of the ripple-carry adder is the need to wait for the carry signals to propagate.
  - delay
    each FA will have 2 delay of half-adder and one or to output $C_{out}$.
    - half-adder: 
      S has `(+ (max or-gate-delay (+ and-gate-delay inverter-delay)) and-gate-delay)`
      C: and-gate-delay.
    - So FA
      C: $S_h+C_h+or-gate-delay$
      SUM: $2*S_h$
    - So 
      to get the final C of "ripple-carry adder" we have $n*(S_h+C_h+or-gate-delay)$
      the final S_1 is similarly $(n-1)*(S_h+C_h+or-gate-delay)+2*S_h$
- [x] 31
  - > Explain why this initialization is necessary
    At least for `inverter` and `and-gate`, we need to register agenda by `after-delay`.
    For `probe` it may be just to tell the init value.
  - `(half-adder input-1 input-2 sum carry)`
    former: register
  - `(set-signal! input-1 1)`
    former and latter: will call `action-procedures` for `input-1`, i.e. `and-action-procedure` and `or...` for `input-1`.
  - `(propagate)`
    former will call more item's listed in `the-agenda`.
  - wiki
    - > in which actions (``events'') trigger further events that happen at a later time
      i.e. "trigger"ed by `after-delay`.
    - IMHO thomas's emphasis is
      > However this will not happen when we run propagate (without an initialization), since the propagate-procedure will *only* call the procedures *stored in the agenda*, but the commands will only get stored in the agenda when *the procedures are run in the first place*.
      But actually `action-procedures` will also be called in `set-signal!`.
  - IMHO 
    > the procedure is immediately run
    is wrong since `(inverter c e)` should wait when we get `c` changed.
    But if we do this when `(half-adder input-1 input-2 sum carry)`, then the delay will just be  earlier.
    So `sum` will be got with just `and-gate-delay` due to `(and-gate d e s)`.
    - ~~TODO~~ ~~after reading implementation about "delay".~~
      ~~the time will be only updated when `first-agenda-item` by `(propagate)`.~~
      ~~So we need to call~~
  - repo ~~lacks this solution.~~ see 3.32 which is same as the wiki top.
- [x] 32
  - > Explain why this order *must* be used.
    IMHO this is *natural*.
    `add-to-agenda!` is only called in `after-delay` -> gates `action-procedure`. See `half-adder` where gates are run by how they are connected in Figure 3.25 circuit.
  - > last in, first out
    As the normal one implies, we just *reverse* the `set-signal!` order in the sequence, so the result is obviously wrong.
    - same as wiki top and the last paragraph of https://github.com/kana/sicp/blob/master/ex-3.32.md.
- [x] 33
- [x] 34
  - by viewing `process-new-value`, if we set `b`, then `a` can't be set automatically.
    - same as wiki meteorgan's and repo.
- [ ] 35
- [ ] 36
  - GE, i.e. global environment: a,b,
  - E1 (`make-connector` for a) null parameter:
    - E1' (`let`) `value` -> false etc: `set-my-value` etc.
  - E2 (`make-connector`): similar to E1
  - E3 (`set-value!`) `connector` -> a etc: 
    - E3' (`connector`) `request` -> 'set-value!:
      - E3'' (`set-my-value`) `newval` -> 10 etc.:
        - E3''' (`for-each-except`) `` -> setter etc.:
- [x] 37
  - `(celsius-fahrenheit-converter x)` just transforms from c to f which is one part of what `(celsius-fahrenheit-converter c f)` does.
  - trivial
  - repo is same as wiki.
- [ ] 38
  - here "half" depends on the context.
  - a. 3 cases based on when Mary does.
  - b. here each sub-sequence is deterministic.
    1. all accesses concurrently, then 3 cases based on who `set!` at last.
    2. 2 concurrently
      - Peter, Paul: 
        90/75/50 if Mary access before `set!` or 45/37.5
      - ...
        IMHO this is more about mathematics... So I *skipped*.
    - See wiki for details.
  - repo only has solution for a.
- [ ] 39
  - here we have 3 components which can't be splitted.
    part 1: access x -> (* x x)
      set x
    part 2: set x to (+ x 1)
    here part 1 is implicitly ordered. So 3 cases for where part 2 is.
    1. before part 1: 121
    2. inside: 100
    3. after: 101
  - the above is *wrong*
    repo is same as karthikk's.
- [x] 40
  - > Give all possible values of x that can result from executing
    ~~Emm... 5 accesses~~
    ~~better to use program to simulate...~~
    - here possible access value are 10,100,1000.
      - all l0 (l00/1k)
      - the 2nd `lambda` has 100,... (1e+6) / 10,100... (1e+5) / 10,10,100 (10000).
      - the 1st has 1k,... (1e+6) / 10,1k (10000)
      - so 1e+2 to 1e+6.
    - same as meteorgan's and repo.
  - > Which of these possibilities remain if we instead use seri-alized procedures:
    2 trivially but they are same as $x^6$.
- [ ] 41
  - > Do you agree?
    Yes.
    See https://en.wikipedia.org/wiki/Hazard_(computer_architecture)#Read_after_write_(RAW).
  - repo is same as Mike's.
- [x] 42
  - IMHO here `withdraw` doesn't change so `(protected withdraw)` also won't change.
    So safe.
- [x] 43
  - > Argue that if the processes are run sequentially, ...
    trivial since each `exchange` just swaps between accounts.
  - > ... can be violated if the exchanges are implemented using the first version of the account-exchange
    (10,20,30) -(Paul)> (30,20,10) -(Peter already gets "difference" since `'balance` is not protected)> (40,10,10) (This is similar to repo where "+10" is done first)
    - > the sum of the balances in the accounts will be preserved
      since whatever `difference` is, each `'withdraw, 'deposit` for `accountx` is "serialized". So `account1` will withdraw `difference1+difference2`. `account2` deposits `difference1` (similar to `account3`)
      So sum "will be preserved".
    - > did not serialize the transactions on individ-ual accounts.
      just see `account1` which may at last only withdraw `difference1` if doing both withdraw concurrently.
- [x] 44
  - Based on "ac-cepts ''negative amounts''" and the prerequisite that the operation sequence of each account will be "serialized", the result is right.
  - repo is same as sam's.
- [x] 45
  - > serialize accounts and deposits as make-account did
    maybe withdraws "and deposits".
  - If just checking `(deposit account amount)`, the behavior is same since `deposit` and `balance-serializer` are all static and can be calculated in advance and reused in the future.
    - > In particu-lar, consider what happens when serialized-exchange is called.
      So here `(account 'deposit)` will cause problems since it causes lock.
      Same as xdavidliu's.
      > since two procedures can be run concurrently if and only if they have *not* been serialized with the *same serializer*.
      - This is can be avoided by [reentrant lock (see the reference link)](https://stackoverflow.com/a/26542901/21294350)
        > A reentrant lock is one where a process can claim the lock multiple times without blocking on itself.
        - difference from semaphore
          see [this](https://www.baeldung.com/java-binary-semaphore-vs-reentrant-lock#ownership) which is same as [this](https://stackoverflow.com/a/57032176/21294350)
          > Yes, ReentrantLocks are owned by a single thread and can *only be released by that thread*.
          https://stackoverflow.com/a/17683722/21294350
          > If for any reason you need *non-ownership-release* semantics then obviously semaphore is your only choice. ... If *more than one thread* (but a limited number) can enter a critical section you can do this through either thread-confinement or a semaphore.
          See [example](https://en.wikipedia.org/wiki/Semaphore_(programming)#Login_queue)
- [x] 46
  - > time-slicing interrupts
    [i.e.](https://www.geeksforgeeks.org/time-slicing-in-cpu-scheduling/#) 
    > If the time slice goes off first, CPU shifts it out to back of ongoing queue.
  - trivial same as Figure 3.29
    where both gets #f and sets to #t. Then "acquire the mutex at the same time".
    - same as xdavidliu's and repo.
- [ ] 47
- [ ] 48
  - since no circular waiting as OSTEP 32.3 "Circular Wait" says.
  - add one number identifier in `make-account-and-serializer` and order by that in `serialized-exchange`.
    - See wiki leafac's.
      maybe better to *avoid id conflict* with one global record (this is done in repo).
- [ ] 49
  - by [this](https://wiki.sei.cmu.edu/confluence/display/java/LCK07-J.+Avoid+deadlock+by+requesting+and+releasing+locks+in+the+same+order), "deadlock-avoid-ance mechanism" should work
    > Deadlock is avoided when two threads request the same two locks but one thread completes its transfer before the other thread begins. Similarly, deadlock is avoided if the two threads request the same two locks *in the same order* (which would happen if they both transfer money from one account to a second account) or if two transfers involving distinct accounts occur concurrently.
  - as wiki leafac says, the problem here is that we may be unable to decide the "ordering" beforehand. (the above is *wrong*)
    This may always occur in "database management systems" due to something like *unknown future transactions*.
  - repo no solution
- [ ] 50
  - TODO by `((lambda (a . args) (null? (car args))) 1)` here `(car argstreams)` may fail.
    - see wiki this is *impossible* (see `(map (lambda (x) x))` error).
    - Shade's is correct.
  - `??, cons-stream, stream-car, stream-cdr`
- [ ] 51
  - `(stream-enumerate-interval 0 10)` is `(cons-stream 0 (stream-enumerate-interval 1 10))`
    so we do `(cons-stream (show 0) (apply stream-map ...))`
  - Then `stream-ref` will do `show` by `force` until `(= n 0)` where we won't `force`.
    So this outputs ~~the former 5 items.~~ the former *cdr* items, i.e. item 1 to item 6.
    Then `(stream-car s)` will get `(car s)`, i.e. showing item 6.
  - `(stream-ref x 7)` depends on whether `memo-proc`
    if `memo-proc`, then only item ~~6 and~~ 7 and 8 will be outputed.
    Otherwise, the former 8.
  - wiki
    - the above `(cons-stream (show 0) (apply stream-map ...))` implies we will output item 0 there.
    - the above strikethrough is *hinted by the wiki*.
  - repo is based on racket whose implementation is a bit weird based on its result.
- [ ] 52
  - 0,0-`(accum 1)`>1-(3,6)>6(`y`)-~~(8,11,15 Notice here `seq` is not modified by the sequence before, so `(accum 2)` will be rerun.)>15-(17,... until 15+(2+...+8)=15+5*7=50)>50-(50+(2+...+))>~~(6+4 due to memorizer. So `delay` will be only `force`d once.)>10-(10+5...+8=36)>36->(1+20)*20/2=210
    - 36 *wrong*
  - > What is the printed response to evaluating the stream-ref and display-stream expressions?
    item 8 -> 36
    1,3,...,210
    - *wrong*, see wiki.
  - > Would these responses differ if we had implemented (delay ⟨exp⟩) simply as (lambda () ⟨exp⟩) without using the optimiza-tion provided by memo-proc?
    ~~just see the above strikethroughed ones.~~
    - hinted by wiki, without memoization:
      0,0-`(accum 1)`>1-(3,6)>6(`y`)
      -(8,11,15 Notice here `seq` is not modified by the sequence before, so `(accum 2)` will be rerun.)>15
      -> 15+4(since we begin from the next number *unevaluated* for `y`)+5(even)+... until we get another 7 even numbers, i.e. until $(2*7+3)=17$, so $15+21*14/2=162$
      -> 162+5+6+7...+20=162+25*8=362, so output 10,180,...
      - same as wiki codybartfast's.
  - wiki
    - the above is `(stream-ref y 7)` instead of `(stream-ref seq 7)`, so it begins with `(accum 4)` until `(accum 10)` (wrong)
    - the above `(display-stream z)` will output `10 15 45 ...` due to memorizer, then `190 ...`.
    - here MIT/GNU Scheme just uses ['odd' streams](https://srfi.schemers.org/srfi-41/srfi-41.html), so "Racket With ..." won't occur.
  - repo is just based on wiki.
- [x] 53 trivial $a_n=2a_{n-1}$
- [x] 54
  - > mul-streams
    trivial
  - `(integers-starting-from 2) factorials`
- [ ] 55
  ```scheme
  (define (partial-sums S)
    (cons-stream (stream-car S) (add-streams (stream-cdr S) (partial-sums S))))
  ```
  - see wiki: the above is wrong.
- [x] 56
  - > But this is very inefficient, since, as the integers get larger, fewer and fewer of them fit the requirement.
    IMHO it should be due to that we need to check much more possible prime factors.
  - > notice the following facts about it.
    This is one generative method instead of the filtering method above, i.e. just listing all  numbers "with" only factors from "2, 3, or 5".
  - `(scale-stream S 2) (merge (scale-stream S 3) (scale-stream S 5))`
- [x] 57
  - based on "shifted by one place: ..."
    (index starting from 0) total addition: 0,0,1,2,... since all the former results are stored in `fibs` itself.
  - > without using the optimization provided by the memo-proc procedure
    In a nutshell, each item will be recalculated.
    So each item needs addition: 0,0,1,2 with $a_{n+2}=a_{n+1}+a_{n}+1$, so $a_{n}+1$ is like [fibonacci sequence](https://math.stackexchange.com/questions/4934605/a-n1-a-na-n-11-relation-with-fibonacci-sequence#comment10546077_4934605) with 1,1,.... So [$a_{n}=F_{n+1}-1$](https://en.wikipedia.org/wiki/Fibonacci_sequence#Definition)
    So $\sum_{i=0}^{n-1} a_{i}=\sum_{i=1}^{n} F_{i}-n=F_{n+2}-1-n$, so [exponential](https://en.wikipedia.org/wiki/Fibonacci_sequence#Closed-form_expression).
  - same as wiki adams "max(0, n-1)".
    fib(n) means item n, needing $a_{n}=F_{n+1}-1=fib(n+1)-1$.
  - > Our call-by-need stream optimization effectively constructs such a table automatically, *storing values in the previously forced parts* of the stream.
    This is just how `memo-proc` does.
    - Also see exercise_codes/SICP/book-codes/ch4-leval.scm `force-it` where argument for one  *specific* procedure won't be reevaluated twice, same as https://cs.stackexchange.com/a/28618/161388 and https://en.wikipedia.org/wiki/Evaluation_strategy#Call_by_need.
      > if the *function* argument is evaluated, that value is stored for *subsequent* use.
      - TODO
        > all arguments are passed, meaning that R allows arbitrary side effects.
        compared with
        > Haskell supports only side effects (such as mutation) via the use of *monads*.
- [x] 58
  - this is just `(num*radix)/den` with the first item being the number before the decimal point.
    - same as repo.
- [x] 59
  - > In Section 2.5.3 we saw how to implement a polynomial arithmetic system representing polynomials as lists of terms.
    Here we doesn't store order (see `(add-terms L1 L2)`) since that is implied as *consecutive*.
  - > In a similar way, we can work with power series
    just reuse the poly lib.
  - `integrate-series`: just based on `integers` and `stream-map`
  - > except for the constant term
    since $\int e^x dx=e^x+C$
  - b trivial
  - wiki (see meteorgan's which is right IMHO)
    - `(stream-map / ones integers)` can be `(stream-map (lambda (num) (/ 1 num)) integers)`
  - repo
    - a. elegant by dropping 1.
    - b. same
- [x] 60
  - `(* (stream-car s1) (stream-car s2))`
    `(mul-series s1 (stream-cdr s2))`
    `(scale-stream (stream-cdr s1) (stream-car s2))`
    - almost same as meteorgan's but swap s1 and s2.
- [ ] 61 trivial by the formula.
  - see wiki and repo to notice using one internal definition to ensure memorization.
- [x] 62
  - > provided that the denominator series begins with a nonzero constant term.
    to ensure `1/Den` exist.
    - if zero, then we make extract factor $1/x^k$, then the rest is same.
  - `Num*(1/(scale Den 1/C))`
    - see wiki meteorgan's, *not to forget factor back*.
  - repo is same as wiki cyzx's.
- [x] 63
  - See LisScheSic's comment in http://community.schemewiki.org/?sicp-ex-3.55.
  - No.
  - same as leafac's.
- [x] 64
  - Let `(sqrt-stream x)` be `t` and `(stream-cdr t)` be `next`, trivial by comparing `(stream-car t)` and `(stream-car next)`, then recursively call `stream-limit` for `next` if not meeting the requirement.
    - same basic ideas as wiki meteorgan's, i.e. repo.
- [ ] 65 trivial by using `partial-sums` and then use that for `euler-transform` and then `accelerated-sequence`.
  - > How rapidly do these sequences converge?
    just count... (same as repo)
    - see wiki Sphinxsky's.
- [ ] 66
  ```
  0 1 3 5 7
    2 4 (here "2 4 6" pattern is just duplicate of "0 1 2", then recursion...) 
      6
  ```
  - this is about maths and the appropriate ordering depends on what elements we want to see earlier, so I skipped.
- [x] 67 add one `stream-map` by `(stream-map (lambda (x) (list (stream-car s) x)) (stream-cdr t))` (let this be `bottom-right`) -> `(interleave (stream-map (lambda (x) (list x (stream-car t))) (stream-cdr s)) bottom-right)` which is same as repo.
  - wiki 3pmtea's is better
- [ ] 68
  - IMHO this is right since no items are dropped.
- [ ] 69
- [ ] 70
  - > We will require ...
    IMHO this is not necessary.
  - `merge-weighted` trivial by substituting `<` with `weight` and modifying `>` to `<` appropriately.
  - based on footnote 69, 
    we can assume `(list (stream-car s) (stream-car t))` must be the 1st,
    so changing `interleave` to `merge` is enough.
    - Then 
      a. trivial by defining `weight`.
      b. since we are combining 3 sub-streams/elem, `filter` at last.
      - b is *wrong*.
        see wiki `filter` for the *inputs* first.
  - wiki
    x3v's: here same weight doesn't mean the same pair, so no dropping. (same as repo)
- [x] 71
  - > then search the stream for two consecu-tive pairs with the same weight
    trivial by using iter which adds one pair when necessary.
    - same as meteorgan's.
      TODO test based on "two consecu-tive" elements in the stream is also used in one former exercise.
    - repo is based on `stream-filter` with zero mark.
- [x] 72
  - same basic ideas as 3.71.
- [x] 73
- [x] 74 trivial `(cons-stream 0 sense-data)` (same as meteorgan's and repo)
- [x] 75
- [x] 76
  - > the extractor should not have to be changed if Alyssa finds a better way to condition her input signal
    i.e. extractor -> `make-zero-crossings`, "condition her input signal" -> average?
  - `smooth`: trivial by `(stream-map average s (cons-stream last-value s))`
  - `make-zero-crossings`: just let `input-stream` be `(smooth input-stream)`
    - wiki use the same `smooth` but use `make-zero-crossings` in Exercise 3.74.
- [x] 77 trivial by using `let` (same as repo and wiki)
- [x] 78
- [x] 79 just as the book to use `(stream-map f dy y)` (see mg's which is right. Same as *repo* and meteorgan's).
  - http://community.schemewiki.org/?sicp-solutions
    > didn't solve the "Fokker-Planck equation on computational graphs"
    This is not said in its org "Cool. As long as ~f~ is implemented in terms of streams, it works.".
- [x] 80
- [ ] 81
  - if based on Exercise 3.6, then we just call `(rand 'generate)` or `((rand 'reset) 1)`.
    - see wiki which *allows setting the argument* for `'reset`.
- [ ] 82
  Here we only need to set `experiment-stream`, i.e. `stream-map (lamdbda (x) (experiment)) ones` where `ones` can be any infinite stream.
  If using `random-update`, IMHO we still need `random`.
  - same as wiki meteorgan's but using `make-point` instead of `cons`.
## chapter 4
- [x] 1 use `let`
  - see wiki. But I will just let `rest` omitted by putting that value in `cons` with only ``(let ((first (eval (first-operand exps) env)))``, i.e. krubar's.
- [x] 2
  - a. trivial since mismatch as procedure for some special forms.
  - b. `(define (application? exp) (tagged-list? exp 'call))`
    then change for `operator`...
  - same as wiki.
- [x] 3
  - `quoted?` up to `cond?` use `get 'eval (proc exp)` where proc is `car`.
- [ ] 4
  - see section 1.1 "The interpreter evaluates the expressions".
    - "if there are no expressions" is not said there.
  - Compared with https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Conditionals.html#index-and
    `and` is same.
    For `or`
    > If all expressions evaluate to false values, the value of the last expression is returned.
    implies returning #f since that is the only case for false.
    > The conditional expressions count only #f as false.
- [ ] 5
- [ ] 6 
  - use `map` to extract `var1~n` and `exp1~n`.
    Then `make-lambda` and `append` with `exp1~n`.
  - see wiki Hertz's `cons` is ~~better~~ *correct*, i.e. repo.
- [ ] 7
  - ["a pointer to the environment in which the procedure was created."](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-21.html#%_sec_3.2)
    so nested `lambda` can access the parent lambda formal parameter bindings.
    so "sufficient".
    - same as repo.
  - use `(fold-right (lambda (x res) (cons 'let (cons x res))) body bindings)` similar to `make-lambda`.
    - The above is *wrong*.
      my comments are hinted by 3pmtea's test.
  - ~~my 1st comment is same as repo.~~
- [ ] 8
  name collision problem is hinted by wiki.
  - see `fib-iter` in chapter 1. 
  - [this](https://stackoverflow.com/a/7719140/21294350) needs to change `body`...
    - also see [this detailed answer][fake_let_assignment]
      - `x x` means [application](https://en.wikipedia.org/wiki/Lambda_calculus#Lambda_terms) (also see https://en.wikipedia.org/wiki/Lambda_calculus#Notation)
        - > Applications are assumed to be left associative: M N P may be written instead of ((M N) P).
          so [Lambda_calculus_Y_combinator]
          `r r (n−1)` means `((r r) (n−1))`, i.e. `((fact-gen fact-gen) (sub1 n))`.
  - **see `4_8_wiki.scm`**
    all the former 4.x exercises are not related with *iteration*, so no need to check for  better solutions for them.
  - [link1](https://en.wikipedia.org/wiki/SKI_combinator_calculus#Self-application_and_recursion) from https://chat.stackoverflow.com/transcript/message/57699637#57699637
    - [H combinator](https://esolangs.org/wiki/Combinatory_logic)
      `BW(BC)`
      so based on [this](https://en.wikipedia.org/wiki/Lambda_calculus#Standard_terms)
      IGNORE:
        -> we have λz.W ((BC) z)
        -> `BC` will be λy.λz.(λx.λy.λz.x z y) (y z)
        -> `((BC) z)` λz.(λx.λy.λz.x z y) (z z)
        -> `W ((BC) z)` λy.(λz.(λx.λy.λz.x z y) (z z)) y y
          i.e. λy.((λx.λy.λz.x z y) (y y)) y
          i.e. λy.((λx.λy.λz.x z y) (y y)) y
      `BW`: λy.λz.W (y z)
      `BC`: λy1.λz1.C (y1 z1)
      `W`: λx2.λy2.x2 y2 y2
      `C`: λx3.λy3.λz3.x3 z3 y3
      - `BW(BC)`: λz.W ((BC) z) -> λz.W (λz1.C (z z1)) -> λz.W T0
        -> λz.λy2.T0 y2 y2 -> λz.λy2.((C (z y2)) y2) -> λz.λy2.λz3.(z y2) z3 y2
          TODO this is not same as link1 definition.
      - checking consistency with link1
        - [SKI](https://esolangs.org/wiki/Combinatory_logic#SKI_calculus) is [consistent](https://en.wikipedia.org/wiki/SKI_combinator_calculus#Informal_description)
        - `B = S(KS)K`: λx.λy.λz.x z (y z) -> λz.(KS) z (K z) 
          -> λz.(λy0.S) z (K z)
          -> λz.(S (K z))
          -> λz.(S (λy1.z))
          -> λz.λy2.λz2.(λy1.z) z2 (y2 z2)
          -> λz.λy2.λz2.z (y2 z2)
          consistent
          - esolangs version
            - > Derivations to prove these (follow them by eta conversions):
              see [eta conversions](https://wiki.haskell.org/Eta_conversion)
              i.e. B->λx.λy.λz.B x y z.
            - `S (K S) K x y z = K S x (K x) y z = S (K x) y z = K x z (y z) = x (y z) = B x y z;`
              the 1st = simplifies `S (K S) K x`, i.e. `H x` which is allowed due to *nested* λ.
            - following the same method to try deriving `H`
              to prove `Hxy = x(yy)`
              - reference
                S f g x = f x (g x);
                x (y z) = B x y z;
                x y y = W x y;
                x z y = C x y z;
              TODO BW(BC) x y=W((BC) x) y=((BC) x) y y=BCxyy=C(x y) y=λz.(x y) z y lacking one variable.
              But
              CBUgx=BgUx=g(U x)...
    - See link1 `Hgx = g(xx) = BgUx = CBUgx`, so H is `CBU`
      `BgUx`: x (y z) -> g (U x) -> g(xx)
      `CBUg`: x z y -> BgU
  - https://stackoverflow.com/a/78586373/21294350 from the above chat
    - > without appealing to their equivalent lambda expressions at all.
      due to eta conversions as the above esolangs shows.
    - H' is chosen instead of `KH'` due to `S` structure.
    - `S(Kg)(S(SSK)(Kg))x`
      `Kgx((S(SSK)(Kg))x)` -> `g((S(SSK)(Kg))x)`
    - > H' itself is not recursive
      since `H'gx  = g(x gx )` where the right part doesn't use `H'`.
      - similar for
        > Y' and X, which, both, are non-recursive
    - ~~TODO jump-starting?~~
    - > Using some speculation
      better to see https://en.wikipedia.org/wiki/SKI_combinator_calculus#Self-application_and_recursion.
      `Yg = Hg(Hg)`
      Hg(Hg)=g(Hg(Hg))=g(Yg).
      - So 2. is by H definition.
    - In a summary, for one arbitray `Hanything = g(hanything)` we just to choose appropriate arguments to make the pattern `Yg=g(Yg)`.
  - https://chat.stackoverflow.com/rooms/258659/discussion-between-an5drama-and-will-ness
    - https://chat.stackoverflow.com/transcript/message/57699969#57699969
      ["static"](https://en.wikipedia.org/wiki/Static_variable#:~:text=In%20computer%20programming%2C%20a%20static,as%20required%20at%20run%20time.) means no mutation.
      "lexical scoping" see sicp_notes
      so static implies "redefining global" is not recommended
      while lexical implies it is better to use local variables.
- [ ] 9
  - https://www.willdonnelly.net/blog/2008-09-04-scheme-syntax-rules/ doesn't show how `syntax-rules` works at all.
  - see https://stackoverflow.com/q/79098453/21294350
    - > They are paired up properly
      maybe done by `(extend-environment ⟨variables⟩ ⟨ values⟩ ⟨base-env ⟩)` in section 4.1.
    - also see https://stackoverflow.com/q/131433/21294350
      - https://web.archive.org/web/20150321052219/http://schemecookbook.org/Cookbook/GettingStartedMacros
        - Only Dybvig, https://web.archive.org/web/20150316032601/http://library.readscheme.org/page3.html and the last are valid.
      - https://web.archive.org/web/20090317073256/http://docs.plt-scheme.org/guide/syntax-case.html
        i.e. current Racket.
      - helpful links
        - https://www.greghendershott.com/fear-of-macros/Transform_.html#%28part._.What_is_a_syntax_transformer_%29
          shows definition same as `syntax-case` in guile doc.
        - https://stackoverflow.com/questions/131433/sources-for-learning-about-scheme-macros-define-syntax-and-syntax-rules#comment137193921_133356 https://github.com/mnieper/scheme-macros is more helpful for newbie.
          like https://github.com/mnieper/scheme-macros?tab=readme-ov-file#incrementing-a-variable says well about hygiene.
    - I don't know why I didn't find [this pdf](http://www.phyast.pitt.edu/~micheles/syntax-rules.pdf) when I first read the above QA comment.
      Maybe I *haven't noticed that*.
    - Also see this email https://lists.gnu.org/archive/html/guile-user/2010-03/msg00052.html related with guile and that guide by Shawn.
- [ ] 10
  - IMHO this is already done in former exercises like Exercise 4.5.
  - wiki demo of [postfix](https://en.wikipedia.org/wiki/Reverse_Polish_notation) is also fine.
- [ ] 11
  - ~~I didn't find this is related with footnote 14.~~
    `add-binding-to-frame!`
    > as it only redefines the binding of the procedure-local variable frame
    same as LisScheSic's "this won't work..." (I *didn't view all comments* when writing that).
- [x] 12
  - trivial due to `scan`.
- [ ] 13
  - > For example, should we remove only the binding in the first frame of the environment? *Complete* the specification and *justify* any choices you make.
    ~~IMHO to have more control on the frame and same as `define-variable!` which only adds to "the first frame of the environment", we should "remove only the binding in the first frame of the environment".~~
    `(eval exp env)` will use `(lookup-variable-value exp env)`, so to *actually* remove "the binding", we need to check `enclosing-environment`.
    - so just modify `set-variable-value!` by changing `(set-car! vals val)` to `(remove-binding-from-frame! var val (first-frame env))` which does `(set-car! frame (delq var (car frame))) ...`.
      - > It is allowed, *but not required, to alter the cons cells in its argument* list to construct the result.
        so `delq!` may not modify in place as MIT/GNU Scheme does.
  - wiki
    - we also need to define the *syntax* of "special form make-unbound!".
- [x] 14
  - IMHO meteorgan's is right same as repo.
- [x] 15
  - > whether p halts on a for *any* procedure p and object a
  - if halts, then will `(run-forever)` which implies `(try try)` will not halt.
    Similar contradiction for not halt.
    - same as wiki meteorgan's.
    - similar to https://en.wikipedia.org/wiki/Halting_problem#Proof_concept which is also refereed to in DMIA notes and same as DMIA 3.1.6 proof where `K` is `try` here.
    - https://en.wikipedia.org/wiki/Halting_problem#Sketch_of_rigorous_proof (TODO it seems that I have read this proof when learning mcs/DMIA but I can't find that)
      - > but the computable function halts does not directly take a subroutine as an argument; instead it takes the source code of a program.
        i.e. footnote.
      - kw
        > Moreover, the definition of g is *self-referential*. A rigorous proof addresses these issues.
        > not producing a defined result (for example, by *looping forever*),
      - > but the computable function halts does not directly take a subroutine as an argument; instead it takes the source code of a program.
        i.e. body and parameter implied by `h(i,x)`.
      - > The verification that g is computable relies on the following constructs (or their equivalents):
        similar to the book "Figure 4.2" except for not explicitly showing "duplication of values".
      - > The following pseudocode for e illustrates a straightforward way to compute g:
        just implement `g`.
        - Compared with here.
          f:halts?
          i:p
          ==0:true
          return 0:'halted
          so they are *same*.
      - > In either case, f cannot be the same function as h. Because f was an *arbitrary* total computable function with two arguments, all such functions must differ from h.
        here we first define `h` to return 1 when halt, so we *then* define `f...== 0` part in `e`.
      - > The contradiction comes from the fact that there is some column e of the array corresponding to g itself.
        - IMHO this just means `f(.,j)`/`f(i,.)` is one unary func which can *emulate all unary funcs* including `g` by "Turing-complete".
          ~~ i.e. `g(e)` can't be in that array same as~~But `g(i)=0` when `f(i,i)=0` is different from construction in [`s` can't be one of `s_n`](https://en.wikipedia.org/wiki/Cantor%27s_diagonal_argument#Uncountable_set), so no direct contradiction.
          This is also shown by the following text which has no relation with column/row.
        - see `mcs.md` for the relation with "Cantor's diagonal argument".
  - > this reasoning still applies even if halts? can gain access to the procedure's text and its environment
    this is just how Scheme manipulates lambda procedure in environment model.
- [ ] 16
  - a. just check `(car vals)`. (same as wiki)
  - b. so `eval-definition` -> `(eval (definition-value exp) env)` -> `(lambda-body exp)`.
    So just wrap `(lambda-body exp)` which will then evaluated by `eval-sequence` in `apply`.
    - So follow `eval-sequence` structure by changing `eval` to some test.
  - c.
    - > Which place is better?
      IMHO both are fine. The former does transformation when construction while the latter does when usage just as section 2.1 does
      > our rational-number implementation does not reduce rational numbers to lowest terms. We can remedy this by changing *make-rat*.
      > an alternate way to address the problem of reducing rational numbers to lowest terms is to perform the reduction *whenever we access* the parts of a rational number, rather than when we construct it.
      How to choose.
      > If in our typical use of rational numbers we *access* the numerators and denominators of the same rational numbers *many times*, it would be preferable to compute the gcd when the rational numbers are *constructed*. If not, we may be better off waiting until access time to compute the gcd.
      IMHO the former case is more frequent.
    - wiki
      > make-procedure is better because we can easily explore other transformations 
      e.g. for `procedure-parameters` or using one general `transformation`.
- [ ] 17
  - > comparing how this will be structured when definitions are interpreted sequentially with how it will be structured if definitions are scanned out as described.
    - original
      E1: when applied with one `<vars>` seq. Then add `u, v` bindings.
    - transformed
      E1: "when applied with one `<vars>` seq."
      E11 in E1: when applied with `'*unassigned*` ... Then `set!` special form to change 2 bindings
    - *same* as wiki.
  - > Explain why this difference in environment structure can never make a difference in the behavior of a correct program.
    i.e. not "badly formed" programs, i.e. keep
    > internal definitions come first and do not use each other while the definitions are being evaluated
    "do not use each other" so original will work.
    - "internal definitions come first" so when the above is finished. `<e3>` has the *same environment effect*.
      - *same* as wiki pvk's "It's pretty clear that ...".
  - wiki
    - > might allow the body to access variables not yet defined in the original code. 
      i.e. `set!` between `define` to change some binding.
    - See @TODO for what I was wrong here.
- [x] 18
  - Not since `y` is unknown.
  - Fine since `y` is known.
  - same as wiki meteorgan's.
- [ ] 19
  - As footnote says, Alyssa's is right for the *book implementation* while Eva's is right academically.
    Also see "But actually MIT/GNU Scheme".
  - see wiki
    > if we had to work with a circular dependency (i.e. `b` depends on `a`, `a` depends on `b`).
    - Same as repo "If `a` and `b` don't reference each other, rearrange the code will solve the problem otherwise throw an error.".
- [x] 20
  - > so it is not surprising that the variables it binds are bound simultaneously and have the same scope as each other.
    "the same scope" i.e. ["has the exprs as its region."](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Lexical-Binding.html#index-letrec-1)
    "are bound simultaneously" is implied by `lambda` application (just see the book "would be transformed into").
  - a.
    - > as shown in the text above
      i.e. 4.16
    - almost same as "Consider a procedure with internal definitions, such as", then "would be transformed into", so just 4.16.
    - As wiki meteorgan's shows, this is simpler than 4.16 since we don't need to traverse to get all `define`s.
      - This is same as what [MIT_Scheme_Reference](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Lexical-Binding.html#index-letrec-1) says except for "*unspecified order*".
        > The variables are bound to fresh locations *holding unassigned values*, the inits are evaluated in the *extended environment* (in some *unspecified order*), each variable is assigned to the result of the corresponding init
  - b.
    - letrec:
      E1: x->5
      E11: '*unassigned*...
    - let:
      E1 same
      E11: even?->lambda...
      ~~Then `(even? 5)` etc will be evaluated~~
      so `lambda...` is created in E1 while the former is in E11.
      Then when `lambda...` is applied it can only search E1 but it doesn't have the binding for `odd?`.
      - see wiki leafac's for the more detailed examples.
        let
        > in which the bindings of the lambda itself *are not in place.*
    - As https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-21.html#%_sec_3.2 shows the key problem is where we *~~define~~create* the lambda value which decides what bindings we can use when applying that lambda.
- [x] 21
  - a. We can do similar to [Lambda_calculus_Y_combinator] "Given n = 4, for example, this gives:"...
    Fib also see https://gist.github.com/z5h/238891 from https://stackoverflow.com/a/7721871/21294350.
  - see repo for 2 versions for a.
- [x] 22
- [ ] 23
  - > What work will the execution procedure produced by Alyssa's program do?
    just `(lambda (env) ((car procs) env))`.
    > What about the execution procedure produced by the program in the text above?
    `first-proc`.
    So same
  - > How do the two versions compare for a sequence with two expressions?
    exercise: `(lambda (env) (proc-1 env) (proc-2 env))`
    book: `(loop (sequentially first-proc (car rest-procs)) ...)` -> `(lambda (env) (proc1 env) (proc2 env))` (more longer arg list case: see the comment in `analyze-lib.scm`)
    IMHO still same.
    - see wiki
      exercise should always be `(lambda (env) (execute-sequence procs env))` -(runtime)> `(lambda (env) ((car procs) env) (execute-sequence (cdr procs) env))`.
  - > In effect, although the individual expressions in the sequence have been analyzed, the *sequence itself has not been.*
    IMHO `(eval-sequence exps env)` just analyze implicitly by iter. So no analyze for "sequence itself"...
    - Wrong
      *See wiki meteorgan's*
      > In Alyssa's analyze-sequence, execute-sequence is running in runtime.
      So the book one has *no recursive calls* when executing that seq.
      i.e.
      > does *more of the work* of evaluating a sequence at analysis time
      > rather than having the *calls* to the individual execution procedures *built in* ... the sequence itself has not been.
      "recursive calls" in `eval-sequence` is already done in book `analyze`.
      - All in all, `execute-sequence` is unexpectedly introduced into the latter eval process while the book only has proc1~n.
- [x] 24
  - repo doesn't compare but just shows each part time used by analyze and eval.
- [x] 25
  - > What happens if we aempt to evaluate (factorial 5)?
    keep ~~expanding~~ evaluating `(* n (factorial (- n 1)))` in each recursive call...
  - > Will our definitions work in a normal-order language?
    -> if (primitive) then will stop when base.
  - same as meteorgan's.
- [ ] 26
  - Alyssa's is just the complement of and in favor of Ben's
  - > Fill in the details on both ...
    Ben: just as the derived expression of if.
    - > not a procedure that could be used in conjunction
      Actually we can be transform that to procedure with something similar to thunk.
  - > it might be useful to have unless available as a procedure
    debug?
    - *wrong*
    - wiki doesn't say about this.
  - TODO 
    See `4_31_dot_list_for_4_26.scm`: how to get `apply` being nested?
- [ ] 27
  - Here `set!` has the original behavior.
    2
    `(id (id 10))` -> `x` (i.e. (id 10)) -> `x` 10
    10
    2
    - *wrong*
    - also see repo based on `driver-loop`.
- [x] 28
  - just use `id` in 27 with `x` as one lambda func.
    Then `(w foo)` needs forcing `w`.
    - meteorgan's is also fine based on *delayed arg* same as the above. (repo similar)
- [x] 29
  - 100, 1, due to memoization
  - hinted by the example, `(square (fib 100))` (`fib` from section 2.2)
- [x] 30
  - > Since the value of an expression in a sequence other than the last one is not used
    so "the last one" may be forced later, so not necessarily force that in seq.
  - a. `(newline)` [returns "an unspecified value"](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Output-Procedures.html#index-newline), so maybe thunk?
    - > which gives an important example of a sequence with side effects:
      > Explain why Ben is right about the behavior of for-each.
      Hinted by b., since here "side effects" are primitives, so automatically force.
    - repo shows one *full trace* although for comparison checking `newline` is enough.
  - b. 
    - p1: 
      - original: Here `cons` will force x, then x will be bound to `'(1 2)`.
      - Cy's: same as p2 but without the `p` wrapper, again `(actual-value (set! x (cons x '(2))) ...)`
    - p2:
      - original: here `e` thunk won't be forced. So `x` is just the input thunk.
      - Cy's: 
        `(eval 'e ...)` -> e-thunk -(`force-it`)> `(actual-value (set! x (cons x '(2))) ...)`
        just as p1 to eval `(set! x (cons x '(2)))` and then force it (the latter has no effects at all).
        so `'(1 2)`
  - c.
    since just adds one `force-it` which will only have effects for thunk *but not for others*.
    But a. has seq
    1. `if` which at last returns `'done`
    2. `(begin ...)`: just force proc, but `proc` returns one "unspecified value" by `display`.
    3. `proc`: again `(newline)` -> unspecified value.
    4. `(for-each proc (cdr items))` back to 1.
    - same as wiki meteorgan's.
  - d.
    by
    > delay evaluation of procedure arguments *until the actual argument values are needed*
    so when assignment can be used is actually unable to predict.
    Then the safe action is to always not delay that, i.e. Cy's approach.
    Or use more complex approach to bookkeep one table which pairs assignment with variable and evaluate all related assignments when that variable is evaluated.
- [x] 31
  - possible changes implied by the exercise
    `define` syntax, eval or apply.
    - same for wiki and repo (~~by searching "definition" and inspecting `eval`~~ see "changed procedures:"), only `apply` is changed.
      The basic ideas are same.
- [ ] 32
  - just car is different
    let `car` be one computation-heavy element.
    - [same for scala](https://stackoverflow.com/a/60129204/21294350)
  - > ; in lazy evaluators, you don't have to worry about the order of definitions 
    right.
    - repo same as wiki meteorgan's.
- [ ] 33
- [ ] 34
  - The `4_34_revc.scm` test plus revc's are *almost* complete.
    The logic of revc is correct IMHO.
- [ ] 35
  use iteration to create one procedure `integers-between`, then `(an-element-of (integers-between i j))`
  - wiki (same as repo) is more elegant by incorporating iteration into `amb`.
- [ ] 36
  Only with `amb` test I found the infinity problem.
  - > That is, write a procedure for which repeatedly typing try-again would in principle eventually generate all Pythagorean triples.
    ~~so we need to add one operation to avoid duplicately generate the same Pythagorean triple.~~
    - see book
      > The *amb evaluator that we will develop and work with* in this section implements a systematic search as follows: When the evaluator encounters an application of amb, it *initially selects the first* alternative. This selection may itself *lead to a further choice*. The evaluator will *always initially choose the first* alternative at each choice point. If a choice results in a failure, then the evaluator automagically backtracks to the most recent choice point and tries the next alternative. If it runs out of alternatives at any choice point, the evaluator will *back up to the previous choice point* and resume from there.
      automagically is just by call stack.
      - So for here, take [example](https://mathworld.wolfram.com/PythagoreanTriple.html)
        > For example, there are four distinct integer triangles with hypotenuse 65, since
        then we have (16,63,65) and then proceed for `k` by dfs, but that will go to infinite...
      - wiki 
        xdavidliu's avoids the above problem since `k` won't be infinite unnecessarily which actually can be decided uniquely by `i,j`.
  - see repo for how racket implements `amb` and then we can manually define `try-again` based on that.
- [ ] 37
  - > Consider the number of possibilities
    trivial since here we won't enumerate unnecessarily for `k`.
    same as wiki meteorgan.
    - see wiki uuu's for more detailed infos.
- [x] 38
  - With `try-again`, this will be easy.
  - ~~As `4_36.rkt` says, Racket lacks `try-again` to get more results.~~
- [ ] 39
  - > Does the order of the restrictions in the multiple-dwelling procedure affect the answer?
    No trivially.
  - > Does it affect the time to find an answer?
    there are 5^5 cases. Assume one of the following runs first:
    `(distinct? (list baker cooper fletcher miller smith))`: -> 5!, so 5!/5^5=24/625 by `from fractions import Fraction;import math;Fraction(math.factorial(5),1)/Fraction(5**5,1)` in python.
    `(not (= baker 5))`: just 4/5
    the 2nd `(not (= fletcher 1))`: *3/4
    `(> miller cooper)` ~~based on cooper still has 5 cases (i.e. not run `(not (= cooper 1))`)~~: (1+...+4)/5^2=2/5 (So we can do this first to be faster)
    `(not (= (abs (- smith fletcher)) 1))`: (5^5-8)/5^5
    - so `(> miller cooper)` can be before `(not (= cooper 1))`
      then all the rest conditions are not influenced.
    - meteorgan's is based on the complexity of each operation instaed of how many cases will be checked.
      Actually the total time is `case-number*average-case-time`.
      So my method decreases the former while meteorgan's decreases the latter. IMHO *the latter matters more* due to O(1) compared with O(n^2).
  - comment with not strict calculation ("Assume we want to choose the 1st filter:" isn't met at all... Better to see xdavidliu's.)
    ```
    <<<LisScheSic
    If we just want to decrease the number of constant time testing (i.e. not {{{distinct?}}}), the computation can be done easier without too much combinatorial calculation.

    If we think of each test as one filter procedure to avoid doing latter filter procedure when necessary, then we just need to put the filter procedure which filters much more first. The filter efficiency can be calculated much easier. Assume we want to choose the 1st filter:
    {{{
    procedure: output-cases/input-cases

    distinct? ...: 5!/5^5=24/625
    (not (= baker 5)), (not (= cooper 1)): 4/5
    ...
    (> miller cooper): (1+...+4)/5^2=2/5
    (not (= (abs (- smith fletcher)) 1)): (5^5-8)/5^5
    }}}
    So we can put (> miller cooper) before (not (= cooper 1)). Notice these 2 filters only influence miller and cooper.

    Then assume we have K cases left after (require (not (= baker 5))), then with the reordering, (require (not (= cooper 1))) efficiency changes (also for (require (> miller cooper))).
    >>>
    ```
  - repo only has test for 40 with no *detailed* explanation for 39,40.
- [ ] 40
  - > For example, most of the restrictions *depend on only one or two* of the person-floor variables, and can thus be imposed before floors have been selected for all the people. 
    So this avoids the *unnecessary* calculation due to `amb`?
    > It is very inefficient to *generate all possible assignments* of people to floors and then leave it to backtracking to eliminate them.
    - *see* http://community.schemewiki.org/?sicp-ex-4.39 revc's.
- [x] 41
  - wiki 
    - woofy: 
      - if `(check next who)` succeeds, then dfs. Otherwise try the next subtree in the same level.
      - `(place who floor result)` means place who at floor based on the former people locations in `result`.
      - `(cons floor result)`: is the reversed order, so `(- head who)` where we only checks based on former floors as 4.40 does.
      - Comparison
        - Shaw's is similar but lacks modularity as "ugly" implies.
          - "Another ugly solution." is just avoids `flatmap` by using `set!`.
    - timothy235's just adds `(map list ...)` after getting candidates like those in my `4_41.scm`.
      - Its `in-permutations` returns one *stream* which is unnecessary for here we must check *all* cases.
        [for/list](https://docs.racket-lang.org/reference/for.html#%28form._%28%28lib._racket%2Fprivate%2Fbase..rkt%29._for%2Flist%29%29)
- [x] 42
  - `(and (= v (cadr kv)) (iter (cdr next)))` is more conservative. Actually, those left have been checked by the former iterations.
- [ ] 43
  See code "correction".
  - My original comment
    > (list barnacle moore hall downing mar): this is implicitly got by method of exclusion based on the other 4 fathers' yacht names (the same trick is also done by davl). We can also *replace* that with implication in "Gabrielle's father owns the yacht that is named after Dr. Parker's daughter.". That implies Gabrielle's father can't be Dr. Parker.
    So that implication is done by `(require (eq? parker (cadr (assq gab yacht-names))))` where if `parker=gab` (i.e. parker's daughter is gab) then `(eq? gab mar)` must be false.
    - rest comments
      ```
      Also see revc's which is based on iterating through daughters instead of fathers with similar basic ideas.

      Thomas (04-2020)'s uses triples which may be unnecessarily complexer IMHO.

      SteeleDynamics's doesn't use the nested lets but with the full solutions including "if we are not told that Mary Ann's last name is Moore." that can be got with  small modifications.
      ```
  - 
- [ ] 44
- [x] 45
  - repo skipped this.
  - https://wizardbook.wordpress.com/2011/01/15/exercise-4-45/
    - > The problem is that swindle *doesn’t “remember”* the value of the top level definition of *unparsed* when it *backtracks* to the next value of the amb expression after meeting a failure.
      i.e. the book
      > evaluator automagically46 backtracks to the most recent choice point
    - > On to the actual exercise. I *still have to use (driver-loop) to be able to use try-again* but at least I can set up all of the parsing procedures through (interpret …) without having to type them.
      so not feasible at all since most of time we need `try-again`.
- [x] 46
- [ ] 47
  - > wouldn't work if the operands were evaluated in some other
    since we need `(parse-word prepositions)` etc to consume word *before* `(parse-noun-phrase)` that is needed for the sentence structure.
    - same as meteorgan's and repo.
  - > left recursion elimination
    - > A => Ax | r
      [this](https://en.wikipedia.org/wiki/Left_recursion#Direct_left_recursion) shows infinite recursion for `A => Ax`.
      If `A => Ax | r` or `A => r | Ax`, when r will be never met, then also infinite recursion which is same as wiki
      > Because the second branch of amb expression will call (parse-verb-phrase) again, this will lead to infinite loop.
    - > to: ...
      same as [this](https://en.wikipedia.org/wiki/Left_recursion#Removing_direct_left_recursion)
      Work due to
      > (we have choices to stop or to go deeper).
- [ ] 48
- [ ] 49
- [ ] 50
  - wiki
    - meteorgan
      - `delete!` is similar to `filter`.
      - `(or (= k 0) (null? lst))` is safer to allow `(>= k (length lst))`
    - I checked the context of "delete", "remove" since I uses the internal `delete` procedure.
  - repo skipped this.
- [x] 51 trivial and repo same as wiki.
- [x] 52 trivial and repo same as wiki.
- [ ] 53
  - if `prime-sum-pair` is found, then `pairs` is that pair, and then `(amb)` which causes. At last return `pairs`.
    If not, then `'()`.
    - wrong.
- [ ] 54
  - `(not pred-value), (fail2)`.
    - see wiki better same as repo.
- [x] 55
  - `(supervisor ?x (Bitdiddle Ben))`
    `(job ?person (accounting . ?job))`
    `(address ?person (Slumerville . ?addr))`
    - similar to repo and same as wiki.
- [x] 56
  ```scheme
  (and (supervisor ?x (Bitdiddle Ben))
     (address ?x ?addr))
  (and (salary (Bitdiddle Ben) ?x)
     (salary ?person ?z)
     (lisp-value < ?z ?x)
     )
  (and (supervisor ?x ?y)
      (not (job ?y (computer . ?rest)))
     (job ?y ?z)
     )
  ```
  - same as repo, wiki.
- [x] 57
- [x] 58
- [ ] 59
  - a. trivial
- [ ] 60
  - due to symmetry (i.e. swap `?person-1 ?person-2` the rule body still holds).
- [ ] 61
  - notice here it assumes ?x is at the left of ?y, and doesn't check nestedly.
- [x] 62
- [x] 63
  - trivial by and
- [x] 64
  - `(outranked-by ?middle-manager ?boss)` has no var bindings available.
    So it will keep calling itself.
- [x] 65
  - trivial by definition since `Bitdiddle Ben` is the supervisor of 3 people etc.
- [ ] 66
  - just `(and (wheel ?who) (salary ?who ?amount))` will *duplicately* accumulates something.
  - > Outline a method he can use to salvage the situation.
    Since frame is manipulated independently, we need to filter duplicate `?x`s in evaluator. Then do as Ben's original thoughts.
    - same as repo.
- [ ] 67
  - > The general idea is that the system should maintain some sort of history of its current chain of deductions and should not begin processing a query that it is already working on.
    just DFS as Exercise 3.18 does.
    - > (After you study the details of the query-system implementation in section 4.4.4, you may want to modify the system to include your loop detector.)
      Emm... As said before, just DFS...
      - TODO see wiki user-unknown's.
  - > Describe what kind of information (patterns and frames) is included in this history, and how the check should be made.
    both.
    - check: replace patterns with possible values. Then compare the current transformed pattern with the former ones. If using the same rule and same number of var's with the same locations, then loop. 
      - `(outranked-by ?n_middle-manager ?k_boss)`
      - `(married ?y-1 Mickey)`
        -> `(married ?Mickey ?x-2)` loops with `(married Mickey ?who)`
    - wiki
      - "rule name" and "unbouned" just implies pattern.
    - same as repo.
- [ ] 68
- [ ] 69
- [ ] 70
  - As hint says, to avoid constructing the infinite stream unexpectedly.
    - wiki
      > so THE-ASSERTIONS will *not be evaluated*
    - This is different from the sub-section "Infinite loops" where loop is caused by *recursive calls* while here is due to infinite assertion stream.
    - Here due to delay, `set!` has the same effects as `define` where `(stream-cdr ones)` will go into the infinite loop.
    - Also see repo which means same with one detailed example.
- [ ] 71
  - > This postpones looping in some cases
    Maybe `(apply-rules query-pattern frame)` -> the 1st `(apply-a-rule rule pattern frame)` -(see `outranked-by` which also uses `disjoin`)> `(outranked-by ?middle-manager ?boss)` (here `?middle-manager` should be different from `?staff-person`, otherwise `?staff-person` will also be in the infinite loop.).
    But why infinite loop here since we doesn't call the same thing.
    - As wiki says, the key is "postpone", which doesn't mean "avoid".
      - Then how the example works is just as the book says.
        > Indeed, whether the system will find the simple answer (married Minnie Mickey) before it goes into the loop depends on implementation details *concerning the order in which the system checks the items in the data base*.
        ~~i.e. whether `` first or not.~~ See exercise_codes/SICP/4/demo/logic-programming/infinite-loop.scm
- [x] 72 
  - By hint, i.e. there are some infinite results.
    Same as 71, if there are one frame which shows the same infinite results, then it is nonsense to keep using that (also see repo for the detailed example).
    - as wiki says
      > The reason is same to why we use interleave in 3.5.3
      i.e. 
      > we need to devise an order of combination that ensures that *every element will eventually be reached*
- [ ] 73
  - Same as `disjoin` but for frame-stream instead of disjunction.
    maybe infinite `frame-stream`?
- [ ] 74
  - a. `stream-car, (lambda (stream) (not (stream-null? stream)))`
  - b. `flatten-stream` implicitly does `stream-map` 
    delay for `interleave-delayed` is implicitly included in `stream-map` which uses `cons-stream`.
    - After all, `(flatten-stream stream)` -> `(interleave-delayed (stream-car stream) ...)` returns `(cons-stream (stream-car (stream-car stream)) ...)`
      ... (if stream has at least 2 non-null elements) is `(interleave-delayed (flatten-stream (stream-cdr stream)) the-empty-stream)` which based on induction is `(interleave-delayed (cons-stream (stream-caadr stream) ...2) the-empty-stream)`, i.e. `(cons-stream (stream-caadr stream) ...2)`.
      ...2 means by induction `(interleave-delayed (flatten-stream (stream-cddr stream)) the-empty-stream)`.
      So it returns `(cons-stream (stream-caar stream) (stream-caadr stream) ...)` which is same as here.
- [ ] 75 repo is same as wiki.
- [ ] 76
- [ ] 77
  - wrong comment
    - ```
      <<<LisScheSic
      Actually, not may be located ''deeply'' in the compound query. As 4.4.4.2 implies, only compound query can have filter query inside it, so maybe not correctly ordered. So we only need to consider one more type of clause in normalize.
      {{{scheme
      (define (normalize clauses)
        (let ((filters (filter filter? clauses))
              (compounds (filter compound? clauses))
              (rest (filter (lambda (x) (and (not (filter? x)) (not (compound? x)))) clauses)))
          (append rest compounds filters)))
      }}}

      ---

      As baby says, this works but is inefficient. 

      >>>
      ```
  - repo
    - It uses `not-filter-vars` to check the possible vars to be matched later.
      So it won't wait until *all* vars can be bound but just the *maximum* possible.
    - `(filter-already-bound? exp frame-stream)` is same as SHIMADA's to work for the entire frame-stream.
    - It stores promise in one separate frame instead of appending as mine does.
    - It tries force when extended, which seems too aggressive since this may ~~fail too many times~~ have too many redundant calls for `frame-passed-filter?` although fine-grained.
- [x] 78
  - For wiki, only poly's and revc's are similar to me.
    woofy's/SHIMADA's ideas are straightforward based on amb/stream-one-by-one. I won't dig into them.
    - > cannot deal with infinite outputs or output the answers in an interleaving style
      solved.
  - repo
    - skipped due to being similar to wiki woofy's.
  - Emm... My implementations may be not expected by the book author. Anyway the basic ideas are same as what woofy says in wiki. 
  - ~~I am stuck at this exercise for a long time, maybe it is better~~
- [ ] 79
  - > Can you relate any of this to the problem of making deductions in a context (e.g., ``If I supposed that P were true, then I would be able to deduce A and B.'') as a method of problem solving? (This problem is open-ended. A good answer is probably worth a Ph.D.)
    ~~IMHO this is more related with `if`...~~
    i.e. `(rule (P ...) (and (A ...) (B ...)))` although it means A && B->P, but it also holds in the reverse direction.
    - "block-structured" is just nested definition which is to be used for the final result.
  - repo skipped this.
  - IMHO this is harder than 4.77 although lockywolf doesn't think that way.
    It changes data structure for 4.77 while I doesn't.
  - maybe related with [annotated syntax objects](https://stackoverflow.com/questions/79098453/how-to-implement-one-anonymous-loop-form-like-do-in-the-evaluator-as-a-derived-e)
  - wiki
    - TODO
      I don't know what SophiaG means by "never evaluated".
  - Also see SDF_notes.md "... SICP 4.79 ..."
### @TODO
- ~~17~~
  - > Design a way...
    See `test-sequential-and-simultaneous-evaluation.scm`. IMHO just making all `define`s before the rest is fine.
      1. The above is *not allowed* by wiki meteorgan's. This is fine due to not allow reordering. Also see the above. (SOLVED)
      2. If so, what is the difference from meteorgan's and the original `define`?
        See "So the above meteorgan's" in the following. (SOLVED)
      3. Most important, what is "simultaneous scope" at all?
        - Based on exercise 4.19, it is just one implementation for footnote 24 restriction where "insisting that internal definitions come first and do not use each other while the definitions are being evaluated" all can be ensured by error signaling for `'*unassigned*`.
          - one specific case of violating "internal definitions come first"
            ```scheme
            (define (even? n) ...)
            (odd? foo)
            (define (odd? n) ...)
            ```
            Then `odd?` will be `'*unassigned*` when accessed earlier.
          - one specific case of violating "do not use each other"
            See exercise 4.19.
        - Here "simultaneous scope" just means all are `'*unassigned*`. (SOLVED)
          > just *create all local variables* that will be in the current environment *before evaluating*
    - repo is same as meteorgan's.
    - See exercise 4.19
      > Eva is in principle correct -- the definitions should be regarded as simultaneous.
      so "simultaneous scope" means the former value will use the *latter* value when necessary.
      - > it is better to *generate an error* in the difficult cases of simultaneous definitions
        "difficult" due to `b` is based on `a` violating footnote 24.
        - So the above meteorgan's will "generate an error" due to accessing `'*unassigned*` while the original won't but saying ";Unbound variable: v".
      > than to produce an incorrect answer (as Ben would have it).
      But actually MIT/GNU Scheme will output as Ben's (IMHO this is just how *environment model* works where `(+ a x)` will search frame*s* and find `(a 1)` and `(+ a b)` just uses the *first* frame `(define a 5)`.)
- 4.78
  Update wiki about (big-shot ?x ?y).

[repo_reference_1_20]:https://mngu2382.github.io/sicp/chapter1/01-exercise06.html

[Fibonacci_variant]:https://math.stackexchange.com/q/4934605/1059606

<!-- wikipedia -->
[Composite_Simpson_rule]:https://en.wikipedia.org/wiki/Simpson%27s_rule#Composite_Simpson's_1/3_rule
[Lambda_calculus_Y_combinator]:https://en.wikipedia.org/wiki/Lambda_calculus#Recursion_and_fixed_points

[fake_let_assignment]:https://stackoverflow.com/a/11833038/21294350