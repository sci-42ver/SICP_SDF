This is one exercise from [Software Design for Flexibility (SDF)][1] book:
> Here is an example:
> ```scheme
> ;;; A missing match!
> (unify:internal '(((?? x) 3) ((?? x)))
>                 '((4 (?? y)) (4 5))
>                 (match:new-dict)
>                 (lambda (dict)
>                   (pp (match:bindings dict))
>                   #f))
> #f
> ```
> But these expressions do match, with the following bindings:
> ```scheme
> ((x (4 5) ??) (y (5 3) ??))
> ```
> 
> ...
> 
> Exercise 4.19: Can we fix these problems?
> 
> ...
> 
> d. Figure out a way to avoid missing matches like the “A missing
match!” shown above. Is there a simple extension of the code
shown that can handle this kind of match? Note: This is an
*extremely difficult* problem.

Here `(?? x)` etc is segment var and it will match one variant length list data like `(1)` or `(1 2)` etc.

Here binding uses [data structure `(name value type)`](https://github.com/sci-42ver/SDF_exercise_solution/blob/f5cfa15eab374b7e08d6e82cfdc97a9a355eb274/software/sdf/common/match-utils.scm#L118-L122)

---

The book original code base just think the segment as one whole, so that it can either be included *totally* in another segment or not. This is shown in [codes](https://github.com/sci-42ver/SDF_exercise_solution/blob/285d69c8ed69d83285bb11cedd8ac64376007593/software/sdf/unification/unify.scm#L303-L304) where it *always* adds one new term instead of possibly splitting it:
```scheme
(slp (append initial (list (car terms*)))
                   (cdr terms*))
```
So it has the above "missing match".

---

So we need to split the segment, so that maybe the 1st / the 1st~2nd / the 1st~3rd etc can be  included in another segment. Then all these cases can be *elegantly denoted* by one single sub-segment variable (I use `???` notation in [my implementation][2]). Actually that is what the book exercise 4.20 says IMHO:
> ```scheme
> (unifier '((?? x) 3) '(4 (?? y)))
> (4 3)
> ```
> Here we see a perfectly good match, but it is not the most general
one possible. The problem is that there can be any number of things
between the 4 and the 3. A better answer would be:
> ```scheme
> (4 (?? z) 3)
> ```

Q1:

Since the exercise requires one "general match", we need to consider all possible cases for segment var.

IMHO for 2 segment var's, since we only cares about their relative locations, we can assume one var location is fixed. Then we slide the other one from the left part of the list to the right. So we have
1. no intersection
2. partial intersection
3. total containment

Since only the last is not one symmetric relation, we then have totally 4 relations between 2 segment var's.

Is the above derivation of the relation between 2 segment var's right?

---

If the answer to Q1 is yes, IMHO my implementation by just adding the partial grab mechanism when grabbing segment var is general as the exercise expects.

[My implementation][2] ideas for segment variable parts are: when we encounter one segment var
1. If the other side also has segment var as the start, then both segment vars *share* the same starting location. So either they are same or one is included totally in the other. So we can still use the original code ideas.
2. If not the case 1, then we try to grab starting from `null`. Then 
- when we encounter one segment var (including sub-segment var) during the grab process, we *first* tries to grab partial part of that segment var which is created by adding one binding like `(?? y): ((??? y-internal:10-left) (??? y-internal:9-right))` for that segment var to be bound to one sub-segment variable pair. If failure, we tries grab totally where the former is *not done by the original code ideas*. 
- Otherwise, we just grab that term totally.

Notice since with the partial grab mechanism, term to be matched with var may be replaced by one value whose length is longer (e.g. `(?? y)` has value `((??? y-internal:10-left) (??? y-internal:9-right))`), we need to consider term binding when doing unification.

Q2:

Is my implementation ideas for the general match with one side being segment var right? 

Maybe I misses some corner cases still after addition of the partial grab mechanism since the exercise says
> This is an extremely difficult problem

p.s. I tired to search for one reference implementation or paper for one unification system with the general segment variable, but [all of my searched results][3] *don't have the same definition for segment variable*.


  [1]: https://mitpress.ublish.com/ebook/software-design-for-flexibility-preview/12618/27
  [2]: https://github.com/sci-42ver/SDF_exercise_solution/blob/f5cfa15eab374b7e08d6e82cfdc97a9a355eb274/chapter_4/4_19.scm#L344-L525
  [3]: https://github.com/sci-42ver/SDF_exercise_solution/blob/f5cfa15eab374b7e08d6e82cfdc97a9a355eb274/chapter_4/4_19.scm#L304-L340