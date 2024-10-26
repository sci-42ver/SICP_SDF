; file=1;sed -i -f ~/SICP_SDF/lecs/6.001_spring_2007_recitation/codes/rec13/format.sed ${file}.scm;vim -c "execute 'normal gg=G'| update | quitall" ${file}.scm
(cd "~/SICP_SDF/lecs/6.001_spring_2007_recitation/codes/rec19/source19")
(load "eval-code.scm")

;; just follow the book
(define (eval-assignment exp env)
  (let ((old-val (lookup-variable-value exp env)))
    (set-variable-value! (assignment-variable exp)
                         (eval (assignment-value exp) env)
                         env)
    ;; changed
    old-val)
  )

;; almost same as lookup-variable-value
(define (lookup-binding name env)
  (if (null? env)
    (error " unbound variable :" name)
    (let ((binding (table-get (car env) name)))
      ;; modified
      (or 
        binding
        (lookup name (cdr env))))))
