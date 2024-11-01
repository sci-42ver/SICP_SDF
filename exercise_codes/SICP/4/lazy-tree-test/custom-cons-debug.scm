; (define custom-cons cons)
(define (demo-tree)
  (custom-cons 0 
        (list 
          (custom-cons 1   
                (list 
                  (custom-cons 3 
                        (list 
                          (custom-cons 5 (list (custom-cons 7 '()) (custom-cons 8 '()))) 
                          (custom-cons 6 '()))) 
                  (custom-cons 4 '()))) 
          (custom-cons 2 '()))))
; (demo-tree)

(define-syntax custom-cons
  (syntax-rules ()
    (
    ;  (_ x y)
     (custom-cons x y)
    ;  (set! x y)
     (cons-stream x y)
     )))

(custom-cons 0 
  (list 
    (custom-cons 1   
          (list 
            (custom-cons 3 
                  (list 
                    (custom-cons 5 (list (custom-cons 7 '()) (custom-cons 8 '()))) 
                    (custom-cons 6 '()))) 
            (custom-cons 4 '()))) 
    (custom-cons 2 '())))

(demo-tree)

(custom-cons 0 
  (list 
    (custom-cons 1   
          (list 
            (custom-cons 3 
                  (list 
                    (custom-cons 5 (list (custom-cons 7 '()) (custom-cons 8 '()))) 
                    (custom-cons 6 '()))) 
            (custom-cons 4 '()))) 
    (custom-cons 2 '())))

(define list stream)
(custom-cons 0 
  (list 
    (custom-cons 1 '()) 
    (custom-cons 2 '())))
(custom-cons 0 
  (list 
    (custom-cons 1   
          (list 
            (custom-cons 3 
                  (list 
                    (custom-cons 5 (list (custom-cons 7 '()) (custom-cons 8 '()))) 
                    (custom-cons 6 '()))) 
            (custom-cons 4 '()))) 
    (custom-cons 2 '())))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; minimal
(define custom-cons cons)
(define (demo-tree)
  (custom-cons 0 1))
(define-syntax custom-cons
  (syntax-rules ()
    (
    ;  (_ x y)
     (custom-cons x y)
    ;  (set! x y)
     (cons-stream x y)
     )))
(custom-cons 0 1)
(demo-tree)
(custom-cons 0 1)