;; 96
;; a 
(define (pseudoremainder-terms a b) 
  (let* ((o1 (order (first-term a))) 
        (o2 (order (first-term b))) 
        (c (coeff (first-term b))) 
        (divident (mul-terms (list (make-term 0  
                                        (expt c (+ 1 (- o1 o2))))) 
                              a))) 
    (cadr (div-terms divident b)))) 

(define (gcd-terms a b) 
  (if (empty-termlist? b) 
    a 
    (gcd-terms b (pseudoremainder-terms a b)))) 

;; b 
(define (gcd-terms a b) 
  (if (empty-termlist? b) 
    (let* ((coeff-list (map cadr a)) 
          (gcd-coeff (apply gcd coeff-list))) 
      (div-terms a (list (make-term 0  gcd-coeff))))
    (gcd-terms b (pseudoremainder-terms a b)))) 

;; 97
;; See wiki Sphinxsky's.
(define (integerizing-factor-term a b)
  (let* ((o1 (order (first-term a))) 
        (o2 (order (first-term b))) 
        (c (coeff (first-term b))))
        ;; see wiki better to use generic operations.
        (make-term 0 (expt c (+ 1 (- o1 o2))))))
(define (reduce-terms a b)
  (let* ((gcd-term-list (gcd-terms a b))
        ; integerizing factor
        (factor (integerizing-factor-term a b))
        (num-denom (list a b))
        (intermediate-a-b 
          (map 
            ;; wiki: lacks car to get quotient.
            (lambda (term-list) (div-terms (mul-term-by-all-terms factor term-list) gcd-term-list))
            num-denom))
        (final-factor 
          (apply gcd 
            (apply append 
              (map 
                (lambda (term-list) 
                  (map coeff term-list))
                intermediate-a-b)))))
    (map (lambda (termlist) (div-terms termlist (list (make-term 0 final-factor)))) num-denom)
    ))

(define (reduce-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
      (map 
        (lambda (termlist) 
          (make-poly 
            (variable p1)
            termlist))
        (reduce-terms (term-list p1) (term-list p2)))
      (error "Polys not in same var -- REDUCE-POLY"
             (list p1 p2))))

;; b
(define (reduce-integers n d)
  (let ((g (gcd n d)))
    (list (/ n g) (/ d g))))

;; put ...

(define (reduce n d)
  (apply-generic 'reduce n d))

;; wrong one is list the other is cons
(define (make-rat n d)
  (reduce n d))