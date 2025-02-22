;; "(match?" has no reference implementation in  6.945 etc based on "@% reference implementation checked".
(cd "~/SICP_SDF/SDF_exercises/chapter_4")
(load "../software/sdf/manager/load.scm")
(manage 'new 'design-of-the-matcher)

; (define (match:collect-type? object)
;   (memq object match:collect-types))

; (define match:collect-types '($))

; ;; similar to match:named-var?
; (define (match:collect? object)
;   (and (pair? object)
;        (match:collect-type? (car object))
;        (n:= (length object) 2)
;        (symbol? (cadr object))))

(define (match:collect-type? object)
  (eq? object '$))

(define match:var-types (cons '$ match:var-types))

#|
In my memory, I have finished one procedure to change one binding based on name. But no such a useful procedure has been found.
$ grep 'match:[^ ).]*' -o -h -r . --color=always | grep 'dict' | sort -u
match:dict?
match:dict-substitution-for-str-transformed-lst
match:dict-substitution
match:extend-dict
match:extend-dict*
match:map-dict-values
match:new-dict
match:pe-dicts
match:pe-with-base-dict
match:pe-with-only-base-dict?
match:pletrec-add-bindings-to-base-dict
match:pletrec-add-bindings-to-dict
|#

(define (match:map-dict-values* procedure dict)
  (match:new-bindings
   dict
   (map procedure
        (match:bindings dict))))

;;; misc tests to check whether (set! binding ...) can be valid.
(define test-lst (list '(1 2)))
(define sub-lst (find (lambda (sub-lst) (= 2 (length sub-lst))) test-lst))
;; here we must use one var like sub-lst, so it will only change sub-lst itself but not its value obviously.
(set! sub-lst (list 2 3))
test-lst

;; similar to element-match
(define (member* data lst)
  (cond 
    ((list? lst) (member data lst))
    (else (equal? data lst)))
  )
(define (cons* data lst)
  (cond 
    ((list? lst) (cons data lst))
    (else (list data lst)))
  )
(define (match:collect variable)
  (define (collect-match data dictionary succeed)
    (and (pair? data)
        ;  (match:satisfies-restriction? variable (car data))
         ;; better to use match:lookup-corrected
         (let ((binding (match:lookup variable dictionary)))
           (if binding
               (succeed 
                (match:map-dict-values*
                  (lambda (binding)
                    (if (eq? (match:var-name variable) (match:binding-name binding))
                      (match:make-binding 
                        variable
                        (let ((insertion (car data))
                              (orig (match:binding-value binding)))
                          (if (member* insertion orig)
                            orig
                            (cons* insertion orig)))
                        )
                      binding)
                    )
                  dictionary)
                  1)
               (succeed (match:extend-dict variable
                                           (car data)
                                           dictionary)
                        1)))))
  collect-match)

;; > and augment the pattern compiler appropriately
(define (match:compile-pattern pattern)
  (cond ((match:var? pattern)
         (case (match:var-type pattern)
           ((?) (match:element pattern))
           ((??) (match:segment pattern))
           ;; put here to be consistent with match:var-type.
           (($) (match:collect pattern))
           (else (error "Unknown var type:" pattern))))
        ; ((match:collect? pattern)
        ;   (match:collect pattern)
        ;   )
        ((list? pattern)
         (match:list (map match:compile-pattern pattern)))
        (else
          ;; IGNORE: SDF_exercises TODO what does this purpose to do?
         (match:eqv pattern))))

(define (match? pat data)
  (let* ((bindings ((matcher pat) data))
         (collect-type-bindings
          (filter 
            (lambda (binding) (match:collect-type? (match:binding-type binding))) 
            bindings))
         )
    (write-line (list "bindings" bindings collect-type-bindings))
    (map 
      (lambda (binding) 
        (list (match:binding-name binding) (match:binding-value binding)))
      collect-type-bindings)
    ))

(trace match:collect)
; Use "sed -i -f ~/SICP_SDF/SDF_exercises/chapter_4/format.sed ./4_a.scm" to change "’" when copy.
(match? '(a (($ b) 2 3) ($ b) c) '(a (1 2 3) 1 c))
;Value: ((b 1))
(match? '(a (($ b) 2 3) ($ b) c) '(a (1 2 3) 2 c))
;Value: ((b (2 1)))
