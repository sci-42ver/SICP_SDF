SICP says "One key idea in dealing with compound data is the notion of
closure —that the glue we use for combining data objects should allow
us to combine not only primitive data objects, but *compound data ob-jects* as well." and "The use of the word “closure” here comes from *abstract algebra*". So you are right SICP uses https://en.wikipedia.org/wiki/Closure_(mathematics) instead of https://en.wikipedia.org/wiki/Closure_(computer_programming).

@adabsurdum Thanks. I understand now.
# Notice
- I won't read many reference papers except when they are *specifically about programming*.
- I don't have time to test all possible *types* of inputs. I will only give some types of inputs which IMHO are all possible types without the review from others.
  Any review of this repo is appreciated.
- I won't dig into the complexity of internal functions like `remainder` since by modularity this is unnecessary.
# Acknowledgment
- > the lambda papers
  [See](https://research.scheme.org/lambda-papers/)
- [PPA](https://ell.stackexchange.com/a/325015)
# Chapter 1
Interestingly this chapter compares the computer system with many other systems like biology and physics, etc. (I only read the footnotes about biology detailedly possibly.)
- > Thus a designer may design a compound function and later choose the family for implementation.
  > The families differ in such characteristics as speed and power dissipation, but *not in function*.
  > The families are cross-consistent as well as internally *consistent* in that each function is available in each family, with the same packaging and a consistent nomenclature for description.
  IMHO it means we should construct multiple alternative primitive implementations.
- [Hox complex](https://en.wikipedia.org/wiki/Hox_gene)
- > To the optimist, the glass is half full. To the pessimist, the glass is half empty. To the engineer, the glass is twice as big as it needs to be.
  [See](https://qr.ae/psfaJy)
# TODO
- > We will examine a very nice example of this optimization in chapter 7.
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
# [ps](https://github.com/sci-42ver/6.945_assignment_solution) (It doesn't have solutions for SDF exercises)
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
# [project](https://github.com/bmitc/mit-6.945-project) (it only has https://github.com/bmitc/the-little-schemer but not solutions for SDF exercises)

---

[R7RS]:https://standards.scheme.org/unofficial/errata-corrected-r7rs.pdf