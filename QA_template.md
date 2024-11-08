Recently when I self-learnt MIT 6.5151 course, I first read CS 61AS Unit 0 as the preparation. Then I have read SICP 1 to 2.1 (with related lecture notes) as [ps0][1] requires (also read 2.2.1 as [CS 61A notes][2] requires) and then [Software Design for Flexibility (SDF)][3] Prologue, chapter 1 and partly Appendix on Scheme. I use MIT-Scheme as the course recommends.

The course [problem set 1][4] has the following problem:
> Exercise 2.a: (Not in SDF)
 Most modern languages, such as *Python* and Javascript provide
 facilities to write and use combinators like COMPOSE. Pick your
 favorite language and write implementations, in your favorite
 language, of three of the combinators that that we show in section 2.1
 of SDF. Can you deal with *multiple arguments*? To what extent can you
 make them *work with multiple returned values*? To what extent can you
 put in checking for correct arity? Do these requirements conflict.
 Demonstrate that your combinators work correctly with a few examples.

My implementation:
```python
import inspect
def compose(f, g):
  g_arity=len(inspect.signature(g).parameters)
  def compose_composition(*arguments):
    # https://stackoverflow.com/a/18994347/21294350
    try:
      if len(arguments) != g_arity:
        print("compose Arg number error")
      # print("g return:",g(*arguments))
      
      # https://stackoverflow.com/a/691274/21294350
      # very inconvenient.
      g_result=g(*arguments)
      if type(g_result) is list:
        print("g_result",g_result) 
        return f(*g_result)
      else:
        return f(*[g_result])
    except:
      pass
  return compose_composition

print("compose test_1",compose(lambda x:x+2, lambda x:x*x)(2))
print("compose test_2",compose(lambda x:x+2, lambda x:x*x)(2,2))
print("compose test_3",compose(lambda x:["foo",x], lambda x:["bar",x])(2))
```

The key problem is due to my assumption of passing "multiple returned values" using *`list`*. But this will have problems if we just pass *one single list, i.e. one type of single-parameter cases*. Then we can't differentiate it from "multiple returned values".

---

[The book Scheme implementation][5] solves the above problem by using `values` which is probably not returned normally as one single data. It is always used as one container of multiple arguments.
```scheme
(define (compose f g)
  (define (the-composition . args)
    (call-with-values (lambda () (apply g args))
      f))
  (restrict-arity the-composition (get-arity g)))
```

Is there one way to solve with the above tricky problem using python?

  [1]: https://groups.csail.mit.edu/mac/users/gjs/6.945/psets/ps00/dh.pdf
  [2]: https://people.eecs.berkeley.edu/~bh/61a-pages/Volume2/notes.pdf
  [3]: https://mitpress.ublish.com/ebook/software-design-for-flexibility-preview/12618/27
  [4]: https://groups.csail.mit.edu/mac/users/gjs/6.945/psets/ps01/ps.pdf
  [5]: https://github.com/sci-42ver/SDF_exercise_solution/blob/ea5c53e090c23245d89b9963e1a238e5cd1bfb03/software/sdf/combinators/function-combinators.scm#L41-L47