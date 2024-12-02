(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

; (define (add-rule! rule)
;   (store-rule-in-index rule)
;   (let ((old-rules THE-RULES))
;     (set! THE-RULES (cons-stream rule old-rules))
;     'ok))

; (define (store-rule-in-index rule)
;   (let ((pattern (conclusion rule)))
;     (if (indexable? pattern)
;         (let ((key (index-key-of pattern)))
;           (let ((current-rule-stream
;                  (get-stream key 'rule-stream)))
;             (put key
;                  'rule-stream
;                  (cons-stream rule
;                               current-rule-stream)))))))

;; 0. Here we only check the 1st frame of the env which is just the behavior rename-variables-in wants.
;; 1. Since all internal variables are renamed, the only bindings we need from frame is those for conclusion.
;; Then when we finish, we return the binding related with query-pattern.

;; IMHO we must use some method to differentiate var in rule and query-pattern.
;; 
(define (apply-a-rule rule query-pattern frame)
  ; (let ((clean-rule (rename-variables-in rule)))
  (let ((unify-result
          (unify-match query-pattern
                       (conclusion rule)
                       frame)))
    (if (eq? unify-result 'failed)
      the-empty-stream
      (qeval (rule-body clean-rule)
             (singleton-stream unify-result))))
  ; )
  )

(define (unify-match p1 p2 frame)
  (cond ((eq? frame 'failed) 'failed)
        ;; must be before extend-if-possible so that something like (?y ?y) binding won't be added by extend.
        ;; > On the other hand, we do not want to reject attempts to bind a variable to itself.
        ((equal? p1 p2) frame)
        ;; this is prioritized before p2.
        ((var? p1) (extend-if-possible p1 p2 frame))
        ((var? p2) (extend-if-possible p2 p1 frame)) ; {\em ; ***}
        ((and (pair? p1) (pair? p2))
         (unify-match (cdr p1)
                      (cdr p2)
                      (unify-match (car p1)
                                   (car p2)
                                   frame)))
        (else 'failed)))


;;; test

(assert! (rule (demo ?x ?x) (base ?x (op ?x foo))))

;;; this is one problem more about data structure... so skip this exercise.
;; lockywolf
(define (apply-rules pattern assertions-env rules-env)
  (let ((r (an-element-of rules-env)))
    (apply-a-rule r pattern assertions-env rules-env)))

(define (apply-a-rule rule query-pattern assertions-env rules-env)
  ;      (newline) (display "entered apply-a-rule")
  (let ((doubleframe-result (two-sided-match query-pattern
                                             (conclusion rule))))
    ;         (newline) (display "doubleframe-result=") (display doubleframe-result)
    (if (or (eq? (doubleframe-downframe-get doubleframe-result) 'failed)
            (eq? (doubleframe-upframe-get doubleframe-result) 'failed))
      (amb)
      (let ((df-u (doubleframe-upframe-get doubleframe-result))
            (t-q-r (begin (newline) (display "- propagating down")
                          (try-qeval (qeval (instantiate
                                              (rule-body rule)
                                              (doubleframe-downframe-get doubleframe-result)
                                              identity-var)
                                            (prolog-extend-env (rule-subassertions rule) assertions-env)
                                            (prolog-extend-env (rule-subrules rule) rules-env)  )))))
        (let ((retval  (begin ;(newline) (display "- propagating up")
                         ;(newline) (display "upward frame=") (display df-u)
                         ;(newline) (display "rule returns frame=") (display t-q-r)

                         (unify-two-frames ; fail if conflict
                           df-u
                           t-q-r
                           (make-frame-prolog '() '())))))
          (if (eq? 'failed retval)
            (amb)
            retval))))))

(define (two-sided-match p1 p2)
  (make-doubleframe (pattern-match-weak p1 p2 (make-frame-prolog '() '()))
                    (pattern-match-weak p2 p1 (make-frame-prolog '() '()))
                    ))

;; Why do this.
(define (pattern-match-weak pat dat frame)
  (cond ((eq? frame 'failed) 'failed)
        ((equal? pat dat) frame)
        ((var? pat) (extend-if-consistent pat dat frame))
        ((and (pair? pat) (pair? dat))
         (pattern-match-weak
           (cdr pat)
           (cdr dat)
           (pattern-match-weak (car pat) (car dat) frame)))
        ((var? dat) frame) ; This is the difference
        (else 'failed)))
