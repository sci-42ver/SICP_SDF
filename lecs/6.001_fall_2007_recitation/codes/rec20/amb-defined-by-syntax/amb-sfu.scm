(define fail 
  (lambda () 
    (error "Amb tree exhausted")))

;;; https://www.sfu.ca/~tjd/383summer2019/scheme-amb.html
;; One interesting course.
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

; (cd "~/SICP_SDF/lecs/6.001_fall_2007_recitation/codes/rec20/")
; (load "amb-test1.scm")
; (test)

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