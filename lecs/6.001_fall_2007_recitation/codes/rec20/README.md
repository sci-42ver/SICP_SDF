## amb
- [sfu](https://www.sfu.ca/~tjd/383summer2019/scheme-amb.html)
  - prime? is similar to book p66 except with the possible step 2 (TODO in my memory the book also uses this possible step somewhere).
  - All implementations have been compared with at least one of others.
## call/cc
the best `call/cc` explanation I found is [at SO](https://stackoverflow.com/a/13338881/21294350). Yes one very good website!!!

Also see [`(call/cc call/cc)`](https://stackoverflow.com/a/77952036/21294350) and [the last comment](https://stackoverflow.com/questions/77951586/how-to-interpret-call-cc-call-cc#comment137459845_77952036) 
> It is *(identity)* if the calll/cc is being made at top level. If the call/cc is deeper in the program, it will be the rest of the computation *afterward*.
### [coroutine](https://wiki.c2.com/?AmbSpecialForm)