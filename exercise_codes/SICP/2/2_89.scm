;; wrong for `mul-term-by-all-terms` case.

;; See meteorgan's where adjoin-term is based on the book coeff order from higher to lower orders when from left to right.
;; `(=zero? (coeff term))` drops the term since it is with the higher order.
(define (adjoin-term term term-list)
  ;; always keep the zero coeff
  (cons term term-list))

;; unchanged
(define (the-empty-termlist) '())
(define (first-term term-list) (car term-list))
(define (rest-terms term-list) (cdr term-list))
(define (empty-termlist? term-list) (null? term-list))

;; TODO order depends on L, then `(order t1)` etc. also needs to be changed.
(define (make-term coeff) coeff)
; (define (order term) (car term))

;; based on `mul-terms` etc. all manipulate only the first term's order.
;; similar to meteorgan's explicit manipulation for `first-term`.
(define (order term L) (- (length L) 1))
(define (coeff term) term)