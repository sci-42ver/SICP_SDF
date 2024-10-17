;; https://stackoverflow.com/a/7721871/21294350
;; > Let's try to call that with a value other than 0.
;; same as OP
((lambda (f) (f f))
  (lambda (fact)
    (lambda (n)
      (cond
        ((= 0 n) 1)
        (else (* n ((fact fact) (- n 1))))))))
;; (l-fact l-fact) -> (l-n ...). So no "maximum recursion depth exceeded" as 4_8_Y_combinator_wikipedia.scm shows.

;; > let's just call (fact fact) fact2
;; > simply rename fact to y, and fact2 to fact
((lambda (f) (f f))
 (lambda (y)
   ((lambda (fact)
      (lambda (n)
        (cond
          ((= 0 n) 1)
          (else (* n (fact (- n 1)))))))
    (lambda (x) ((y y) x)))))

;; > If you refactored out the factorial specific code
;; from SO answer.
;; > Let's pull out (lambda (fact) ... ) and pass it in as a parameter
;; r
((lambda (r)
   ((lambda (f) (f f))
    (lambda (y)
      (r (lambda (x) ((y y) x))))))
 (lambda (fact)
   (lambda (n)
     (cond
       ((= 0 n) 1)
       (else (* n (fact (- n 1))))))))
(define Z
  (lambda (r)
    ((lambda (f) (f f))
     (lambda (y)
      ;  (r (lambda (x) ((y y) x)))
       (r (lambda args (apply (y y) args)))
       ))))
;; r=l-fib, then we call l-f, which then gets (l-y l-y) -> (r l-x) -> (l-n) where l-x function as fib.
;; https://gist.github.com/z5h/238891?permalink_comment_id=1208187#gistcomment-1208187

;; can't use external fib.
; (define fib-body
;   (delay
;     (lambda (n)
;       (cond 
;         ((< n 2) n)
;         (else (+ (fib (- n 1)) (fib (- n 2))))))))
((Z
  (lambda (fib)
    (lambda (n)
      (cond 
        ((< n 2) n)
        (else (+ (fib (- n 1)) (fib (- n 2))))))
    )) 8)