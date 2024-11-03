(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "Lazy_Evaluation_lib.scm")

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
        (list 'iota iota) 
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
  ;; modified

  ; (define visited (make-hash-table))
  ; ;;;;;;;;; modify the interface
  ; (define (put k v) (hash-table-set! visited k v))   ; an interface to visited for convenience 
  ; (define (get k) (hash-table-ref/default visited k #f))     ; an interface to visited for convenience 
  ; (define (remove k) (hash-table-delete! visited k)) ; an interface to visited for convenience 
  (define visited (list))
  ;;;;;;;;; modify the interface
  (define (put k v) 
    (let ((val (assq k visited)))
      (if val 
        (set-cdr! val v)
        (set! visited (cons (cons k v) visited))))
    )   ; an interface to visited for convenience 
  (define (get k) 
    (let ((val (assq k visited)))
      (and val (cdr val))))     ; an interface to visited for convenience 
  ;; use the primitive remove in MIT/GNU Scheme.
  (define (delete k) (set! visited (remove (lambda (elm) (eq? k (car elm))) visited)))
  
  (define (convert-printable-pair object) 
    ; (bkpt "debug")
    ;; if object is evaluated-thunk, then return its value, otherwise return a tag like #<Thunk {alternative}> 
    (define (thunk-or-value object alternative) 
      (if (evaluated-thunk? object) 
        (begin
          ; (bkpt "debug")
          (convert-printable-pair (thunk-value object))) 
        (string-append "#<thunk " alternative ">"))) 

    ;; we visit some pair in visited table again, so change the its value to the desired string 
    (define (visit-again! object) 
      (put object (+ 1 (get object))) 
      (list 'refer-to object '*CAR* '*CDR*)) 

    (if (meta-pair? object)
      (begin 
      ; (bkpt "debug")
      (cond ((get object) 
              ; (bkpt "revisit") 
              (visit-again! object))      ; visit again! return a string like "#{counter}" 
            (else
              ; (bkpt "debug")
              (put object 0)                           ; the first visit! 
              ;; Here which one of x/y is run first doesn't influence the result since they doesn't have the nesting relation.
              (let ((x (thunk-or-value (eval 'x (procedure-environment (cdr object))) "CAR")) 
                    (y (thunk-or-value (eval 'y (procedure-environment (cdr object))) "CDR"))) 
                ;; the above eval may visit this object.
                (if (zero? (get object))                       ; no inner elements refer to it 
                  (begin 
                    ; (newline)
                    ; (display "remove")
                    ; (newline)
                    (delete object)                          ; no tagging required 
                    (list 'just-pair object x y)) 

                  (begin 
                    (put object counter) 
                    (set! counter (+ counter 1))             ; increment counter 
                    (list 'be-referred-as object x y))))
                    )))   ; return the processed pair 
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
    (let* ((left (if with-paren "(" "")) 
           (right (if with-paren ")" "")) 
           (val (get (cadr pair))) 
           (x (list-ref pair 2)) 
           (y (list-ref pair 3)) 
           (tag (if val (string-append "#" (number->string val)) val)) 
           (middle (if (null? y) "" " "))) 

      (cond ((be-referred? pair) (display tag) (display "=") (display left)) 
            ((referer? pair) (display tag) (display "#")) 
            (else (display left))) 

      (cond ((not (referer? pair)) 
             (cond 
              ((compound-procedure? x) (user-print x))
              ;; just-pair ...
              ((pair? x) (print-pair x #t)) 
              (else (user-print x))) 

             (display middle)
            ;  (bkpt "debug")

             (cond ((be-referred? y) (print-pair y #t)) 
                   ((referer? y) (display ". ") (print-pair y #f))
                   ((compound-procedure? y) (user-print y))
                   ;; notice here internal ()'s are dropped.
                   ((pair? y) (print-pair y #f)) 
                   ((null? y) (display "")) 
                   (else (display ". ") (user-print y))) 

             (display right)) 
            ))) 

  (print-pair (convert-printable-pair object) #t)) 

(define (user-print object) 
  (cond ((meta-pair? object) (print-pair object)) ; the clause for pair of META-CIRCULAR 
        ((compound-procedure? object) 
         (display (list 'compound-procedure 
                        (procedure-parameters object) 
                        (procedure-body object) 
                        '<procedure-env>))) 
        (else 
          ; (bkpt "debug")
          (display object))))
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

;; added
(user-print (actual-value '(cons 1 2) the-global-environment))
(load "test-lib.scm")
(define user-print-general user-print)

;; must force, otherwise displaying thunk will cause the loop.
(run-program-list-force 
  '(
    ; (cons 1 2)
    ; ;; integers should be with the same structure, i.e. one non-nested list.
    ; (define ones (cons 1 ones))
    ; ones
    ; ;; infinite car
    ; ; p158
    ; (define (accumulate op initial sequence)
    ;   (if (null? sequence)
    ;     initial
    ;     (op (raw-car sequence)
    ;         (accumulate op initial (raw-cdr sequence)))))
    ; (define many-cars (accumulate (lambda (elm res) (cons res elm)) ones (iota 20)))
    ; many-cars
    ; ; '(a b (c d))
    ; (cons 'a (cons 'b (cons (cons 'c (cons 'd '())) '())))
    ; (cons 'a (cons 'b (cons 'c '())))

    ; (define c1 (cons 1 1))
    ; (car c1)
    (define c2 (cons c1 (lambda (x) x))) 
    ; (define c2 (cons c1 2)) 
    (define c3 (cons c2 3)) 
    (define c1 (cons c2 c3))
    (cdr c2)
    (cdr c3)

    ; (car (car (car c2)))
    ; c2
    ; c3
    ; c1
    ; c3
    
    ;; explicitly evaluate all vals in *the related env*
    ;; See (thunk-or-value (eval 'x (procedure-environment (cdr object))) "CAR").
    (car c2)
    ;; fine
    c2
    (car c3)
    (cdr c2)
    (cdr c3)
    (car c1)
    (cdr c1)
    ; #1=(#0=((#0# . #1#) . 2) . 3)
    ; #1=(#0=((#0# . #1#) . 2) . 3)
    c1
    ; #0=(#1# (#0# . 2) . 3)
    ;; So (#0# . 2) is c2.
    ;; (#0# . 2) . 3 is c3.
    ;; Then #1# is c2?
    c3
    c1
    c2
    ; #0=((#0# #0# . 3) . 2)
    )
  the-global-environment)

;; in applicative order, we need set!
(define c2 (cons 0 2)) 
(define c3 (cons 0 3))
(define c1 (cons c2 c3))
(set-car! c2 c1)
(set-car! c3 c2)
c1
c2
c3
