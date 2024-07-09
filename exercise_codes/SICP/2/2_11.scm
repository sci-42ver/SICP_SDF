;;; > Rewrite this procedure using Ben’s suggestion.
;; from book
(define (make-interval a b) (cons a b))
;; from Exercise 2.7
(define (upper-bound interval) (max (car interval) (cdr interval))) 
(define (lower-bound interval) (min (car interval) (cdr interval)))

(define (mul-interval x y)
  (let ((lx (lower-bound x))
        (ux (upper-bound x))
        (ly (lower-bound y))
        (uy (upper-bound x))
        (p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    ;; For simplicity, here I only change the arguments of min/max to show the differences.
    ;; TODO: by symmetry, assume each iterval has `a` cases. Then there are `a+a-1+...+1=(a+1)*a/2=9`. This has no integer solution.

    ;; See wiki. Here we think x,y are ordered. So we should solve `a*a=9`.
    ;; Here `(opposite-pair? a b)` should consider all pairs spanning zero.
    (cond (predicate1 consequent1)
          (predicate2 consequent2))(make-interval (min p1 p2 p3 p4)
          (max p1 p2 p3 p4))))

;;; > Engineers usually specify percentage tolerances on the parameters of devices, as in the resistor specifications given earlier.
;;; This is easier
(define (make-center-width c p) ; only this is changed
  (let ((w (* c p)))
    (make-interval (- c w) (+ c w))))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))
