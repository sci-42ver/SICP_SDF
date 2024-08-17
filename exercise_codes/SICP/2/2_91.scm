;; mimic add-poly
(define (div-poly p1 p2)
  (if (and (same-variable? (variable p1) (variable p2)) (not (=zero? p2)))
    (map 
      (lambda (poly-term) (make-poly (variable p1) poly-term)) 
      (div-terms (term-list p1) (term-list p2)))
    (error "Polys not in same var -- ADD-POLY"
           (list p1 p2))))

;; L1/L2
(define (div-terms L1 L2)
  (if (empty-termlist? L1)
    (list (the-empty-termlist) (the-empty-termlist))
    (let ((t1 (first-term L1))
          (t2 (first-term L2)))
      (if (> (order t2) (order t1))
        (list (the-empty-termlist) L1)
        (let* ((new-c (div (coeff t1) (coeff t2)))
               (new-o (- (order t1) (order t2)))
               (new-term (make-term new-o new-c)) ; added
               )
          (let ((rest-of-result
                  ;; use 2.88
                  ;; `mul-term-by-all-terms` is more appropriate here.
                  (div-terms (add-terms L1 (negation (mul-terms L2 (list new-term)))) L2)
                  ))
            ;; wrong. we need to return "both the quotient and the remainder".
            ; (adjoin-term new-term rest-of-result)
            (list (adjoin-term new-term (car rest-of-result)) (cadr rest-of-result))
            ))))))
