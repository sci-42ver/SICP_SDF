;; > Write a procedure fringe that takes as argument a tree (represented as a list) and 
;; > returns a list whose elements are all the *leaves* of the tree arranged in *left-to-right order*.


;; This is similar to "Yes, there is a better way"
;; 1. But doesn't use `(cons first (fringe (cdr tree)))`.
;; `(null? tree)` functions same as `(not (pair? lst))` here since `lst` can't be number when recursively calling `fringe`.
;; 2. ` (fringe 3)  ;; fails, as it should.` is not considered here since we assume the first lst is list.

(define (fringe lst)
  (if (pair? lst)
    (let* ((first_elem (car lst))
           (to_append_first_elem
             ;; first_elem may be nil hinted by Nico de Vreeze
             ; (if (pair? first_elem)
             (if (list? first_elem)
               (fringe first_elem)
               (list first_elem))))
      (append to_append_first_elem (fringe (cdr lst))))
    lst))

;; from Adam Stanton
(define test-lst (list (list (list 1 2 3 19 283 38) 2 3 2) (list 2 3 (list 217 382 1827) 2 187 (list 2838)) 2 1 2 (list 2 (list 3 (list 3)) 23 2 1 238)))
; (((1 2 3 19 283 38) 2 3 2) (2 3 (217 382 1827) 2 187 (2838)) 2 1 2 (2 (3 (3)) 23 2 1 238))
(define fringed-test-lst '(1 2 3 19 283 38 2 3 2 2 3 217 382 1827 2 187 2838 2 1 2 2 3 3 23 2 1 238) )

(define test-lst-with-empty '(1 2 3 (4 5) 6 () (((7 (8 9) (()) 10) 11) 12)))
(define fringed-test-lst-with-empty '(1 2 3 4 5 6 7 8 9 10 11 12))

(define x (list (list 1 2) (list 3 4)))
(fringe x)
(fringe (list x x))

(define (test)
  (assert (equal? fringed-test-lst (fringe test-lst)))
  (assert (equal? fringed-test-lst-with-empty (fringe test-lst-with-empty))))
(test)

;; wiki "A solution which I found that happens to be similar to the one from enumerate-tree"
(define (fringe x) 
  (define (fringe-recur x result) 
    (cond ((null? x) 
           result) 
          ;; fails for `(fringe (list 1 (list 2 3)))`
          ; ((not (pair?  (car x)))
          ((not (pair? x))
           (list x))
          (else 
            ;; append from left to right.
            (fringe-recur (cdr x) (append result (fringe-recur (car x) (list ))))) )) 
  (fringe-recur x (list )))
(fringe x)
(fringe (list 1 (list 2 3)))
(test)

;; musiXelect
(define nil '()) 
(define (fringe ls) 
  (define (helper ls result)
    (cond ((null? ls) result) 
          ((not (pair? ls)) (cons ls result)) 
          (else (append (helper (car ls) result) (helper (cdr ls) result))))) 
  (helper ls nil))
(fringe (list 2 (list 1 (list 2 3))))
(test)

;; vpraid
(define (fringe x) 
  (define (collect stack acc) 
    (if (null? stack) 
      acc 
      (let ((top (car stack))) 
        (cond 
          ((null? top) 
           ; (newline)
           ; (display stack)
           (collect (cdr stack) acc))
          ((not (pair? top)) (collect (cdr stack) (cons top acc))) 
          (else 
            (if (null? (car top))
              ; (begin
              ;   (newline)
              ;   (display "weird top:")
              ;   (display top)
              ;   )
              (display ""))
            (collect (cons (car top) 
                           ;; here `(cdr top)` may be nil.
                           (cons (cdr top) (cdr stack))) 
                     acc))))))
  ; (trace collect)
  (reverse (collect (list x) nil)))
(test)

;; madhur95
(define (fringe lst) 
  ; iter succesively reduces the inputted list by cdr ing it 
  (define (iter lst f is-outer-list?)  
    ; f keeps record of the leaves using cons and succesive application of itself 
    ; list of leaves is formed by applying f to nil when finally original list has  
    ; been cdr ed into empty. 
    ; is-outer-list? ensures nil is applied only once to make final list, is #t for  
    ; outermost list and #f for any sub-lists found within the original list  
    (cond ((null? lst) (if is-outer-list? 
                         (f lst) 
                         f)) 
          ; edge case
          ((null? (car lst))
           (iter (cdr lst)  
                 f
                 is-outer-list?))
          ; ((not (pair? lst)) lst) 
          ; if first element is a leaf, add it to the function
          ((not (pair? (car lst)))
           (iter (cdr lst)  
                 (lambda (x) (f (cons (car lst) x)))  
                 is-outer-list?)) 
          ; otherwise add all the leaves of first element to the function 
          (else (iter (cdr lst)  
                      (iter (car lst) f #f)  
                      is-outer-list?)) 
          )) 
  (if (not (pair? lst))
    (list lst)
    (iter lst (lambda (x) x) #t)))
(test)
; (assert (equal? fringed-test-lst (fringe test-lst)))
