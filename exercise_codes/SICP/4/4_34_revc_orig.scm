;; Exercise 4.34 

(define primitive-procedures 
  (list (list 'car-in-underly-scheme car)   ; preserved but renamed 
        (list 'cdr-in-underly-scheme cdr)   ; preserved but renamed 
        (list 'cons-in-underly-scheme cons) ; preserved but renamed 
        (list 'null? null?) 
        (list 'list list) 
        (list '+ +) 
        (list '- -) 
        (list '* *) 
        (list '/ /) 
        (list '= =) 
        (list 'newline newline) 
        (list 'display display) 
;;      more primitives 
        )) 

(define the-global-environment (setup-environment)) 

;;; represent pair of META-CIRCULAR as pair of SCHEME which is composed of a tag 'cons 
;;; and a lexical closure(i.e. a procedure of META-CIRCULAR). 
(eval '(define (cons x y) 
        (cons-in-underly-scheme 'pair? (lambda (m) (m x y)))) the-global-environment) 

(eval '(define (car z) 
        ((cdr-in-underly-scheme z) (lambda (p q) p))) the-global-environment) 

(eval '(define (cdr z) 
        ((cdr-in-underly-scheme z) (lambda (p q) q))) the-global-environment) 

;;; predicate that check if an object is a pair of META-CIRCULAR 
(define (meta-pair? object) 
  (tagged-list? object 'pair?)) 

;;; print pair of META-CIRCULAR 
(define (print-pair object) 

  (define counter 0)                    ; the number of pairs which were revisited 

  ;; use a pair as key and the correspoding number of revisited times as value 
  ;; when the recursion to CAR and CDR of some pair ends, check if VALUE > 0, 
  ;; change VALUE to counter, and then increment counter by 1 
  ;; NOTE: We do not add things which are not pair into hashtable 
  (define visited (make-hash-table)) 

  (define (put k v) (put-hash-table! visited k v))   ; an interface to visited for convenience 
  (define (get k) (get-hash-table visited k #f))     ; an interface to visited for convenience 
  (define (remove k) (remove-hash-table! visited k)) ; an interface to visited for convenience 

  ;; convert pair of META-CIRCULAR into pair of SCHEME for which we can handle more conveniently. 
  ;; The struct of converted pair is as follows: 

  ;;========================================================================== 

  ;; Printable-pair ::= ('be-referred-as Pair-of-META-CIRCULAR X Y)) 
  ;;                ||  ('refer-to Pair-of-META-CIRCULAR '*CAR* '*CDR*) 
  ;;                ||  ('just-pair Pair-of-META-CIRCULAR X Y) 
  ;;                ||  Not-pair 

  ;; X ::= #<Thunk CAR> 
  ;;   ||  Printable-pair 

  ;; Y ::= #<Thunk CDR> 
  ;;   ||  Printable-pair 

  ;;========================================================================== 

  (define (convert-printable-pair object) 

    ;; if object is evaluated-thunk, then return its value, otherwise return a tag like #<Thunk {alternative}> 
    (define (thunk-or-value object alternative) 
      (if (evaluated-thunk? object) 
          (convert-printable-pair (thunk-value object)) 
          (string-append "#<thunk " alternative ">"))) 

    ;; we visit some pair in visited table again, so change the its value to the desired string 
    (define (visit-again! object) 
      (put object (+ 1 (get object))) 
      (list 'refer-to object '*CAR* '*CDR*)) 

    (if (meta-pair? object) 
        (cond [(get object) (visit-again! object)]      ; visit again! return a string like "#{counter}" 
              [else 
              (put object 0)                           ; the first visit! 
              (let ([x (thunk-or-value (eval 'x (procedure-environment (cdr object))) "CAR")] 
                    [y (thunk-or-value (eval 'y (procedure-environment (cdr object))) "CDR")]) 
                (if (zero? (get object))                       ; no inner elements refer to it 
                    (begin 
                      (remove object)                          ; no tagging required 
                      (list 'just-pair object x y)) 

                    (begin 
                      (put object counter) 
                      (set! counter (+ counter 1))             ; increment counter 
                      (list 'be-referred-as object x y))))])   ; return the processed pair 
        object))                                                ; not pair, return directly 

  (define (be-referred? object) 
    (tagged-list? object 'be-referred-as)) 

  (define (referer? object) 
    (tagged-list? object 'refer-to)) 

  ;; print printable pair 
  ;; We need consider three cases: 
  ;; 1. a pair refers to its outer list, which will be printed as #{counter} where counter is the corresponding 
  ;; serial number of its outer list. 
  ;; 2. a pair is referenced by its inner elements, which will be printed as #{counter}=(X . Y) where counter is 
  ;; its serial number 
  ;; 3. a normal pair which does not refer to another pair and is not referenced by others, that will be printed 
  ;; as (X . Y) 
  ;; NOTE: if Y is a pair, then print-pair won't print the preceding ". "  and the parentheses enclosing it. 

  (define (print-pair pair with-paren) 
    (let* ([left (if with-paren "(" "")] 
          [right (if with-paren ")" "")] 
          [val (get (cadr pair))] 
          [x (list-ref pair 2)] 
          [y (list-ref pair 3)] 
          [tag (if val (string-append "#" (number->string val)) val)] 
          [middle (if (null? y) "" " ")]) 

      (cond [(be-referred? pair) (display tag) (display "=") (display left)] 
            [(referer? pair) (display tag) (display "#")] 
            [else (display left)]) 

      (cond [(not (referer? pair)) 
              (cond [(pair? x) (print-pair x #t)] 
                    [else (display x)]) 

              (display middle) 

              (cond [(be-referred? y) (print-pair y #t)] 
                    [(referer? y) (display ". ") (print-pair y #f)] 
                    [(pair? y) (print-pair y #f)] 
                    [(null? y) (display "")] 
                    [else y (display ". ") (display y)]) 

              (display right)] 
          ))) 

  (print-pair (convert-printable-pair object) #t)) 

(define (user-print object) 
  (cond [(meta-pair? object) (print-pair object)] ; the clause for pair of META-CIRCULAR 
        [(compound-procedure? object) 
        (display (list 'compound-procedure 
                        (procedure-parameters object) 
                        (procedure-body object) 
                        '<procedure-env>))] 
        [else (display object)])) 

;;; Exercise 4.34 additional procedures 
(eval '(define (list-ref items n) 
        (if (= n 0) 
            (car items) 
            (list-ref (cdr items) (- n 1)))) the-global-environment) 

(eval '(define (map proc items) 
        (if (null? items) 
            '() 
            (cons (proc (car items)) 
                  (map proc (cdr items))))) the-global-environment) 

(eval '(define (scale-list items factor) 
        (map (lambda (x) (* x factor)) 
              items)) the-global-environment) 

(eval '(define (add-lists list1 list2) 
        (cond ((null? list1) list2) 
              ((null? list2) list1) 
              (else (cons (+ (car list1) (car list2)) 
                          (add-lists (cdr list1) (cdr list2)))))) the-global-environment) 

(eval '(define ones (cons 1 ones)) the-global-environment) 

(eval '(define integers (cons 1 (add-lists ones integers))) the-global-environment) 

(eval '(define (for-each proc items) 
        (if (null? items) 
            'done 
            (begin (proc (car items)) 
                    (for-each proc (cdr items))))) the-global-environment) 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;; test ;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;;;;;;;;;;;;;; 
;;; ones ;;;;; 
;;;;;;;;;;;;;; 

;;; L-Eval input: 
ones 

;;; L-Eval value: 
(#<thunk CAR> . #<thunk CDR>) 

;;; L-Eval input: 
(car ones) 

;;; L-Eval value: 
1 

;;; L-Eval input: 
ones 

;;; L-Eval value: 
(1 . #<thunk CDR>) 

;;; L-Eval input: 
(cdr ones) 

;;; L-Eval value: 
#0=(1 . #0#) 


;;;;;;;;;;;;;;;;;; 
;;; integers ;;;;; 
;;;;;;;;;;;;;;;;;; 

;;; L-Eval input: 
(list-ref integers 3) 

;;; L-Eval value: 
4 

;;; L-Eval input: 
integers 

;;; L-Eval value: 
(1 2 3 4 . #<thunk CDR>) 

;;; L-Eval input: 
(list-ref integers 20) 

;;; L-Eval value: 
21 

;;; L-Eval input: 
integers 

;;; L-Eval value: 
(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 . #<thunk CDR>) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;  not cyclic but referenced ;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;; L-Eval input: 
(define s (cons 1 2)) 

;;; L-Eval value: 
ok 

;;; L-Eval input: 
(define w (cons s s)) 

;;; L-Eval value: 
ok 

;;; L-Eval input: 
(car s) 

;;; L-Eval value: 
1 

;;; L-Eval input: 
(cdr s) 

;;; L-Eval value: 
2 

;;; L-Eval input: 
(car w) 

;;; L-Eval value: 
(1 . 2) 

;;; L-Eval input: 
(cdr w) 

;;; L-Eval value: 
(1 . 2) 

;;; L-Eval input: 
w 

;;; L-Eval value: 
((1 . 2) 1 . 2) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;; list: special pair ;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;;; L-Eval input: 
(define lst '(1 2 3 4)) 

;;; L-Eval value: 
ok 

;;; L-Eval input: 
(for-each (lambda (x) (display x)) lst) 
1234 
;;; L-Eval value: 
done 

;;; L-Eval input: 
lst 

;;; L-Eval value: 
(1 2 3 4) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;; Multiplex cycle ;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

                                                  
                            e3                     
                    +-------|-------+             
                    |       |       |             
+------------------> |   +   |   +---------------+ 
|                    |   |   |       |           | 
|                    +---|---|-------+           | 
|                        |                       | 
|                        v                       v 
|              +-------|-------+                 3 
|           e2 |       |       |                   
|          +-> |   +   |   +-------------+         
|          |   |   |   |       |         |         
|          |   +---|---|-------+         |         
|          |       |                     |         
|          |  e1   v                     |         
|      +---|---|-------+                 |         
|      |   |   |       |                 v         
|      |   +   |   +   |                 2         
|      |       |   |   |                           
|      +-------|---|---+                           
|                  |                               
|                  |                               
|                  |                               
|                  |                               
+------------------+                               

;;; L-Eval input: 
(define c1 (cons 1 1)) 

;;; L-Eval value: 
ok 

;;; L-Eval input: 
(define c2 (cons c1 2)) 

;;; L-Eval value: 
ok 

;;; L-Eval input: 
(define c3 (cons c2 3)) 

;;; L-Eval value: 
ok 

;;; L-Eval input: 
(define c1 (cons c2 c3)) 

;;;;;; 
Skip the access section 
;;;;;; 

;;; L-Eval input: 
c1 

;;; L-Eval value: 
#0=((#0# . 2) (#0# . 2) . 3) 

;;; L-Eval input: 
c3 

;;; L-Eval value: 
#1=(#0=((#0# . #1#) . 2) . 3) 