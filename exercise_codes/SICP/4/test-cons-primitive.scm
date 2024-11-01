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
  (append test-lib '(list-ref integers 17)))

; (trace actual-value)
(trace force-it)

(run-program-list test-program the-global-environment)