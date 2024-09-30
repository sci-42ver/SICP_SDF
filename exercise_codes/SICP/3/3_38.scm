;; http://community.schemewiki.org/?sicp-ex-3.38
(define cnt 1) 
(define (execute-list lst) 
  (display cnt) 
  (display ":") 
  (set! cnt (inc cnt)) 
  (define (iter lst)
    (if (null? lst) 
      (newline) 
      (begin ((car lst)) (iter (cdr lst))))) 
  (iter lst)) 

(define (factorial n) 
  (if (= n 0) 1 (* n (factorial (dec n))))) 

(define balance 100) 
(define (make-person) 
  (define mybalance 100) 
  (define (access) 
    (set! mybalance balance)) 
  (define (deposit x) 
    (set! mybalance (+ mybalance x))) 
  (define (withdraw x) 
    (set! mybalance (- mybalance x))) 
  (define (withdraw-half) 
    (set! mybalance (/ mybalance 2))) 
  (define (sync) 
    (set! balance mybalance)) 
  (define (check) 
    (display mybalance) 
    (newline)) 
  (define (dispatch m) 
    (cond ((eq? m 'access) access) 
          ((eq? m 'deposit) deposit) 
          ((eq? m 'withdraw) withdraw) 
          ((eq? m 'withdraw-half) withdraw-half) 
          ((eq? m 'sync) sync) 
          ((eq? m 'check) check))) 
  dispatch) 

(define petter (make-person)) 
(define paul (make-person)) 
(define mary (make-person)) 

(define petter-seq (list (petter 'access) (lambda () ((petter 'deposit) 10)) (lambda () ((petter 'sync))))) 
(define paul-seq (list (paul 'access) (lambda () ((paul 'withdraw) 20)) (lambda () ((paul 'sync))))) 
(define mary-seq (list (mary 'access) (lambda () ((mary 'withdraw-half))) (lambda () ((mary 'sync))))) 

(define result '())
;; result is all possible sequences.
(define (interleave petter paul mary temp) 
  (if (and (null? petter) 
           (null? paul) 
           (null? mary)) 
    (set! result (cons (reverse temp) result))) 
  (if (not (null? petter)) 
    (interleave (cdr petter) paul mary (cons (car petter) temp))) 
  (if (not (null? paul)) 
    (interleave petter (cdr paul) mary (cons (car paul) temp))) 
  (if (not (null? mary)) 
    (interleave petter paul (cdr mary) (cons (car mary) temp)))) 

(interleave petter-seq paul-seq mary-seq '()) 
;; reset for the next sequence.
; (define (in) (display balance) (set! balance 100)) 
;; changed
(define balance-lst '())
(define (in) 
  (if (memq balance balance-lst)
    'duplicated
    (begin
      (set! balance-lst (cons balance balance-lst))
      (display balance)))
  (set! balance 100)) 

(define op (map (lambda (x) (append x (list in))) result)) 

;; added
(define (inc x)
  (+ x 1))

(for-each execute-list op) 
(display balance-lst)
