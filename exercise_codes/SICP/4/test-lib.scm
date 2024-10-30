(define (run-program-list program-lst env)
  (for-each (lambda (exp) (eval exp env)) program-lst))