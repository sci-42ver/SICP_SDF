(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lib.scm")

(define unassigned '*unassigned*)

(cd "~/SICP_SDF/exercise_codes/SICP/2")
(load "2_28.scm")

(define (vars-is-contained? vars exp-)
    (define (iter vars exp-list) 
        (if (null? vars) 
            false 
            (if (memq (car vars) exp-list) 
                true 
                (iter (cdr vars) exp-list)))) 
    (iter vars (fringe exp-))) 


(define (sort-define defines) 
    (define (iter self other depend defs vars) 
        (if (null? defs) 
            (append self other depend) 
            (let* ((first (car defs)) 
                  (exp- (definition-value first))) 
                (cond ((self-evaluating? exp-) 
                        (iter (cons first self) other depend (cdr defs) vars)) 
                    ((vars-is-contained? vars exp-) 
                        (iter self other (cons first depend) (cdr defs) vars)) 
                    (else 
                        (iter self (cons first other) depend (cdr defs) vars)))))) 
    (iter '() '() '() defines (map definition-variable defines))) 



(define (scan-out-defines proc-body)
    ;; modified
    (let ((is-defines (filter definition? proc-body))) 
        (if (null? is-defines) 
            proc-body 
            (let* ((others (filter 
                                (lambda (exp-) 
                                    (not (definition? exp-))) 
                                proc-body)) 
                  (is-defines (sort-define is-defines)) 
                  (vars (map definition-variable is-defines)) 
                  (vals (map definition-value is-defines)) 
                  (bindings (map 
                                (lambda (var) 
                                    (make-combination var unassigned)) 
                                vars)) 
                  (sets (map make-set vars vals)) 
                  (new-body (append sets others))) 
                (list (make-let bindings new-body))))))

;; added
(define (make-combination left right)
  (list left right))
(define (make-set var val)
  (list 'set! var val))
(define (make-let args body) (cons 'let (cons args body)))

(scan-out-defines
  '((define (f x) 7) (define a 3) (define b a)))
;Value: ((let ((a *unassigned*) (f *unassigned*) (b *unassigned*)) (set! a 3) (set! f (lambda (x) 7)) (set! b a)))