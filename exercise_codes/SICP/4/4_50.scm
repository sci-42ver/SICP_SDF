(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lib/amb/amb-lib.scm")

;; similar to wiki poly version 1.
;; IGNORE: Also see version 2 for why do shuffle.
(define (analyze-amb exp)
  (let ((cprocs (map analyze (amb-choices exp))))
    (lambda (env succeed fail)
      ;; 0. since analyze is done once, so define here is fine.
      ;; 1. just copy from adventure-substrate.scm with small modification.
      (define (random-choice items)
        (assert (list? items))
        (and (pair? items)
            (let ((idx (random (length items))))
              (display (list "choose" idx))
              (list-ref items idx))))
      (define (try-next choices)
        (if (null? choices)
            (fail)
            ;; modified
            (let ((cur (random-choice choices)))
              (cur env
                           succeed
                           (lambda ()
                             (try-next (delete cur choices)))))))
      (try-next cprocs))))

; (define (4-50-test)
;   (driver-loop)
;   (define (require p)
;     (if (not p) (amb)))
;   (list (amb 1 2 3 4 5 6 7 8 9) (amb 'a 'b))
;   try-again
;   try-again)

(driver-loop)
(define (require p)
  (if (not p) (amb)))
(list (amb 1 2 3 4 5 6 7 8 9) (amb 'a 'b))
try-again
try-again

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; problem shown by revc
(define (an-integer-between low high) 
  (require (<= low high))
  ; (ramb (<Prob> low 1) (<Prob> (an-integer-between (+ low 1) high) (- high low)))
  (amb low (an-integer-between (+ low 1) high))
  )

;; all 1 or 2...
(an-integer-between 1 10)
(an-integer-between 1 10)
; (choose 1)(choose 0)
;; the 2nd choose is for the recursive call.
(an-integer-between 1 10)
(an-integer-between 1 10)
(an-integer-between 1 10)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; > Show how this can help with Alyssa's problem in exercise 4.49.
;; See 4_50_revc_mod.scm
