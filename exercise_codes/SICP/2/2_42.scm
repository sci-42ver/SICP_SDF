(load "conventional_interfaces_lib.scm")
;; just return a list of row-idx's.
;; row-col-index:
;; \ 1 2 3
;; 1
;; 2
;; 3
(define (queens board-size)
  (define (queen-cols k)  
    (if (= k 0)
        (list empty-board)
        (filter
          (lambda (positions) (safe? k positions))
          (flatmap
            (lambda (rest-of-queens)
              (map (lambda (new-row)
                    (adjoin-position new-row k rest-of-queens))
                  (enumerate-interval 1 board-size)))
            (queen-cols (- k 1))))))
  (queen-cols board-size))

(define empty-board nil)

(define (adjoin-position new-row k rest-of-queens)
  (append rest-of-queens (list (list new-row k))))

(define (row pos)
  (car pos))

(define (col pos)
  (cadr pos))

(define (check-anti-diagonal pos-1 pos-2)
  (define (row-minus-col pos)
    (- (row pos) (col pos)))
  (not (= (row-minus-col pos-1) (row-minus-col pos-2))))

(define (check-diagonal pos-1 pos-2)
  (define (row-plus-col pos)
    (+ (row pos) (col pos)))
  (not (= (row-plus-col pos-1) (row-plus-col pos-2))))

(define (safe? k positions)
  (let* ((add-pos (list-ref positions (- k 1)))
         (add-pos-row (row add-pos))
         (rest-positions (remove add-pos positions)))
    (if (> k 1)
      (and 
        (accumulate (lambda (x y) (and (not (equal? (row x) add-pos-row)) y)) #t rest-positions)
        ; (accumulate (lambda (x y) (and (not (equal? (col x) (col add-pos))) y)) #t rest-positions)
        (accumulate (lambda (x y) (and (check-anti-diagonal x add-pos) y)) #t rest-positions)
        (accumulate (lambda (x y) (and (check-diagonal x add-pos) y)) #t rest-positions)
        )
      #t)))

;; https://en.wikipedia.org/wiki/Eight_queens_puzzle#Constructing_and_counting_solutions_when_n_=_8
(assert (= (length (queens 8)) 92))
(define my-found-queens (queens 8))
; (queens 10)

;; wiki x3v
(define (adjoin-position row col rest) 
  (cons (list row col) rest)) 

(define (check a b)    ; returns true if two positions are compatible 
  (let ((ax (car a))   ; x-coord of pos a 
        (ay (cadr a))  ; y-coord of pos a 
        (bx (car b))   ; x- coord of pos b 
        (by (cadr b))) ; y-coord of pos b 
    (and (not (= ax bx)) (not (= ay by))  ; checks col / row 
        (not (= (abs (- ax bx)) (abs (- ay by))))))) ; checks diag  

(define (safe? y) 
  (= 0 (accumulate + 0 
                  (map (lambda (x) 
                          (if (check (car y) x) 0 1)) 
                        (cdr y)))))

(define (queens board-size) 
  (define (queen-cols k) 
    (if (= k 0) 
      (list '()) 
      (filter 
        (lambda (positions) (safe? positions)) 
        (flatmap 
          (lambda (rest-of-queens) 
            (map (lambda (new-row) 
                  (adjoin-position 
                    new-row k rest-of-queens)) 
                (enumerate-interval 1 board-size))) 
          (queen-cols (- k 1)))))) 
  (queen-cols board-size)) 

(assert (= (length (queens 8)) 92))
(assert (equal? (map reverse my-found-queens) (queens 8)))

;; wiki anonymous
(define (queens n)
     (define (check-row p k)
        (define (iter k count)
           (cond ((= count (+ n 1)) true)
                 (else (if (or (= (abs (-  count
                                           k))
                                  (abs (- (list-ref p (- count 1))
                                          (list-ref p (- k 1)))))
                               (= (+ k
                                     (list-ref p (- k 1)))
                                  (+ count
                                     (list-ref p (- count 1)))))
                           false
                           (iter k (+ count 1))))))
        (iter k (+ k 1)))
     (define (check p)
         (define (iter p count)
            (cond ((= count n) true)
                  (else (if (not (check-row p count))
                            false
                            (iter p (+ count 1))))))
         (iter p 1))
     (filter (lambda (x) (check x))
             (permutations (enumerate-interval 1 n))))

; (queens 10)
;Aborting!: out of memory
;GC #130 13:43:19: took:   0.10 (100%) CPU,   0.10 (100%) real; free: 16747379
;GC #131 13:43:19: took:   0.10 (100%) CPU,   0.10  (90%) real; free: 16749405
;GC #132 13:43:19: took:   0.10 (100%) CPU,   0.10  (90%) real; free: 16749405

;; emj
(define (same-diag? p1 p2) 
  (= (abs (- (car p1) (car p2))) (abs (- (cdr p1) (cdr p2))))) 
  
(define (same-col? p1 p2) 
  (= (cdr p1) (cdr p2))) 

(define (same-row? p1 p2) 
  (= (car p1) (car p2))) 

(define (check-pos-pos? p1 p2) 
  (or (same-row? p1 p2) (same-col? p1 p2) (same-diag? p1 p2))) 
  
;; Add one candidate position to front of earlier  
;; solution (singular) for rest-of-queens 
(define (adjoin-position row col queens-config) 
  (cons (cons row col) queens-config)) 


;; rest-of-queens is a list of list queens-configs. Each queens-config is a 
;; solution for the columns checked so far. 

;; To keep things simple, assume a 3 by 3 board with two queens-cofig and  
;; last colum still to add 
(define rest-of-queens (list (list (cons 1 1) (cons 3 2)) (list (cons 3 1) (cons 1 2)))) 

;; Note there is no 3 queen solution to t 3 by 3 board.  
;; Use 3x3 for simple testing. 

;; Check if a single position works with a single queens configuration: 
(define (check-pos-config? pos queens-config) 
  (if (null? queens-config) 
      #f 
      (or (check-pos-pos? pos (car queens-config)) (check-pos-config? pos (cdr queens-config))))) 

(check-pos-config? (cons 2 4) (car rest-of-queens)) 