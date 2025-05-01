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

;; https://wiki.c2.com/?SchemeCoroutineExample different from https://rosettacode.org/wiki/Concurrent_computing#Scheme
;; Relation with Python *old* coroutine https://peps.python.org/pep-0342/ (Notice not the async new version https://peps.python.org/pep-0492/)
;; See "Rationale and Goals" in 492
(define nil '())
(define FINISH-MARK 'finish-routine)
(define-syntax coroutine-wrapper
  (syntax-rules (yield)
    ((_ routine)
      (let ((yield #f))
        (coroutine routine))
      )
    )
  )
; (define demo
;   (let ((yield #f))
;     (lambda () 'test))
;   )
(define (has-yield-binding? proc)
  (environment-bound? (procedure-environment proc) 'yield)
  )
;; can't check for this
; (has-yield-binding? (lambda (yield) 'test))
;Value: #f

;; similar to environment-assign! https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Environment-Operations.html#index-environment_002dassign_0021
(define (set-proc-env! proc symbol object)
  (environment-assign!
    (procedure-environment proc)
    symbol object))
; (has-yield-binding? demo)

;; Failure to fix the bug in https://stackoverflow.com/a/79197544/21294350.
(define (coroutine routine-with-yield)
  (assert 
    (and
      ; ;; To be compatible with continuation return procedure.
      (and (procedure? routine-with-yield) (equal? '(1 . 1) (procedure-arity routine-with-yield)))
      ; (thunk? routine-with-yield)
      (has-yield-binding? routine-with-yield)))
  (let* (
        ;  (yield #f)
        ;  ;; make routine able to access yield.
        ;  (routine-with-yield routine)
         )
    (let ((current routine-with-yield)
        (status 'suspended)
        ; (global-returner #f)
        )
    ;; For MIT/GNU Scheme, we can use bundle. See https://stackoverflow.com/q/79570000/21294350
    (lambda args
      (cond ((or (null? args) (eq? (car args) 'next)) ; Similar to Python API for yield iterator. 
            (if (eq? status 'dead)
                ; (error 'dead-coroutine)
                'coroutine-iteration-finished
                (let ((continuation-and-value
                        (call/cc (lambda (return)
                                  (let ((returner
                                          (lambda (value)
                                            ; (if (or (not global-returner) (equal? global-returner returner))
                                              (call/cc (lambda (next)
                                                      ;; 0. called by the 1st (yield 1)
                                                      ;; yield is binded as returner
                                                      ;; Then value is 1
                                                      ;; so return (cons cc value)
                                                      ; (let* ((cc (lambda () (next 'return-value-is-ignored)))
                                                      ;        (env (procedure-environment cc)))
                                                      ;   (for-each
                                                      ;     (lambda (binding)
                                                      ;       (assert (= 2 (length binding)))
                                                      ;       (environment-define env (car binding) (cadr binding))
                                                      ;       )
                                                      ;     (environment-bindings (procedure-environment next))
                                                      ;     )
                                                      ;   (return (cons cc value))
                                                      ;   )
                                                      (return (cons next value))
                                                      ))
                                              ;; i.e. (and global-returner (not (equal? global-returner returner)))
                                              ; (global-returner value))
                                            )))
                                    ;; we also need to use the new returner to return rightly.
                                    ;; This returner can influence the former one due to it is inherent inside returner procedure.
                                    ; (set! global-returner returner)
                                    (write-line (list "returner" returner))
                                    ;; See https://stackoverflow.com/a/79197544/21294350 for why this fails.
                                    (set-proc-env! current 'yield returner)

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
                                    (current 'unused)
                                    (set! status 'dead)
                                    ;; added
                                    FINISH-MARK
                                    )))))
                  (write-line "continuation-and-value is got")
                  (if (pair? continuation-and-value)
                      (begin 
                        ;; so we can return to the former yield location.
                        (set! current (car continuation-and-value))
                        (let ((ret (cdr continuation-and-value)))
                          (write-line (list "to return" ret))
                          ret))
                      continuation-and-value))))
            ((eq? (car args) 'status?) status)
            ((eq? (car args) 'dead?) (eq? status 'dead))
            ((eq? (car args) 'alive?) (not (eq? status 'dead)))
            ((eq? (car args) 'kill!) (set! status 'dead))
            (true nil))))
    )
  )

;; TODO better to use tagged-list
(define (coroutine? coroutine)
  (and (procedure? coroutine)
    (equal? '(0 . #f) (procedure-arity coroutine))
    )
  )

(define test-coroutine-1
  ;; Same as Python behaviours https://docs.python.org/3/reference/simple_stmts.html#the-yield-statement.
  ;; > Yield expressions and statements are only used when defining a generator function, and are only used in the body of the generator function.
  (coroutine-wrapper (lambda (unused)
              (print "HELLO!")
              (yield 1)
              (print "WORLD!")
              (yield 2)
              (print "SORRY, I'M OUT"))))

;; added
(define print write-line)

; (test-coroutine-1 'status?)
; ; suspended
; (test-coroutine-1 'dead?)
; ; #f
; (test-coroutine-1 'alive?)
; ; #t
; (test-coroutine-1)
; ; "HELLO!"
; ; 1
; (test-coroutine-1)
; ; "WORLD!"
; ; 2
; (test-coroutine-1)
; ; "SORRY, I'M OUT"
; ;Value: finish-routine
; (test-coroutine-1 'status?)
; ; dead
; (test-coroutine-1 'dead?)
; ; #t

; (test-coroutine-1)
;; error
; dead-coroutine

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; test2
(define (make-iterator list)
     (coroutine-wrapper (lambda (unused)
                  (for-each yield list))))
(define (iterator-empty? iterator)
    (iterator 'dead?))
(define my-iterator (make-iterator (list 1 2 3)))
(write-line "begin my-iterator")
(cd "~/SICP_SDF/SDF_exercises/common-lib/")
(load "test_lib.scm")
(define (test-iterator val expected)
  (assert* (= val 1) (list val expected))
  )
(test-iterator (my-iterator) 1)
;; regex (^[^(].*) -> ; $1
; 1
; (assert (= (my-iterator) 2))
(my-iterator)
; 2
(assert (= (my-iterator) 3))
; 3
(assert (not (iterator-empty? my-iterator)))
; #f
(assert (= (my-iterator) FINISH-MARK))
(assert (iterator-empty? my-iterator))
; #t