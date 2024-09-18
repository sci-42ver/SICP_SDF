;; Let 'decell' be a type of cell which contains references to two other cells (e.g. next and previous cells in queue) and a value. 

;; Although my 'deque' does contain a cycle, evaluating a deque itself does not force the interpreter into an infinite loop, because some evaluations are delayed which is a property of decell). 
;;----------------------------------------------------------------------;; 
;;; Deque ("double-ended queue"). 
(define (make-deque) (cons '() '())) ; constructor 

(define (empty-deque? deque) 
  ;; Even though an empty deque might contain 
  ;; a reference to an element we have "removed," we provide 
  ;; no access to it and consider the deque emptied. 
  (or (null? (front-dptr deque)) 
      (null? (rear-dptr deque)))) ; predicate 

(define (front-deque deque) 
  (if (empty-deque? deque) 
    (error "FRONT called with an empty deque" deque) 
    (val-decell (front-dptr deque)))) 
;; see below for definition of a decell. 
(define (rear-deque deque) 
  (if (empty-deque? deque) 
    (error "REAR called with an empty deque" deque) 
    (val-decell (rear-dptr deque)))) ; selectors  

(define (set-first-deque! deque decell) 
  (set-front-dptr! deque decell) 
  (set-rear-dptr! deque decell)) 
(define (front-insert-deque! deque item) 
  (let ((decell (make-decell '() item '()))) 
    (cond ((empty-deque? deque) 
           (set-first-deque! deque decell)) 
          (else 
            (connect-decell! decell (front-dptr deque)) 
            (set-front-dptr! deque decell))) 
    deque)) 
(define (rear-insert-deque! deque item) 
  (let ((decell (make-decell '() item '()))) 
    (cond ((empty-deque? deque) 
           (set-first-deque! deque decell)) 
          (else 
            (connect-decell! (rear-dptr deque) decell) 
            (set-rear-dptr! deque decell))) 
    deque)) 

(define (front-delete-deque! deque) 
  (cond ((empty-deque? deque) 
         (error "FRONT-DELETE called with an empty deque" deque)) 
        (else 
          (set-front-dptr! deque (right-decell (front-dptr deque))) 
          ;; Since we won't do anything for empty-deque, so it is ok to have the wrong "left-decell".
          (if (not (empty-deque? deque)) 
            (set-left-decell! (front-dptr deque) '())) 
          deque))) 
(define (rear-delete-deque! deque) 
  (cond ((empty-deque? deque) 
         (error "REAR-DELETE called with an empty deque" deque)) 
        (else 
          (set-rear-dptr! deque (left-decell (rear-dptr deque))) 
          (if (not (empty-deque? deque)) 
            (set-right-decell! (rear-dptr deque) '())) 
          deque))) ; mutators 

(define (deque->list deque) 
  (define (iter decell) 
    (if (null? decell) 
      '() 
      (cons (val-decell decell) (iter (right-decell decell))))) 
  (if (empty-deque? deque) 
    '() 
    (iter (front-dptr deque)))) 


;; A dequeue is a pair of front and rear references to the same list, 
;; whose elements are decells. 
(define (front-dptr deque) (car deque)) 
(define (rear-dptr deque) (cdr deque)) 
(define (set-front-dptr! deque decell) (set-car! deque decell)) 
(define (set-rear-dptr! deque decell) (set-cdr! deque decell)) 

;; A decell is a cell, whose car is a pair of value and 
;; pointer to another decell (previous in queue). Whose cdr is a pointer 
;; to another decell (next in queue). 
(define (make-decell left value right) 
  (cons (cons value left) right)) 
(define (val-decell decell) (caar decell)) 
(define (left-decell decell) 
  (if (not (null? (cdr (car decell)))) 
    ;; delay/force evaluation of this part 
    ;; prevents the interpreter from printing 
    ;; cycle of decells. 
    ; ((cdr (car decell))) 
    (cdr (car decell))
    '())) 
(define (right-decell decell) (cdr decell)) 
(define (set-right-decell! decell right-decell) 
  (set-cdr! decell right-decell)) 
(define (set-left-decell! decell left-decell) 
  (set-cdr! (car decell) 
            ; (lambda () left-decell) ; changed
            left-decell
            )) 

(define (connect-decell! l-decell r-decell) 
  (set-left-decell! r-decell l-decell) 
  (set-right-decell! l-decell r-decell)) 

;;; Test 
(define (newline-display exp) 
  (newline) (display exp)) 
(define deq (make-deque))
(define (3_23_test) 
  (front-insert-deque! deq 'a) 
  (front-insert-deque! deq 'b) 
  (rear-insert-deque! deq 'z) 
  (rear-insert-deque! deq 'y) 
  ; (#0=((b) . #1=((a . #0#) . #2=((z . #1#) (y . #2#)))) (y . #2#))
  ; (#0=((b) . #1=((a . #0#) . #2=((z . #1#) (y . #2#)))) (y . #2#))

  ; (define old-deq deq)

  (newline-display (deque->list deq)) 
  ;;Value: (b a z y) 
  (newline-display (front-deque deq)) 
  ;;Value: b 
  (front-delete-deque! deq) 
  (newline-display (front-deque deq)) 
  ;;Value: a 
  (rear-delete-deque! deq) 
  (newline-display (rear-deque deq)) 
  ;;Value: z 

  ; (equal? deq old-deq) ; #t, so define is shallow copy.
  )
(3_23_test)

; (load "3_19.scm")
; (has-cycle? deq)
; (load "3_18.scm")
; (inf_loop? deq)
(load "3_19_AntonKolobov_mod.scm")
(assert (has-cycle? deq))

;; cycle
(define new-deq (make-deque))
(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "lib.scm")
(define cycle (make-cycle (list 'a 'b 'c)))
(front-insert-deque! new-deq cycle)
; (newline-display (front-deque new-deq))

(load "3_19_AntonKolobov_mod.scm")
(define (newline-display exp) 
  (and (not (has-cycle? exp))
       (newline) 
       (display exp)))
(newline-display (front-deque new-deq))
(3_23_test)

;; too heavy test and the assumption is different about `empty-deque?` etc.
(load "deque_test.scm")
