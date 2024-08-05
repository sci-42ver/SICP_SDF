(load "2_18.scm")

(define (count-leaves x)
  (cond ((null? x) 0)  
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

;; This is very similar to jz's last `deep-reverse` which moves `(null? lst)` and `(else ...` to `(not (pair? x))`.
(define (deep-reverse lst)
  (cond 
    ;; the 1st is hinted by wiki jz
    ((not (pair? lst)) lst)
    ((= (count-leaves lst) (length lst)) (reverse lst))
    ;; notice "the list with its ele-ments reversed".
    ;; corrected based on jz
    ; (else (list (deep-reverse (cdr lst)) (deep-reverse (car lst))))))
    (else (append (deep-reverse (cdr lst)) (list (deep-reverse (car lst)))))))

(define x (list (list 1 2) (list 3 4)))
(assert (equal? '((4 3) (2 1)) (deep-reverse x)))

(define x (list (list 1 2) (list 3 (list 4 (list 4 5)))))
(assert (equal? '((((5 4) 4) 3) (2 1)) (deep-reverse x)))
(assert (equal? (list 3 2 1) (deep-reverse (list 1 2 3))))

;; ybsh
(define (deep-reverse l) 
  (define (rev l res) 
    (cond ((null? l) res) 
          ((not (pair? l)) l) 
          (else (rev (cdr l) 
                    (cons (rev (car l) 
                                '()) 
                          res))))) 
  (rev l '()))
(deep-reverse (list 1 2 3))

;; chessweb
(define (deep-reverse l) 
  (define atom? 
    (lambda (x) 
      (and (not (pair? x)) (not (null? x))))) 
  (define (reverse l) 
    (if (null? (cdr l)) 
        l  
        (append (reverse (cdr l)) (list (car l))))) 
  (cond 
    ((null? l) nil) 
    ((pair? (car l)) (append (deep-reverse (cdr l)) 
                            (list (deep-reverse (car l))))) 
    ((atom? (car l)) 
      ; (display "atom car -> reverse")
      (append (deep-reverse (cdr l)) (list (car l)))) 
    (else 
      (display "directly reverse")
      (reverse l))))
(deep-reverse (list 1 2 3))

;; rwitak
(define (deep-reverse items)
  ; (trace reverse)
  ; (trace deep-reverse)
  (if (pair? items) 
      (reverse (cons (deep-reverse (car items)) 
                    (reverse (deep-reverse (cdr items))))) 
      items))
(deep-reverse x)
(deep-reverse (list 1 2 3))
(deep-reverse (list 1 (list 2 3)))
(define (deep-reverse-wrong items)
  (if (pair? items) 
      (reverse (cons (deep-reverse-wrong (car items)) 
                    (deep-reverse-wrong (cdr items)))) 
      items))
(deep-reverse-wrong (list 1 2 3))