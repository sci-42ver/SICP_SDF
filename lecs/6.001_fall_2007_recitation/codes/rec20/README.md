I checked the dir tree here. All file contents have been understood.
## amb
- [sfu](https://www.sfu.ca/~tjd/383summer2019/scheme-amb.html)
  - prime? is similar to book p66 except with the possible step 2 (TODO in my memory the book also uses this possible step somewhere).
  - All implementations *have been compared* with at least one of others.
## call/cc
the best `call/cc` explanation I found is [at SO](https://stackoverflow.com/a/13338881/21294350). Yes one very good website!!!

Also see [`(call/cc call/cc)`](https://stackoverflow.com/a/77952036/21294350) and [the last comment](https://stackoverflow.com/questions/77951586/how-to-interpret-call-cc-call-cc#comment137459845_77952036) 
> It is *(identity)* if the calll/cc is being made at top level. If the call/cc is deeper in the program, it will be the rest of the computation *afterward*.
- https://wiki.c2.com/?ContinuationsAreGotos
  2nd paragraph: IMHO actually their uasge purposes are similar, i.e. both to use somewhere .
### [coroutine](https://wiki.c2.com/?AmbSpecialForm)
- [TODO](https://stackoverflow.com/questions/715758/coroutine-vs-continuation-vs-generator/715913#comment5172146_715758)
  > is it possible to model continuations with coroutines
  - https://wiki.c2.com/?ContinuationImplementation says not, although the more specific exception can implement continuation as lispy2 shows.
### python
- see [this](https://stackoverflow.com/a/66972983/21294350)
  - TODO
    > because the moment control passes out through the block form the return-from becomes invalid
- https://squiddev.medium.com/continuing-continuations-cps-in-python-47bba90c8d1e
  - just wraps continuation manually `lambda v: closureifier(k(v+l_o_n[0])`
    > take in an extra parameter for that continuation, in this case k.
    actually it is just like one lazy evaluation but it can't do something like calling cc
    - So *skip* this.
  - [trampoline](https://stackoverflow.com/a/489860/21294350)
- https://www.ps.uni-saarland.de/~duchier/python/continuations.html
  just shows how continuation is [*used*](https://web.archive.org/web/20081216015619/http://www.ps.uni-sb.de/~duchier/python/validity.py) but *not implemented*.
  - here is just uses call/cc to implement amb (i.e. "backtracking").