(load "procedure-define.scm")
(display "FIXING-QUOTE-PROC-DEF.SCM ...") (newline)

; Handle (define* (proc-name param1 param2 ...) body)
; while disallowing the overriding of special forms.
(define (eval-procedure-define exp env)
  (let ((name   (first (second exp)))
        (params (cdr   (second exp)))
        (body   (third exp)))
    (if (memq name '(define* if* lambda* let* quote quote* set!*))
      'reserved-word-error
      (begin
        (table-put! (car env) name (make-compound params body env))
        'undefined))))

(eval '(define* x 10)           GE) ; -> undefined
(eval '(define* 'x 10)          GE) ; -> reserved-word-error
(eval '(define* (quote* x) 10)  GE) ; -> reserved-word-error
(eval '(define* (define* x) 10) GE) ; -> reserved-word-error
