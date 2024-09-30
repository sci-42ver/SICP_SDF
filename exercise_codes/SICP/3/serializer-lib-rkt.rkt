#lang racket

;; https://stackoverflow.com/a/13474623/21294350
(define (parallel-execute . procs)
  (map thread-wait
       (map (lambda (proc) (thread proc))
            procs)))

;; https://docs.racket-lang.org/pkg/getting-started.html#%28part._installing-packages%29 
;; raco pkg install rebellion
;; safe to break when "reco setup: 0: idle ..."
(require rebellion/concurrency/lock)
(define (make-serializer)
  ;; https://docs.racket-lang.org/rebellion/Locks.html#%28def._%28%28lib._rebellion%2Fconcurrency%2Flock..rkt%29._lock%21%29%29
  (let ((mutex (make-lock)))
    (lambda (p)
      (define (serialized-p . args)
        (lock!
          mutex
          (lambda () 
            (apply p args))
          ))
      serialized-p
      )))

; ;; same as serializer-lib.scm
; (define (make-serializer)
;   (let ((mutex (make-mutex)))
;     (lambda (p)
;       (define (serialized-p . args)
;         (mutex 'acquire)
;         (let ((val (apply p args)))
;           (mutex 'release)
;           val))
;       serialized-p)))

; (define (make-mutex)
;   (let ((cell 
;           ;; for compatibility.
;           ; (list false)
;           (mcons false '())
;           ))            
;     (define (the-mutex m)
;       (cond ((eq? m 'acquire)
;              (if (test-and-set! cell)
;                (the-mutex 'acquire)
;                'acquire-success
;                )) ; retry
;             ((eq? m 'release) (clear! cell))))
;     the-mutex))

; ;; https://stackoverflow.com/a/9475405/21294350
; (require rnrs/mutable-pairs-6)
; (define cons mcons)
; (define set-car! set-mcar!)
; (define car! mcar)
; (define pair? mpair?)

; (define (clear! cell)
;   (set-car! cell false))

; (define (test-and-set! cell)
;   (if (car cell)
;     true
;     (begin (set-car! cell true)
;            false)))

(displayln "finished loading")

(provide (all-defined-out))