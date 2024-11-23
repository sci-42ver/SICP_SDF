(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "book-stream-lib.scm")

;; from https://stackoverflow.com/q/14640833/21294350. Also see non-memo https://stackoverflow.com/a/24529585/21294350
;; This https://stackoverflow.com/q/79053667/21294350 may say too much redundant...
(define (memo-func function)
  (let ((already-run? false)
        (result false))
    (lambda ()
      (if (not already-run?)
          (begin (set! result (function))
                 (set! already-run? true)
                 result)
          result))))


(define (delay exp)
  (memo-func (lambda () exp)))

(define (force function)
  (function))

(define the-empty-stream '())
(define (stream-null? stream) (null? stream))
(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))

(define (cons-stream a b) (cons a (memo-func (lambda () b))))

;; Also see lecs/6.001_spring_2007_recitation/codes/rec22/source22/streams.scm
;; 1. print-stream are trivial
(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream a b)
     (cons a (memo-func (lambda () b))))))

(define (stream-take n s)
  (cond ((or (stream-null? s)
             (= n 0)) the-empty-stream)
        (else (cons-stream (stream-car s)
                           (stream-take (- n 1) (stream-cdr s))))))

(stream-take 10 integers)