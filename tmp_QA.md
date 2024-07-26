This is from [Software Design for Flexibility (SDF)][1] book:
> Exercise 2.8: Too much nesting
> 
> Our program produces excessively nested regular expressions: it
makes groups even *when they are not necessary*. For example, the
following simple pattern leads to an overly complex regular
expression:
> ```scheme
> (display (r:seq (r:quote "a") (r:dot) (r:quote "c")))
> \(\(a\).\(c\)\)
> ```
>
> Another problem is that BREs may involve back-references. (See
section 9.3.6.3 of the POSIX regular expression documentation.[14]) A
back-reference refers to a preceding parenthesized subexpression.
So it is important that the parenthesized subexpressions be ones
*explicitly placed* by the author of the pattern. (Aargh! This is one of the worst ideas we have ever heard of—grouping, which is *necessary for iteration*, was *confused with naming for later reference*!)
> 
> **To do:** Edit our program to eliminate as much of the
unnecessary nesting as you can. Caution: There are *subtle cases*
here that you have to watch out for. What is such a case?
Demonstrate your better version of our program and show how it
handles the subtleties.
> 
> Hint: Our program uses strings as its intermediate representation
as well as its result. You might consider using a *different intermediate representation*.

I can "eliminate as much of the unnecessary nesting as you can" by using `r:seq` as:
```scheme
(define (r:seq . exprs)
  (apply string-append exprs))
```
without adding the outer parentheses.

I have used regex before for about 2 years from time to time, I don't know what "subtle cases" above mean? IMHO when we want to group some expression `x` then we just do `(x)`. Is there some subtle case related with "intermediate representation" of "string"?

---

P.S. What does the above sentence mean?
> Aargh! This is one of the worst ideas we have ever heard of—grouping, which is *necessary for iteration*, was *confused with naming for later reference*!


  [1]: https://mitpress.ublish.com/ebook/software-design-for-flexibility-preview/12618/27