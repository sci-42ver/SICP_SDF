;; https://blog.klipse.tech/assets/y-in-practical-programs.pdf "Sequential Realisability" is skipped.

;; 1. see SDF p458 "In MIT/GNU Scheme we can use the sugar recursively, to write:"
;; 2. Just "fixed-point combinator" definition https://en.wikipedia.org/wiki/Fixed-point_combinator
;; 3. returns (f (Y f)). Based on the following, i.e. the actual fact func.
(define ((Y f) x)
  ((f (Y f)) x))
;; 1. Here we must use define since Y is recursively defined.
;; 2. following the last paragraph https://stackoverflow.com/a/78586373/21294350
;; Ygx=g(Yg)x

;; Compared with Z combinator in 4_8_Y_combinator.scm, (Y f) returns one lambda instead of keeping recursion.
;; (Z r) -> (l-y l-y) -> (r (lambda args (apply (y y) args))) -> (r (Z r)) but (Z r) is wrapped in lambda.
;; also returns l-x as the above point 3 shows.

;; 4_8_Y_combinator_wikipedia.scm
; (define FIX (lambda (f) ((lambda (x) (f (x x))) (lambda (x) (f (x x))))))
; (define (FIX f) ((lambda (x) (f (x x))) (lambda (x) (f (x x)))))
; (define (FIX f) (f ((lambda (x) (f (x x))) (lambda (x) (f (x x)))))) ; i.e. (define (FIX f) (f (FIX f)))
; (define (FIX f) (f (FIX f)))

;; 1. i.e. G in https://en.wikipedia.org/wiki/Lambda_calculus#Recursion_and_fixed_points
;; 2. https://en.wikipedia.org/wiki/SKI_combinator_calculus#Self-application_and_recursion
;; > If α expresses a "computational step" computed by αρν for some ρ and ν
;; ρ is fact and v is x here.
;; > its fixed point ββ expresses the whole recursive computation
;; α is fact_, so (Y fact_) functions as ββ.
;; So αρ and ρ/ββ are both l-x here.
;; 2.1 "step" meaning see: g (g (g (g (g ...)))) in https://stackoverflow.com/questions/7719004/in-scheme-how-do-you-use-lambda-to-create-a-recursive-function/7719126#comment139475320_7719126
;; 2.2. divergence maybe similar to maths https://math.stackexchange.com/a/894503/1059606 where we keep calculating the next value...
;; 3. > α will have to employ some kind of conditional to stop
;; See https://chat.stackoverflow.com/transcript/message/57699616#57699616 where g stops somewhere.
;; (G (Y G) (1−1)) -> ((λn. ...) 0), so actually it is αρ to check where to stop.
(define ((fact_ fact) x)
  (if (= x 0)
    1
    (* x (fact (- x 1)))))

(define fact (Y fact_))
;; so (fact_ (Y fact_)) -> (fact_ fact) -> l-x above.

(fact 5)