(define (last-pair items)
  (if (= (length items) 1)
    items
    (last-pair (cdr items))))
(define test_L (list 23 72 149 34))
(last-pair test_L)

;; See wiki kaiix's comment for pass of '() although unnecessary.

;; The above is same as jz's although without `rest`.

;; wiki FPaul's.
(define (lastPair L)  
  (define (ref lst x) 
    (if (= x 0) 
      (car lst) 
      (ref (cdr lst) (- x 1)))) 
  (if (=(length L)1) 
    (car L)  
    (cons (ref  L (- (length L) 2)) 
          (cons (ref L (- (length L) 1)) '()) 
          ) 
    ) 
  ) 
(lastPair test_L)
