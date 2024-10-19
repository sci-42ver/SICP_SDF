;; similar to 4_9.scm `let loop`. see https://small.r7rs.org/attachment/r7rs.pdf p71 or https://people.csail.mit.edu/jaffer/r5rs/Derived-expression-type.html
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
(do ((loop (make-vector 5))
      (i 0 (+ i 1)))
    ((= i 5) loop)
   (vector-set! loop i i))

;; https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Pattern-Language.html#index-syntax_002drules
;; > pattern variables that occur in the template are *replaced* by the subforms they match in the input.
(letrec
  ((loop
    (lambda (loop i)
      (if (= i 5)
          (begin
            (if #f #f)
            loop)
          (begin
            (vector-set! loop i i)
            (loop loop (+ i 1)))))))
  (loop (make-vector 5) 0))

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