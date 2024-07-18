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
- 

---

[R7RS]:https://standards.scheme.org/unofficial/errata-corrected-r7rs.pdf