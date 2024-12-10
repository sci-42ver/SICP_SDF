;; sc meaning -> syntactic-closure
;; https://people.csail.mit.edu/jaffer/slib/Syntactic-Closures.html
;; > A syntactic closure consists of a form, a syntactic environment, and a list of identifiers. 
;; > All identifiers in the form take their meaning from the syntactic environment, except those in the given list.
;; 0. form is just expression, see MIT_Scheme_Reference
;; > a macro transformer is a procedure that takes two arguments, a form and a syntactic environment
;; i.e. (lambda (exp env) ...)
;; OR just see "special form" https://groups.csail.mit.edu/mac/ftpdir/scheme-7.4/doc-html/scheme_3.html
;; > A special form is an expression that follows special evaluation rules. 
(define-syntax let1
  (sc-macro-transformer
    (lambda (exp env)
      (let ((id (cadr exp))
            (init (caddr exp))
            (exp (cadddr exp)))
        `((lambda (,id)
            ,(make-syntactic-closure env (list id) exp))
          ,(make-syntactic-closure env '() init))))))

;; https://stackoverflow.com/q/5304680/21294350
(define-syntax let1-error
  (sc-macro-transformer        
    (lambda (form env)
      (let* ((id  (cadr form))
             (init (make-syntactic-closure env '() (caddr form)))
             ; (exp (make-syntactic-closure env '(id) (cadddr form)))
             (exp (make-syntactic-closure env (list id) (cadddr form)))
             )
        ;; (pp `(id:,id))
        ;; (pp `(init:, init))
        ;; (pp `(exp:, exp))
        `((lambda (,id)
            ,exp) 
          ,init)))))
(let1-error a 1 (+ a 1))

;; try to use syntax-rules to implement the above

(define-syntax let1
  (syntax-rules ()
    ((let1 id init exp)
     ((lambda (id)
        exp) init))
    ))
(let1 a 1 (+ a 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  https://stackoverflow.com/a/75051562/21294350
;; it is to search outside
(define-syntax aif
  (sc-macro-transformer
    (lambda (exp env)
      (let ((test (make-syntactic-closure env '(it) (second exp)))
            ; (cthen (third exp))
            ; (cthen (make-syntactic-closure env '() (third exp)))
            (cthen (make-syntactic-closure env '(it) (third exp)))
            (celse (if (pair? (cdddr exp))
                     (make-syntactic-closure env '(it) (fourth exp))
                     #f)))
        `(let ((it ,test))
           (if it ,cthen ,celse))))))

(let ((i 4)
      (it (cons 1 2)))
  (aif (memv i '(2 4 6 8))
       (car it)))
;; captured by the output form, i.e. that created by let in the transformer.
;; > All the identifiers used in form, except those explicitly excepted by free-names, obtain their meanings from environment.
;; So it obtains from (it ,test) instead of (it (cons 1 2)).
;; IMHO i.e. get value from transformer environment https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/SC-Transformer-Definition.html
; 4

;; here we need no extra literal
(define-syntax aif
  (syntax-rules ()
    ((aif test cthen)
      (let ((it test))
           (if it cthen #f)))
    ((aif test cthen celse)
      (let ((it test))
           (if it cthen celse)))))

(let ((i 4)
      (it (cons 1 2)))
  (aif (memv i '(2 4 6 8))
       (car it)))
;; it in the caller has no connection with it in the template. Also see "loop" context in https://stackoverflow.com/q/79098453/21294350
; 1
;; won'e be expanded as since MIT/GNU Scheme will differentiate it's at different locations appropriately as the above comment says.
(let ((i 4)
      (it (cons 1 2)))
  (let ((it (memv i '(2 4 6 8))))
    (if it (car it) #f)))
; 4
