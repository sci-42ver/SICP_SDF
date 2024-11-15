;; https://hipster.home.xs4all.nl/lib/scheme/gauche/define-syntax-primer.txt
(define-syntax emit-cwv-form
  (syntax-rules ()
    ((emit-cwv-form temps assignments values-form)
     (call-with-values (lambda () values-form)
       (lambda temps . assignments)))))

(define-syntax multiple-value-set!
  (syntax-rules ()
    ((multiple-value-set! variables values-form)
     (gen-temps-and-sets
         variables
         ()  ;; initial value of temps
         ()  ;; initial value of assignments
         values-form))))

; (define (gen-temps-and-sets variables temps assignments values-form)
;    (cond
;       ((null? variables)
;        (emit-cwv-form temps assignments values-form))

;       ((pair? variables) (let ((variable (car variables))
;                                (more     (cdr variables)))
;                            (gen-temps-and-sets
;                               more
;                               ;; https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Quoting.html#index-_002c_0040
;                               `(temp ,@ temps)
;                               `((set! ,variable temp) ,@ assignments)
;                                values-form)))))

(define a 0)
(define b 1)
(define c 2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; > collect them with the other temporaries and assignments.
(define-syntax gen-temps-and-sets
  (syntax-rules ()

    ((gen-temps-and-sets () temps assignments values-form)
     (emit-cwv-form temps assignments values-form))

    ((gen-temps-and-sets (variable . more) temps assignments values-form)
     (gen-temps-and-sets
        more
       (temp . temps)
       ((set! variable temp) . assignments)
       values-form))))
;; https://www.gnu.org/software/guile/manual/html_node/Multiple-Values.html
(multiple-value-set! (a b c) (values 1 2 3))
(list a b c)

;;; > The funny thing is, though, the code works.
; (call-with-values (lambda () 
;   ; (generate-values)
;   (values 3 2 1)
;   )
;   (lambda (temp temp temp)
;     (set! c temp)
;     (set! b temp)
;     (set! a temp)))
; (list a b c)
;Ill-formed syntax: (lambda (temp temp temp) (set! c temp) (set! b temp) (set! a temp))

;;; > It will be a *different* syntactic object than any created during any other *expansion step*.
;;; 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; > but to simulate APPEND:
; (define-syntax multiple-value-set!
;   (syntax-rules ()
;     ((multiple-value-set! variables values-form)

;      (gen-temps-and-sets
;          variables
;          ()  ;; initial value of temps
;          ()  ;; initial value of assignments
;          values-form))))

(define-syntax gen-temps-and-sets
  (syntax-rules ()

    ((gen-temps-and-sets () temps assignments values-form)
     (emit-cwv-form temps assignments values-form))

    ;; ... see
    ;; > Suppose our pattern is (foo var #t ((a . b) c) ...) and it is matched ...... This pattern would match:
    ;; where ... is only matched with `((a . b) c)`, i.e.
    ;; > The ... *operator* modifies how the *PREVIOUS* form is interpreted by the macro language.
    ((gen-temps-and-sets (variable . more) (temps ...) (assignments ...) values-form)
     (gen-temps-and-sets
        more
       ;; 
       (temps ... temp)
       (assignments ... (begin
                          (newline)
                          (display "Now assigning value ")
                          (display temp)
                          (display " to variable ")
                          (display 'variable)
                          (flush-output)
                          (set! variable temp)))
       values-form))))

(multiple-value-set! (a b c) (values 4 5 6))
(list a b c)