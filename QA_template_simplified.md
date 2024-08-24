Recently I self-learnt MIT 6.5151 course to learn SICP and [Software Design for Flexibility (SDF)][1] book. I am reading SDF chapter 3 which will redefine  Scheme primitive arithmetic after having read SICP chapter 2.

Its uses [`(install-package! (arithmetic->package arithmetic))`][2] to do this. This actually did `package-installer` in some environment returned by [`(the-environment)`][3] in "common/package.scm" which then uses `(environment-define environment name value)` to redefine arithmetic primitive procedures. "common/package.scm" is loaded by `(manage 'new 'combining-arithmetics)` where [`manage` is defined in one top-level-environment `manager-env`][4].
```scheme
;; these funcs are from different files.
(define (install-arithmetic! arithmetic)
  (set! *current-arithmetic* arithmetic)
  (install-package! (arithmetic->package arithmetic)))

(define install-package! (package-installer (the-environment)))

(environment-define system-global-environment
                    'manage
                    (access manage-software manager-env))
```

I tried to use [`(pp (pe))`][5] in "common/package.scm" to show the environment info but it throws error ";Ill-formed syntax: (define install-package! (pp (pe)) (package-installer (the-environment)))".
```scheme
(define install-package! 
  (pp (pe))
  (package-installer (the-environment)))
```

By reading [the doc of `access`][6], here `manage` is in `manager-env`. 

Q1: Does this mean [all what `manage` does][7] (I didn't dig into this part of codes since this is beyond what SDF intends to teach) without calling `ge` is also in that env (including loading "common/package.scm")? So `(environment-define environment name value)` should also be done in `manager-env`.

Q2: Then when we call `(environment-lookup system-global-environment name)` where `system-global-environment` is [the parent of top-level-environment `manager-env`][8], will it also look up in its child env?

From [the doc][9], it seems that they are separate. If so, why we define parent env here?
> The operations in this section reveal the frame-like structure of environments by permitting you to examine the bindings of a particular environment *separately from those of its parent*.

P.s. Is there some appropriate tag like `env` for this question in SO? (The recommendations like `environment-variables` are inappropriate here.)


  [1]: https://mitpress.ublish.com/ebook/software-design-for-flexibility-preview/12618/27
  [2]: https://github.com/sci-42ver/SDF_exercise_solution/blob/9959cb5bdb2c9b51765a3c250cd70020ad228035/software/sdf/common/arith.scm#L166
  [3]: https://github.com/sci-42ver/SDF_exercise_solution/blob/9959cb5bdb2c9b51765a3c250cd70020ad228035/software/sdf/common/package.scm#L79
  [4]: https://github.com/sci-42ver/SDF_exercise_solution/blob/9959cb5bdb2c9b51765a3c250cd70020ad228035/software/sdf/manager/load.scm#L46
  [5]: https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-user/The-Current-REPL-Environment.html
  [6]: https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Assignments.html#index-access
  [7]: https://github.com/sci-42ver/SDF_exercise_solution/blob/9959cb5bdb2c9b51765a3c250cd70020ad228035/software/sdf/manager/software-manager.scm#L24-L44
  [8]: https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Top_002dlevel-Environments.html#index-the_002denvironment
  [9]: https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Environment-Operations.html