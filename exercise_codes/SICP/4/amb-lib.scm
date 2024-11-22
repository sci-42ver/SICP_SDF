(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lib.scm")
(load "analyze-lib.scm")

(define (amb? exp) (tagged-list? exp 'amb))
(define (amb-choices exp) (cdr exp))

;; 4.22 to support let used in multiple-dwelling as the book footnote 56 says
(load "4_22.scm")
;; for and/or -> if
(load "4_4_analyze.scm")
(define (analyze exp)
  (cond ((self-evaluating? exp) 
         (analyze-self-evaluating exp))
        ((quoted? exp) (analyze-quoted exp))
        ((variable? exp) (analyze-variable exp))
        ((assignment? exp) (analyze-assignment exp))
        ((definition? exp) (analyze-definition exp))
        ((if? exp) (analyze-if exp))
        ((lambda? exp) (analyze-lambda exp))
        ((begin? exp) (analyze-sequence (begin-actions exp)))
        ((cond? exp) (analyze (cond->if exp)))
        ;; 9 conditions above
        ;; 4.22
        ((let? exp) (analyze-let exp))
        ((let*? exp) (analyze-let* exp))
        ;; 4.4
        ((and? exp) (analyze (and->if exp)))
        ((or? exp) (analyze (or->if exp)))
        ;; add one "special form"
        ((amb? exp) (analyze-amb exp))
        ((application? exp) (analyze-application exp))
        (else
         (error "Unknown expression type -- ANALYZE" exp))))

(define (ambeval exp env succeed fail)
  ((analyze exp) env succeed fail))

(define (analyze-self-evaluating exp)
  (lambda (env succeed fail)
    (succeed exp fail)))
(define (analyze-quoted exp)
  (let ((qval (text-of-quotation exp)))
    (lambda (env succeed fail)
      (succeed qval fail))))
(define (analyze-variable exp)
  (lambda (env succeed fail)
    (succeed (lookup-variable-value exp env)
             fail)))
(define (analyze-lambda exp)
  (let ((vars (lambda-parameters exp))
        (bproc (analyze-sequence (lambda-body exp))))
    (lambda (env succeed fail)
      (succeed (make-procedure vars bproc env)
               fail))))

(define (analyze-if exp)
  (let ((pproc (analyze (if-predicate exp)))
        (cproc (analyze (if-consequent exp)))
        (aproc (analyze (if-alternative exp))))
    (lambda (env succeed fail)
      (pproc env
             ;; success continuation for evaluating the predicate
             ;; to obtain pred-value
             (lambda (pred-value fail2)
               (if (true? pred-value)
                   (cproc env succeed fail2)
                   (aproc env succeed fail2)))
             ;; failure continuation for evaluating the predicate
             fail))))

(define (analyze-sequence exps)
  ;; only this part is changed since only this manipulates with the actual proc1~n.
  ;; same as analyze-lib.scm, "evaluated sequentially from left to right" https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Sequencing.html#index-begin
  (define (sequentially a b)
    (lambda (env succeed fail)
      (a env
         ;; success continuation for calling a
         (lambda (a-value fail2)
           (b env succeed fail2))
         ;; failure continuation for calling a
         fail)))
  (define (loop first-proc rest-procs)
    (if (null? rest-procs)
        first-proc
        (loop (sequentially first-proc (car rest-procs))
              (cdr rest-procs))))
  (let ((procs (map analyze exps)))
    (if (null? procs)
        (error "Empty sequence -- ANALYZE"))
    (loop (car procs) (cdr procs))))

(define (analyze-definition exp)
  (let ((var (definition-variable exp))
        (vproc (analyze (definition-value exp))))
    (lambda (env succeed fail)
      (vproc env                        
             (lambda (val fail2)
               (define-variable! var val env)
               (succeed 'ok fail2))
             fail))))

(define (analyze-assignment exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze (assignment-value exp))))
    (lambda (env succeed fail)
      (vproc env
             (lambda (val fail2)        ; *1*
               (let ((old-value
                      (lookup-variable-value var env))) 
                 (set-variable-value! var val env)
                 (succeed 'ok
                          (lambda ()    ; *2*
                            (set-variable-value! var
                                                 old-value
                                                 env)
                            (fail2)))))
             fail))))

(define (analyze-application exp)
  (let ((fproc (analyze (operator exp)))
        (aprocs (map analyze (operands exp))))
    (lambda (env succeed fail)
      (fproc env
             (lambda (proc fail2)
               (get-args aprocs
                         env
                         (lambda (args fail3)
                           (execute-application
                            ;; Here proc is (make-procedure vars bproc env).
                            proc args succeed fail3))
                         fail2))
             fail))))

;; 0. analyze-lib uses map which uses cons in the book not ensuring the order, also for the internal implementation https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Mapping-of-Lists.html#index-map
;; > The dynamic order in which procedure is applied to the elements of the lists is unspecified.
;; 0.a. Here `(car aprocs)` and `(lambda (arg fail2) ...)` implies the latter is delayed in lambda, so "evaluated sequentially from left to right".
;; 1. How get-args return args
;; when aprocs is (a), then assume succeed1 is passed at the 1st call of get-args.
;; (Here fail index analysis is skipped.)
;; Then (succeed2 '() fail) -> (succeed1 (cons arg '()) fail3) -> (execute-application proc (cons arg '()) succeed fail3)
;; Then use induction for the cases with more than 1 arg.
(define (get-args aprocs env succeed fail)
  (if (null? aprocs)
      (succeed '() fail)
      ((car aprocs) env
                    ;; success continuation for this aproc
                    (lambda (arg fail2)
                      (get-args (cdr aprocs)
                                env
                                ;; success continuation for recursive
                                ;; call to get-args
                                (lambda (args fail3)
                                  (succeed (cons arg args)
                                           fail3))
                                fail2))
                    fail)))

(define (execute-application proc args succeed fail)
  (cond ((primitive-procedure? proc)
         (succeed (apply-primitive-procedure proc args)
                  fail))
        ((compound-procedure? proc)
         ((procedure-body proc)
          (extend-environment (procedure-parameters proc)
                              args
                              (procedure-environment proc))
          succeed
          fail))
        (else
         (error
          "Unknown procedure type -- EXECUTE-APPLICATION"
          proc))))

(define (analyze-amb exp)
  (let ((cprocs (map analyze (amb-choices exp))))
    (lambda (env succeed fail)
      (define (try-next choices)
        (if (null? choices)
            (fail)
            ((car choices) env
                           succeed
                           (lambda ()
                             (try-next (cdr choices))))))
      (try-next cprocs))))

(define input-prompt ";;; Amb-Eval input:")
(define output-prompt ";;; Amb-Eval value:")
(define (driver-loop)
  (define (internal-loop try-again)
    (prompt-for-input input-prompt)
    (let ((input (read)))
      (if (eq? input 'try-again)
          (try-again)
          (begin
            (newline)
            (display ";;; Starting a new problem ")
            (ambeval input
                     the-global-environment
                     ;; ambeval success
                     (lambda (val next-alternative)
                       (announce-output output-prompt)
                       (user-print val)
                       (internal-loop next-alternative))
                     ;; ambeval failure
                     (lambda ()
                       (announce-output
                        ";;; There are no more values of")
                       (user-print input)
                       (driver-loop)))))))
  (internal-loop
   (lambda ()
     (newline)
     (display ";;; There is no current problem")
     (driver-loop))))

;; added
(define (driver-loop-take-input input-seq)
  (define (internal-loop try-again input-seq)
    (if (null? input-seq)
      (prompt-for-input input-prompt) ; to have the same behavior as the above.
      (begin
        (prompt-for-input input-prompt)
        (let ((input (car input-seq)))
          ;; to have the same behavior as the above.
          (display input)
          (if (eq? input 'try-again)
              (try-again)
              (begin
                (newline)
                (display ";;; Starting a new problem ")
                (ambeval input
                          the-global-environment
                          ;; ambeval success
                          (lambda (val next-alternative)
                            (announce-output output-prompt)
                            (user-print val)
                            ;;; IGNORE: Notice here `next-alternative` may have the failure here.
                            ;; So 4_38.scm will output one more ";;; There is no current problem" (see `(trace internal-loop)` results).
                            ;; That is due to when we call `next-alternative` which will normally try the next candidate,
                            ;; but if no candidate is left, then the upper fail is called, i.e. the following ";;; There are no more values of".
                            ;; But that is wrapped in lambda which uses the *old* input-seq.
                            ;; IMHO the normal calling seq will be internal-loop->internal-loop->internal-loop...->driver-loop-take-input to take the next problem input.
                            ;; So use cddr may be feasible.
                            (internal-loop next-alternative (cdr input-seq)))
                          ;; ambeval failure
                          (lambda ()
                            (announce-output
                            ";;; There are no more values of")
                            (user-print input)
                            (driver-loop-take-input (cddr input-seq))))))))
      )
    )
  ; (assert (pair? input-seq))
  (assert (list? input-seq))
  ; (trace internal-loop)
  (internal-loop
    (lambda ()
     (newline)
     (display ";;; There is no current problem")
     (driver-loop-take-input (cdr input-seq)))
    input-seq))

; (driver-loop)

(define (driver-loop-wrapper)
  ;; added
  (if (not (assq 'not primitive-procedures))
    (set! primitive-procedures (cons (list 'not not) primitive-procedures))
    )
  
  (set! the-global-environment (setup-environment))
  (ambeval '(define (require p) (if (not p) (begin (write-line "retry") (amb)) p)) ; mod
	   the-global-environment
     ;; mod
	   (lambda (a b) 'ignored)
	   (lambda () 'ignored)
     )
  (driver-loop))