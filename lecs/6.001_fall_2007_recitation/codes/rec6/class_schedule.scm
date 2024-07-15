;; rec
(define (make-units C L H)
  (list C L H))
(define get-units-C car)
(define get-units-L cadr)
(define get-units-H caddr)
(define (make-class number units)
  (list number units))
(define get-class-number car)
(define get-class-units cadr)
(define (get-class-total-units class)
  (let ((units (get-class-units class)))
    (+ (get-units-C units)
       (get-units-L units)
       (get-units-H units))))
(define (same-class? c1 c2)
  (= (get-class-number c1) (get-class-number c2)))

;; 1 both O(1)
(define (empty-schedule)
  '())

;; 2 both O(1)
(define (add-class class schedule)
  (cons class schedule))

;; 3 both O(n)*map complexity which may be O(n)
(define (total-scheduled-units sched)
  (define (sum_lst lst)
    (if (null? lst)
      0
      (+ (car lst) (sum_lst (cdr lst)))))
  (sum_lst (map get-class-total-units sched)))

;; 4 Assume `append` is O(1). Then helper/drop-class is time O(n) and space O(1).

;; See sol. `((null? sched) nil)` to consider the case where `classnum` is not in `sched`.
;; Here I use iter. So space O(1).
(define (drop-class sched classnum)
  (define (helper prev rest)
    (let ((cur (car sched)))
      (if (= (get-class-number cur) classnum)
        (append prev (cdr rest))
        (helper (append prev (list cur)) (cdr rest)))))
  (helper (empty-schedule) sched))

;; 5 time O(n^2) space O(1)

;; Sol uses \Theta based on the worst case.
;; `(total-scheduled-units sched)` has space \Theta(n).
(define (credit-limit sched max-credits)
  (if (>= (total-scheduled-units sched) max-credits)
    ;; See sol, here cdr is faster.
    (credit-limit (drop-class sched (get-class-number (car sched))) max-credits)
    sched))

(define test_units (make-units 1 2 3))
(define test_units (make-units 2 3 4))
(define test_schedule (list (make-class 100 test_units) (make-class 101 test_units)))
(add-class (make-class 102 test_units) test_schedule)
(total-scheduled-units test_schedule)
(drop-class test_schedule 100)
(credit-limit test_schedule 10)

;;; HOP
(define (make-student number sched-checker)
  (list number (list) sched-checker))
(define get-student-number car)
(define get-student-schedule cadr)
(define get-student-checker caddr)
(define (update-student-schedule student schedule)
  (if ((get-student-checker student) schedule)
    (list (get-student-number student)
          schedule
          (get-student-checker student))
    (error "invalid schedule")))

;; 6
(make-student 575904467 (lambda (sched) (not (null? sched))))

;; 7
(make-student 575904467 (lambda (sched) (<= (total-scheduled-units sched) 54)))

;; 8
(define (class-numbers schedule)
  (map get-class-number schedule))

;; 9
(define (drop-class sched classnum)
  (filter (lambda (class) (not (= (get-class-number class) classnum))) sched))

;; 10
;; TODO `total-scheduled-units` must iterate all so at least \Theta(n).
;; Then check all classes -> \Theta(n^2).

;; This is based on addition, so \Theta(n).
(define (credit-limit sched limit)
  (define (helper sched)
    (if (null? sched)
        (list (list) 0)
        (let ((res (helper (cdr sched))) ; This will be called recursively first.
              (newunits (get-class-total-units (car sched))))
          (if (< (+ newunits (cadr res)) limit)
            (list (add-class (car sched) (car res)) ; \Theta(1)
                  (+ newunits (cadr res)))
            res))))
  (car (helper sched)))
