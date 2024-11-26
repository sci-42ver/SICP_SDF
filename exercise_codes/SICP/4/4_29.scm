(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lib/lazy/Lazy_Evaluation_lib.scm")

; (define (driver-loop)
;   (prompt-for-input input-prompt)
;   (let ((input (read)))
;     (let* ((start (runtime))
;             (output
;             ;; modified
;             (actual-value input the-global-environment)))
;       (define end (runtime))
;       (announce-output output-prompt)
;       (user-print output)
;       (display (list "ms: " (- end start)))
;       (newline)
;       ))
;   (driver-loop))

(load "test-lib.scm")

(define test-def
  '((define (even? num)
      (= 0 (remainder num 2)))
    (define (fib n)
      (define (fib-iter a b p q count)
        (cond ((= count 0) b)
          ((even? count)
          (fib-iter a
                    b
                    (+ (* q q) (* p p))   ;; compute p′
                    (+ (* 2 p q) (* q q)) ;; compute q′
                    (/ count 2)))
          (else (fib-iter (+ (* b q) (* a q) (* a p))
                          (+ (* b p) (* a q))
                          p
                          q
                          (- count 1)))))
      (fib-iter 1 0 0 1 n))
    (define (fib2 n)
      (define (iter a b k)
        (if (= k 0)
          b
          (iter (+ a b) a (- k 1))))
      (iter 1 0 n))
    (define (factorial n)
      (if (= n 0)
        1
        (* n (factorial (- n 1)))))
    ))

(run-program-list test-def the-global-environment)

(define test-program-1
  ; '((display (fib 2000000)))
  '((display (fib 100)))
  )

(define test-program-2
  '((display (factorial 1000))))

(elapsed-time-test test-program-1)
; *** 2.88 -> 2000000
;  *** 0.

;; have debug info
; (define (force-it obj)
;   (cond ((thunk? obj)
;          (let ((result (actual-value
;                         (thunk-exp obj)
;                         (thunk-env obj))))
;            (set-car! obj 'evaluated-thunk)
;            (set-car! (cdr obj) result)  ; replace exp with its value
;           ;  (set-cdr! (cdr obj) '())     ; forget unneeded env
;            (set-cdr! (cdr obj) (list (thunk-exp obj)))     ; forget unneeded env
;            (display (list "memo for" (thunk-exp obj)))
;            result))
;         ((evaluated-thunk? obj)
;          (display (list "use memo for" (cddr obj)))
;          (thunk-value obj))
;         (else obj)))
(elapsed-time-test test-program-2)
; *** .2
;; (= n 0) -> (memo for 1000)(use memo for (1000))(memo for 999)(use memo for (999)) ... (memo for 1)(use memo for (1))(memo for 0)
;; Then 
;; (* n ...) -> (use memo for (1))(use memo for (2))(use memo for (3)) ... (use memo for (1000))


(define (force-it obj)
  (if (thunk? obj)
      (actual-value (thunk-exp obj) (thunk-env obj))
      obj))

(elapsed-time-test test-program-1) 
; much slower -> 2000000
;  *** .6000000000000001

;; Even for (- n 1), the difference can be large
(elapsed-time-test test-program-2)
;  *** 30.63