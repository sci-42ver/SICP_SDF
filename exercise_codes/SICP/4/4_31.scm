;; > Design and implement the changes required to produce such an extension to Scheme.
;; 0. Based on Lazy_Evaluation_lib.scm since we *may* have delayed variables, so choose the more conservative version.
;; 1. all procedure definitions by set!/define at last becomes lambda.
;; We can keep these lazy/lazy-memo marks until we get operands and manipulate with them accordingly.
;; 2. Only args are changed. So change where they are created/bound (i.e. apply) and used (i.e. eval).
;; Same as Lazy_Evaluation_lib, we only need to consider thunk usage. So just using Lazy_Evaluation_lib is enough.

(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "Lazy_Evaluation_lib.scm")
(load "test-lib.scm")

;; from wiki
(define (parameter-names p)
  (map (lambda (x) (if (pair? x) (car x) x)) p)) 

(define (apply procedure arguments env)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure
          procedure
          (list-of-arg-values arguments env)))
        ((compound-procedure? procedure)
         (eval-sequence
          (procedure-body procedure)
          ;; changed
          (let ((parameters (procedure-parameters procedure)))
            (extend-environment
              ;; wrong. See wiki woofy's
              ; parameters
              (parameter-names parameters)
              ;; similar to compound-procedure-args procedure
              ;; > when arguments are to be delayed, and to force or delay arguments accordingly, and you must arrange for forcing to memoize or not
              (map (lambda (var val) (interpret-var-for-val var val env)) parameters arguments)
              (procedure-environment procedure)))))
        (else
         (error
          "Unknown procedure type -- APPLY" procedure))))

(define (arg-tag? var tag)
  (eq? tag (cadr var)))

(define (force-it obj)
  (cond ((thunk? obj)
         (let ((result (actual-value
                        (thunk-exp obj)
                        (thunk-env obj))))
           (set-car! obj 'evaluated-thunk)
           (set-car! (cdr obj) result)  ; replace exp with its value
           (set-cdr! (cdr obj) '())     ; forget unneeded env
           result))
        ((evaluated-thunk? obj)
         (thunk-value obj))
        ;; added
        ((non-memo-thunk? obj)
          (actual-value (thunk-exp obj) (thunk-env obj)))
        (else obj)))

(define (non-memo-delay-it exp env)
  (list 'non-memo-thunk exp env))
(define (non-memo-thunk? obj)
  (tagged-list? obj 'non-memo-thunk))

(define (interpret-var-for-val var val env)
  (if (pair? var)
    (cond
      ((arg-tag? var 'lazy) (non-memo-delay-it val env))
      ((arg-tag? var 'lazy-memo) (delay-it val env))
      (else (error "unknown arg tag")))
    (actual-value val env)))

;; test similar to Felix021 but showing
;; 1. memo effects
;; 2. same as revc to test all possible cases for arg.

(run-program-list 
  '((define x 1)
    (define (p d (e lazy) (f lazy-memo)) (lambda () (cons e f)))
    ;; since delay won't happen for val of define, so not assign (begin ...) to one variable.
    (define lazy-ret 
      (p 
        (begin (display "run0 ") (set! x 0) (display x))
        (begin (display "run1 ") (set! x 1) x)
        (begin (display "run2 ") (set! x 2) x)
        ))
    (lazy-ret)
    (lazy-ret)
    )
  the-global-environment)
; ok
; okrun0 0
; okrun2 run1 
; (1 . 2)run1 
; (1 . 2)
; ;Unspecified return value
