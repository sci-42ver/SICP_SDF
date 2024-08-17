(load "set-lib.scm")
(define (poly-vars poly)
  (if (poly? poly)
    (if (every (lambda (term) (not (poly? term))) (term-list poly))
      (list (variable poly))
      (cons (variable poly) 
            (fold 
              (lambda (term res) (union-unordered-set (poly-vars term) res))
              '()
              (term-list poly))))
    '()))

(define (add-poly p1 p2)
  (cond 
    ((same-variable? (variable p1) (variable p2)) 
     (make-poly (variable p1)
                (add-terms (term-list p1)
                           (term-list p2))))
    ;; (intersection-unordered-set (poly-vars p1) (poly-vars p2)) is the order of variables.
    ;; Here we still need Coercion if we multiply poly with number etc.
    ((not (null? (intersection-unordered-set (poly-vars p1) (poly-vars p2))))
     )))

(define (poly-conversion-lst target-var-lst poly)
  ;; TODO 
  ;; My programming structure is a bit messy ...
  ;; I tried to transform poly first to (car target-var-lst) (*), then transform each term to (cadr target-var-lst) ... (recursively)
  ;; Then for (*) we first transform term-list to (car target-var-lst), then multiply each term with corresponding (variable poly)^(order term).

  ;; But this may cause invalid x^3*y for (((z)*y)*x^3) to transform to poly of z where
  ;; ((z)*y) -(1*y=y by Coercion)> ((y)*z)
  ;; Maybe x^3*y is solved by ordering to ((x^3)*y) in mul.

  ;; But anyway my recursion structure is not elegant.

  ;; After all, this is more about programming logic instead of programming strategy, so I skipped this exercise.
  (define (poly-conversion target-var poly cur-target-var-lst)
    (make-polynomial 
      target-var
      (map 
        (map 
          (lambda (term) (poly-conversion target-var term cur-target-var-lst))
          (term-list )))))
  )

(define (poly? term)
  (eq? 'polynomial (type-tag term)))

(define (term-conversion target-var term)
  (if (and (poly? term) ())

    term))
