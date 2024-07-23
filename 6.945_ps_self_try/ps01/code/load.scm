(let ((env (make-top-level-environment)))
  (with-working-directory-pathname
    (directory-pathname (current-load-pathname))
    (lambda ()
      (load '("~/SICP_SDF/software/sdf/combinators/function-combinators")
            env)))
  (environment-define system-global-environment 'problem-set-environment env)
  (ge env))
