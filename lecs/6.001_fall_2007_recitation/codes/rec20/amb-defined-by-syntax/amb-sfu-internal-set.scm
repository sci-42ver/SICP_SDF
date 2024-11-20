(define fail 
  (lambda () 
    (error "Amb tree exhausted")))

;;; https://www.sfu.ca/~tjd/383summer2019/scheme-amb.html
;; One interesting course.

;; seems to cause the infinite loop since this is just replacement...
(define-syntax internal-set!
  (syntax-rules ()
    ((_ a b)
      (set! a b))))
(define-syntax amb
  (syntax-rules ()
    ((_) (fail))
    ((_ a) a)
    ((_ a b ...)
     (let ((fail0 fail))
       (call/cc
         (lambda (cc)
           (internal-set! fail
             (lambda ()
               (internal-set! fail fail0)
               ;; similar to the induction in c2.
               (cc (amb b ...))))
           ;; since this is at tail, IMHO directly a is also fine just as c2 link.
           (cc a)))))))

;; added
(define-syntax set!
  (syntax-rules ()
    ((_ a b)
     (let ((fail0 fail))
       (call/cc
         (lambda (cc)
           (let ((old-value a)) 
              (write-line "call amb-set!")
              (internal-set! a b)
              (internal-set! fail
                (lambda ()
                  (write-line "restore")
                  ;; follow the book structure.
                  (internal-set! a old-value)
                  (internal-set! fail fail0)
                  (fail)))
              (cc old-value)
              )))))))
(define x 2)
(set! x 2)

; (cd "~/SICP_SDF/lecs/6.001_fall_2007_recitation/codes/rec20/")
; (load "amb-test1.scm")
; (test)
; (set!-test)
(define global-x '(0))
(define (test y)
  (define (demo-set! x)
    ;; since this is one special form, we can't pass one proc.
    ; (set! global-x (cons x global-x))
    (set! global-x (cons x global-x))
    (write-line "finish amb-set!")
    global-x)
  (demo-set! y))
(write-line (test (amb 1 2)))
(write-line (amb))
(write-line "finish all")
; (assert (eq? '(1 0) (test (amb 1 2))))
; (assert (eq? '(2 0) (amb)))

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