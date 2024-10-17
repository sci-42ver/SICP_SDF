;; https://stackoverflow.com/a/11833038/21294350 -> https://en.wikipedia.org/wiki/Lambda_calculus#Recursion_and_fixed_points
;; self-application just means U combinator https://en.wikipedia.org/wiki/SKI_combinator_calculus#Self-application_and_recursion
;; > We would like to have a generic solution, without a need for any re-writes:
;; FIX https://en.wikipedia.org/wiki/Fixed-point_combinator https://en.wikipedia.org/wiki/Fixed-point_combinator#Example_implementations
(lambda (f) ((lambda (x) (f (x x))) (lambda (x) (f (x x))))) ; FIX
; -(application)> ((lambda (x) (g (x x))) (lambda (x) (g (x x))))
; -> (g ((lambda (x) (g (x x))) (lambda (x) (g (x x)))))

;; r = G r =: FIX G means r:=FIX G.
;; (λn.(1, if n = 0; else n × ((FIX G) (n−1)))) -> G r where r:=FIX G.
(define fact
  (lambda (n)
    (if (= n 0)
      1
      (* n (fact (- n 1))))))
(fact 5)

;; (λr.λn.(1, if n = 0; else n × (r (n−1)))) (Y G) 4
(define FIX (lambda (f) ((lambda (x) (f (x x))) (lambda (x) (f (x x))))))
(FIX square)
;; Emm... keeping (FIX G) -> (G (FIX G)) -> (G (G (FIX G))) -> (G (G (G (FIX G)))) ...
;; https://en.wikipedia.org/wiki/Lambda_calculus#Recursion_and_fixed_points order is not applicative.
;; https://en.wikipedia.org/wiki/Fixed-point_combinator#Strict_fixed-point_combinator
;; 1. > never halt in case of tail call optimization
;; no *call* stack overflow due to accumulated G... see https://en.wikipedia.org/wiki/Tail_call#Example_programs
;; > This is not written in a tail-recursive style, because the multiplication function *("*") is in the tail position*
;; 2. > The Z combinator has the next argument defined explicitly
;; what is "the next argument"?
;; better see the reference https://www.cs.cornell.edu/courses/cs6110/2017sp/lectures/lec05.pdf p2 bottom.
;; so "defined explicitly" means 
;; > wrapping the self-application ff in another lambda abstraction
;; > but it is a *value*, therefore will only be evaluated when it is applied
;; which is just η-reduction
;; 2.1 why eta-expansion must work?
;; we only need to check https://en.wikipedia.org/wiki/Lambda_calculus#%CE%B7-reduction
;; > whenever x does not appear free in f.
;; based on https://en.wikipedia.org/wiki/Lambda_calculus#Free_and_bound_variables
;; here we need to ensure v is not free for x. But x has only free variable f. So fine.

;; Also see https://gist.github.com/z5h/238891?permalink_comment_id=5239505#gistcomment-5239505 which is clarified version of the above with the same infos.

(define FIX-G
  (delay
    (FIX
      ;; G
      (lambda (fact)
        ;; same as the above
        (force fact)
        )
      ))
  ;; return (λn.(1, if n = 0; else n × ((FIX G) (n−1))))
)
((force FIX-G) 5)