;; added
(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-ambeval.scm")

;; from index.org
(define primitive-procedures
      (list (list 'car car)
	    (list 'cdr cdr)
	    (list 'cons cons)
	    (list 'cadr cadr)
	    (list 'null? null?)
	    (list 'exit exit)
	    (list 'display display)
	    (list 'newline newline)
	    (list 'assoc assoc)
	    (list '= =)
	    (list '< <)
	    (list '> >)
	    (list '+ +)
	    (list '- -)
	    (list 'not not)
	    (list '* *)
	    (list 'current-second current-second)
	    (list 'list list)
	    (list 'underlying-cons cons)
	    (list 'underlying-car car)
	    (list 'underlying-cdr cdr)
	    (list 'eq? eq?)
	    (list 'equal? equal?)
	    (list 'pair? pair?)
	    (list 'error error)
	    (list 'random-integer random-integer)
	    (list 'even? even?)
	    (list 'remainder remainder)
	    (list 'square square)
	    (list '/ /)
	    (list 'member member)
	    (list 'abs abs)
	    (list 'cdar cdar)
	    (list 'cdadr cdadr)
	    (list 'caar caar)
	    (list 'caadr caadr)
	    (list 'cddr cddr)
	    (list 'cdddr cdddr)
	    (list 'caddr caddr)
	    (list 'cadddr cadddr)
	    (list 'set-car! set-car!)
	    (list 'set-cdr! set-cdr!)
	    (list 'memq memq)
	    (list 'read read)
	    ; (list 'show show)
	    ; (list 'pretty pretty)
	    (list 'number? number?)
	    (list 'string? string?)
	    (list 'symbol? symbol?)
      ;; added
	    (list 'symbol->string symbol->string)
	    (list 'string=? string=?)
	    (list 'substring substring)
      (list 'string->symbol string->symbol)
      (list 'string-length string-length)
      (list 'assq assq)
      (list 'append append)
	    ))
(define the-global-environment (setup-environment))
(driver-loop)

;; added
(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))
(define unary-map
  (lambda (proc items)
    (if (null? items)
      '()
      (cons (proc (car items))
            (unary-map proc (cdr items))))))
(define map unary-map)
(define (accumulate op initial sequence) (if (null? sequence) initial (op (car sequence) (accumulate op initial (cdr sequence)))))

; (assoc 1 (list 1 2))

(define (require p) (if (not p) (amb)))
(define (an-element-of items)
  (require (not (null? items)))
  (amb (car items) (an-element-of (cdr items))))
(define (an-integer-starting-from n)
  (amb n (an-integer-starting-from (+ n 1))))
(define (distinct? items)
  (cond ((null? items) true)
        ((null? (cdr items)) true)
        ((member (car items) (cdr items)) false)
        (else (distinct? (cdr items)))))
(define THE-ASSERTIONS '())
(define THE-RULES '())

(define (add-rule-or-assertion! assertion)
  (if (rule? assertion)
    (add-rule! assertion)
    (add-assertion! assertion)))

(define (add-assertion! assertion)
  (set! THE-ASSERTIONS  (cons assertion THE-ASSERTIONS))
  'ok)
(define (add-rule! rule)
  (set! THE-RULES (cons rule THE-RULES))
  'ok)
(define (rule? statement)
  (tagged-list? statement 'rule))
(define (conclusion rule) (cadr rule))
(define (rule-body rule)
  (if (null? (cddr rule)) '(always-true) (caddr rule)))

(define (identity-var v f)
  v)

(define (lq i)
  (let ((q (query-syntax-process i)))
    (cond  ((assertion-to-be-added? q)
            (add-rule-or-assertion! (add-assertion-body q))
            'added)
           (else
             (instantiate
               q
               (try-qeval (qeval q THE-ASSERTIONS THE-RULES))
               (lambda (v f)
                 (contract-question-mark v)))))))
(define (query-syntax-process exp)
  (map-over-symbols expand-question-mark exp))
(define (map-over-symbols proc exp)
  (cond ((pair? exp)
         (cons (map-over-symbols proc (car exp))
               (map-over-symbols proc (cdr exp))))
        ((symbol? exp) (proc exp))
        (else exp)))

(define (type exp)
  (if (pair? exp)
    (car exp)
    (error "Unknown expression TYPE" exp)))
(define (contents exp)
  (if (pair? exp)
    (cdr exp)
    (error "Unknown expression CONTENTS" exp)))
(define (assertion-to-be-added? exp)
  (eq? (type exp) 'assert!))
(define (add-assertion-body exp) (car (contents exp)))
(define (empty-conjunction? exps) (null? exps))
(define (first-conjunct exps) (car exps))
(define (rest-conjuncts exps) (cdr exps))
(define (empty-disjunction? exps) (null? exps))
(define (first-disjunct exps) (car exps))
(define (rest-disjuncts exps) (cdr exps))
(define (negated-query exps) (car exps))
(define (predicate exps) (car exps))
(define (args exps) (cdr exps))
(define (rule? statement)
  (tagged-list? statement 'rule))
(define (conclusion rule) (cadr rule))
(define (rule-body rule)
  (if (null? (cddr rule)) '(always-true) (caddr rule)))

(define (rule-inner-rules-and-assertions rule2)
  (if (equal? '(always-true) (rule-body rule2))
    (list '() '())
    (cdddr rule2)))

(define (rule-subfeatures-assertions subfeatures)
  (assq 'assertions subfeatures))

(define (rule-subfeatures-rules subfeatures)
  (assq 'rules subfeatures))

(define (rule-subrules r)
  (cdr (rule-subfeatures-rules (rule-inner-rules-and-assertions r))))

(define (rule-subassertions r)
  (cdr (rule-subfeatures-assertions (rule-inner-rules-and-assertions r))))

(define (query-syntax-process exp)
  (map-over-symbols expand-question-mark exp))
(define (map-over-symbols proc exp)
  (cond ((pair? exp)
         (cons (map-over-symbols proc (car exp))
               (map-over-symbols proc (cdr exp))))
        ((symbol? exp) (proc exp))
        (else exp)))
(define (expand-question-mark symbol)
  (let ((chars (symbol->string symbol)))
    (if (string=? (substring chars 0 1) "?")
      (list '?
            (string->symbol
              (substring chars 1 (string-length chars))))
      symbol)))
(define (var? exp) (tagged-list? exp '?))
(define (constant-symbol? exp) (symbol? exp))
(define rule-counter 0)
(define (new-rule-application-id)
  (set! rule-counter (+ 1 rule-counter))
  rule-counter)
(define (make-new-variable var rule-application-id)
  (cons '? (cons rule-application-id (cdr var))))
(define (contract-question-mark variable)
  (string->symbol
    (string-append "?"
                   (if (number? (cadr variable))
                     (string-append (symbol->string (caddr variable))
                                    "-"
                                    (number->string (cadr variable)))
                     (symbol->string (cadr variable))))))
(define (frame-promises frame)
  (if (null? frame)
    '()
    (cadr frame)))
(define (frame-bindings frame)
  (if (null? frame)
    '()
    (car frame)))
(define (make-binding variable value)
  (cons variable value))
(define (binding-variable binding) (car binding))
(define (binding-value binding) (cdr binding))
(define (binding-in-frame variable frame)
  (assoc variable (frame-bindings frame)))
(define (extend variable value frame)
  (make-frame-prolog (cons (make-binding variable value) (frame-bindings frame))
                     (frame-promises frame)))
(define (frame-add-promise frame promise)
  (make-frame-prolog (frame-bindings frame) (cons promise (frame-promises frame))))
(define (make-frame-prolog bindings promises)
  (list bindings promises))
(define (instantiate exp frame unbound-var-handler)
  (define (copy exp)
    (cond ((var? exp)
           (let ((binding (binding-in-frame exp frame)))
             (if binding
               (copy (binding-value binding))
               (unbound-var-handler exp frame))))
          ((pair? exp)
           (cons (copy (car exp)) (copy (cdr exp))))
          (else exp)))
  (copy exp))

(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
          (let ((record (assoc key-2 (cdr subtable))))
            (if record
              (cdr record)
              false))
          false)))
    (define (insert! key-1 key-2 value)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
          (let ((record (assoc key-2 (cdr subtable))))
            (if record
              (set-cdr! record value)
              (set-cdr! subtable
                        (cons (cons key-2 value)
                              (cdr subtable)))))
          (set-cdr! local-table
                    (cons (list key-1
                                (cons key-2 value))
                          (cdr local-table)))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))
(define coercion-table (make-table))
(define get-coercion (coercion-table 'lookup-proc))
(define put-coercion (coercion-table 'insert-proc!))

(define (try-qeval result)
  (if (eq? result 'no-more-answers)
    (amb)
    result))
(define (qeval query assertions-env rules-env)
  ;(newline) (display "debug:") (display query) (newline)
  ;(newline) (display "debug:contents:") (display (contents query)) (newline)
  (amb (processor
         (let ((qproc (get (type query) 'qeval)))
           (if qproc
             (qproc (contents query) assertions-env rules-env)
             (simple-query query assertions-env rules-env))))
       'no-more-answers))
(define (processor frame)
  (define (loop bindings promises retval)
    (cond ((null? promises) retval)
          ((eq? ((car promises) retval) 'kill-it)
           (amb))
          ((eq? ((car promises) retval) 'let-it-stay)
           (loop bindings
                 (cdr promises)
                 retval)) ;; this promise can't kill this frame
          ((eq? ((car promises) retval) 'has-not-bound)
           (loop bindings
                 (cdr promises)
                 (frame-add-promise retval (car promises)))) ;; we don't have enough variables so far
          (else (error "process-promises -- unknown promise protocol"))))
  (loop (frame-bindings frame)
        (frame-promises frame)
        (make-frame-prolog (frame-bindings frame) '())))
(define (simple-query query-pattern assertions-env rules-env)
  (amb
    (find-assertions query-pattern assertions-env)
    (apply-rules query-pattern assertions-env rules-env)))

(define (find-assertions query-pattern assertions-env) ; -> frame
  (let ((a (an-element-of assertions-env)))
    (check-an-assertion a query-pattern (make-frame-prolog '() '()) )))

(define (check-an-assertion assertion query-pat query-frame)
  (let ((match-result
          (pattern-match query-pat assertion query-frame)))
    (if (eq? match-result 'failed)
      (amb)
      match-result)))

(define (apply-rules pattern assertions-env rules-env)
  (let ((r (an-element-of rules-env)))
    (apply-a-rule r pattern assertions-env rules-env)))

(define (prolog-extend-env lst env)
  (append lst env))

(define (extend-if-unifies var pat1 pat2 frame)
  ;        (newline) (display "entering extend-if-unifies")
  ;        (newline) (display "var=") (display var)
  ;        (newline) (display "pat1=") (display pat1)
  ;        (newline) (display "pat2=") (display pat2)
  (let ((match-frame (unify-match pat1 pat2 frame)))
    (if (eq? 'failed match-frame)
      'failed
      (extend var (instantiate pat1 match-frame identity-var) frame))))
; <<accumulate>>
; <<map-append-length>>
(define (union-set set1 set2)
  (if (null? set2)
    set1
    (if (member (car set2) set1)
      (union-set set1 (cdr set2))
      (union-set (cons (car set2) set1) (cdr set2)))))
(define (unify-two-frames f1 f2 iframe)
  ; We have at most two bindings for each variable. The final binding is a unification of those.
  (cond ((eq? 'failed f1) 'failed)
        ((eq? 'failed f2) 'failed)
        (else   (let ((f1-vars (map car (frame-bindings f1)))
                      (f2-vars (map car (frame-bindings f2))))
                  (let ((ret-vars (union-set f1-vars f2-vars)))
                    ;(newline) (display "unify-two-frames-variable-list:") (display ret-vars)
                    (accumulate  (lambda (var iframe)
                                   (if (eq? 'failed iframe)
                                     'failed
                                     (let ((binding-f1 (binding-in-frame var f1))
                                           (binding-f2 (binding-in-frame var f2)))
                                       (cond ((and binding-f1 (not binding-f2))
                                              (extend-if-possible var (binding-value binding-f1) iframe))
                                             ((and binding-f2 (not binding-f1))
                                              (begin ;(display "running extend-if--f2")
                                                (extend-if-possible var (binding-value binding-f2) iframe)))
                                             ((and binding-f1 binding-f2)
                                              (begin ;(newline) (display "running extend-if-unifies")  (newline)
                                                (extend-if-unifies  var
                                                                    (binding-value binding-f1)
                                                                    (binding-value binding-f2)
                                                                    iframe)))
                                             (else (error "Impossible case"))))))
                                 (make-frame-prolog '() '())
                                 ret-vars)
                    )))))

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

(define (unify-match p1 p2 frame)
  ;      (newline)
  ;      (display "p1=") (display p1)
  ;      (display "p2=") (display p2)
  ;      (display "frame=") (display frame)
  ;      (newline)
  (cond ((eq? frame 'failed) 'failed)
        ((equal? p1 p2) frame)
        ((var? p1) (extend-if-possible p1 p2 frame))
        ((var? p2) (extend-if-possible p2 p1 frame))
        ; ***
        ((and (pair? p1) (pair? p2))
         (unify-match (cdr p1)
                      (cdr p2)
                      (unify-match (car p1)
                                   (car p2)
                                   frame)))
        (else 'failed)))



(define (extend-if-possible var val frame)
  ;    (newline) (display "entering extend-if-possible")
  ;    (newline) (display "var=") (display var)
  ;    (newline) (display "val=") (display val)
  ;    (newline) (display "frame=") (display frame)
  ;    (newline)
  (let ((binding (binding-in-frame var frame)))
    (cond (binding
            (unify-match (binding-value binding) val frame))
          ; ***
          ((var? val)
           (let ((binding (binding-in-frame val frame)))
             (if binding
               (unify-match
                 var (binding-value binding) frame)
               (extend var val frame))))
          ((depends-on? val var frame)
           ; ***
           'failed)
          (else (extend var val frame)))))

(define (depends-on? exp var frame)
  (define (tree-walk e)
    (cond ((var? e)
           (if (equal? var e)
             true
             (let ((b (binding-in-frame e frame)))
               (if b
                 (tree-walk (binding-value b))
                 false))))
          ((pair? e)
           (or (tree-walk (car e))
               (tree-walk (cdr e))))
          (else false)))
  (tree-walk exp))


(define (and a b)
  (if a
    (if b true false)
    false))

(define (or a b)
  (if a
    true
    (if b true false)))

(define (not e)
  (if e false true))

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

(define (two-sided-match p1 p2)
  (make-doubleframe (pattern-match-weak p1 p2 (make-frame-prolog '() '()))
                    (pattern-match-weak p2 p1 (make-frame-prolog '() '()))
                    ))
(define (make-doubleframe upward-frame downward-frame)
  (list upward-frame downward-frame))
(define (doubleframe-upframe-get doubleframe)
  (car doubleframe))
(define (doubleframe-downframe-get doubleframe)
  (cadr doubleframe))

(define (pattern-match pat dat frame)
  (cond ((eq? frame 'failed) 'failed)
        ((equal? pat dat) frame)
        ((var? pat) (extend-if-consistent pat dat frame))
        ((and (pair? pat) (pair? dat))
         (pattern-match
           (cdr pat)
           (cdr dat)
           (pattern-match (car pat) (car dat) frame)))
        (else 'failed)))
(define (extend-if-consistent var dat frame)
  (let ((binding (binding-in-frame var frame)))
    (if binding
      (pattern-match (binding-value binding) dat frame)
      (extend var dat frame))))
(define (always-true pat assertions rules) (make-frame-prolog '() '()))
(put 'always-true 'qeval always-true)
(define (conjoin conjuncts assertions rules)
  ;      (newline) (display "entered conjoin")
  (if (empty-conjunction? conjuncts)
    (make-frame-prolog '() '())
    (let ((rest-frame (conjoin (rest-conjuncts conjuncts) assertions rules))
          (this-frame (try-qeval (qeval (first-conjunct conjuncts) assertions rules))))
      ;          (newline) (display "conjoin unifying: rest-frame: ") (display rest-frame)
      ;          (newline) (display "conjoin unifying: this-frame: ") (display this-frame)
      (let ((retval	  (unify-two-frames
                        rest-frame
                        this-frame
                        (make-frame-prolog '() '()))))
        ;            (newline) (display "conjoining two clauses result:") (display retval)
        retval))))
(put 'and 'qeval conjoin)
;; This place has a subtle bug in case the stream happens to be infinite.
(define (disjoin disjuncts assertions rules)
  (if (empty-disjunction? disjuncts)
    (amb)
    (amb
      (try-qeval (qeval (first-disjunct disjuncts) assertions rules))
      (disjoin (rest-disjuncts disjuncts) assertions rules))))
(put 'or 'qeval disjoin)

(define (negate operands assertions rules)
  (let ((promise (lambda (frame)
                   (if (has-not-bound?  (negated-query operands) frame)
                     'has-not-bound
                     (if (eq? 'no-more-values (qeval (negated-query operands) assertions rules))
                       'let-it-stay ; let it stay
                       'kill-it)))))
    (frame-add-promise frame1 promise)))


(define (has-not-bound? query frame)
  (cond ((null? query) false)
        ((var? query) (if (binding-in-frame query frame)
                        (has-not-bound?
                          (binding-value (binding-in-frame query frame))
                          frame)
                        true))
        ((pair? query) (or (has-not-bound? (car query) frame)
                           (has-not-bound? (cdr query) frame)))
        (else false)))
(put 'not 'qeval negate)
(define (lisp-value call ignore ignore)
  (let ((promise (lambda (frame) (if (has-not-bound? call frame)
                                   'has-not-bound
                                   (if (execute
                                         (instantiate
                                           call
                                           frame
                                           (lambda (v f)
                                             (error "Unknown pat var: LISP-VALUE" v))))
                                     'let-it-stay
                                     'kill-it)))))
    (frame-add-promise frame1 promise)
    ))
(define (execute exp)
  (let ((pred (eval
                (predicate exp)
                (interaction-environment))))
    (apply-in-underlying-scheme pred  (args exp))))

(put 'lisp-value 'qeval lisp-value)

(unify-match
  (query-syntax-process '(can-do-job (computer programmer) (computer ?x trainee)))
  (query-syntax-process '(can-do-job (computer ?x) (computer programmer trainee)))
  (make-frame-prolog '() '()))

(two-sided-match
  (query-syntax-process '(can-do-job (computer programmer) (computer ?x trainee)))
  (query-syntax-process '(can-do-job (computer programmer) (computer programmer ?x))))

(two-sided-match
  (query-syntax-process '(can-do-job (computer programmer) (computer ?x trainee)))
  (query-syntax-process '(can-do-job (computer programmer) (computer programmer ?x assistant))))

(two-sided-match
  (query-syntax-process '(can-do-job (computer programmer) (computer ?x trainee)))
  (query-syntax-process '(can-do-job (computer programmer) (computer ?y trainee))))

(rule-subfeatures-assertions
  (rule-inner-rules-and-assertions
    '(rule (lives-near ?person-1 ?person-2)
           (and (address ?person-1 (?town . ?rest-1))
                (address ?person-2 (?town . ?rest-2)))
           (assertions ((homefull world) (peopleful world)))
           (rules ((same ?x ?x))) )))

(rule-subfeatures-rules
  (rule-inner-rules-and-assertions
    '(rule (lives-near ?person-1 ?person-2)
           (and (address ?person-1 (?town . ?rest-1))
                (address ?person-2 (?town . ?rest-2)))
           (assertions ((homefull world) (peopleful world)))
           (rules ((same ?x ?x))) )))
(lq '(assert! (rule (lives-near ?person-1 ?person-2)
                    (and (address ?person-1 (?town . ?rest-1))
                         (address ?person-2 (?town . ?rest-2)))
                    (assertions ((homefull world) (peopleful world)))
                    (rules ((same ?x ?x))) )))
(lq '(assert! (address (Hacker Alyssa P) (Cambridge (Mass Ave) 78))))
(lq '(assert! (address (Schemer The Little) (Cambridge (Mass Ave) 78))))
(lq '(lives-near ?x ?y))
try-again
(exit)
try-again
try-again
try-again
(exit)
(lq '(assert! (address (Tweakit Lem E) (Boston (Bay State Road) 22))))
(lq '(assert! (job (Tweakit Lem E) (computer technician))))
(lq '(assert! (salary (Tweakit Lem E) 25000)))
(lq '(assert! (supervisor (Tweakit Lem E) (Bitdiddle Ben))))
(lq '(assert! (address (Reasoner Louis) (Slumerville (Pine Tree Road) 80))))
(lq '(assert! (job (Reasoner Louis) (computer programmer trainee))))
(lq '(assert! (salary (Reasoner Louis) 30000)))
(lq '(assert! (supervisor (Reasoner Louis) (Hacker Alyssa P))))
(lq '(assert! (supervisor (Bitdiddle Ben) (Warbucks Oliver))))
(lq '(assert! (address (Warbucks Oliver) (Swellesley (Top Heap Road)))))
(lq '(assert! (job (Warbucks Oliver) (administration big wheel))))
(lq '(assert! (salary (Warbucks Oliver) 150000)))
(lq '(assert! (address (Scrooge Eben) (Weston (Shady Lane) 10))))
(lq '(assert! (job (Scrooge Eben) (accounting chief accountant))))
(lq '(assert! (salary (Scrooge Eben) 75000)))
(lq '(assert! (supervisor (Scrooge Eben) (Warbucks Oliver))))
(lq '(assert! (address (Cratchet Robert) (Allston (N Harvard Street) 16))))
(lq '(assert! (job (Cratchet Robert) (accounting scrivener))))
(lq '(assert! (salary (Cratchet Robert) 18000)))
(lq '(assert! (supervisor (Cratchet Robert) (Scrooge Eben))))
(lq '(assert! (address (Aull DeWitt) (Slumerville (Onion Square) 5))))
(lq '(assert! (job (Aull DeWitt) (administration secretary))))
(lq '(assert! (salary (Aull DeWitt) 25000)))
(lq '(assert! (supervisor (Aull DeWitt) (Warbucks Oliver))))
(lq '(assert! (can-do-job (computer wizard) (computer programmer))))
(lq '(assert! (can-do-job (computer wizard) (computer technician))))
(lq '(assert! (can-do-job (computer programmer) (computer programmer trainee))))
(lq '(assert! (can-do-job (administration secretary) (administration big wheel))))
(lq '(assert! (rule (lives-near ?person-1 ?person-2)
                    (and (address ?person-1 (?town . ?rest-1))
                         (address ?person-2 (?town . ?rest-2))
                         (not (same ?person-1 ?person-2))))))

(lq '(assert! (rule (wheel ?person)
                    (and (supervisor ?middle-manager ?person)
                         (supervisor ?x ?middle-manager)))))
(lq '(assert! (rule (outranked-by ?staff-person ?boss)
                    (or (supervisor ?staff-person ?boss)
                        (and (supervisor ?staff-person ?middle-manager)
                             (outranked-by ?middle-manager ?boss))))))
(lq '(assert! (rule (append-to-form () ?y ?y))))
(lq '(assert! (rule (append-to-form (?u . ?v) ?y (?u . ?z))
                    (append-to-form ?v ?y ?z))))

(lq '(job ?x (computer programmer)))
try-again
(lq '(same a ?x))
(lq '(and (job ?x (computer programmer)) (salary ?x 40000)))
(lq '(or (job ?x (computer programmer)) (salary ?x 18000)))
(lq '(and (job ?x (computer programmer)) (not (salary ?x 40000))))
(lq '(and (job ?x (computer programmer))
          (salary ?x ?y)
          ))
(lq '(and (salary ?x ?y) (lisp-value < ?y 50000)))
try-again
try-again
try-again
(exit)
EOF
#+end_src


#+header: :stdin prolog-environments
#+begin_src shell :shebang "#! /usr/bin/chibi-scheme" :results output scalar code :exports both
<<s-glue1>>
<<s-amb-amb-implementation>>
<<s-amb-analyze-eval-with-let-amb-ramb-pset-iffail>>
<<s-amb-analyze-permanent-assignment>>
<<s-let-implementation>>
<<s-amb-simple-expressions>>
<<s-amb-analyze-if>>
<<s-amb-analyze-sequence>>
<<s-amb-analyze-definition>>
<<s-amb-analyze-assignment>>
<<s-amb-analyze-application>>
<<s-amb-get-args>>
<<s-amb-execute-application>>
<<s-amb-analyze-amb>>
<<s-amb-ramb>>
<<s-amb-analyze-if-fail>>
<<s-syntax>>
<<s-application>>
<<s-cond-with-arrow>>
<<s-truefalse>>
<<s-compound-procedures>>
<<s-environments-list-of-bindings-better-abstractions>>
<<s-primitive-procedures>>
<<primitive-procedures-prolog-in-amb>>
<<s-amb-driver-loop>>
<<s-user-prompt-print>>
<<s-glue2>>
(driver-loop)

#+end_src

#+RESULTS[22468ff82ee995b57b32f14431a84d918a86cb20]:
#+begin_src shell

;;; Amb-Eval input:
(define (require p) (if (not p) (amb)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (an-element-of items) (require (not (null? items))) (amb (car items) (an-element-of (cdr items))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (an-integer-starting-from n) (amb n (an-integer-starting-from (+ n 1))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (distinct? items) (cond ((null? items) true) ((null? (cdr items)) true) ((member (car items) (cdr items)) false) (else (distinct? (cdr items)))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define THE-ASSERTIONS (quote ()))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define THE-RULES (quote ()))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (add-rule-or-assertion! assertion) (if (rule? assertion) (add-rule! assertion) (add-assertion! assertion)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (add-assertion! assertion) (set! THE-ASSERTIONS (cons assertion THE-ASSERTIONS)) (quote ok))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (add-rule! rule) (set! THE-RULES (cons rule THE-RULES)) (quote ok))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (rule? statement) (tagged-list? statement (quote rule)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (conclusion rule) (cadr rule))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (rule-body rule) (if (null? (cddr rule)) (quote (always-true)) (caddr rule)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (identity-var v f) v)
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (lq i) (let ((q (query-syntax-process i))) (cond ((assertion-to-be-added? q) (add-rule-or-assertion! (add-assertion-body q)) (quote added)) (else (instantiate q (try-qeval (qeval q THE-ASSERTIONS THE-RULES)) (lambda (v f) (contract-question-mark v)))))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (query-syntax-process exp) (map-over-symbols expand-question-mark exp))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (map-over-symbols proc exp) (cond ((pair? exp) (cons (map-over-symbols proc (car exp)) (map-over-symbols proc (cdr exp)))) ((symbol? exp) (proc exp)) (else exp)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (type exp) (if (pair? exp) (car exp) (error "Unknown expression TYPE" exp)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (contents exp) (if (pair? exp) (cdr exp) (error "Unknown expression CONTENTS" exp)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (assertion-to-be-added? exp) (eq? (type exp) (quote assert!)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (add-assertion-body exp) (car (contents exp)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (empty-conjunction? exps) (null? exps))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (first-conjunct exps) (car exps))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (rest-conjuncts exps) (cdr exps))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (empty-disjunction? exps) (null? exps))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (first-disjunct exps) (car exps))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (rest-disjuncts exps) (cdr exps))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (negated-query exps) (car exps))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (predicate exps) (car exps))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (args exps) (cdr exps))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (rule? statement) (tagged-list? statement (quote rule)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (conclusion rule) (cadr rule))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (rule-body rule) (if (null? (cddr rule)) (quote (always-true)) (caddr rule)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (rule-inner-rules-and-assertions rule2) (if (equal? (quote (always-true)) (rule-body rule2)) (list (quote ()) (quote ())) (cdddr rule2)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (rule-subfeatures-assertions subfeatures) (assq (quote assertions) subfeatures))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (rule-subfeatures-rules subfeatures) (assq (quote rules) subfeatures))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (rule-subrules r) (cdr (rule-subfeatures-rules (rule-inner-rules-and-assertions r))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (rule-subassertions r) (cdr (rule-subfeatures-assertions (rule-inner-rules-and-assertions r))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (query-syntax-process exp) (map-over-symbols expand-question-mark exp))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (map-over-symbols proc exp) (cond ((pair? exp) (cons (map-over-symbols proc (car exp)) (map-over-symbols proc (cdr exp)))) ((symbol? exp) (proc exp)) (else exp)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (expand-question-mark symbol) (let ((chars (symbol->string symbol))) (if (string=? (substring chars 0 1) "?") (list (quote ?) (string->symbol (substring chars 1 (string-length chars)))) symbol)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (var? exp) (tagged-list? exp (quote ?)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (constant-symbol? exp) (symbol? exp))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define rule-counter 0)
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (new-rule-application-id) (set! rule-counter (+ 1 rule-counter)) rule-counter)
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (make-new-variable var rule-application-id) (cons (quote ?) (cons rule-application-id (cdr var))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (contract-question-mark variable) (string->symbol (string-append "?" (if (number? (cadr variable)) (string-append (symbol->string (caddr variable)) "-" (number->string (cadr variable))) (symbol->string (cadr variable))))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (frame-promises frame) (if (null? frame) (quote ()) (cadr frame)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (frame-bindings frame) (if (null? frame) (quote ()) (car frame)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (make-binding variable value) (cons variable value))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (binding-variable binding) (car binding))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (binding-value binding) (cdr binding))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (binding-in-frame variable frame) (assoc variable (frame-bindings frame)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (extend variable value frame) (make-frame-prolog (cons (make-binding variable value) (frame-bindings frame)) (frame-promises frame)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (frame-add-promise frame promise) (make-frame-prolog (frame-bindings frame) (cons promise (frame-promises frame))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (make-frame-prolog bindings promises) (list bindings promises))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (instantiate exp frame unbound-var-handler) (define (copy exp) (cond ((var? exp) (let ((binding (binding-in-frame exp frame))) (if binding (copy (binding-value binding)) (unbound-var-handler exp frame)))) ((pair? exp) (cons (copy (car exp)) (copy (cdr exp)))) (else exp))) (copy exp))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (make-table) (let ((local-table (list (quote *table*)))) (define (lookup key-1 key-2) (let ((subtable (assoc key-1 (cdr local-table)))) (if subtable (let ((record (assoc key-2 (cdr subtable)))) (if record (cdr record) false)) false))) (define (insert! key-1 key-2 value) (let ((subtable (assoc key-1 (cdr local-table)))) (if subtable (let ((record (assoc key-2 (cdr subtable)))) (if record (set-cdr! record value) (set-cdr! subtable (cons (cons key-2 value) (cdr subtable))))) (set-cdr! local-table (cons (list key-1 (cons key-2 value)) (cdr local-table))))) (quote ok)) (define (dispatch m) (cond ((eq? m (quote lookup-proc)) lookup) ((eq? m (quote insert-proc!)) insert!) (else (error "Unknown operation -- TABLE" m)))) dispatch))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define operation-table (make-table))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define get (operation-table (quote lookup-proc)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define put (operation-table (quote insert-proc!)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define coercion-table (make-table))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define get-coercion (coercion-table (quote lookup-proc)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define put-coercion (coercion-table (quote insert-proc!)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (try-qeval result) (if (eq? result (quote no-more-answers)) (amb) result))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (qeval query assertions-env rules-env) (amb (processor (let ((qproc (get (type query) (quote qeval)))) (if qproc (qproc (contents query) assertions-env rules-env) (simple-query query assertions-env rules-env)))) (quote no-more-answers)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (processor frame) (define (loop bindings promises retval) (cond ((null? promises) retval) ((eq? ((car promises) retval) (quote kill-it)) (amb)) ((eq? ((car promises) retval) (quote let-it-stay)) (loop bindings (cdr promises) retval)) ((eq? ((car promises) retval) (quote has-not-bound)) (loop bindings (cdr promises) (frame-add-promise retval (car promises)))) (else (error "process-promises -- unknown promise protocol")))) (loop (frame-bindings frame) (frame-promises frame) (make-frame-prolog (frame-bindings frame) (quote ()))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (simple-query query-pattern assertions-env rules-env) (amb (find-assertions query-pattern assertions-env) (apply-rules query-pattern assertions-env rules-env)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (find-assertions query-pattern assertions-env) (let ((a (an-element-of assertions-env))) (check-an-assertion a query-pattern (make-frame-prolog (quote ()) (quote ())))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (check-an-assertion assertion query-pat query-frame) (let ((match-result (pattern-match query-pat assertion query-frame))) (if (eq? match-result (quote failed)) (amb) match-result)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (apply-rules pattern assertions-env rules-env) (let ((r (an-element-of rules-env))) (apply-a-rule r pattern assertions-env rules-env)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (prolog-extend-env lst env) (append lst env))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (extend-if-unifies var pat1 pat2 frame) (let ((match-frame (unify-match pat1 pat2 frame))) (if (eq? (quote failed) match-frame) (quote failed) (extend var (instantiate pat1 match-frame identity-var) frame))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (accumulate op initial sequence) (if (null? sequence) initial (op (car sequence) (accumulate op initial (cdr sequence)))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (map p sequence) (accumulate (lambda (x y) (cons (p x) y)) (quote ()) sequence))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (append seq1 seq2) (accumulate cons seq2 seq1))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (length sequence) (accumulate (lambda (x y) (+ 1 y)) 0 sequence))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (union-set set1 set2) (if (null? set2) set1 (if (member (car set2) set1) (union-set set1 (cdr set2)) (union-set (cons (car set2) set1) (cdr set2)))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (unify-two-frames f1 f2 iframe) (cond ((eq? (quote failed) f1) (quote failed)) ((eq? (quote failed) f2) (quote failed)) (else (let ((f1-vars (map car (frame-bindings f1))) (f2-vars (map car (frame-bindings f2)))) (let ((ret-vars (union-set f1-vars f2-vars))) (accumulate (lambda (var iframe) (if (eq? (quote failed) iframe) (quote failed) (let ((binding-f1 (binding-in-frame var f1)) (binding-f2 (binding-in-frame var f2))) (cond ((and binding-f1 (not binding-f2)) (extend-if-possible var (binding-value binding-f1) iframe)) ((and binding-f2 (not binding-f1)) (begin (extend-if-possible var (binding-value binding-f2) iframe))) ((and binding-f1 binding-f2) (begin (extend-if-unifies var (binding-value binding-f1) (binding-value binding-f2) iframe))) (else (error "Impossible case")))))) (make-frame-prolog (quote ()) (quote ())) ret-vars))))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (apply-a-rule rule query-pattern assertions-env rules-env) (let ((doubleframe-result (two-sided-match query-pattern (conclusion rule)))) (if (or (eq? (doubleframe-downframe-get doubleframe-result) (quote failed)) (eq? (doubleframe-upframe-get doubleframe-result) (quote failed))) (amb) (let ((df-u (doubleframe-upframe-get doubleframe-result)) (t-q-r (begin (newline) (display "- propagating down") (try-qeval (qeval (instantiate (rule-body rule) (doubleframe-downframe-get doubleframe-result) identity-var) (prolog-extend-env (rule-subassertions rule) assertions-env) (prolog-extend-env (rule-subrules rule) rules-env)))))) (let ((retval (begin (unify-two-frames df-u t-q-r (make-frame-prolog (quote ()) (quote ())))))) (if (eq? (quote failed) retval) (amb) retval))))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (unify-match p1 p2 frame) (cond ((eq? frame (quote failed)) (quote failed)) ((equal? p1 p2) frame) ((var? p1) (extend-if-possible p1 p2 frame)) ((var? p2) (extend-if-possible p2 p1 frame)) ((and (pair? p1) (pair? p2)) (unify-match (cdr p1) (cdr p2) (unify-match (car p1) (car p2) frame))) (else (quote failed))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (extend-if-possible var val frame) (let ((binding (binding-in-frame var frame))) (cond (binding (unify-match (binding-value binding) val frame)) ((var? val) (let ((binding (binding-in-frame val frame))) (if binding (unify-match var (binding-value binding) frame) (extend var val frame)))) ((depends-on? val var frame) (quote failed)) (else (extend var val frame)))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (depends-on? exp var frame) (define (tree-walk e) (cond ((var? e) (if (equal? var e) true (let ((b (binding-in-frame e frame))) (if b (tree-walk (binding-value b)) false)))) ((pair? e) (or (tree-walk (car e)) (tree-walk (cdr e)))) (else false))) (tree-walk exp))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (and a b) (if a (if b true false) false))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (or a b) (if a true (if b true false)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (not e) (if e false true))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (pattern-match-weak pat dat frame) (cond ((eq? frame (quote failed)) (quote failed)) ((equal? pat dat) frame) ((var? pat) (extend-if-consistent pat dat frame)) ((and (pair? pat) (pair? dat)) (pattern-match-weak (cdr pat) (cdr dat) (pattern-match-weak (car pat) (car dat) frame))) ((var? dat) frame) (else (quote failed))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (two-sided-match p1 p2) (make-doubleframe (pattern-match-weak p1 p2 (make-frame-prolog (quote ()) (quote ()))) (pattern-match-weak p2 p1 (make-frame-prolog (quote ()) (quote ())))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (make-doubleframe upward-frame downward-frame) (list upward-frame downward-frame))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (doubleframe-upframe-get doubleframe) (car doubleframe))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (doubleframe-downframe-get doubleframe) (cadr doubleframe))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (pattern-match pat dat frame) (cond ((eq? frame (quote failed)) (quote failed)) ((equal? pat dat) frame) ((var? pat) (extend-if-consistent pat dat frame)) ((and (pair? pat) (pair? dat)) (pattern-match (cdr pat) (cdr dat) (pattern-match (car pat) (car dat) frame))) (else (quote failed))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (extend-if-consistent var dat frame) (let ((binding (binding-in-frame var frame))) (if binding (pattern-match (binding-value binding) dat frame) (extend var dat frame))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (always-true pat assertions rules) (make-frame-prolog (quote ()) (quote ())))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(put (quote always-true) (quote qeval) always-true)
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (conjoin conjuncts assertions rules) (if (empty-conjunction? conjuncts) (make-frame-prolog (quote ()) (quote ())) (let ((rest-frame (conjoin (rest-conjuncts conjuncts) assertions rules)) (this-frame (try-qeval (qeval (first-conjunct conjuncts) assertions rules)))) (let ((retval (unify-two-frames rest-frame this-frame (make-frame-prolog (quote ()) (quote ()))))) retval))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(put (quote and) (quote qeval) conjoin)
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (disjoin disjuncts assertions rules) (if (empty-disjunction? disjuncts) (amb) (amb (try-qeval (qeval (first-disjunct disjuncts) assertions rules)) (disjoin (rest-disjuncts disjuncts) assertions rules))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(put (quote or) (quote qeval) disjoin)
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (negate operands assertions rules) (let ((promise (lambda (frame) (if (has-not-bound? (negated-query operands) frame) (quote has-not-bound) (if (eq? (quote no-more-values) (qeval (negated-query operands) assertions rules)) (quote let-it-stay) (quote kill-it)))))) (frame-add-promise frame1 promise)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (has-not-bound? query frame) (cond ((null? query) false) ((var? query) (if (binding-in-frame query frame) (has-not-bound? (binding-value (binding-in-frame query frame)) frame) true)) ((pair? query) (or (has-not-bound? (car query) frame) (has-not-bound? (cdr query) frame))) (else false)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(put (quote not) (quote qeval) negate)
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (lisp-value call ignore ignore) (let ((promise (lambda (frame) (if (has-not-bound? call frame) (quote has-not-bound) (if (execute (instantiate call frame (lambda (v f) (error "Unknown pat var: LISP-VALUE" v)))) (quote let-it-stay) (quote kill-it)))))) (frame-add-promise frame1 promise)))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(define (execute exp) (let ((pred (eval (predicate exp) (interaction-environment)))) (apply-in-underlying-scheme pred (args exp))))
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(put (quote lisp-value) (quote qeval) lisp-value)
;;; Starting a new problem 
;;; Amb-Eval value:
ok
;;; Amb-Eval input:
(unify-match (query-syntax-process (quote (can-do-job (computer programmer) (computer ?x trainee)))) (query-syntax-process (quote (can-do-job (computer ?x) (computer programmer trainee)))) (make-frame-prolog (quote ()) (quote ())))
;;; Starting a new problem 
;;; Amb-Eval value:
((((? x) . programmer)) ())
;;; Amb-Eval input:
(two-sided-match (query-syntax-process (quote (can-do-job (computer programmer) (computer ?x trainee)))) (query-syntax-process (quote (can-do-job (computer programmer) (computer programmer ?x)))))
;;; Starting a new problem 
;;; Amb-Eval value:
(((((? x) . programmer)) ()) ((((? x) . trainee)) ()))
;;; Amb-Eval input:
(two-sided-match (query-syntax-process (quote (can-do-job (computer programmer) (computer ?x trainee)))) (query-syntax-process (quote (can-do-job (computer programmer) (computer programmer ?x assistant)))))
;;; Starting a new problem 
;;; Amb-Eval value:
(failed failed)
;;; Amb-Eval input:
(two-sided-match (query-syntax-process (quote (can-do-job (computer programmer) (computer ?x trainee)))) (query-syntax-process (quote (can-do-job (computer programmer) (computer ?y trainee)))))
;;; Starting a new problem 
;;; Amb-Eval value:
(((((? x) ? y)) ()) ((((? y) ? x)) ()))
;;; Amb-Eval input:
(rule-subfeatures-assertions (rule-inner-rules-and-assertions (quote (rule (lives-near ?person-1 ?person-2) (and (address ?person-1 (?town . ?rest-1)) (address ?person-2 (?town . ?rest-2))) (assertions ((homefull world) (peopleful world))) (rules ((same ?x ?x)))))))
;;; Starting a new problem 
;;; Amb-Eval value:
(assertions ((homefull world) (peopleful world)))
;;; Amb-Eval input:
(rule-subfeatures-rules (rule-inner-rules-and-assertions (quote (rule (lives-near ?person-1 ?person-2) (and (address ?person-1 (?town . ?rest-1)) (address ?person-2 (?town . ?rest-2))) (assertions ((homefull world) (peopleful world))) (rules ((same ?x ?x)))))))
;;; Starting a new problem 
;;; Amb-Eval value:
(rules ((same ?x ?x)))
;;; Amb-Eval input:
(lq (quote (assert! (rule (lives-near ?person-1 ?person-2) (and (address ?person-1 (?town . ?rest-1)) (address ?person-2 (?town . ?rest-2))) (assertions ((homefull world) (peopleful world))) (rules ((same ?x ?x)))))))
;;; Starting a new problem 
;;; Amb-Eval value:
added
;;; Amb-Eval input:
(lq (quote (assert! (address (Hacker Alyssa P) (Cambridge (Mass Ave) 78)))))
;;; Starting a new problem 
;;; Amb-Eval value:
added
;;; Amb-Eval input:
(lq (quote (assert! (address (Schemer The Little) (Cambridge (Mass Ave) 78)))))
;;; Starting a new problem 
;;; Amb-Eval value:
added
;;; Amb-Eval input:
(lq (quote (lives-near ?x ?y)))
;;; Starting a new problem 
- propagating down
;;; Amb-Eval value:
(lives-near (Schemer The Little) (Schemer The Little))
;;; Amb-Eval input:
try-again
;;; Amb-Eval value:
(lives-near (Hacker Alyssa P) (Schemer The Little))
;;; Amb-Eval input:
(exit)
;;; Starting a new problem 
