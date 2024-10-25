;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Description about the relation with what was learned before about Y operator/combinator,
;; https://en.wikipedia.org/wiki/Lambda_calculus#Recursion_and_fixed_points "at a call point:..."
;; Also see https://stackoverflow.com/a/11824644/21294350
((lambda (n)
   ((lambda (fact)
      ;; just apply F to x
      (fact fact n))
    ;; G := λr. λn.
    (lambda (ft k)
      (if (= k 1)
          1
          (* k (ft ft (- k 1)))))))
 10)
;; For the relation with the question post. See the comment.
((lambda (x) (x x))
 (lambda (fact-gen)
   (lambda (n)
     (if (zero? n)
         1
         (* n ((fact-gen fact-gen) (sub1 n)))))))
;; can be uncurried to the above 1st
;; ((fact-gen fact-gen) (sub1 n)) -> (fact-gen fact-gen (sub1 n))
;; then the related lambda also needs to be changed.

;; one straightforward change is to follow the above structure, so (lambda (fact-gen) (lambda (n) ...)) corresponds to the application ((fact-gen fact-gen) (sub1 n)).
(lambda (fact-gen n)
  (if (zero? n)
    1
    (* n (fact-gen fact-gen (sub1 n)))))
;; Then ((lambda (x) (x x) ...) should be
; ((lambda (f) (f f outer-n)) '...)
;; To get the outer-n, we need
(lambda (outer-n) ((lambda (f) (f f outer-n)) '...))
;; Then we get the book one.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; a
((lambda (n)
   ((lambda (fact)
      (fact fact n))
    (lambda (ft k)
      ;; just modify here.
      ;; from gist link and small modification
      (cond 
        ((< k 2) k)
        (else (+ (ft ft (- k 1)) (ft ft (- k 2)))))
      )))
 10)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; b
(define (f x)
  ((lambda (even? odd?)
    ;; use even? first due to `(even? x)` body.
     (even? even? odd? x))
   (lambda (ev? od? n)
      ;; trivial due to what (ev? od? n) mean here.
     (if (= n 0) true (od? ev? od? (- n 1))))
   (lambda (ev? od? n)
     (if (= n 0) false (ev? ev? od? (- n 1))))))
(f 5)