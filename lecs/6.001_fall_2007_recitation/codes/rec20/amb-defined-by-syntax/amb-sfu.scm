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
; (define x 2)
; (amb-set! x 2)

(cd "~/SICP_SDF/lecs/6.001_fall_2007_recitation/codes/rec20/")
(load "amb-test1.scm")
; (test)
; (set!-test)
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

;; from exercise_codes/SICP/4/amb-misc-lib.scm
(define (require p)
  (if (not p) (amb)))
(define (an-element-of items)
  (require (not (null? items)))
  (amb (car items) (an-element-of (cdr items))))
(define (reset-fail)
  (set! fail 
    (lambda () 
      (error "Amb tree exhausted"))))