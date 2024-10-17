;; https://www.geeksforgeeks.org/bash-scripting-until-loop/# is similar to do https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Iteration.html#index-do-2
;; where "test expression" functions as until.

(do ((vec (make-vector 5))
      (i 0 (+ i 1)))
    ((= i 5) vec)
   (vector-set! vec i i))
; becomes named let
;; > iterative processes can be expressed
;; IMHO the procedure name has no convenient to avoid name clash/shadow. Just use the normal loop name.
(let loop
  ;; > the init expressions are stored in the bindings of the variables, and then the iteration phase begins.
  ((vec (make-vector 5))
      (i 0))
  (if (= i 5) 
    vec
    (begin
      (vector-set! vec i i)
      ;; > the step expressions are evaluated in some *unspecified* order, the variables are bound to fresh locations, the results of the steps are stored in the bindings of the variables, and the next iteration begins.
      (loop vec (+ i 1)))))

;; similar to the above using loop. see https://small.r7rs.org/attachment/r7rs.pdf p71 or https://people.csail.mit.edu/jaffer/r5rs/Derived-expression-type.html
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

;; mimic cond->if.
(define (do-vars clauses)
  body)