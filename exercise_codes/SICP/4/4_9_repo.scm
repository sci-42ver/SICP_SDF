;; from book
(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))

(define (last-exp? seq) (null? (cdr seq)))
(define (first-exp seq) (car seq))
(define (sequence->exp seq)
  (cond ((null? seq) seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))))
(define (make-begin seq) (cons 'begin seq))

;; 
(define null '())
(define (make-define id expr)
  (cons 'define (cons id expr)))

(define (do->combination exp)
  (let ((var-list (map car (cadr exp)))
        (init-list (map cadr (cadr exp)))
        (intermediate-step-list (map cddr (cadr exp)))
        (stop?-expr (caaddr exp))
        (finish-expr (cdaddr exp))
        (expr (cdddr exp)))
    (let ((step-list 
            (map 
              (lambda (var step) 
                (if (null? step)
                  var
                  (car step))) 
              var-list intermediate-step-list)))
      (list
        (make-lambda null
                      (list
                        (make-define
                          (cons 'loop var-list)
                          (list
                            (make-if stop?-expr
                                    (sequence->exp finish-expr)
                                    (sequence->exp
                                      (append expr
                                              (list (cons 'loop
                                                          step-list)))))))
                        (cons 'loop init-list)))))))

(assert 
  (equal? 
    (do->combination 
      '(do ((loop (make-vector 5))
            (i 0 (+ i 1)))
          ((begin 
            (set! test loop)
            (= i 5)) (list loop test))
        (vector-set! loop i i)))
    '((lambda () 
      (define (loop loop i) 
        (if (begin (set! test loop) (= i 5)) 
          (list loop test) 
          (begin (vector-set! loop i i) (loop loop (+ i 1))))) 
      (loop (make-vector 5) 0)))))

;; here we doesn't redefine do at all. We just show the derived expression.
; (define test (vector))
; (assert 
;   (equal? 
;     (do ((loop (make-vector 5))
;           (i 0 (+ i 1)))
;         ((begin 
;           (set! test loop)
;           (= i 5)) (list loop test))
;       (vector-set! loop i i))
;     '(#(0 1 2 3 4) #(0 1 2 3 4))))