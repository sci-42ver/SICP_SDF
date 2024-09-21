(define (merge! x y less?)
  (let ((xroot (cons '() x))
        (yroot (cons '() y)))
    (define (iter ans)
      (cond ((and (null? (cdr xroot)) (null? (cdr yroot))) ; only match the case of both original inputs are nil due to the following 2 conditions.
             ans)
            ;; based on the following 2 changes and "choose", ! won't mess up with each other.
            ((null? (cdr xroot))
             (append! (reverse! (cdr yroot)) ans))
            ((null? (cdr yroot))
             (append! (reverse! (cdr xroot)) ans) ; change the rest of x and return x ptr.
             )
            ((less? (cadr xroot) (cadr yroot))
             (let ((current (cdr xroot)))
               (set-cdr! xroot (cdr current)) ; choose the rest of x.
               (set-cdr! current ans) ; change the first elem of the current x ref in xroot.
               (iter current)))
            (else
              (let ((current (cdr yroot)))
                (set-cdr! yroot (cdr current))
                (set-cdr! current ans)
                (iter current)))))
    (cond ((null? x) y)
          ((null? y) x)
          (else 
            (reverse! (iter '())) ; change x / y.
            ))))
