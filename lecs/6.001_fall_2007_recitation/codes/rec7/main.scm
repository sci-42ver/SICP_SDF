;; 1
(define (occurrences num lst)
  (length (filter (lambda (x) (= x num)) lst)))
(occurrences 1 (list 1 2 1 1 3))

;; lec
(define (fold-right op init lst)
  (if (null? lst)
    init
    (op (car lst)
        (fold-right op init (cdr lst)))))

; (define (occurrences num lst)
;   (fold-right (lambda (x lst) (if (= x num)
;                                 consequent
;                                 alternative)) 0 lst))

;; sol
(define (occurrences elm lst)
  (fold-right
    (lambda (a b)
      (+ (if (= a elm) 1 0)
         b))
    0
    lst))
(occurrences 1 (list 1 2 1 1 3))

;; 2 Hinted by 1 sol
(define (occurrences elm lst)
  (fold-right
    (lambda (a b)
      (+ 1
         b))
    0
    lst))

;; 4
(define (fold-right op init lst)
  (if (null? lst)
    init
    (op (car lst)
        (fold-right op init (cdr lst)))))
(define x '(1 2 3 4 5 6 7))
(define nil '())

;; (f)
;; Here from the last `nil`, return the last element. Then use `b` to propagate back.
(fold-right (lambda (a b) (if (null? b) (list a) b)) nil x)

;; (g)
(fold-right (lambda (a b) (cons a b)) nil x) ; This is wrong.

;; (h) from sol
(define (square x) (* x x))
(define (fold-left op init lst)
  (define (helper result rest_lst)
    (if (null? rest_lst)
      result
      (helper (op result (car rest_lst)) (cdr rest_lst))))
  (helper init lst))
; (fold-left (lambda (a b) (cons b a)) nil x)
; (fold-left (lambda (a b) (cons b (square a))) nil x) ; debugged using drracket which shows contract error.
(fold-left (lambda (a b) (cons (square b) a)) nil x) ; debugged using drracket which shows contract error.