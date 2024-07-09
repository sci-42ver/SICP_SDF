(define (make-interval a b) 
  (if (< a b) 
    (cons a b) 
    (cons b a))) 

(define (lower-bound interval) (car interval)) 
(define (upper-bound interval) (cdr interval)) 

(define (mul-interval x y) 
  (define (opposite-pair? a b) 
    (if (positive? a) 
      (negative? b) 
      (positive? b))) 

  (define (positive-pair? a b) 
    (if (opposite-pair? a b) 
      #f 
      (positive? a))) 

  (define (negative-pair? a b) 
    (if (opposite-pair? a b) 
      #f 
      (negative? a))) 
  (let        ((x0 (lower-bound x)) 
               (x1 (upper-bound x)) 
               (y0 (lower-bound y)) 
               (y1 (upper-bound y))) 
    (cond   ((negative-pair? x0 x1) 
             (cond   ((opposite-pair? y0 y1) 
                      (make-interval (* x0 y0) (* x0 y1))) 
                     ((negative-pair? y0 y1) 
                      (make-interval (* x1 y1) (* x0 y0))) 
                     (else 
                       (make-interval (* x1 y0) (* x0 y1))))) 
            ((positive-pair? x0 x1) 
             (cond   ((opposite-pair? y0 y1) 
                      (make-interval (* x1 y0) (* x1 y1))) 
                     ((negative-pair? y0 y1) 
                      (make-interval (* x1 y0) (* x0 y1))) 
                     (else 
                       (make-interval (* x0 y0) (* x1 y1))))) 
            (else 
              (cond   ((positive-pair? y0 y1) 
                       (make-interval (* x0 y1) (* x1 y1))) 
                      ((negative-pair? y0 y1) 
                       (make-interval (* x1 y0) (* x0 y0))) 
                      (else    
                        (make-interval 
                          ((lambda (a b) (if (< a b) a b)) (* x0 y1) (* x1 y0)) 
                          ((lambda (a b) (if (> a b) a b)) (* x0 y0) (* x1 y1)))))))))  

(define (generate-intervals) 
  (define test-list '()) 
  (define test-data 
    (cons (list 0 1 2 3 4 5 -6 -7 -8 -9 -10) 
          (list 5 4 3 2 1 0 -1 -2 -3 -4 -5))) 
  (for-each 
    (lambda (x) (set! test-list (append test-list x))) 
    (map    (lambda (x)     (map    (lambda (y) (make-interval x y)) 
                                    (cdr test-data))) 
            (car test-data))) 
  (cons test-list test-list)) 

(define test-intervals 
  (generate-intervals)) 

(define (test f g) 
  (define (interval-equals a b) 
    (and (= (lower-bound a) (lower-bound b)) (= (upper-bound a) (upper-bound b)))) 
  (for-each (lambda (x) 
              (for-each (lambda (y) 
                          (cond   ((interval-equals (f x y) (g x y)) #t) 
                                  (else 
                                    (newline) 
                                    (display x) (display y) 
                                    (newline) 
                                    (display (f x y)) (display (g x y)) 
                                    (newline)))) 
                        (cdr test-intervals))) 
            (car test-intervals))) 

(define (old-mul-interval x y) 
  (let            ((p1 (* (lower-bound x) (lower-bound y))) 
                   (p2 (* (lower-bound x) (upper-bound y))) 
                   (p3 (* (upper-bound x) (lower-bound y))) 
                   (p4 (* (upper-bound x) (upper-bound y)))) 
    (make-interval 
      (min p1 p2 p3 p4) 
      (max p1 p2 p3 p4)))) 

(test old-mul-interval mul-interval) 
