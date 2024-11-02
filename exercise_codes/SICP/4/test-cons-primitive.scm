(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "Lazy_Evaluation_lib.scm")

(define primitive-procedures
  (list 
    ;; modified
    (list 'car (lambda (z) (z (lambda (p q) p))))
    (list 'cdr (lambda (z) (z (lambda (p q) q))))
    (list 'cons (lambda (x y) (lambda (m) (m x y))))

    (list 'null? null?)
    (list 'square (lambda (x) (* x x)))
    (list 'square-twice (lambda (x) (square (square x))))
    (list 'first car)
    ;; 4.24
    (list '= =)
    (list '- -)
    (list '* *)
    (list '<= <=)
    (list '+ +)
    (list 'display display)
    ;; 4.26. See 4.14 for why we don't define here.
    ; (list 'map map)
    ; (list 'nil '())
    (list 'length length)

    ;; 4.29
    (list 'remainder remainder)
    (list '/ /)
    ;; 4.30
    (list 'list list)
    (list 'newline newline)
    ))

(define the-global-environment (setup-environment))

(load "test-lib.scm")
(run-program-list 
  '((cons ((lambda () (display "run0") 1)) 2))
  the-global-environment)
;; not lazy due to primitive.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; test driver-loop
(define test-lib
  '((define (cons x y)
      (lambda (m) (m x y)))
    (define (car z)
      (z (lambda (p q) p)))
    (define (cdr z)
      (z (lambda (p q) q)))
    (define (list-ref items n)
      (if (= n 0)
        (car items)
        (list-ref (cdr items) (- n 1))))
    (define (map proc items)
      (if (null? items)
        '()
        (cons (proc (car items))
              (map proc (cdr items)))))
    (define (scale-list items factor)
      (map (lambda (x) (* x factor))
           items))
    ;; in recursive calls, list2 may be (add-lists ones integers), so (car list2) is (+ (car list1) (car list2)). (just show symbol. So 2 list2's are not same.)
    (define (add-lists list1 list2)
      (cond ((null? list1) list2)
            ((null? list2) list1)
            (else (cons (+ (car list1) (car list2))
                        (add-lists (cdr list1) (cdr list2))))))
    (define ones (cons 1 ones))
    (define integers (cons 1 (add-lists ones integers)))
    ))

;; 1. Notice for infinite stream, null? is always false although list1/2 (lambda for here) is evaluated.
;; 2. It will keep call list-ref until n=0 with `(cdr items)` being always wrapped as one thunk.
;; then (car (cdr (cdr ...))) where each cdr is one thunk.
;; So it keep forcing until (cdr integers-thunk) -> (add-lists ones integers)-thunk.
;; Then (cdr (add-lists ones integers)-thunk) -(Thunks for ones integers are forced)> (cdr (cons thunk-+-1 thunk-add-lists-2)) -> thunk-add-lists-2
;; (cdr thunk-add-lists-2) -(Thunks for (cdr list1) (cdr list2) are forced, i.e. (cdr ones)-thunk ...)> similarly thunk-add-lists-2-0...

(define test-program
  (append test-lib 
    ; '((list-ref integers 17))
    '((list-ref integers 2)) ; to have one small demo log.
    ; '(list-ref integers 17)
    ))

(trace actual-value)
; (trace force-it) ; test-cons-primitive.log

(run-program-list-force test-program the-global-environment)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; log partial analysis
;; IGNORE these since the evaluator logic is more important.
;; test-cons-primitive-actual-val.log with '((list-ref integers 17))
; 1. 17 is got from thunk which is val of n.
; [Entering #[compound-procedure 14 actual-value]
;     Args: n
;           (((items n) (thunk integers #0=(((integers ones add-lists scale-list...]
; [Entering #[compound-procedure 14 actual-value]
;     Args: 17
;           #0=(((integers ones add-lists scale-list map list-ref false true car...]
; [17
;       <== #[compound-procedure 14 actual-value]
;     Args: 17
;           #0=(((integers ones add-lists scale-list map list-ref false true car...]
; [17                                                                                                                                                                                          
;       <== #[compound-procedure 14 actual-value]
;     Args: n
;           (((items n) (thunk integers #0=(((integers ones add-lists scale-list...]
;; test-cons-primitive-actual-val-small.log with '((list-ref integers 2))
; 2. delayed evaluation of (- n 1)-thunk.
; [Entering #[compound-procedure 14 actual-value]
;     Args: n
;           (((items n) (thunk (cdr items) (((items n) (thunk integers #0=(((int...]
; [Entering #[compound-procedure 14 actual-value]
;     Args: (- n 1)
;           (((items n) (thunk integers #0=(((integers ones add-lists scale-list...]
; ...
; [1
;       <== #[compound-procedure 14 actual-value]
;     Args: (- n 1)
;           (((items n) (thunk integers #0=(((integers ones add-lists scale-list...]
; [1
;       <== #[compound-procedure 14 actual-value]                                                                                                                                              
;     Args: n
;           (((items n) (thunk (cdr items) (((items n) (thunk integers #0=(((int...]
; 3. notice here keeping expanding thunks, so (car (cdr (cdr integers))) corresponding to 2 cdr
; [Entering #[compound-procedure 14 actual-value]
;     Args: car
;           (((items n) (thunk (cdr items) (((items n) (thunk (cdr items) (((ite...]
; [#0=(procedure (z) ((z (lambda (p q) p))) #1=(((integers ones add-lists scale-...
;       <== #[compound-procedure 14 actual-value]
;     Args: car
;           (((items n) (thunk (cdr items) (((items n) (thunk (cdr items) (((ite...]
; [Entering #[compound-procedure 14 actual-value]
;     Args: z
;           (((z) (thunk items (((items n) (thunk (cdr items) (((items n) (thunk...]
; [Entering #[compound-procedure 14 actual-value]
;     Args: items
;           (((items n) (thunk (cdr items) (((items n) (thunk (cdr items) (((ite...]
; [Entering #[compound-procedure 14 actual-value]
;     Args: (cdr items)
;           (((items n) (thunk (cdr items) (((items n) (thunk integers #0=(((int...]
;...
; [Entering #[compound-procedure 14 actual-value]
;     Args: (cdr items)                                                                                                                                                                        
;           (((items n) (thunk integers #0=(((integers ones add-lists scale-list...]
;...
; [Entering #[compound-procedure 14 actual-value]
;     Args: items
;           (((items n) (thunk integers #0=(((integers ones add-lists scale-list...]
; [Entering #[compound-procedure 14 actual-value]                                                                                                                                              
;     Args: integers
;           #0=(((integers ones add-lists scale-list map list-ref false true car...]
; 4. See notes. Force m
; [Entering #[compound-procedure 14 actual-value]
;     Args: m
;           (((m) (thunk (lambda (p q) q) (((z) (evaluated-thunk #0=(procedure (...]
; [Entering #[compound-procedure 14 actual-value]
;     Args: (lambda (p q) q)
;           (((z) (evaluated-thunk #0=(procedure (m) ((m x y)) (((x y) (thunk 1 ...]
; ...
; [Entering #[compound-procedure 14 actual-value]
;     Args: y
;           (((m) (evaluated-thunk (procedure (p q) (q) (((z) (evaluated-thunk #...]
; 5. i.e. above, force list1
; [Entering #[compound-procedure 14 actual-value]
;     Args: (null? list1)
;           (((list1 list2) (thunk ones #0=(((integers ones add-lists scale-list...]
; [Entering #[compound-procedure 14 actual-value]
;     Args: null?
;           (((list1 list2) (thunk ones #0=(((integers ones add-lists scale-list...]
; [(primitive #[compiled-procedure 17 ("list" #x5) #x1c #xe2d9c4])
;       <== #[compound-procedure 14 actual-value]
;     Args: null?
;           (((list1 list2) (thunk ones #0=(((integers ones add-lists scale-list...]
; [Entering #[compound-procedure 14 actual-value]
;     Args: list1
;           (((list1 list2) (thunk ones #0=(((integers ones add-lists scale-list...]                                                                                                           
; [Entering #[compound-procedure 14 actual-value]
;     Args: ones
;           #0=(((integers ones add-lists scale-list map list-ref false true car...]
; 6. see above
; [Entering #[compound-procedure 14 actual-value]
;     Args: (add-lists (cdr list1) (cdr list2))
;           #0=(((list1 list2) (evaluated-thunk #1=(procedure (m) ((m x y)) (((x...]
; 7. car part
; [Entering #[compound-procedure 14 actual-value]
;     Args: (+ (car list1) (car list2))
;           #0=(((list1 list2) (evaluated-thunk #1=(procedure (m) ((m x y)) (((x...]
; 8. this is first (car list2). (1 + + ...) so the most inner (car list2) will be (car (cdr integers)) which is just the 1st +...
;; So we evaluate that by 1+1.
; [Entering #[compound-procedure 14 actual-value]
;     Args: (car list2)
;           #0=(((list1 list2) (evaluated-thunk #1=(procedure (m) ((m x y)) (((x...]
; ...
; [Entering #[compound-procedure 14 actual-value]
;     Args: x
;           (((m) (evaluated-thunk (procedure (p q) (p) (((z) (evaluated-thunk #...]
; [Entering #[compound-procedure 14 actual-value]
;     Args: 1
;           #0=(((integers ones add-lists scale-list map list-ref false true car...]
; ...
; [2
;       <== #[compound-procedure 14 actual-value]
;     Args: (+ (car list1) (car list2))
; 8. Notice here ones is always passed to cdr of ones. So to get car of (cdr (cdr ... (cdr ones))) is much easier than to get (cdr (cdr ... (cdr integers)))
; [1
;       <== #[compound-procedure 14 actual-value]                                                                                                                                              
;     Args: (car list1)
;           #0=(((list1 list2) (evaluated-thunk #1=(procedure (m) ((m x y)) (((x...]
; [3
;       <== #[compound-procedure 14 actual-value]
;     Args: (+ (car list1) (car list2))
;           #0=(((list1 list2) (evaluated-thunk #1=(procedure (m) ((m x y)) (((x...]
