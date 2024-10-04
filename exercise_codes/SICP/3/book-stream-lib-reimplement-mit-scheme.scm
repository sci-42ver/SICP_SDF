;; These are also defined in MIT/GNU Scheme (at least shown in doc MIT_Scheme_Reference).
(define (stream-car stream) (car stream))

(define (stream-cdr stream) (force (cdr stream)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; The following won't work. See http://community.schemewiki.org/?sicp-ex-3.51 LisScheSic's.
; (define (force delayed-object)
;   (delayed-object))

; (define (memo-proc proc)
;   (display "call memo-proc")
;   (let ((already-run? false) (result false))
;     (lambda ()
;       (if (not already-run?)
;           (begin (set! result (proc))
;                  (set! already-run? true)
;                  result)
;           result))))

; ;; This won't work since exp will be evaluated. So for `stream-map`, we must evaluate `(stream-map proc (stream-cdr s))` to run `cons-stream`...
; ;; Same as wiki http://community.schemewiki.org/?sicp-ex-3.51 madhusudann's.
; (define (delay exp)
;   (memo-proc (lambda () exp)))

; ;; use the above delay. see https://stackoverflow.com/q/79053667/21294350 which should work for all primitive procedures.
; (define (cons-stream a b)
;   (cons a (delay b)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;; To use the above definition.
(define (stream-ref s n)
  (if (= n 0)
    (stream-car s)
    (stream-ref (stream-cdr s) (- n 1))))
(define (stream-map proc s)
  (if (stream-null? s)
    the-empty-stream
    (cons-stream (proc (stream-car s))
                 (stream-map proc (stream-cdr s)))))
