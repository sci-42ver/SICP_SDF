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

(cd "~/SICP_SDF/lecs/6.001_fall_2007_recitation/codes/rec20/")
(load "amb-test1.scm")
(test)