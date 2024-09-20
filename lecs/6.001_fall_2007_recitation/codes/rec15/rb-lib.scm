;; 1
(define (make-ring! ring-list)
  (define (last-pair lst)
    (if (null? (cdr lst))
      lst
      (last-pair (cdr lst))))
  (or (pair? ring-list) (error "cannot ringify ()"))
  (set-cdr! (last-pair ring-list) ring-list)
  ring-list)
;; http://community.schemewiki.org/?sicp-ex-1.43
(define (compose f g) (lambda (x) (f (g x)))) 
(define (repeated f n) 
  (if (< n 1) 
    (lambda (x) x) 
    (compose f (repeated f (- n 1))))) 

;; lib
(define (rb-capacity-pair rb)
  (cdr rb))
(define (rb-number-filled-pair rb)
  (cddr rb))
(define (rb-next-read-pair rb)
  (cdddr rb))
(define (rb-next-fill-pair rb)
  (cddddr rb))
(define (rb-empty? rb)
  (if (not (ring-buffer? rb))
    (error "not a ring buffer")
    (= (car (rb-number-filled-pair rb)) 0)))
(define (rb-full? rb)
  (if (not (ring-buffer? rb))
    (error "not a ring buffer")
    (= (car (rb-number-filled-pair rb))
       (car (rb-capacity-pair rb)))))

;; added
(define (ring-buffer? rb)
  (and (pair? rb) (eq? (car rb) 'ring-buffer)))
