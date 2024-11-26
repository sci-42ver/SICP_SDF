(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lib/amb/amb-lib.scm")

; (define (shuffled s) 
;     (define (swap s p q) 
;         (let ((ps (list-starting-from s p)) 
;               (qs (list-starting-from s q))) 
;             (let ((pv (car ps))) 
;                 (set-car! ps (car qs)) 
;                 (set-car! qs pv))))  
;     (define (iter rest) 
;         (if (null? rest) 
;             s 
;             (let ((n (random (length rest)))) 
;                 (swap rest 0 n) 
;                 (iter (cdr rest))))) 
;     (iter s))

;;; 0. poly's shuffle does the same thing by adding adding one by one reordered element but implements `remove` manually.
;;; 1. from meteorgan
;; same as the above, doing n times swap implied by "(- pos 1)" etc.
(define (shuffle-list lst) 
  (define (random-shuffle result rest) 
    (if (null? rest) 
        result 
            (let* ((pos (random (length rest))) 
                  (item (list-ref rest pos))) 
            ; (display (list "len" (length rest)))
            (if (= pos 0) 
                (random-shuffle (append result (list item)) (cdr rest)) 
                (let ((first-item (car rest))) 
                      (random-shuffle (append result (list item)) 
                                      (insert! first-item (- pos 1) (cdr (delete! pos rest))))))))) 
  (random-shuffle '() lst))
;; insert item to lst in position k. 
(define (insert! item k lst) 
  (if (or (= k 0) (null? lst)) 
      (append (list item) lst) 
      (cons (car lst) (insert! item (- k 1) (cdr lst))))) 
;; similar to filter but won't keep doing when already deleting the *only* one.
(define (delete! k lst) 
  (cond ((null? lst) '()) 
        ((= k 0) (cdr lst)) 
        (else (cons (car lst)  
                    (delete! (- k 1) (cdr lst)))))) 
            

(define (analyze-amb exp) 
    (let ((cprocs (map analyze (amb-choices exp))))  ; can't shuffle here 
        (lambda (env succeed fail) 
            ; achieve random order by shuffling choices at RUNTIME 
            (define shuffled-cprocs (shuffle-list cprocs)) 
            (define (try-next choices) 
                (if (null? choices) 
                    (fail) 
                    ((car choices) env 
                                  succeed 
                                  (lambda () 
                                    (try-next (cdr choices)))))) 
            (try-next shuffled-cprocs))))

(driver-loop)
(define (require p)
  (if (not p) (amb)))

(define (an-integer-between low high) 
  (require (<= low high))
  ; (ramb (<Prob> low 1) (<Prob> (an-integer-between (+ low 1) high) (- high low)))
  (amb low (an-integer-between (+ low 1) high))
  )

;; all less than 5
(an-integer-between 1 10)
(an-integer-between 1 10)
(an-integer-between 1 10)
(an-integer-between 1 10)
(an-integer-between 1 10)
(an-integer-between 1 10)
(an-integer-between 1 10)