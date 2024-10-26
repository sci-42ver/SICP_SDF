(cd "~/SICP_SDF/lecs/6.001_spring_2007_recitation/codes/rec19/source19")
(load "eval-code.scm")

(define (quote? exp)
  (tag-check exp 'quote))
(define (quote*? exp)
  (tag-check exp 'quote*))
(define (eval exp env)
  (cond
    ((number? exp) exp)
    ((symbol? exp) (lookup exp env))
    ((define? exp) (eval-define exp env))
    ((if? exp) (eval-if exp env))
    ((lambda? exp) (eval-lambda exp env))
    ((let? exp) (eval-let exp env))
    ;; added here due to being special form.
    ((quote? exp) 
     ;; https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Quoting.html#index-quasiquote
     `',(cadr exp)
     ; (let ((str (cadr exp)))
     ;   (car `(',str)))
     )
    ((quote*? exp) (cadr exp))
    ((application? exp) (apply* (eval (car exp) env)
                                (map (lambda (e) (eval e env))
                                     (cdr exp))))
    (else
      (error "unknown expression " exp))))

;; See sol. My above understanding is wrong by just outputing verbatim
(eval '(quote quote) GE)
(eval '(quote* quote) GE)
