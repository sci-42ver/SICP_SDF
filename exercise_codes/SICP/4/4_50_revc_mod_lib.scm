(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lib/amb/amb-lib.scm")

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
        ;; added
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

;; added https://stackoverflow.com/a/4297432/21294350
(define null '())
(define (qsort e leq-proc)
  (if (or (null? e) (<= (length e) 1)) e
      (let loop ((left null) (right null)
                   (pivot (car e)) (rest (cdr e)))
            (if (null? rest)
                ;; all have been put. Then qsort sublist's.
                (append (append (qsort left leq-proc) (list pivot)) (qsort right leq-proc))
               ;; put elements in left/right.
               (if (leq-proc (car rest) pivot)
                    (loop (append left (list (car rest))) right pivot (cdr rest))
                    (loop left (append right (list (car rest))) pivot (cdr rest)))))))

;;; sort pmf with probability in descending order, and return its CDF  
(define (distribution pmf) 
  ;; modify sort interface.
  (let* ((sorted-pmf (qsort pmf (lambda (x y) (<= (cadr x) (cadr y))))) 
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
  (define (loop pairs) 
    (if (eq? choice (caar pairs))
        ;; modified
        (delete (car pairs) pmf) 
        (loop (cdr pairs)))) 
  (loop pmf)) 

;; added
(define binary-map
  (lambda (proc items1 items2)
    (define (iter proc items1 items2)
      (if (null? items1)
        '()
        (cons (proc (car items1) (car items2))
              (binary-map proc (cdr items1) (cdr items2)))))
    (if (not (= (length items1) (length items2)))
      (error (list "wrong arg" items1 items2))
      (iter proc items1 items2))
    ))

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define (analyze-ramb exp)
  (let ((pmf (ramb-pmf exp))) 
    (lambda (env succeed fail) 
      (define (try-next pmf)
        ;; Here we use the-default-succeed etc since otherwise succeed will propagate back to (driver-loop) earlier without continue running.
        (let* ((probs 
                (map 
                  (lambda (x) 
                    ; (display "run map")
                    ((pmf-probability x) env the-default-succeed the-default-fail)
                    )
                  pmf))
              ;; modified
              (total-prob (accumulate +  0 probs)) 
              ;; with prob value instead of prob-proc.
              (new-pmf (binary-map (lambda (x y) (list (car x) y)) pmf probs)) 
              (cdf (distribution new-pmf))) 
          (if (null? pmf) 
              (fail) 
              (let ((choice (car (select cdf total-prob)))) ; select a choice in running rather analyzing. 
                (choice env 
                        succeed 
                        (lambda () 
                          (try-next (remove-choice choice pmf)))))))) 
      (try-next pmf)))) 

;; not needed since (amb) is just to abort. So amb is also fine.
; (ambeval '(define (require p) 
;             (if (not p) (ramb))) 
;           the-global-environment 
;           the-default-succeed the-default-fail) 

; (ambeval '(define (an-integer-between low high) 
;             (require (<= low high)) 
;             (ramb (<Prob> low 1) (<Prob> (an-integer-between (+ low 1) high) (- high low)))) 
;           the-global-environment 
;           the-default-succeed the-default-fail)

