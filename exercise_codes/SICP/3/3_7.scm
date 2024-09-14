;; wiki x3v uses "auth layer" by `(null? m)`.
;; repo adds one unnecessary `[(eq? m 'withdraw) withdraw]` etc. IMHO.
(load "3_3.scm")
(define (make-joint acc old-passwd new-passwd)
  (if (equal? ((acc old-passwd 'deposit) 0) "Incorrect password")
    (lambda (password m)
      (lambda (amount)
        "Incorrect acc password"))
    (lambda (password m) 
      (if (equal? new-passwd password)
        (acc old-passwd m)
        (lambda (amount)
          "Incorrect password")))))

;; test from wiki
(define peter-acc (make-account 100 'open-sesame)) 
(define paul-acc (make-joint peter-acc 'open-sesame 'rosebud)) 
(define pan-acc (make-joint paul-acc 'rosebud 'vvv)) 

;; tests
(define (test-1)
  (assert (= 200 ((pan-acc 'vvv 'deposit) 100)))
  (assert (= 300 ((peter-acc 'open-sesame 'deposit) 100)))
  (assert (= 400 ((paul-acc 'rosebud 'deposit) 100)));; 400 
  )
(define (test-2)
  (assert (equal? "Incorrect password" ((peter-acc 'rosebud 'deposit) 100))) ;; error as intended 
  (assert (equal? "Incorrect password" ((paul-acc 'open-sesame 'deposit) 100)))
  (assert (equal? "Incorrect password" ((pan-acc 'rosebud 'deposit) 100))))
(test-1)
(test-2)

;; wiki x3v

(define (make-account balance password) 
  (define incorrect-count 0) 
  (define (withdraw amount) 
    (if (>= balance amount) 
      (begin (set! balance (- balance amount)) 
             balance) 
      "insufficient")) 
  (define (deposit amount) 
    (set! balance (+ balance amount)) 
    balance) 
  (define (issue-warning) 
    (if (> incorrect-count 7) 
      (error "the cops are on their way") 
      (error (- 7 incorrect-count) 'more 'attempts))) 
  (define (auth-layer pw . m) 
    (cond ((null? m) (eq? pw password)) 
          ((eq? pw password) (dispatch (car m))) 
          (else (begin (set! incorrect-count (+ incorrect-count 1)) 
                       (issue-warning))))) 
  (define (dispatch m) 
    (set! incorrect-count 0) 
    (cond ((eq? m 'withdraw) withdraw) 
          ((eq? m 'deposit) deposit) 
          (else (error "Unknown request" m)))) 
  auth-layer) 

(define (make-joint acc pw-prev pw-next) 
  (define (dispatch pw . m) 
    (if (null? m) 
      (eq? pw pw-next) 
      ;; pw-next will just throw errors, so it can be anything besides pw-prev.
      (acc (if (eq? pw pw-next) pw-prev pw-next) (car m)))) 
  (if (acc pw-prev) 
    dispatch 
    (error "Incorrect password to original account" pw-prev))) 

(define peter-acc (make-account 100 'open-sesame)) 
(define paul-acc (make-joint peter-acc 'open-sesame 'rosebud)) 
(define pan-acc (make-joint paul-acc 'rosebud 'vvv)) 

;; tests 
(test-1)
((peter-acc 'rosebud 'deposit) 100)  ;; error as intended
((paul-acc 'open-sesame 'deposit) 100)
