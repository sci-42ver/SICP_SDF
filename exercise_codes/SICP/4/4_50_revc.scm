;;; Exercise 4.50 

(define the-default-succeed (lambda (value fail) value)) 
(define the-default-fail (lambda () 'fail)) 

(define (analyze exp) 
  (cond ((self-evaluating? exp) 
        (analyze-self-evaluating exp)) 
        ((quoted? exp) (analyze-quoted exp)) 
        ((variable? exp) (analyze-variable exp)) 
        ((assignment? exp) (analyze-assignment exp)) 
        ((definition? exp) (analyze-definition exp)) 
        ((if? exp) (analyze-if exp)) 
        ((lambda? exp) (analyze-lambda exp)) 
        ((begin? exp) (analyze-sequence (begin-actions exp))) 
        ((cond? exp) (analyze (cond->if exp))) 
        ((let? exp) (analyze (let->combination exp))) ;** 
        ((amb? exp) (analyze-amb exp))                ;** 
        ((ramb? exp) (analyze-ramb exp))              ;** 
        ((application? exp) (analyze-application exp)) 
        (else 
        (error "Unknown expression type -- ANALYZE" exp)))) 

;;; Extended syntax for ``ramb`` is as follows: 
;;; (ramb expr ...) 
;;; expr ::= value-expr 
;;;      || (<Prob> value-expr prob-expr) 
;;; NOTE: The probability here tends to be a proportion of likelihood. 
;;; The first type of expr has ZERO probability. 
;;; The probability of the second type is the value of prob-expr. 
;;; The total probability is the sum of the probabilities of all expr. 

(define (ramb? exp) (tagged-list? exp 'ramb)) 
(define (ramb-choices exp) (map 
                            (lambda (x) 
                              (if (and (pair? x) (eq? (car x) '<Prob>)) (cadr x) x)) 
                            (cdr exp))) 

(define (ramb-probabilities exp) (map 
                                  (lambda (x) 
                                    (if (and (pair? x) (eq? (car x) '<Prob>)) (caddr x) 0)) 
                                  (cdr exp))) 

;;; pmf: Probability Mass Function 
;;; return a list of pairs consisiting of a choice(variable) and a probability. 
(define (ramb-pmf exp) (map list (map analyze (ramb-choices exp)) (map analyze (ramb-probabilities exp)))) 
(define (pmf-variable pair) (car pair)) 
(define (pmf-probability pair) (cadr pair)) 

(define (cdf-variable pair) (car pair)) 
(define (cdf-probability pair) (cadr pair)) 

;;; Cumulative Distribution Function 
;;; return a list of pairs consisting of choice(variable) and a cumulative probability. 
(define (CDF pmf) 
  (let loop ((cumulation 0) 
            (choices-probs pmf) 
            (ans '())) 
    (if (null? choices-probs) 
        (reverse ans) 
        (let ((new-cumulation (+ cumulation (pmf-probability (car choices-probs))))) 
          (loop new-cumulation 
                (cdr choices-probs) 
                (cons (list (pmf-variable (car choices-probs)) new-cumulation) ans)))))) 

;;; sort pmf with probability in descending order, and return its CDF  
(define (distribution pmf) 
  (let* ((sorted-pmf (sort (lambda (x y) (> (cadr x) (cadr y))) pmf)) 
        (cdf (CDF sorted-pmf))) 
    cdf)) 

;;; select the first variable if its cumulative probability > r 
(define (select-with-random cdf r) 
  (if (< r (cdf-probability (car cdf))) 
      (car cdf) 
      (select-with-random (cdr cdf) r))) 

;;; if the total probability n is ZERO, then select a variable with the same possibility, 
;;; otherwise generate a number between 0 and n - 1 and then call select-with-random. 
(define (select cdf n) 
  (if (= n 0) 
      (list-ref cdf (random (length cdf))) 
      (select-with-random cdf (random n)))) 

(define (remove-choice choice pmf) 
  (define (loop pair) 
  (if (eq? choice (caar pair)) 
      (remove (car pair) pmf) 
      (loop (cdr pair)))) 
  (loop pmf)) 

(define (analyze-ramb exp) 
  (let ((pmf (ramb-pmf exp))) 
    (lambda (env succeed fail) 
      (define (try-next pmf) 
        ;; Here implies (pmf-probability x) must work by the-default-...?
        (let* ((probs (map (lambda (x) ((pmf-probability x) env the-default-succeed the-default-fail)) 
                          pmf)) 
              (total-prob (apply-in-underlying-scheme + probs)) 
              ;; with prob value instead of prob-proc.
              (new-pmf (map (lambda (x y) (list (car x) y)) pmf probs)) 
              (cdf (distribution new-pmf))) 
          (if (null? pmf) 
              (fail) 
              (let ((choice (car (select cdf total-prob)))) ; select a choice in running rather analyzing. 
                (choice env 
                        succeed 
                        (lambda () 
                          (try-next (remove-choice choice pmf)))))))) 
      (try-next pmf)))) 

(ambeval '(define (require p) 
            (if (not p) (ramb))) 
          the-global-environment 
          the-default-succeed the-default-fail) 

(ambeval '(define (an-integer-between low high) 
            (require (<= low high)) 
            (ramb (<Prob> low 1) (<Prob> (an-integer-between (+ low 1) high) (- high low)))) 
          the-global-environment 
          the-default-succeed the-default-fail) 

;;;;;;;;;;;;;;; 
;;;; test;;;;;; 
;;;;;;;;;;;;;;; 
;;; Amb-Eval input: 
(an-integer-between 1 10) 

;;; Starting a new problem 
;;; Amb-Eval value: 
4 

;;; Amb-Eval input: 
(an-integer-between 1 10) 

;;; Starting a new problem 
;;; Amb-Eval value: 
2 

;;; Amb-Eval input: 
(an-integer-between 1 10) 

;;; Starting a new problem 
;;; Amb-Eval value: 
10 

;;; Amb-Eval input: 
(an-integer-between 1 10) 

;;; Starting a new problem 
;;; Amb-Eval value: 
2 

;;; Amb-Eval input: 
(an-integer-between 1 10) 

;;; Starting a new problem 
;;; Amb-Eval value: 
8 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;help with Alyssa’s problem;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

(define (an-element-of items) 
  (require (not (null? items))) 
  (ramb (car items) (an-element-of (cdr items)))) 

(define (generate-word word-list) 
  (require (not (null? *unparsed*))) 
  (let ((word (an-element-of (cdr word-list)))) 
    (set! *unparsed* (cdr *unparsed*)) 
    (list (car word-list) word))) 