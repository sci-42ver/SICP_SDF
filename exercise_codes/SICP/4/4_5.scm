(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lib.scm")

(define (alternative? sequence)
  (tagged-list? sequence '=>))
(define (recipient clause)
  (caddr clause))

(define (expand-clauses clauses)
  (if (null? clauses)
    'false                          ; no else clause
    (let ((first (car clauses))
          (rest (cdr clauses)))
      (if (cond-else-clause? first)
        (if (null? rest)
          (sequence->exp (cond-actions first))
          (error "ELSE clause isn't last -- COND->IF"
                 clauses))
        ;; see zxymike93's. We should "*the value* of the <test>, I eval it before making it an expression.".
        ;; x3v's and zxymike93's tests all are based on eval which needs lookup-variable-value.
        (make-if (cond-predicate first)
                 ;; modified
                 (let ((seq (cond-actions first)))
                   (if (alternative? seq)
                     ;; see http://community.schemewiki.org/?sicp-ex-4.4 LisScheSic's 1st comment to avoid expanding if to avoid recalculation when do early eval for predicate.
                     ;; see wiki we should return one expression instead of eval'ing it here.
                     ;  ((recipient first) (cond-predicate first))
                     (list (recipient first) (cond-predicate first))
                     (sequence->exp seq)))
                 (expand-clauses rest))))))

(define (test)
  (assert 
    (equal?
      '(if (assoc (quote b) (quote ((a 1) (b 2)))) (cadr (assoc (quote b) (quote ((a 1) (b 2))))) (if (= 3 3) (quote match) false))
      (expand-clauses
        '(((assoc 'b '((a 1) (b 2))) => cadr)
          ((= 3 3) 'match)
          (else false))))))
(test)

;; aos's modification
(define (expand-clauses clauses) 
  (if (null? clauses) 
      'false ; no else clause 
      (let ((first (car clauses)) 
            (rest (cdr clauses))) 
        (if (cond-else-clause? first) 
            (if (null? rest) 
                (sequence->exp 
                  (cond-actions first)) 
                (error "ELSE clauses isn't 
                        last: COND->IF" 
                        clauses)) 
        (make-if (cond-predicate first) 
          (if (eq? (car (cond-actions first)) '=>) ; <---- here 
            ;; see make-lambda where body implies ending with '(). So better to use list.
            (list (cadr (cond-actions first)) 
                  (cond-predicate first)) 
            (sequence->exp (cond-actions first))) 
          (expand-clauses 
            rest))))))
(test)