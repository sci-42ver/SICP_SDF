----
[http://community.schemewiki.org/?sicp-ex-4.76 << Previous exercise (4.76)]
| [http://community.schemewiki.org/?sicp-solutions Index] |
[http://community.schemewiki.org/?sicp-ex-4.78 Next exercise (4.78) >>]
----
<<<poly
{{{scheme



(define (filter? exp)
  (or (list-value? exp)
      (not? exp)))

(define (conjoin conjuncts frame-stream)
  (conjoin-mix conjuncts '() frame-stream))

(define (conjoin-mix conjs delayed-conjs frame-stream)
  (if (null? conjs)
      (if (null? delayed-conjs)
          frame-stream          ; conjoin finish if both of conjuncts are empty
          the-empty-stream)     ; no result return cause filters with unbound vars exist
      (let ((first (first-conjunct conjs))
            (rest (rest-conjuncts conjs)))
        (if (filter? first)
            (let ((check-result
                   (conjoin-check first delayed-conjs frame-stream)))
              (conjoin-mix rest
                           (car check-result)
                           (cdr check-result)))
            (let ((new-frame-stream (qeval first frame-stream)))
              (let ((delayed-result
                     (conjoin-delayed delayed-conjs '() new-frame-stream)))
                (conjoin-mix rest (car delayed-result) (cdr delayed-result))))))))

(define (conjoin-delayed delayed-conjs rest-conjs frame-stream)
  ; evaluate those conjuncts in delayed-conjs if there are
  ; enough bindings for them.
  (if (null? delayed-conjs)
      (cons rest-conjs frame-stream)
      (let ((check-result
             (conjoin-check (first-conjunct delayed-conjs)
                            rest-conjs frame-stream)))
        (conjoin-delayed (cdr delayed-conjs)
                         (car check-result)
                         (cdr check-result)))))

(define (conjoin-check target conjs frame-stream)
  ; Check if there are any unbound vars in target.
  ; Delay it if there are unbound vars, or just evaluate it.
  (if (has-unbound-var? (contents target) (stream-car frame-stream))
      (cons (cons target conjs) frame-stream)
      (cons conjs (qeval target frame-stream))))

(define (has-unbound-var? exp frame)
  (define (tree-walk exp)
    (cond ((var? exp)
           (let ((binding (binding-in-frame exp frame)))
             (if binding
                 (tree-walk (binding-value binding))
                 true)))
          ((pair? exp)
           (or (tree-walk (car exp)) (tree-walk (cdr exp))))
          (else false)))
  (tree-walk exp))
}}}
unique is also sort of filter, but won't work with this because the contents of unique usually contain at least one variable that is not relevant with other variables.
<<<LisScheSic
"; no result return cause filters with unbound vars exist": is wrong. We should let filter to decide what to return. For example to evaluate (and (not (fum ?x))), if there are no rules and assertions related with fum, then we return the frame arg passed in encapsulated in singleton-stream.

(stream-car frame-stream) is inappropriate in some cases. See the following "qux qux-person" context.
>>>
>>>
<<<revc

*** No complicated mechanism is required.
----

we can simply rearrange the order of clauses of compound queries by putting all filters at the end, which is an efficient and trivial method. In order to accomplish this, we will normalize the non-normalized compound queries during the parse phase of qeval.

{{{scheme
;;; Exercise 4.77

(define compound-table '())
(define (put-compound combinator) (set! compound-table (cons combinator compound-table)))
(define (compound? query) (memq (type query) compound-table))

(define filter-table '())
(define (put-filter operator) (set! filter-table (cons operator filter-table)))
(define (filter? query) (memq (type query) filter-table))

(define (normalize clauses)
  (let ((filters (filter filter? clauses))
	(non-filters (filter (lambda (x) (not (filter? x))) clauses)))
    (append non-filters filters)))

(define (qeval query frame-stream)
  (let ((qproc (get (type query) 'qeval)))
    (cond ((compound? query) (qproc (normalize (contents query)) frame-stream))
	  (qproc (qproc (contents query) frame-stream))
	  (else (simple-query query frame-stream)))))

(put-compound 'and)
(put-filter 'not)
(put-filter 'lisp-value)
(put-filter 'unique)
}}}
>>>
<<<baby
First of all, having used this site as a reference for most exercises until 4.77, I am glad to contribute my 2 cents!

The easiest path would have been to push all the filters to the end, but the question explicitly states that it is inefficient (as per my understanding, it is stating that even if one variable is available out of all those required by the filter, it is better to perform a partial filter in the hope that the frame count will decrease).

So as directed by the book, I am appending promises to frames. The word promise is used in quotes, so I interpreted it as not an intention to use literal promises, but one that is conceptually an agreement to check. For this, the structure of frame is changed into a list of 2 elements - one for bindings, the other for promises (the following line is the entry point):

{{{scheme
(qeval q (singleton-stream (list '() '())))
}}}

The following is the new negate function:

{{{scheme
(define (negate operands frame-stream)
  (simple-stream-flatmap
   (lambda (frame)
     (let ((replaced (instantiate (negated-query operands) frame (lambda (v f) v)))
           (check (has-unbound-variables? (negated-query operands) frame)))
       (if (stream-null?
            (qeval (negated-query operands)
                   (singleton-stream frame)))
           (if check
               (singleton-stream (add-promise (list 'not replaced) frame))
               (singleton-stream frame))
           (if check
               (singleton-stream (add-promise (list 'not replaced) frame))
               the-empty-stream))))
   frame-stream))
}}}

Negate sends back the empty stream only in the case where the filter fails AND there are no unbound variables. Note what is being added in the promise; the instantiated query is being added, so that the next time this filter is checked, any variables that were found will already be there.

find-assertions is where the promise handling is done:

{{{scheme
(define (find-assertions pattern frame)
  (simple-stream-flatmap
   (lambda (datum)
     (let ((check-result (check-an-assertion datum pattern frame)))
       (if (stream-null? check-result)
           check-result
           (handle-promises (stream-car check-result)))))
   (fetch-assertions pattern frame)))

(define (handle-promises frame)
  (define (iter promises frame)
    (if (null? promises)
        (singleton-stream frame)
        (let ((result (qeval (car promises) (singleton-stream frame))))
          (if (stream-null? result)
              the-empty-stream
              (iter (cdr promises) (stream-car result))))))
  (let ((current-promises (get-promises frame)))
    (iter current-promises (remove-promises frame))))
}}}

The result of check-an-assertion isn't sent directly; instead, this new frame stream is examined for promises. In handle-promises, I iterate over the current existing promises and remove the frame's promises entirely. The idea is that when qeval is called inside again, and some promises still aren't satisfied due to unbound variables still remaining, then they will get re-inserted into the frame again.

Here are the frame operations:

{{{scheme
(define (make-binding variable value)
  (cons variable value))
(define (binding-variable binding) (car binding))
(define (binding-value binding) (cdr binding))
(define (binding-in-frame variable frame)
  (assoc variable (car frame)))
(define (extend variable value frame)
  (list (cons (make-binding variable value) (car frame))
        (cadr frame)))
(define (add-promise promise frame)
  (list (car frame)
        (cons promise (cadr frame))))
(define (get-promises frame) (cadr frame))
(define (remove-promises frame) (list (car frame) '()))
}}}

And the helper function:

{{{scheme
(define (has-unbound-variables? pattern frame)
  (cond ((null? pattern) #f)
        ((var? (car pattern))
         (let ((b (binding-in-frame (car pattern) frame)))
           (if b
               (has-unbound-variables? (cdr pattern) frame)
               #t)))
        (else (has-unbound-variables? (cdr pattern) frame))))
}}}

I built this structure around negation first, and then modifying lisp-value was trivial:

{{{scheme
(define (lisp-value call frame-stream)
  (simple-stream-flatmap
   (lambda (frame)
     (let ((replaced (instantiate call frame (lambda (v f) v)))
           (check (has-unbound-variables? call frame)))
       (if (not check)
           (if (execute replaced)
               (singleton-stream frame)
               the-empty-stream)
           (singleton-stream (add-promise (cons 'lisp-value replaced) frame)))))
   frame-stream))
(put 'lisp-value 'qeval lisp-value)
}}}

Note that in adding promise here, cons is used to combine 'lisp-value instead of list as in negate.
<<<LisScheSic
Corrections:
# You changed the frame structure, then all related procedures like binding-in-frame all need small changes which is inconvenient.
# (iter (cdr promises) (stream-car result)) drops many frames from frame-stream  unexpectedly.
# binding-in-frame is not enough to evaluate filter query. Assume we are evaluating one rule like (lives-near ?x (Hacker Alyssa P)), although ?x is bound to ?person-1 when (address ?person-1 (?town . ?rest-1)), we still doesn't get the ''actual'' value of ?x. Although it is fine to pull out one promise and put back one promise if failure, IMHO it is more efficient to avoid unnecessary useless promise force.

Interested people can fix the above errors. I won't do that.

I also offer one implementation in the following which won't have the above 3 errors.

IMHO the change of the frame structure is better than my implementation based on lambda promise since no need for deep copy.
>>>
>>>
<<<SHIMADA


Process Flow

If a filter procedure exists, add it to another variable (here referred to as THE-FILTERS).

Execute other queries in the qeval procedure, 
and if the number of bindings is sufficient (enough-bindings? is true), apply the procedures in THE-FILTERS (apply-filters).

Currently, debugging is only done with the not filter.

{{{scheme
(define (query-driver-loop)
...
(display-stream
  (stream-map
    (lambda (frame)
	(instantiate q frame (lambda (v f) (contract-question-mark v))))
    (apply-filter (qeval q (singleton-stream '()))))) ; change here
...
)

(define (qeval query frame-stream)
  (let* ((qproc (get (type query) 'qeval))
	 (q-val
	  (if qproc
            (qproc (contents query) frame-stream)
	    (simple-query query frame-stream))))
    (if (enough-bindings? q-val)
      (apply-filter q-val)
      q-val)))

(define THE-FILTERS the-empty-stream)
(define (filter-initial) (set! THE-FILTERS the-empty-stream))
(define (empty-frame? frame) (null? frame))
(define (empty-filter? exps) (null? exps))
(define (first-filter exps) (stream-car exps))
(define (rest-filter exps) (stream-cdr exps))
(define (apply-filter frame-stream)
  (define (run filters frame-stream)
    (cond
      ((empty-filter? filters) frame-stream)
      ((stream-null? (stream-car frame-stream)) '()) ; don't apply filter
      (else
	(run (rest-filter filters) ((first-filter filters) frame-stream)))))
  (let ((filters THE-FILTERS))
    (filter-initial)
    (run filters frame-stream)))
(define enough-bindings-max 5)
(define (enough-bindings? frame-stream)
  (define (iter count frame)
    (cond
      ((>= count enough-bindings-max) #t)
      ((stream-null? frame) #f)
      (else (iter (inc count) (stream-cdr frame)))))
  (iter 0 frame-stream))

(define (negate operands dummy-frame-stream)
  (define (negate-filter frame-stream)
    (stream-flatmap
      (lambda (frame)
	(if (stream-null?
	    (qeval (negated-query operands)
	      (singleton-stream frame)))
	  (singleton-stream frame)
	  the-empty-stream))
      frame-stream))
  (let ((old-filters THE-FILTERS))
    (set! THE-FILTERS
      (cons-stream
	(lambda (frame-stream)
	  (negate-filter frame-stream)) old-filters))
  dummy-frame-stream))
(put 'not 'qeval negate)
}}}
DEBUG
{{{scheme
(job (Bitdiddle Ben) (computer wizard))
(not (baseball-fan (Bitdiddle Ben)))
(and (not (job ?x (computer programmer)))
		  (supervisor ?x ?y))
(and (supervisor ?x ?y)
	 (not (job ?x (computer programmer))))
}}}
<<<LisScheSic
The above implementation has some errors: 

1. The above checks the binding satisfaction for the entire frame-stream, IMHO that may not work for some cases. Assume the frame-stream is offered by the following (it is possible although weird) 

{{{scheme
(assert! (qux qux-person))
(assert! (baz baz-person))
(assert! (bar bar-person))
(assert! (foo foo-person))
(and
  ;; based on interleave-delayed, car is (bar ?person-1) result.
  (or (bar ?person-1) (foo ?person-2))
  (not (qux ?person-1))
  (baz ?person-1)
  )
; null

(and
  (or (bar ?person-1) (foo ?person-2))
  (baz ?person-1)
  (not (qux ?person-1))
  )
;; Here (bar baz-person) should be omitted since we choose (foo foo-person) for or.
; (and (or (bar baz-person) (foo foo-person)) (baz baz-person) (not (qux baz-person)))
}}}
Then for the 2nd conjunction, some offers the binding only for ?person-2 while some offers only for ?person-1. So the types of bindings are inconsistent. Actually, we should wait until ?person-1 is offered by baz, otherwise (not (qux ?person-1)) may reject frames created by (foo ?person-2) unexpectedly.

2. enough-bindings? is done by counting frame number in frame-stream. I don't know why you do that. Here even if we have many frames, but if all of them don't offer the required bindings, they can't make filter valid.

One improvement: (stream-null? (stream-car frame-stream)) won't occur due to stream-flatmap.

My implementation is similar to yours by using one lambda as the promise but I somewhat strictly follow the book hints by appending the frame instead of using one global THE-FILTERS. IMHO due to checking each frame ''independently'', we should not use one ''global'' THE-FILTERS. Local data structure like the original frame is more appropriate.

As baby says, the quote around promise means it may be not the promise created by delay.

------

I tried first by append one binding {{{(all-vars-if-not-all-vars-bound . (delay procedure-to-rerun-filter))}}} to the frame. But this binding will be passed to the later compound query conjunct/disjunct. Then when one is forced, all are implicitly forced since that binding is ''shared'' among all extended frames.

So I tried {{{(all-vars-if-not-all-vars-bound . procedure-to-rerun-filter)}}} (i.e. {{{(cons operand-vars orig-proc)}}}), then use deep copy https://stackoverflow.com/a/79232811/21294350 when necessary (I don't know how to copy the internal-unknown structure promise generated by delay). Actually, this is very inefficient.

---

My basic idea is that doing filter when possible, otherwise store the promise to frame. Then for each simple-query (all compound queries and rules will at last call simple-query), after we add the bindings, we check {{{try-run-lambda}}} which is  recursive since there may be multiple pending promises.

Before {{{try-run-lambda}}}, we must do deep copy since here I mark promise done by set-cdr! which may change the shared promise (Maybe there are some other intelligent methods to mark).

{{{try-run-lambda}}} will run the 1st lambda promise (i.e. added by the 1st filter) if possible, otherwise just encapsulate frame with (singleton-stream frame) and then return back. Then we will try the possible next lambda promise for the new ''frame-stream'' created by promise.

vars, var-bound-to-val, all-vars-has-bindings, find-pair-with-lambda helper procedures are trivial.

p.s. When I finished this implementation, I checked this wiki and https://github.com/xxyzz/SICP/blob/master/4_Metalinguistic_Abstraction/4.4_Logic_Programming/Exercise_4_77.rkt. The latter does 
# It uses `not-filter-vars` to check the possible vars to be matched later. So it won't wait until *all* vars can be bound but just the *maximum* possible. This shouldn't be used for lisp-value since > etc can't be applied to var. 
# It stores promise in one separate frame. So many APIs need to be changed which is inconvenient. 
# It tries force when extended, which seems too aggressive since this may have too many redundant calls for `frame-passed-filter?` although fine-grained.
You can check the point 1 if you are interested. I just run force-run-lambda which is try-run-lambda variant not checking all-vars-has-bindings in query-driver-loop similar to what SHIMADA does above.

{{{scheme
(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

;; 0.a. lisp-value needs operator, operands. 
;; Some operand may be frame-stream, ~~but then operator should be procedure using specical form.~~
;; but frame-stream should be used with operands etc which has more meaning.
;; So we can assume operand to be either var or val.
;; 0.b. So only and can pass frame-stream between operands (i.e. conj's) which can have nested or etc.

(define (negate operands frame-stream)
  ;; this promise should check all bindings in the frame just as not does.
  (define (orig-negate-for-frame operands frame)
    ;; unchanged
    (if (stream-null? (qeval (negated-query operands)
                            (singleton-stream frame)))
      (singleton-stream frame)
      the-empty-stream))
  (stream-flatmap
    (lambda (frame)
      (let ((operand-vars (vars (car operands)))
            (orig-proc 
              (lambda (frame) (orig-negate-for-frame operands frame))))
        (if (all-vars-has-bindings operand-vars frame)
          (orig-proc frame)
          ;; added
          (singleton-stream 
            ;; append to ensure force ordering for try-run-lambda.
            (append frame (list (cons operand-vars orig-proc)))
            )
          )))
    frame-stream))

(define (vars exp)
  (filter-map 
    (lambda (op) 
      (and (var? op) op))
    exp
    ))

(define (var-bound-to-val var frame)
  (if (var? var)
    (let ((binding (assoc var frame)))
      (and binding (var-bound-to-val (cdr binding) frame)))
    #t))

(define (all-vars-has-bindings vars frame)
  (fold 
    (lambda (a res) (and res (var-bound-to-val a frame))) ; res put before to ensure short circuit
    #t 
    vars))

;; binding is passed by reference.
(define (find-pair-with-lambda frame)
  (let ((res 
          (filter-map 
            (lambda (binding) 
              (let ((proc (cdr binding)))
                (and (procedure? proc) binding))
              ) 
            frame)))
    (and 
      (not (null? res))
      res
      ))
  )

;; 0. promise needs the frame with needed bindings to evaluate the result.
;; 1. Since partial operand results are not sufficient to do the operation, so wait until all are offered.
(define (try-run-lambda frame)
  (let ((pair-with-lambda (find-pair-with-lambda frame)))
    (if (and pair-with-lambda (all-vars-has-bindings (caar pair-with-lambda) frame))
      ;; 0. pass one lambda, then no need for force at all.
      ;; 1. here maybe there multiple pair-with-lambda's.
      (let ((proc (cdar pair-with-lambda)))
          ;; no need to delete since this bindind has list car instead of var.
          (set-cdr! (car pair-with-lambda) 'used)
          (stream-flatmap
            try-run-lambda
            ;; return frame-stream
            (proc frame)))
      (singleton-stream frame)
      )))

; https://stackoverflow.com/a/20802742/21294350
;; only work for pair.
;; See link for the general.
(define (full-copy pair)
  (if (pair? pair) 
    (cons (full-copy (car pair)) (full-copy (cdr pair)))
    pair))

(define (use-separate-not-mark-binding frame)
  (map 
    (lambda (binding) 
      (let ((promise (cdr binding)))
        (let ((proc (cdr binding)))
          (if (procedure? proc) 
            (full-copy binding)
            binding
            ))
        ))
    frame
    )
  )

;; all "Compound queries" will at last call simple-query.
(define (simple-query query-pattern frame-stream)
  (stream-flatmap
    (lambda (frame)
      ;; we should try immediately after new frame-stream is constructed. 
      (stream-flatmap
        (lambda (frame)
          (try-run-lambda (use-separate-not-mark-binding frame))
          )
        (stream-append-delayed
          (find-assertions query-pattern frame)
          (delay (apply-rules query-pattern frame))))
      )
    frame-stream))

;; added based on repo not-filter-vars
(define (force-run-lambda frame)
  (let ((pair-with-lambda (find-pair-with-lambda frame)))
    (if pair-with-lambda ; changed
      (let ((proc (cdar pair-with-lambda)))
          (set-cdr! (car pair-with-lambda) 'used)
          (stream-flatmap
            try-run-lambda
            (proc frame)))
      (singleton-stream frame)
      )))
(define (query-driver-loop)
  (prompt-for-input input-prompt)
  (let ((q (query-syntax-process (read))))
    (cond ((assertion-to-be-added? q)
           (add-rule-or-assertion! (add-assertion-body q))
           (newline)
           (display "Assertion added to data base.")
           (query-driver-loop))
          (else
           (newline)
           (display output-prompt)
           ;; [extra newline at end] (announce-output output-prompt)
           (display-stream
            (stream-map
             (lambda (frame)
               (instantiate q
                            frame
                            (lambda (v f)
                              (contract-question-mark v))))
             ;; modified
             (stream-flatmap force-run-lambda (qeval q (singleton-stream '())))
             ))
           (query-driver-loop)))))

(put 'not 'qeval negate)
}}}

>>>
>>>
