(let ((path '())
      (c #f))
  (let ((add (lambda (s)
               (set! path (cons s path)))))
    (dynamic-wind
      (lambda () (add 'connect))
      (lambda ()
        (add (call-with-current-continuation
               (lambda (c0)
                 (set! c c0)
                 'talk1))))
      (lambda () (add 'disconnect)))
    (if (< (length path) 4)
        (c 'talk2)
        (reverse path))))
;; > Calling the escape procedure will cause the invocation of before and after thunks installed using dynamic-wind.
;; so connect before talk2.

;; 0. https://matt.might.net/articles/programming-with-continuations--exceptions-backtracking-search-threads-generators-coroutines/
;; > In Scheme, an implementation of try will also use dynamic-wind to maintain a stack of exception handlers.
;; This is trivially implied by before, after.
;; 1. before, after is very similar to hook in gdb.