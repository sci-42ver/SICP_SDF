(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
;;; Exercise 4.78 
(load "ch4-ambeval.scm")
(load "ch4-query.scm")

(define input-prompt ";;; Query input:") 
(define output-prompt ";;; Query results:") 

(define (qeval query frame succeed fail) 
  ((analyze query) frame succeed fail)) 

;;; predicates 
(define (and? query) (tagged-list? query 'and)) 
(define (or? query) (tagged-list? query 'or)) 
(define (not? query) (tagged-list? query 'not)) 
(define (lisp-value? query) (tagged-list? query 'lisp-value)) 

(define (analyze query) 
  ;; not consider 1. rule? related with always-true? 2. assertion?.
  (cond ((and? query) (analyze-and (contents query))) 
        ((or? query) (analyze-or (contents query))) 
        ((lisp-value? query) (analyze-lisp-value (contents query))) 
        ((not? query) (analyze-not (contents query))) 
        (else (analyze-simple query)))) 

;; analyze-lisp-value, analyze-negate, analyze-and are same as mine.
(define (analyze-lisp-value call) 
  (lambda (frame succeed fail) 
    (if (execute 
        (instantiate 
          call 
          frame 
          (lambda (v f) 
            (error "Unknown pat var -- LISP-VALUE" v)))) 
        (succeed frame fail) 
        (fail)))) 

(define (analyze-not operands) 
  (lambda (frame succeed fail) 
    ((analyze (negated-query operands)) 
    frame 
    (lambda (ext fail2) 
      (fail)) 
    (lambda () (succeed frame fail))))) 

(define (analyze-or disjuncts) 
  (lambda (frame succeed fail) 
    (define (try) 
      ((analyze (car disjuncts)) 
      frame 
      succeed 
      (lambda () 
        ((analyze-or (cdr disjuncts)) 
          frame succeed fail)))) 
    
    (if (empty-disjunction? disjuncts) 
        (succeed frame fail) 
        (try)))) 

(define (analyze-and conjuncts) 
  (lambda (frame succeed fail) 
    (define (try) 
      ((analyze (car conjuncts)) 
      frame 
      (lambda (ext fail2) 
        ((analyze-and (cdr conjuncts)) 
          ext succeed fail2)) 
      fail)) 
    
    (if (empty-conjunction? conjuncts) 
        (succeed frame fail) 
        (try)))) 

;;; rewritten 
(define (rule-body rule) 
  (if (null? (cddr rule)) 
      #f 
      (caddr rule))) 

;; added
(define (succeeded? ext-frame)
  (not (eq? ext-frame 'failed)))

;; underlying logic is same as mine.
(define (analyze-simple query) 
  (lambda (frame succeed fail) 
    (define (try-assertion assertions) 
      (if (stream-null? assertions) 
          (try-rule (fetch-rules query frame)) 
          (let ((ext (pattern-match query (stream-car assertions) frame)) 
                (fail2 (lambda () (try-assertion (stream-cdr assertions))))) 
            (if (succeeded? ext) 
                (succeed ext fail2) 
                (fail2))))) 

    (define (try-rule rules) 
      (if (stream-null? rules) 
          (fail) 
          (let* ((clean-rule (rename-variables-in (stream-car rules))) 
                (ext (unify-match query (conclusion clean-rule) frame)) 
                (fail2 (lambda () (try-rule (stream-cdr rules))))) 
            (if (succeeded? ext) 
                (if (rule-body clean-rule) 
                    (qeval (rule-body clean-rule) 
                          ext 
                          succeed fail2)
                    ;; always-true
                    (succeed ext fail2)) 
                (fail2))))) 
    
    (try-assertion (fetch-assertions query frame)) 
    )) 

(define (driver-loop) 
  (define (internal-loop try-again) 
    (prompt-for-input input-prompt) 
    (let ((q (query-syntax-process (read)))) 
      (cond 
      ;; ((eq? q '#!eof) 'goodbye!) 
      ((eq? q 'try-again) (try-again)) 
      ((assertion-to-be-added? q) 
        (add-rule-or-assertion! (add-assertion-body q)) 
        (newline) 
        (display "Assertion added to assertions base.") 
        (driver-loop)) 
      (else (newline) 
            (display ";;; Starting a new problem ") 
            (qeval q 
                    '()  ; an empty frame 
                    ;; ambeval success 
                    (lambda (val next-alternative) 
                      (announce-output output-prompt) 
                      (user-print 
                      (instantiate q 
                                    val 
                                    (lambda (v f) 
                                      (contract-question-mark v)))) 
                      (internal-loop next-alternative)) 
                    ;; ambeval failure 
                    (lambda () 
                      (announce-output 
                      ";;; There are no more values of") 
                      (user-print q) 
                      (driver-loop))))))) 
  (internal-loop 
  (lambda () 
    (newline) 
    (display ";;; There is no current problem") 
    (driver-loop)))) 

;; added
(driver-loop)
;;;;;;;;;;;;;;;;;;;;;; 
        ; test 
;;;;;;;;;;;;;;;;;;;;;; 

;;; Query input: 
(big-shot ?p ?q) 

;;; Starting a new problem 
;;; Query results: 
(big-shot (Aull DeWitt) administration) 

;;; Query input: 
try-again 

;;; Query results: 
(big-shot (Cratchet Robert) accounting) 

;;; Query input: 
try-again 

;;; Query results: 
(big-shot (Scrooge Eben) accounting) 

;;; Query input: 
try-again 

;;; Query results: 
(big-shot (Scrooge Eben) accounting) 


;;; Query input: 
(reverse (1 2 3) ?x) 

;;; Starting a new problem 
;;; Query results: 
(reverse (1 2 3) (3 2 1)) 


;;; Query input: 
(and (replace ?p2 ?p1) 
            (salary ?p1 ?s1) 
            (salary ?p2 ?s2) 
            (lisp-value > ?s2 ?s1)) 

;;; Starting a new problem 
;;; Query results: 
(and (replace (Hacker Alyssa P) (Fect Cy D)) (salary (Fect Cy D) 35000) (salary (Hacker Alyssa P) 40000) (lisp-value > 40000 35000)) 

;;; Query input: 
try-again 

;;; Query results: 
(and (replace (Warbucks Oliver) (Aull DeWitt)) (salary (Aull DeWitt) 25000) (salary (Warbucks Oliver) 150000) (lisp-value > 150000 25000)) 

;;; Query input: 
try-again 

;;; There are no more values of 
(and (replace (? p2) (? p1)) (salary (? p1) (? s1)) (salary (? p2) (? s2)) (lisp-value > (? s2) (? s1))) 

;; added
(assert! (married Minnie Mickey))
(assert! (married Randy Pooh))
(assert! (rule (married ?x ?y)
               (married ?y ?x)))
(or (married Mickey ?who1)
    (married Pooh ?who2)
    )
try-again
try-again

(or 
  ;; lisp-value
  (and (salary ?person ?amount)
    (lisp-value > ?amount 30000))
  ;; and, not
  (lives-near ?y (Bitdiddle Ben))
  )
try-again
try-again
try-again