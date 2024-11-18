<!-- notice to use one blank line after the section header, otherwise maybe code block can't be recognized here. -->
Keith Gaughan's answer is great which says the relation between generator and coroutine in its 2nd paragraph. Actually, `cc(max(x, y))` in `biggest = callcc(foo, [23, 42])` can be thought as doing `biggest = max(23, 42)`. This is what "return with the value you're calling the current continuation with" means.

Here I give example programs which can be run to show how them work as one  supplementary resource for Keith Gaughan's answer. For the former 2 I is mainly based on [Reuven's blog][1]. For callcc, I followed lispy2 doc.

I also give their relations with codes or implementation ideas. If we can understand relations, then differences may probably be implicitly got.

#### generator
##### definition extracted from wikipedia
> a generator yields the values *one at a time*, which requires less memory and allows the caller to get started processing the first few values immediately

Here yield means generate.
##### implementation
Simple demo from the above blog.

```python
# creation
def myfunc():
    yield 1
    yield 2
    yield 3
# usage
for one_item in myfunc():
    print(one_item)
# 1
# 2
# 3
```

#### coroutine
##### definition

This is from one [wikipedia reference][2]
> Under these conditions each module may be made into a **co**routine; that is, it may be coded as an autonomous program which **co**mmunicates with adjacent modules as if they were *input or output* subroutines. Thus, coroutines are subroutines all at the same level, each acting *as if it were the master program* when in fact there is no master program. ... When coroutines A and B are connected so that A sends items to B, B runs for a while until it encounters a *read* command, which means it needs something from A. Then control is transferred to A until it wants to *"write,"* whereupon control is returned to B at the point where it *left off*.

##### asymmetric coroutine implementation
The following program is just following the structure of Keith Gaughan's. 
Notice here `x` is directly passed from `my_coroutine_body` to `x = my_coro.send(x)`. So it is asymmetric. How "symmetric and asymmetric coroutines" are converted to each other is shown in [boost doc "Symmetric and asymmetric coroutine transformation"][3] (reference of [this QA answer][4]) which is fine to read without much cpp background.
1. `my_coroutine_body` is just one doubling program. Here it can still do suspension and resumption at least due to `yield` as the above shows. But notice here we uses yield-expression `bar = yield foo` instead of yield-statement `yield foo` (please see [PEP 342][5] for more infos). It is used here since it can pass data in by `send`. So it achieves the *data communication* implied in the definition.
   > which is the value that should be *sent in* to the generator ... the send() method returns the *next* value *yielded* by the generator-iterator

2. What `make_coroutine` does is to Delegate to a Subgenerator as [PEP 380][6] shows. For here it is just to keep the Keith Gaughan's structure to show how *the general idea* works. We can work well without this here as the blog shows. But as "Delegate" implies, it will be helpful when implementing one dispatcher (see `switchboard` in the blog).

   One good explanation of `yield-from` is shown in [this QA answer "transparent, bidirectional connection"][7]
3. `next(my_coro)` usage is said by PEP 342
   > Because generator-iterators begin execution *at the top* of the generator’s function body ... *advance* its execution to the *first yield* expression.

###### how this implementation relates with the above definition
I give number index in the following paragraph to show the relation with the above quote sentence more clearly. In a nutshell, it is just one loop where 2 or more coroutines passes data read/write control to each other.

1- Here `my_coro` (let it be coroutine A) cooperates with `my_coroutine_body` (let it be coroutine B) just as `make_coroutine` expects. 2- Assume the master program (MP) is the program part which is running currently. 3- Coroutine A (CMP, i.e. the current MP) `send`s one number to coroutine B. 4- coroutine B then immediately reads that by `x = yield x` where the result of `yield x` is that coroutine A sends in. Then coroutine B (CMP) does some calculation and then transfer control explicitly by `yield x` in `x = yield x`. 5- Then coroutine A (CMP) *reads* that yielded value which is assigned to the left `x` in `x = my_coro.send(x)`. Then coroutine A does the next write by `send`. 6- Then coroutine B *continues* from the "the point where it left off" implied by `yield` similar to the generator behavior.

