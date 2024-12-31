Recently I self-learnt MIT 6.5151 course to learn SICP and [Software Design for Flexibility (SDF)][1] book. I am reading SDF chapter 3 which will redefine  Scheme primitive arithmetic after having read SICP chapter 2.

I am trying to understand what [`(the-environment)`][2] is when one file is loaded. I run these in one file ([load.scm][3]):
```scheme
(load "sdf/manager/load.scm")
(manage 'new 'generic-procedures)
(pp (pe))

   load.scm
(environment-define system-global-environment
                    'manage
                    (access manage-software manager-env))
```

`(manage 'new 'generic-procedures)` (I didn't dig into the implementation of `manage-software` since this is beyond what SDF intends to teach) will do ";Loading ".../sdf/common/package.scm"... done" without calling [`ge`][4] (I changed the path by using ... to avoid leaking some sensitive information). 

IMHO [`manage` is defined in one top-level-environment `manager-env`][3], so what "common/package.scm" does including [`(package-installer (the-environment))`][2] is also in that env, i.e. `(the-environment)` here is `manager-env`. Is it that case?

---

The following is wrong since we are defining one variable instead of one lambda function. So the value [should be expression][5].
```scheme
(define install-package! 
  (pp (pe))
  (package-installer (the-environment)))
```

After adding `(pp (pe))` in `package-installer` and in the file run, I  found the env is  actually changed when calling `new-environment` command (see [SDF Software Manager documentation][6] p4). This is  probably done by [`force-top-level-repl!`][7] (but the 3 functions used like [`abort->top-level`][8] are not defined in code base and internal Scheme. I don't know how it works actually).

So `(the-environment)` returns the env changed by `(manage 'new 'generic-procedures)` instead of

  [1]: https://mitpress.ublish.com/ebook/software-design-for-flexibility-preview/12618/27
  [2]: https://github.com/sci-42ver/SDF_exercise_solution/blob/9959cb5bdb2c9b51765a3c250cd70020ad228035/software/sdf/common/package.scm#L79
  [3]: https://github.com/sci-42ver/SDF_exercise_solution/blob/9959cb5bdb2c9b51765a3c250cd70020ad228035/software/sdf/manager/load.scm#L46
  [4]: https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-user/The-Current-REPL-Environment.html
  [5]: https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Definitions.html#index-define-1
  [6]: https://SDF%20Software%20Manager%20documentation
  [7]: https://github.com/sci-42ver/SDF_exercise_solution/blob/9959cb5bdb2c9b51765a3c250cd70020ad228035/software/sdf/manager/software-manager.scm#L194-L198
  [8]: https://github.com/sci-42ver/SDF_exercise_solution/blob/9959cb5bdb2c9b51765a3c250cd70020ad228035/software/sdf/manager/utils.scm#L82-L85

- > only functional languages (and not even all of them) use lazy evaluation uniformly for every function call

  IMHO giving one tree lib based on stream is also fine for lazy tree.
- > More importantly, lazy evaluation permits us to modularize evaluate in this way. Since gametree has a potentially infinite result, this program would never terminate without lazy evaluation
  
  See infinite context.

- > Since each part can be thrown away (reclaimed by the garbage collector) as soon as maximize has finished with it, the whole tree is never resident in memory. Only a small part of the tree is stored at a time. The lazy program is therefore efficient.
  
  this is due to lazy combined with garbage collector. Stream can also do that.

- > Thanks to lazy evaluation, if maximize doesn’t look at all of the list of numbers, some of them will not be computed
   Stream can also do that.

- > This efficiency depends on an interaction between maximize (the last function in the chain of compositions) and gametree (the first) without lazy evaluation
   
  i.e. the chain will generate each depth level of the gametree infinitely. But stream will only evaluate each `node-value` without evaluating `subtrees` if `subtrees` are not needed for the current computation goal, so stream can also do that.

- > Thanks to lazy evaluation, the fact that maximize' looks at less of the tree means that the whole program runs more efficiently

  `maximize'` implies lazy by dropping some subtrees based on checking the static value (i.e. "the true value of the positions" to help deciding how gametree grows) relation with `minleq`.
  Since `rest` etc can be stream, so infinite val of `rest` is fine if not using lazy evaluation for argument.


   infinite context
- > The function repeat is an example of a function with an “infinite” output
  >
  > the function repeat used to construct infinite lists
  >
  > The function integrate computes an infinite list of better and better approximations to the integral
  
  Just like infinite stream 
- > it doesn’t work for infinite trees, because maximize keeps on recursing until it finds a node with no subtrees
  > 
  > If it’s possible for a game to go on forever with neither side winning, its game tree is infinite
   
  infinite depth
- > statically evaluates all the positions in the tree (which may be infinitely many)
   
  infinite width/depth
- > First of all, it doesn’t work for infinite trees, because maximize keeps on recursing
   
  since lazy is about argument evaluation instead of procedure calls.