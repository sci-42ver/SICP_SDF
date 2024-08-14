(load "2_17.scm")

(define (reverse lst)
  ;; Here there is no easy way to extract `butlast` of `lst`.
  ;; See wiki bmm's comment for how to do the above thing using `list-ref`.
  (if (null? lst)
    lst
    (cons (car (last-pair lst)) (reverse (cdr lst)))))

(reverse (list 1 4 9 16 25))

;; from wiki
(define nil '()) 

(define (reverse items) 
  (define (iter items result) 
    (if (null? items) 
      result 
      (iter (cdr items) (cons (car items) result)))) 

  (iter items nil))
(reverse (list 1 4 9 16 25))
