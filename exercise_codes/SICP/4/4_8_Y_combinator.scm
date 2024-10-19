;; I found the following link when *rechecking* one old link https://stackoverflow.com/a/7719140/21294350
;; where I first found https://stackoverflow.com/a/11833038/21294350 similar to karthikk's in http://community.schemewiki.org/?sicp-ex-4.9
;; Then I found https://en.wikipedia.org/wiki/Lambda_calculus#Standard_terms -> https://en.wikipedia.org/wiki/Lambda_calculus#Recursion_and_fixed_points -> 4_8_Y_combinator_wikipedia.scm
;; Then infinite recursion problem, so rechecking "combinator" in the 1st link -> https://stackoverflow.com/a/7721871/21294350
;; and google "fixed-point combinator avoid maximum recursion" -> https://stackoverflow.com/a/67408069/21294350

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

(define fib-body
  (lambda (fib)
    (lambda (n)
      (cond 
        ((< n 2) n)
        (else (+ (fib (- n 1)) (fib (- n 2))))))
    ))
((Z fib-body) 8)