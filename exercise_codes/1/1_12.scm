 ;; ex 1.12 

(define (pascal-triangle row col) 
  (cond ((> col row) 0) 
        ((< col 0) 0) 
        ((= col 1) 1) 
        ((+ (pascal-triangle (- row 1) (- col 1)) 
            (pascal-triangle (- row 1) col))))) 

;; Testing 
(pascal-triangle 1 1) 
(pascal-triangle 2 2) 
(pascal-triangle 3 2) 
(pascal-triangle 4 2) 
(pascal-triangle 5 2) 
(pascal-triangle 5 3) 

(trace pascal-triangle)
; (-1 0) -> 0 will end the recursion
(pascal-triangle 5 0)


;;; calculates nth row of pascal's triangle as a list
(define (pascal n)
  (define (p-row prev)
    (cond ((null? (cdr prev)) (list 1)) ; manipulates *first* for (1)
          ;; Here add one number each time, so at last we get one list, e.g. `(cons 1 (cons 10 (list 1 2 3)))`.
          ;; But `(cons (list 1 2 3) (list 1 2 3))` won't be that case.
          ((= 1 (car prev)) (cons 1 (cons (+ (car prev) (cadr prev)) (p-row (cdr prev))))) ; 
          (else (cons (+ (car prev) (cadr prev)) (p-row (cdr prev))))))
  (trace p-row)
  (trace cadr)
  (cond ((< n 1) (display "error: one or more rows"))
        ((= n 1) 1)
        ((= n 2) (list 1 1))
        (else (p-row (pascal (- n 1))))))
(pascal 9)
