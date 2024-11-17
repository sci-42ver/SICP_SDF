;; https://www.sfu.ca/~tjd/383summer2019/scheme-amb.html
;; the same structure as syntax-rules except that
;; 0. no (_ a) a) shortcut
;; 1. 

;; from lecs/6.001_fall_2007_recitation/codes/rec20/amb-defined-by-syntax/amb-in-underlying-scheme.scm
(define fail 
  (lambda () 
    (error "Amb tree exhausted"))) 

(define-syntax amb
  (sc-macro-transformer
   (lambda (exp env)
     (if (null? (cdr exp))
         `(fail)
       `(let ((fail0 fail))
          (call/cc
           (lambda (cc)
             (set! fail
                   (lambda ()
                     (set! fail fail0)
                     (cc (amb ,@(map (lambda (x)
                                       (make-syntactic-closure env '() x))
                                     (cddr exp))))))
             (cc ,(make-syntactic-closure env '() (second exp))))))))))

(list (amb 1 2) (amb 3 4))
(amb)