```python
# https://lerner.co.il/2020/05/08/making-sense-of-generators-coroutines-and-yield-from-in-python/
def my_coroutine_body():
  x = ''
  while True:
    print(f'Yielding x ({x}) and waiting…')
    # Do some funky stuff
    x = yield x
    # Do some more funky stuff
    if x is None:
      break
    print(f'Got x {x}. Doubling.')
    x = x * 2


def make_coroutine(routine):
  yield from routine()


my_coro = make_coroutine(my_coroutine_body)
next(my_coro)

x = 1
while True:
  # The coroutine does some funky stuff to x, and returns a new value.
  # send to routine which then sends to the left x in `x = yield x` in my_coroutine_body.
  if x < 2**10:
    x = my_coro.send(x)
  else:
    my_coro.send(None)
  print(x)
## in coroutine B
# Yielding x () and waiting…
# Got x 1. Doubling.
# Yielding x (2) and waiting…
## back to coroutine A
# 2
## again into coroutine B
# Got x 2. Doubling.
# ...
```
###### relation with generator
As the above implementation implies, here we still uses suspension and resumption offered by `yield`. But we added the data passing mechanism by `send` method. So this implies we can use coroutine to implement generator where we don't send data but just send the command to let the generator continuing to run. One  straightforward implementation is shown in [c2 CoRoutine wiki][8] with the same Generate123 example which uses wikipedia `yield, resume` notation.

IMHO the following from c2 CoRoutine wiki is inappropriate since generator actually also saves control state. The difference is Keith Gaughan says, coroutine can *pass data* while generator can't.
> Coroutines are functions or procedures that *save control state* between calls (as opposed to, but very similar to, Generators, such as Random Number Generators, that *save data state* between calls).

##### symmetric coroutine implementation
See "A simple co-routine scheduler ..." part in PEP 342. Actually it does same as the above boost doc by using one scheduler to allow yield to one given address instead of only to the caller.
###### relation with generator
Quoted from [wikipedia][9] which quotes PEP 342
> The only difference is that a generator function *cannot control where* should the execution continue after it yields; the control is always transferred to the generator's caller.

#### call/cc or call-with-current-continuation
The naming is borrowed from Scheme.
##### definition from wikipedia
> The "current continuation" or "continuation of the computation step" is the continuation that, from the perspective of running code, would be *derived from the current point in a program's execution*. The term continuations can also be used to refer to first-class continuations, which are constructs that give a programming language the ability to *save* the execution state at any point and return to that point at a later point in the program, possibly multiple times.
##### implementation in python
There is one implementation based on *exception* as [this question][10] implies in lispy2. This is possible since exception can be implemented based on  continuation as wikipedia and [mattmight blog][11] shows. In a nutshell, it uses `try` location as the continuation.

```python
def callcc(proc):
    "Call proc with current continuation; escape only"
    ball = RuntimeWarning("Sorry, can't continue this continuation any longer.")
    def throw(retval): ball.retval = retval; raise ball
    try:
        return proc(throw)
    except RuntimeWarning as w:
        if w is ball: return ball.retval
        else: raise w
```

Let us check this implementation based on one official lispy2 example lisp program (You can think the syntax here as `(function argument1 ... argumentn)` where function can be also special operator like `lambda` here to denote one lambda expression).
```lisp
(call/cc (lambda (throw) 
         (+ 5 (* 10 (call/cc (lambda (escape) (* 100 (throw 3))))))))
; 3
```
When `(call/cc (lambda (throw) ...))` is run, `proc(throw)` is run. Then `(throw 3)` will do `raise ball` which is one exception so that is *directly* caught by `except RuntimeWarning as w:` part of the *1st* `call/cc`. This *implicitly* implements the continuation and uses Exception to pass the value around.
##### relation with coroutine
In Scheme (probably also for other Lisp dialect with first-class continuation), coroutine can be implemented by call/cc which is also said by wikipedia. [c2 wiki][12] has one such implementation.

In a nutshell, the basic ideas of `(coroutine routine)` in that wiki is to use continuation to track where coroutine is suspended. Then `yield` is implemented by the escape function, i.e. the above `throw`, which can  directly goes back to the caller location as the above shows. So if the caller is the other coroutine, then we achieve the communication.


  [1]: https://lerner.co.il/2020/05/08/making-sense-of-generators-coroutines-and-yield-from-in-python/
  [2]: https://melconway.com/Home/pdf/compiler.pdf
  [3]: https://www.crystalclearsoftware.com/soc/coroutine/coroutine/symmetric_coroutines.html
  [4]: https://stackoverflow.com/a/42042904/21294350
  [5]: https://peps.python.org/pep-0342/#new-syntax-yield-expressions
  [6]: https://peps.python.org/pep-0380/
  [7]: https://stackoverflow.com/a/26109157/21294350
  [8]: https://wiki.c2.com/?CoRoutine
  [9]: https://en.wikipedia.org/wiki/Coroutine#cite_note-9
  [10]: https://stackoverflow.com/q/66962102/21294350
  [11]: https://matt.might.net/articles/programming-with-continuations--exceptions-backtracking-search-threads-generators-coroutines/
  [12]: https://wiki.c2.com/?CategoryContinuation