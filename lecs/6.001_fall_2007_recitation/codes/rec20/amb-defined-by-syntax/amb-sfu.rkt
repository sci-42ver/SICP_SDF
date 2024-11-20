#lang racket
(require racket/control)
;; both [] or () are ok https://docs.racket-lang.org/guide/syntax-overview.html "parentheses and square brackets"

(define fail 
  (lambda () 
    (error "Amb tree exhausted")))

;;; https://www.sfu.ca/~tjd/383summer2019/scheme-amb.html
;; One interesting course.

;; seems to cause the infinite loop since this is just replacement...
; (define-syntax internal-set!
;   (syntax-rules ()
;     ((_ a b)
;       (set! a b))))
; (define internal-set! set!)
(define-syntax amb
  (syntax-rules ()
    ((_) (fail))
    ((_ a) a)
    ((_ a b ...)
     (let ((fail0 fail))
       (call/cc
         (lambda (cc)
           (set! fail
             (lambda ()
               (set! fail fail0)
               ;; similar to the induction in c2.
               (cc (amb b ...))))
           ;; since this is at tail, IMHO directly a is also fine just as c2 link.
           (cc a)))))))

;; added
(define-syntax amb-set!
  (syntax-rules ()
    ((_ a b)
     (let ((fail0 fail))
       (call/cc
         (lambda (cc)
           ;; similar to the book
           (let ((old-value a))
              (set! a b)
              ;; follow the amb structure.
              (set! fail
                (lambda ()
                  ;; follow the book structure.
                  (set! a old-value)
                  (set! fail fail0)
                  (fail)))
              ;; return old-value same as the behavior in MIT/GNU Scheme
              (cc old-value)
              )))))))

(define global-x '(0))
(define (test y)
  (define (demo-set! x)
    ;; since this is one special form, we can't pass one proc.
    (amb-set! global-x (cons x global-x))
    global-x)
  (demo-set! y))
(test (amb 1 2))
; (1 0)
(amb)
; (2 0)

(list (amb 1 2) (amb 3 4))
;; 0. from left to right
;; 1. due to call/cc, here (amb) goes back to (list (amb 1 2) (amb 3 4)), and then finish evaluation there.
;; So output '(1 4) instead of #t.
(equal? '(1 4) (amb))