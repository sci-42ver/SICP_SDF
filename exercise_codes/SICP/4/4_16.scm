(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "../lib.scm")
(load "4_7.scm") ; include let definition in 4.6

;; The following has the wrong understanding of
;; > we ``scan out'' and eliminate all the internal definitions in the body.
;; So when ⟨e3⟩ has define, we also need to eliminate that.

;; As the book says
;; > internally defined names have truly simultaneous scope
;; So we need "all the internal definitions" in only one frame together.


;; similar to eval-sequence
(define (scan-out-defines body)
  ;; > Thus, some programs that don't obey this restriction will in fact run in such implementations.
  (define (warp expr)
    (cons 'wrap expr))
  (define (find-define-ending! rest wrap-return-rest)
    (define (set-rest-body-and-return-nil rest)
      (set-cdr! wrap-return-rest rest)
      nil)
    (if (null? rest)
      ;; all are define.
      (set-rest-body-and-return-nil rest)
      (let ((cur-expr (car rest)))
        (if (definition? cur-expr)
          (cons cur-expr (find-define-ending (cdr rest) wrap-return-rest))
          (set-rest-body-and-return-nil rest)))))
  (let ((rest-body '*unassigned*)
        (define-seq (find-define-ending! body (warp rest-body))))
    (let* ((definition-lst-seq (map (lambda (expr) (list (definition-variable expr) (definition-value expr))) define-seq))
           (args (map (lambda (lst) (cons ((car lst) '*unassigned*))) definition-lst-seq))
           (set!-seq (map (lambda (lst) (cons 'set! lst)) definition-lst-seq)))
      (make-let args (append set!-seq rest-body)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; scan out *all* and keep the evaluation order
;; > then set to their values by assignment.
;; Doesn't say about reordering, so both are fine by footnote 24 "leaves implementors some choice".
(define (scan-out-defines body)
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
              (cons (list 'set! var val) body-with-set!)))
          (iter (cdr rest) 
              args-init
              (cons exp body-with-set!))))))
  (let ((args-and-body (iter body nil nil)))
    (make-let (reverse (car args-and-body)) (reverse (cdr args-and-body)))))

(scan-out-defines '((define a 1) (define b 2) (+ a b)))
;Value: (let ((a (quote *unassigned*)) (b (quote *unassigned*))) (set! a 1) (set! b 2) (+ a b))
(scan-out-defines '((define a 1) (define b 2) (+ a b) (define c 2)))
;Value: (let ((a (quote *unassigned*)) (b (quote *unassigned*)) (c (quote *unassigned*))) (set! a 1) (set! b 2) (+ a b) (set! c 2))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; woofy
(define (make-let bingings body) 
    (cons 'let (cons bingings body))) 

(define (make-assignment var exp) 
    (list 'set! var exp)) 

(define (scan-out-defines body) 

    (define (collect seq defs exps) 
        (if (null? seq) 
            (cons defs exps) 
            (if (definition? (car seq)) 
                (collect (cdr seq) (cons (car seq) defs) exps) 
                (collect (cdr seq) defs (cons (car seq) exps))))) 

    (let ((pair (collect body '() '()))) 
        (let ((defs (car pair)) (exps (cdr pair))) 
            (make-let (map (lambda (def)  
                                (list (definition-variable def)  
                                      '*unassigned*)) 
                          defs) 
                      (append  
                        (map (lambda (def)  
                                (make-assignment (definition-variable def) 
                                                (definition-value def))) 
                            defs) 
                        exps)))))
;; trivially not use reverse and reorder to keep set! together.
(scan-out-defines '((define a 1) (define b 2) (+ a b)))
;Value: (let ((b *unassigned*) (a *unassigned*)) (set! b 2) (set! a 1) (+ a b))
(scan-out-defines '((define a 1) (define b 2) (+ a b) (define c 2)))
;Value: (let ((c *unassigned*) (b *unassigned*) (a *unassigned*)) (set! c 2) (set! b 2) (set! a 1) (+ a b))