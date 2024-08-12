(load "deriv_lib.scm")
;; a
;; input: '(x + (3 * (x + (y + 2))))
;; for simplification, here I assume "parenthesized" is implied and we drop parentheses, so we just 

;; The following is same as AA's.
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))

(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+)))

(define (addend s) (car s))

(define (augend s) (caddr s))

;; product is similar

;; b
;; input: '(x + 3 * (x + y + 2))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (append a1 '(+) a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list m1 '* m2))))

;; Here sum? is searched first. So if this is false, it just means "product" since only +/* are considered here.
(define (sum? x)
  (and (pair? x) (memq '+ x) #t))

(define (lst->elem lst)
  (if (= 1 (length lst))
    (car lst)
    lst))

(define (prefix symbol expr)
  ; (let ((prefix-lst
  ;         (cdr
  ;           (fold 
  ;             (lambda (elem res) 
  ;               (cond 
  ;                 ((eq? elem symbol) (append (list symbol) res))
  ;                 ((and (not (null? res)) (eq? symbol (car res))) res)
  ;                 (else (append res (list elem)))))
  ;             '()
  ;             expr))))
  ;   (lst->elem prefix-lst))
  (lst->elem 
    (let loop ((res '())
                (rest-expr expr))
      (if (eq? symbol (car expr))
        res
        (append res (list (car expr))))))
)
; (trace prefix)
; (trace addend)

(define (addend s) (prefix '+ s))

(define (augend s) 
  (let ((augend-lst (cdr (memq '+ s))))
    (lst->elem augend-lst)))

(define (product? x)
  (and (pair? x) (not (sum? x)) (memq '* x) #t))

;; since we have removed addition, car must be multiplier
(define (multiplier p) (car p))

; (define (multiplicand p) (caddr p))
;; The above is wrong since we may have multiple multiplications.

; (define (multiplier expr) 
;   (define (iter expr result) 
;         (if (eq? (car expr) '*) 
;           result 
;           (iter (cdr expr) (append result (list (car expr)))))) 
;   (let ((result (iter expr '()))) 
;     (if (= (length result) 1) 
;         (car result) 
;         result)))
(define (multiplicand expr) 
  (let ((result (cdr (memq '* expr)))) 
    (if (= (length result) 1) 
        (car result) 
        result))) 

(trace deriv)
(define (test)
  (assert (= 4 (deriv '(x + 3 * (x + y + 2)) 'x)))
  (assert (= 1 (deriv '(x + 3) 'x)))
  ; (deriv '(x * y * (x + 3)) 'x)
  ; (deriv '((x * y) * (x + 3)) 'x)
  ; (deriv '(x * (y * (x + 3))) 'x)
  (assert (equal? '((x * y) + (y * (x + 3))) (deriv '(x * y * (x + 3)) 'x)))
  (assert (equal? '((x * y) + (y * (x + 3))) (deriv '((x * y) * (x + 3)) 'x)))
  (assert (equal? '((x * y) + (y * (x + 3))) (deriv '(x * (y * (x + 3))) 'x)))
  )
; (test)
(trace make-product)
(deriv '(x * y * (x + 3)) 'x)

;; sgm
(define (sum? expr) 
  (eq? '+ (smallest-op expr))) 

(define (product? expr) 
  (eq? '* (smallest-op expr)))

(load "conventional_interfaces_lib.scm")
(define (smallest-op expr) 
  (accumulate (lambda (a b)
                ;; base case: the rightmost number is passed upwards and then the adjacent operator is passed upwards by `a`.
                ;; Then we just 
                (if (operator? b) 
                    (min-precedence a b) 
                    a)) 
              'maxop 
              expr))

(define *precedence-table* 
  '( (maxop . 10000) 
    (minop . -10000) 
    (+ . 0) 
    (* . 1) )) 

(define (operator? x) 
  (define (loop op-pair) 
    (cond ((null? op-pair) #f) 
          ((eq? x (caar op-pair)) #t) 
          (else (loop (cdr op-pair))))) 
  (loop *precedence-table*)) 

(define (min-precedence a b)
  (if (operator? a)
    (if (precedence<? a b) 
      a 
      b)
    b)) 

(define (precedence<? a b) 
  (< (precedence a) (precedence b))) 

(define (precedence op) 
  (define (loop op-pair) 
    (cond ((null? op-pair) 
          (error "Operator not defined -- PRECEDENCE:" op)) 
          ((eq? op (caar op-pair)) 
          (cdar op-pair)) 
          (else 
          (loop (cdr op-pair))))) 
  (loop *precedence-table*))

(define (singleton? lst)
  (= 1 (length lst)))

(define (augend expr) 
  (let ((a (cdr (memq '+ expr)))) 
    (if (singleton? a) 
        (car a) 
        a))) 

(define (prefix sym list) 
  (if (or (null? list) (eq? sym (car list))) 
      '() 
      (cons (car list) (prefix sym (cdr list))))) 

(define (addend expr) 
  (let ((a (prefix '+ expr))) 
    (if (singleton? a) 
        (car a) 
        a)))

(define (make-sum a1 a2) 
  (cond ((=number? a1 0) a2) 
        ((=number? a2 0) a1) 
        ((and (number? a1) (number? a2)) 
        (+ a1 a2)) 
        (else (list a1 '+ a2)))) 

(define (multiplier expr) 
  (let ((m (prefix '* expr))) 
    (if (singleton? m) 
        (car m) 
        m))) 

(define (multiplicand expr) 
  (let ((m (cdr (memq '* expr)))) 
    (if (singleton? m) 
        (car m) 
        m))) 

(define (make-product m1 m2) 
  (cond ((=number? m1 1)  m2) 
        ((=number? m2 1)  m1) 
        ((or (=number? m1 0) (=number? m2 0))  0) 
        ((and (number? m1) (number? m2)) 
        (* m1 m2)) 
        (else (list m1 '* m2))))

(deriv '(x + 3 * (x + y + 2)) 'x)
(test)