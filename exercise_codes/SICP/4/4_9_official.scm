;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; syntax usage
;; example https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Syntactic-Binding-Constructs.html#index-define_002dsyntax
(let-syntax
  ((foo (syntax-rules ()
          ((foo (proc args ...) body ...)
           (define proc
             (lambda (args ...)
               body ...))))))
  (let ((x 3))
    (foo (plus x y) (+ x y))
    (define foo x)
    (plus foo x)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; syntax for do
;; similar to 4_9.scm `let loop`. see https://small.r7rs.org/attachment/r7rs.pdf p71 or https://people.csail.mit.edu/jaffer/r5rs/Derived-expression-type.html
;;; "deriv" context summary
;; > These were derived from rules in the grammar given in chapter 7 
;; see 7.1.3
;; > Derived expression types are not semantically primitive, but can instead be defined as macros
(define-syntax do
  (syntax-rules ()
    ((do ((var init step ...) ...)
        (test expr ...)
        command ...)
    (letrec
      ((loop
        (lambda (var ...)
          (if test
              (begin
                (if #f #f)
                expr ...)
              (begin
                command
                ...
                (loop (do "step" var step ...)
                      ...))))))
      (loop init ...)))
    ((do "step" x)
    x)
    ((do "step" x y)
    y)))

(do "step" 1)

;; TODO how loop is known to be procedure or vec?
(define (loop-as-var-test)
  ;; will implicitly always use the above syntax
  (define test (vector 3))
  (do ((loop (make-vector 5))
        (i 0 (+ i 1)))
      ((begin 
        (set! test loop)
        (= i 5)) (list loop test))
    (vector-set! loop i i)))
(loop-as-var-test)

;; https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Pattern-Language.html#index-syntax_002drules
;; > pattern variables that occur in the template are *replaced* by the subforms they match in the input.
; (letrec
;   ((loop
;     (lambda (loop i)
;       (if (= i 5)
;           (begin
;             (if #f #f)
;             loop)
;           (begin
;             (vector-set! loop i i)
;             (loop loop (+ i 1)))))))
;   (loop (make-vector 5) 0))
;The object #(0 #f #f #f #f) is not applicable.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; https://hipster.home.xs4all.nl/lib/scheme/gauche/define-syntax-primer.txt
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; debug. Not showing pairing in "They are paired up". And also not avoid `loop` collision.
(define-syntax do
  (syntax-rules ()
    ((do ((var init step ...) ...)
        (test expr ...)
        command ...)
    '(letrec
      ((loop
        (lambda (var ...)
          (if test
              (begin
                (if #f #f)
                expr ...)
              (begin
                command
                ...
                (loop (do "step" var step ...)
                      ...))))))
      (loop init ...)))
    ((do "step" x)
    'x)
    ((do "step" x y)
    'y)))
(do ((loop (make-vector 5))
      (i 0 (+ i 1)))
    ((begin 
      (set! test loop)
      (= i 5)) (list loop test))
   (vector-set! loop i i))
; (letrec 
;   ((loop 
;     (lambda (loop i) 
;       (if (= i 5) 
;         (begin (if #f #f) loop) 
;       (begin (vector-set! loop i i) 
;         (loop (do "step" loop) (do "step" i (+ i 1)))))))) 
;     (loop (make-vector 5) 0))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; use named let instead of lecrec
(define-syntax do
  (syntax-rules ()
    ((do ((var init step ...) ...)
        (test expr ...)
        command ...)
    (let loop 
      ((var init) ...)
        (if test
            (begin
              (if #f #f)
              expr ...)
            (begin
              command
              ...
              (loop (do "step" var step ...)
                    ...)))))
    ((do "step" x)
    x)
    ((do "step" x y)
    y)))
(define test (vector 3))
(do ((loop (make-vector 5))
      (i 0 (+ i 1)))
    ((begin 
      (set! test loop)
      (= i 5)) (list loop test))
   (vector-set! loop i i))