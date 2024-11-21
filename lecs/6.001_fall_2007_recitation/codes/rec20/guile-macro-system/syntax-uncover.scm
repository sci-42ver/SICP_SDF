;; run in guile

;; https://www.gnu.org/software/guile/manual/html_node/Syntax-Case.html
(define-syntax aif
  (lambda (x)
    (syntax-case x ()
      ((_ test then else)
       ;; invoking syntax-case on the generated
       ;; syntax object to expose it to `syntax'
       (syntax-case (datum->syntax x 'it) ()
         (it
           #'(let ((it test))
               (if it then else)
              ;  (read-syntax it)
               )
          ; #'(read-syntax it)
          ))))))
(aif (getuid) (display it) (display "none"))

;; not run syntax
(define aif-syntax-transformer
  (lambda (x)
    (syntax-case x ()
      ((_ test then else)
       ;; invoking syntax-case on the generated
       ;; syntax object to expose it to `syntax'
       (syntax-case (datum->syntax x 'it) ()
         (it
           #'(let ((it test))
               (if it then else)
              ;  (read-syntax it)
               )
          ; #'(read-syntax it)
          ))))))
(define wrong-aif-syntax-transformer
  (lambda (x)
    (syntax-case x ()
      ((_ test then else)
       (let ((it (datum->syntax x 'it)))
         #'(let ((it test))
            (if it then else))
          )))))
;; unknown location: reference to pattern variable outside syntax form in form it
; (use-modules (system syntax))
; (define aif-syntax-transformer-extract-it
;   (lambda (x)
;     (syntax-case x ()
;       ((_ test then else)
;        ;; invoking syntax-case on the generated
;        ;; syntax object to expose it to `syntax'
;        (syntax-case (datum->syntax x 'it) ()
;          (it
;           ;  #''it
;           (let ((ignore ((lambda () (display (syntax-local-binding #'it))))))
;             #''it)
;           ; #'(read-syntax it)
;           ))))))

;; https://www.gnu.org/software/guile/manual/html_node/Annotated-Scheme-Read.html
(define input-syntax (call-with-input-string "(aif (getuid) (display it) (display 'none))" read-syntax))
; #<syntax:unknown file:1:0 (#<syntax:unknown file:1:1 aif> #<syntax:unknown file:1:5 (#<syntax:unknown file:1:6 getuid>)> #<syntax:unknown file:1:14 (#<syntax:unknown file:1:15 display> #<syntax:unknown file:1:23 it>)> #<syntax:unknown file:1:27 (#<syntax:unknown file:1:28 display> #<syntax:unknown file:1:36 (quote #<syntax:unknown file:1:37 none>)>)>)>
(newline)
(display (source-properties 'input-syntax))
(newline)
(define output-correct-syntax (aif-syntax-transformer input-syntax))
(display (caaadr output-correct-syntax))
(newline)
; (call-with-values (lambda () (values (caaadr output-correct-syntax))) read-syntax)
(display (source-properties (caaadr output-correct-syntax)))
(newline)
(display (source-properties (car output-correct-syntax)))
(newline)
;; The doc https://www.gnu.org/software/guile/manual/html_node/Syntax-Case.html#index-datum_002d_003esyntax
;; doesn't say how to inspect this syntax object.
;; But from how it is constructed, it *may* relates this syntax object with the input-syntax.
;; > Create a syntax object that wraps datum, within the lexical context corresponding to the identifier template-id.
;; Maybe this will shadow it in input-syntax. so we can use this syntax object #<syntax it> in input-syntax
;; So here 
;; 1. datum->syntax puts it into x part implied by the wrong part "(let ((it (datum->syntax x 'it)))"
;; > we want to introduce it in the context of the whole expression
;; 2. replaces it in the output with this new it (shown in the correct one).
(display (equal? (datum->syntax input-syntax 'it) (caaadr output-correct-syntax)))
(display (eqv? (datum->syntax input-syntax 'it) (caaadr output-correct-syntax)))
(newline)
(display (caaadr output-correct-syntax))
(newline)
(display (quote-syntax (caaadr output-correct-syntax)))
(newline)
(display (macroexpand (caaadr output-correct-syntax)))
(newline)
(display output-correct-syntax)
; (#<syntax:unknown file:26:14 let> ((#<syntax it> #<syntax:unknown file:1:5 (#<syntax:unknown file:1:6 getuid>)>)) (#<syntax:unknown file:27:16 if> #<syntax it> #<syntax:unknown file:1:14 (#<syntax:unknown file:1:15 display> #<syntax:unknown file:1:23 it>)> #<syntax:unknown file:1:27 (#<syntax:unknown file:1:28 display> #<syntax:unknown file:1:36 (quote #<syntax:unknown file:1:37 none>)>)>))
(newline)
(display (wrong-aif-syntax-transformer input-syntax))

; (newline)
; (display (aif-syntax-transformer-extract-it input-syntax))
