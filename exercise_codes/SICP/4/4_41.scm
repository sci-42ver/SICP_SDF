;; we can interleave map with filter as Exercise 4.40 does.
;; And also change the filtering order as Exercise 4.39 does.

;;; https://stackoverflow.com/a/5547174/21294350
;; 2 lists
(define concat/map
  (lambda (ls f)
    (cond
      ((null? ls) '())
      (else (append (f (car ls)) (concat/map (cdr ls) f))))))
(define combine
  (lambda (xs ys)
    (concat/map xs (lambda (x)
                     (map (lambda (y) (list x y)) ys)))))
;; n lists
(define combine*
  (lambda (xs . ys*)
    (cond
      ((null? ys*) (map list xs))
      ((null? (cdr ys*)) (combine xs (car ys*)))
      (else (concat/map xs (lambda (x)
                             (map (lambda (y) (cons x y))
                                  (apply combine* ys*))))))))

(define (iota-from-1 num)
  (map (lambda (x) (+ 1 x)) (iota num)))
; (define (all-combinations)
;   (apply combine* (make-list 5 (iota-from-1 5))))
; (all-combinations)

(cd "~/SICP_SDF/exercise_codes/SICP/4")
; (load "4_38.scm") ; will redefine apply...
(define (distinct? items)
  (cond ((null? items) true)
        ((null? (cdr items)) true)
        ((member (car items) (cdr items)) false)
        (else (distinct? (cdr items)))))

(define (multiple-dwelling)
  ;; as wiki shows, better to put locally.
  (define (all-combinations)
    (apply combine* (make-list 5 (iota-from-1 5))))
  ;; also see wiki Thomas's. We can give one more readable name for car etc like get-baker-floor etc.
  (let ((candidates (all-combinations))
        (filtering-list 
          (list
            (lambda (lst) (distinct? lst))
            (lambda (lst) (not (= (car lst) 5)))
            (lambda (lst) (not (= (cadr lst) 1)))
            (lambda (lst) (not (= (caddr lst) 1)))
            (lambda (lst) (not (= (caddr lst) 5)))
            (lambda (lst) (> (cadddr lst) (cadr lst)))
            ; (lambda (lst) (not (= (abs (- (car (cddddr lst)) (caddr lst))) 1)))
            (lambda (lst) (not (= (abs (- (caddr lst) (cadr lst))) 1)))
            )))
    (fold filter candidates filtering-list)))
(multiple-dwelling)
;; solutions for 4.38
;Value: ((1 2 4 3 5) (1 2 4 5 3) (1 4 2 5 3) (3 2 4 5 1) (3 4 2 5 1))