(define (make-mobile left right)
  (list left right))
(define (make-branch length structure)
  (list length structure))
;; a
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (cadr mobile))

(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (cadr branch))

;; b
;; See wiki `(null? mobile)`.
;; Also see "I prefer to factor out the code".
(define (total-weight mobile)
  (if (number? mobile)
    mobile
    (+ (total-weight (branch-structure (left-branch mobile))) 
      (total-weight (branch-structure (right-branch mobile))))))

;; Test from wiki
(define a (make-mobile (make-branch 2 3) (make-branch 2 3))) 
(assert (= 6 (total-weight a))) ;; 6 

;; c
(define (mobile-balanced? mobile)
  (define (torque branch)
    (* (total-weight (branch-structure branch)) (branch-length branch)))
  (if (number? mobile)
    #t
    (let ((lbr (left-branch mobile))
        (rbr (right-branch mobile)))
      (and
        (= (torque rbr) (torque lbr))
        (mobile-balanced? (branch-structure lbr))
        (mobile-balanced? (branch-structure rbr))))))

;; from wiki
(define d (make-mobile (make-branch 10 a) (make-branch 12 5))) 
;; Looks like: ((10 ((2 3) (2 3))) (12 5)) 

(assert (mobile-balanced? d))

;; d 
;; Just change selectors.