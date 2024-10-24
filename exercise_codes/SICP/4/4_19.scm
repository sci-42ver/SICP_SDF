(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "4_16.scm")

;; Based on "... keep the evaluation order"
(define (make-set! var val)
  (list 'set! var val))
;; This replacement mechanism won't work for wiki example
;; > may break our program and result in undefined behavior:
(define (scan-out-defines-simultaneous body)
  ;;; same as 4.16.
  ;; similar to woofy's collect
  (define (iter rest args-init body-with-set!)
    (if (null? rest)
      (cons args-init body-with-set!)
      (let ((exp (car rest)))
        (if (definition? exp)
          (let ((var (definition-variable exp))
                (val (definition-value exp)))
            ;; Not use append as dzy's and xxyzz repo. Just reverse at last as master's. IMHO the latter has the better complexity.
            (iter (cdr rest) 
              ;; see repo. Notice to quote again to return quote expr when evaluated.
              (cons (list var ''*unassigned*) args-init) 
              (cons (make-set! var val) body-with-set!)))
          (iter (cdr rest) 
              args-init
              (cons exp body-with-set!))))))
  ;; added
  (define (primitive-replace-val var-val-pairs exp)
    (let ((pair (assq exp var-val-pairs)))
      (if pair
        (cadr pair)
        exp)))
  (define (replace-val var-val-pairs body whether-in-val)
    (if (not (pair? body))
      ;; This will have weird behavior maybe due to the env.
      ; (primitive-replace-val var-val-pairs exp)
      (if whether-in-val
        (primitive-replace-val var-val-pairs body)
        body)
      (map 
        (lambda (exp)
          (if (assignment? exp)
            (make-set! (assignment-variable exp) (replace-val var-val-pairs (assignment-value exp) #t))
            (replace-val var-val-pairs exp whether-in-val)))
        body)))
  ; (trace primitive-replace-val)
  ; (trace replace-val)
  (let ((args-and-body (iter body nil nil))
        ;; Since we need to check all definitions to find one appropriate, we need 2 iters.
        ;; 1 to get all var-val pairs, 2 to then replace when necessary.
        ;; For simplicity, I use 2 iters for the 1st.
        (var-val-pairs 
          (map (lambda (exp)
            ;; to use assoc.
            (list (definition-variable exp) (definition-value exp))) 
          (filter definition? body))))
    ;; add one wrapper.
    (make-let (reverse (car args-and-body)) (replace-val var-val-pairs (reverse (cdr args-and-body)) #f))))

(scan-out-defines-simultaneous 
  '((define b (+ a x))
    (define a 5)
    (+ a b)))
;Value: (let ((b (quote *unassigned*)) (a (quote *unassigned*))) (set! b (+ 5 x)) (set! a 5) (+ a b))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; letrec won't work
;; https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Lexical-Binding.html#index-letrec-1
;; > the inits are evaluated in the extended environment (in some unspecified order)
; (letrec ((b (+ a 10))
;          (a 5))
;   b)

