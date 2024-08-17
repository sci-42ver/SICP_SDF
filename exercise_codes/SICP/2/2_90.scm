;; > where we allowed both rectangular and polar representations.
;; similarly 3 installs.

(define (install-polynomial-package)
  ;; internal procedures
  ;; representation of poly

  ;; Here we should add the tag for term-list, similar to 2.77.
  (define (make-poly variable term-list)
    (cons variable term-list))
  (define (variable p) (car p))
  (define (term-list p) (cdr p))
  ;; representation of terms and term lists

  ;; continued on next page
  (define (add-terms L1 L2)
    (cond ((empty-termlist? L1) L2)
          ((empty-termlist? L2) L1)
          (else
            (let ((t1 (first-term L1)) (t2 (first-term L2)))
              (cond ((> (order t1) (order t2))
                     (adjoin-term
                       t1 (add-terms (rest-terms L1) L2)))
                    ((< (order t1) (order t2))
                     (adjoin-term
                       t2 (add-terms L1 (rest-terms L2))))
                    (else
                      (adjoin-term
                        (make-term (order t1)
                                   (add (coeff t1) (coeff t2)))
                        (add-terms (rest-terms L1)
                                   (rest-terms L2)))))))))
  (define (mul-terms L1 L2)
    (if (empty-termlist? L1)
      (the-empty-termlist L1)
      (add-terms (mul-term-by-all-terms (first-term L1) L2)
                 (mul-terms (rest-terms L1) L2))))
  (define (mul-term-by-all-terms t1 L)
    (if (empty-termlist? L)
      (the-empty-termlist L)
      (let ((t2 (first-term L)))
        (adjoin-term
          (make-term (+ (order t1) (order t2))
                     (mul (coeff t1) (coeff t2)))
          (mul-term-by-all-terms t1 (rest-terms L))))))

  ; (define (adjoin-term term term-list)
  ;   (if (=zero? (coeff term))
  ;       term-list
  ;       (cons term term-list)))

  ;; these changes are similar to repo "(define (empty-termlist? term-list) (apply-generic 'empty-termlist? term-list)) ...".
  ;; change 1
  (define (adjoin-term term term-list)
    ;; although here `(get 'adjoin-term (type-tag term-list))` returns #f if run. But this lambda func is not run when defining it.
    ;; So we can delay definition until `install-dense-polynomial-package`.
    ((get 'adjoin-term (type-tag term-list)) term term-list))
  ; (define (the-empty-termlist) '())
  ;; change 2
  ;; The above should also change
  ;; Here we doesn't use L for `(the-empty-termlist L)` since this doesn't abstract anything.
  (define (the-empty-termlist L) (attach-tag (type-tag term-list) '()))

  ;; change 3
  ; (define (first-term term-list) (car term-list))
  ;; Wiki: This is fine to be local since it is not used outside.
  (define (first-term term-list)
    (apply-generic 'first-term term-list))
  ;; change 4
  ;; at last rest-terms and empty-termlist?  are called for adjoin-term to give term-list.
  ; (define (rest-terms term-list) (cdr term-list))
  (define (rest-terms term-list) (attach-tag (type-tag term-list) (cdr term-list)))
  ;; change 5
  ;; See repo, we can use `apply-generic` to avoid directly calling `contents` here.
  ; (define (empty-termlist? term-list) (null? (contents term-list)))
  (define (empty-termlist? term-list) 
    (apply-generic 'empty-termlist? term-list))

  (define (make-term order coeff) (list order coeff))
  (define (order term) (car term))
  (define (coeff term) (cadr term))

  (define (add-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (add-terms (term-list p1)
                            (term-list p2)))
      (error "Polys not in same var -- ADD-POLY"
             (list p1 p2))))
  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (mul-terms (term-list p1)
                            (term-list p2)))
      (error "Polys not in same var -- MUL-POLY"
             (list p1 p2))))
  ;; interface to rest of the system
  (define (tag p) (attach-tag 'polynomial p))
  (put 'add '(polynomial polynomial) 
       (lambda (p1 p2) (tag (add-poly p1 p2))))
  (put 'mul '(polynomial polynomial) 
       (lambda (p1 p2) (tag (mul-poly p1 p2))))
  (put 'make 'polynomial
       (lambda (var terms) (tag (make-poly var terms))))
  (put 'order 'polynomial order)
  'done)
(install-polynomial-package)

(define (install-dense-polynomial-package)
  (define (first-term term-list) 
    (list (- (length term-list) 1) (car term-list)))

  (define (order term)
    ((get 'order 'polynomial) term))
  ;; others should be similar, e.g. coeff.

  (define (adjoin-term term term-list) 
    (let ((exponent (order term))
          (len (length term-list))) 
      (define (iter-adjoin times terms) 
        (cond ((=zero? (coeff term)) 
               terms)) 
        ((= exponent times) 
         (cons (coeff term) terms)) 
        (else (iter-adjoin (+ times 1)  
                           (cons 0 terms)))) 
      (iter-adjoin len term-list)))
  (put 'first-term '(dense) first-term)
  (put 'adjoin-term 'dense adjoin-term)

  ;; from repo
  (define (empty-termlist? term-list) (null? term-list))
  (put 'empty-termlist? 'dense empty-termlist?)
  )

;; sparse should be similar.
