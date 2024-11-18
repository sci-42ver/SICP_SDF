;; https://en.wikipedia.org/wiki/Coroutine#Scheme
;; > requiring only that a queue of continuations be maintained.
;; Here we just reuse cc by set! since we don't need former used cc's.
;; https://en.wikipedia.org/wiki/Coroutine#Definition_and_types
;; a. characteristics
;; a.1. trivial by local states in Scheme
;; a.2. by cc
;; b. 3 features
;; b.1. Here this is Asymmetric coroutine since it can't "specify a yield destination."
;; See https://www.crystalclearsoftware.com/soc/coroutine/coroutine/symmetric_coroutines.html#symmetric_coroutines.symmetric_and_asymmetric_coroutine_transformation from https://stackoverflow.com/a/42042904/21294350
;; > The asymmetry is due to the fact that the caller/callee relation between a coroutine's context and caller's context is *fixed*.
;; > Control flow with symmetric coroutines instead is not stack-like. A coroutine can always yield *freely to any other coroutine*
;; Also see "Symmetric and asymmetric coroutine transformation" which is understandable without much Cpp background.
;; IMHO "scheduler example" doesn't implement "returning to the dispatcher the *address* of the target coroutine".
;; b.2. first-class objects trivially due to Scheme
;; b.3. Scheme 
;; b.3.1. Actually Python can always use yield to create one coroutine. 
;; See https://lerner.co.il/2020/05/08/making-sense-of-generators-coroutines-and-yield-from-in-python/
;; As it says, https://docs.python.org/3/library/asyncio-task.html is just one normal function with internal wait, but no *manual* suspension and resumption.
;; > But that’s not the sort of coroutine I’m talking about here.
;; b.3.1.1 yield from
;; > And so, the real reason to use “yield from” is when you have a coroutine that acts as an agent between its caller and other coroutines.
;; 
;; https://wiki.c2.com/?SchemeCoroutineExample
(define (coroutine routine)
  (let ((current routine)
        (status 'suspended))
    (lambda args
      (cond ((null? args) 
            (if (eq? status 'dead)
                (error 'dead-coroutine)
                (let ((continuation-and-value
                        (call/cc (lambda (return)
                                  (let ((returner
                                          (lambda (value)
                                            (call/cc (lambda (next)
                                                      ;; 0. called by the 1st (yield 1)
                                                      ;; yield is binded as returner
                                                      ;; Then value is 1
                                                      ;; so return (cons cc value)
                                                      (return (cons next value)))))))
                                    ;; 1. the 2nd (test-coroutine-1)
                                    ;; i.e. apply (lambda (value) _) in (let ((returner (lambda (value) _))) ...) to returner
                                    ;; Notice this is not the whole let expression since we have finished part of them at least for defining the 1st returner.
                                    ;; So what we does is set (yield 1) to the 2nd returner.
                                    ;; Then we run ... (yield 2). Notice still use the 1st returner (actually same as the 2nd returner since they are lambda).
                                    ;; Then do the thing similar to point 0 but with value 2 this time.
                                    ;; 2. The 3rd will similarly return the 3nd returner for (yield 2).
                                    ;; Then finish the 1st (current returner) when finishing (lambda (yield) ...)
                                    ;; Then (set! status 'dead) which will return the old status in MIT/GNU Scheme although the MIT_Scheme_Reference doc says "unspecified".
                                    ;; So "return the old status" if without the following addition.
                                    (current returner)
                                    (set! status 'dead)
                                    ;; added
                                    'finish-routine
                                    )))))
                  (if (pair? continuation-and-value)
                      (begin 
                        ;; so we can return to the former yield location.
                        (set! current (car continuation-and-value))
                        (cdr continuation-and-value))
                      continuation-and-value))))
            ((eq? (car args) 'status?) status)
            ((eq? (car args) 'dead?) (eq? status 'dead))
            ((eq? (car args) 'alive?) (not (eq? status 'dead)))
            ((eq? (car args) 'kill!) (set! status 'dead))
            (true nil)))))

(define test-coroutine-1
     (coroutine (lambda (yield)
                  (print "HELLO!")
                  (yield 1)
                  (print "WORLD!")
                  (yield 2)
                  (print "SORRY, I'M OUT"))))

;; added
(define print write-line)

(test-coroutine-1 'status?)
; suspended
(test-coroutine-1 'dead?)
; #f
(test-coroutine-1 'alive?)
; #t
(test-coroutine-1)
; "HELLO!"
; 1
(test-coroutine-1)
; "WORLD!"
; 2
(test-coroutine-1)
; "SORRY, I'M OUT"
(test-coroutine-1 'status?)
; dead
(test-coroutine-1 'dead?)
; #t
(test-coroutine-1)
; . error: dead-coroutine

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; test2
(define (make-iterator list)
     (coroutine (lambda (yield)
                  (for-each yield list))))
(define (iterator-empty? iterator)
    (iterator 'dead?))
(define my-iterator (make-iterator (list 1 2 3)))
(my-iterator)
;; regex (^[^(].*) -> ; $1
; 1
(my-iterator)
; 2
(my-iterator)
; 3
(iterator-empty? my-iterator)
; #f
(my-iterator)
(iterator-empty? my-iterator)
; #t