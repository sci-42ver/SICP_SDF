#lang sicp 

(#%require sicp-pict)

;; 2.48

(define (make-segment start end) 
  (list start end)) 

;; Selectors 

(define (start-segment segment) 
  (car segment)) 

(define (end-segment segment) 
  (cadr segment)) 

;; 2.49
(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))

;; a
(define outline-seg 
  (let ((bl (make-vect 0 0))
        (tl (make-vect 0 1))
        (tr (make-vect 1 1))
        (br (make-vect 1 0)))
    (list 
      (make-segment bl tl)
      (make-segment tl tr)
      (make-segment tr br)
      (make-segment br bl)
      )))

(define outline-painter (segments->painter segment-list))

;; the rest should be similar.