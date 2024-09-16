;; Here I only give the predicted result of non-func.
(define (make-adder n)
  (lambda (x) (+ x n)))
(make-adder 3)
(assert (= 8 ((make-adder 3) 5)))
(define (f x) (make-adder 3))
(f 5)
(define g (make-adder 3))
(assert (= 8 (g 5)))
(define (make-funny-adder n)
  (lambda (x)
    (if (equal? x 'new)
      (set! n (+ n 1))
      (+ x n))))
(define h (make-funny-adder 3))
(define j (make-funny-adder 7))
(assert (= 8 (h 5)))
(assert (= 8 (h 5)))
(h 'new)
; n -> 4
(assert (= 9 (h 5)))
(assert (= 12 (j 5)))
(assert 
  (= 
    8
    (let ((a 3))
      (+ 5 a))))

(let ((a 3))
  (lambda (x) (+ x a)))
(assert 
  (= 
    8
    ((let ((a 3))
       (lambda (x) (+ x a)))
     5)))
(define s
  (let ((a 3))
    (lambda (msg)
      (cond ((equal? msg 'new)
             (lambda ()
               (set! a (+ a 1))))
            ((equal? msg 'add)
             (lambda (x) (+ x a)))
            (else (error "huh?"))))))
(s 'add)
(s 'add 5) ; error
(assert (= 8 ((s 'add) 5)))
(s 'new)
(assert (= 8 ((s 'add) 5)))
((s 'new))
(assert (= 9 ((s 'add) 5)))
(assert 
  (= 
    8
    ((lambda (x)
       (let ((a 3))
         (+ x a)))
     5)))
(define k
  (let ((a 3))
    (lambda (x) (+ x a))))
(assert (= 8 (k 5)))
(define m
  (lambda (x)
    (let ((a 3))
      (+ x a))))
(assert (= 8 (m 5)))
(define p
  (let ((a 3))
    (lambda (x)
      (if (equal? x 'new)
        (set! a (+ a 1))
        (+ x a)))))
(assert (= 8 (p 5)))
(assert (= 8 (p 5)))
(p 'new)
(assert (= 9 (p 5)))
(define r
  (lambda (x)
    (let ((a 3))
      (if (equal? x 'new)
        (set! a (+ a 1))
        (+ x a)))))
(assert (= 8 (r 5)))
(assert (= 8 (r 5)))
(r 'new)
(assert (= 8 (r 5)))
(define (ask obj msg . args)
  (apply (obj msg) args))
(assert (= 9 (ask s 'add 5)))
(ask s 'new)
(assert (= 10 (ask s 'add 5)))
(define x 5)
(assert 
  (= 
    ; 17 ; this is wrong since we don't use let*.
    12
    (let ((x 10)
          (f (lambda (y) (+ x y))))
      (f 7))))
(define x 5)
(assert 
  (= 
    17
    (let* ((x 10)
           (f (lambda (y) (+ x y))))
      (f 7))))
