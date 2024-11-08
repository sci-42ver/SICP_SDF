(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "amb-lib.scm")
(driver-loop)

(define stmts 
    '(((kitty 2) (betty 3)) 
      ((ethel 1) (joan 2)) 
      ((joan 3) (ethel 5)) 
      ; ((kitty 2) (betty 1))
      ((kitty 2) (mary 4))
      ((mary 4) (betty 1)))) 

(define (no-conflict kv set) 
    (define (iter next) 
        (or (null? next) 
            (let ((k (caar next)) 
                  (v (cadar next))) 
                (if (eq? (car kv) k) 
                    (and (= v (cadr kv)) (iter (cdr next))) 
                    (iter (cdr next)))
                (cond 
                  ;; maybe (k1,v1), (k1,v2)
                  ((eq? (car kv) k) (and (= v (cadr kv)) (iter (cdr next))))
                  ;; maybe (k1,v1), (k2,v1)
                  ((= v (cadr kv)) (and (eq? (car kv) k) (iter (cdr next))))
                  ;; must be (k1,v1), (k2,v2)
                  (else (iter (cdr next)))
                  )
                ; (and (not (eq? (car kv) k))
                ;   (not (= (cadr kv) v))
                ;   (iter (cdr next)))
                ))) 
    (iter set)) 

(define (choose girl-says) 
    (define (iter rest-girl-says selected) 
        (if (null? rest-girl-says) 
            (display selected) 
            (let ((s1 (caar rest-girl-says)) 
                  (s2 (cadar rest-girl-says))) 
                (let ((which (amb s1 s2))) 
                    (require (no-conflict which selected)) 
                    (iter (cdr rest-girl-says) (cons which selected)))))) 
    (iter girl-says '())) 

;; added
(define (require p)
  (if (not p) (amb)))
(define (distinct? items)
  (cond ((null? items) true)
        ((null? (cdr items)) true)
        ((member (car items) (cdr items)) false)
        (else (distinct? (cdr items)))))

(choose stmts)
;; Shows right statements but not the total assignment for people
; ((mary 4) (kitty 2) (joan 3) (ethel 1) (kitty 2))
;; non-conflict statements doesn't ensure one valid assignment.
;; For example, all people say the same.

; ((betty 3) (ethel 5) (joan 2) (kitty 1) (mary 4))
;; corresponds to ((betty 3) (joan 2) (ethel 5) (mary 4) (mary 4))