(define prompt_enable #f)
(define trace_enable #f)

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
    guess
    (sqrt-iter (improve guess x)
               x)))
(define (improve guess x)
  (average guess (/ x guess)))
(define (average x y)
  (/ (+ x y) 2))
(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

; https://stackoverflow.com/a/66959122/21294350
(define (prompt msg sentinel)
  (display sentinel) (display " to finish") (newline)
  (display msg)
  (let ((user-input (read)))
    (if (equal? user-input sentinel)
      '()
      ; https://stackoverflow.com/a/11263539/21294350
      (begin
        (display (sqrt user-input))
        (newline)
        (prompt msg sentinel)))))
; https://stackoverflow.com/a/47724861/21294350 Run: scheme --quiet --load "~/SICP/problems_codes/1/1_7.scm". Then use ^D to quit.
(if trace_enable
  (trace sqrt-iter)
  '())
(if prompt_enable
  (prompt "Enter a number to square: " 'q)
  '())
; 1e-10 -> .03125000106562499 since the latter square is already samller than 0.001
#|
; 1e100 will be very slow since 0.001 is too small compared with 1e100 
; [$(a+b)^2-a^2\approx 2ab,a>>b$, so we need b very small when a is very large. 
; Then we need too many average to achieve that.]

; wiki
> the machine precision is unable to represent small differences between large numbers.
The latter "keep on yielding the same guess".
> Try (sqrt 1000000000000) [that's with 12 zeroes], then try (sqrt 10000000000000) [13 zeroes].
|#

(define (sqrt-iter guess x last_guess)
  (if (good-enough? guess last_guess)
    guess
    (sqrt-iter (improve guess x)
               x
               guess)))
; This depends on the guess, so it is with more flexibility.
(define (good-enough? guess last_guess)
  (< (/ (abs (- guess last_guess)) guess) 0.001))
(define (sqrt x)
  (sqrt-iter 1.0 x 0.0))
#|
The above is almost same as wiki oldguess except
1. (* guess 0.001)
2. (sqrt-iter 1.0 2.0 x)
|#
; https://www.cs.toronto.edu/~sheila/324/w07/assns/A3/debug.pdf
(if trace_enable
  (trace good-enough?)
  '())
(if prompt_enable
  (prompt "Enter a number to square: " 'q)
  '())
(display (sqrt 0.000005))

;;;;;;;;;;;;;;;;;;;;;;;; wiki
; wiki [atoy] says <= is needed for one trivial case x=0.
; I skipped [random person], [SchemeNewb] because they are rephrasing what the problem asks for.

;;;;;;;;;;;;;;;;;;;;;;;; [robwebbjr] problem 
; Ignore: may probably depends on the compiler. I don't have his problem.
; the 0th solution which depends on the compiler precision having the more precise answer.
; This is same as python output of math.sqrt
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
    guess
    (sqrt-iter (improve guess x)
               x)))
(define (good-enough? guess x) 
  (= (improve guess x) guess))
(define (sqrt x)
  (sqrt-iter 1.0 x))
(if trace_enable
  (trace good-enough?)
  '())
(newline)
(display "0th by precision:")
(newline)
(display (sqrt 0.000005))
(newline)
(display (sqrt 1e10))
; TODO I don't know what [JESii] means in wiki. Here 1/3 = 0.\overdot{3} but `(sqrt (/ 1 9))` works fine with the limited precision
(newline)
(display (sqrt (/ 1 3)))
(newline)
(display (sqrt (/ 1 9)))
(newline)
(display (sqrt 1e-10))

; the 1th solution and the 2nd are not same where "(improve guess x)" -> "oldguess"
; 1st
(define (good-enough? guess x) 
  (< (abs (- (improve guess x) guess)) 
     (* guess .001))) 
(newline)
(newline)
(display "1st solution:")
(newline)
; (trace good-enough?)
(display (sqrt 0.000005))
; [Chan] maybe for "It returns the same value to first solution". But I have the different results maybe due to the different compiler optimization's.
(newline)
(display (sqrt 0.0001))
(newline)
(display (sqrt 100000000))

; IMHO the / is weird since that will make 2 relative comparisons plus `(* guess 0.0001)`.
; 
; > Another take on the good-enough? function 
; This doesn't care about refinement but cares about whether enough approach x.
(define (good-enough? guess x) 
  (< (abs (- (square guess) x)) (* guess 0.0001))) 
(newline)
(newline)
; (trace good-enough?)
(display (sqrt 0.000005))
(newline)
(display (sqrt 1e-10))

; [robwebbjr]
; Ignore: solution by "/ guess" is wrong with the worser precision when guess is one very large number.
; [robwebbjr] and [torinmr] since $guess^2 \approx x$
(define (good-enough? guess x) 
  (< (/ (abs (- (square guess) x)) guess) (* guess 0.0001))) 
(newline)
(display "robwebbjr:")
(newline)
(display (sqrt 0.000005))
(newline)
; (trace improve)
(display (sqrt 1e-10))

; [torinmr] 
; Ignore: still has the problem as [robwebbjr] solution where `x>guess` causes the worser precision when x is one very large number.
; But it is better than [robwebbjr]
(define (good-enough? guess x) 
  (< (abs (- (square guess) x)) (* x 0.0001))) 
(newline)
(newline)
; (trace good-enough?)
(display "torinmr:")
(newline)
(display (sqrt 0.000005))
(newline)
(display (sqrt 1e10))

; 1st modified which is same as the 2nd solution
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
    (improve guess x)
    (sqrt-iter (improve guess x)
               x)))
(define (good-enough? guess x) 
  (< (abs (- (improve guess x) guess)) 
     (* (improve guess x) .001)))
(newline)
(newline)
; (trace good-enough?)
(display (sqrt 0.000005))

; just one more iteration is enough by choosing "(improve guess x)" as the above shows.
(define (good-enough? guess x) 
  (< (abs (- (improve guess x) guess)) 
     (* guess .001)))
(newline)
(newline)
; (trace good-enough?)
(display "1st with one more iteration: ")
(newline)
(display (sqrt 0.000005))

; using the wiki version
(define (sqrt-iter-3 guess oldguess x) 
  (if (good-enough? guess oldguess) 
    guess 
    (sqrt-iter-3 (improve guess x) guess 
                 x))) 

(define (good-enough? guess oldguess) 
  (< (abs (- guess oldguess)) 
     (* guess 0.001))) 

(define (sqrt x) 
  (sqrt-iter-3 1.0 2.0 x))
(newline)
(newline)
; (trace good-enough?)
(display "2nd: ")
(newline)
(display (sqrt 0.000005))
(newline)
(display (sqrt 1e10))
; (newline)
; (display (sqrt 1e-10))

;;;;;;;;;;;;;;;;;;;;;;;; [tnvu] is same as my original solution except that mine is using oldguess.
; GWB is same as the 0th.

;;;;;;;;;;;;;;;;;;;;;;;; [Sreeram]
(define (good-enough? guess x) 
  (< (abs (- (square guess) x)) (* x 0.1))) 

; I changed this to be compatible with MIT-scheme
#|
Here we should not use "sqrt-iter-3" which uses one incompatible "good-enough?" with the above definition. Otherwise the infinite loop.
This can be checked by log `scheme < ~/SICP/problems_codes/1/1_7.scm --silent > ~/1_7.log` OR split this part out as one separate file.
|#
(define (small-enuf guess x) 
  ( <= 
    (abs (- (square guess) x) )
    (abs (- (square (improve guess x)) x))) )

(define (sqrt-iter guess x) 
  (if (good-enough? guess x) 
    (if (small-enuf guess x) 
      guess 
      (sqrt-iter (improve guess x) x))  
    (sqrt-iter (improve guess x) x)))
; (trace small-enuf)
; (trace sqrt-iter)
; (trace improve)
; (trace good-enough?)
; Ignore: Here the infinite loop will be `(sqrt guess)` -> 
; (sqrt-iter 1 1e-10)

(define (sqrt x)
  (sqrt-iter 1.0 x))
(newline)
(display (sqrt-iter 1 1e-10))

; directly "repeatedly funnelling down" is fine.
(define (sqrt-iter guess x) 
  (if (small-enuf guess x) 
    guess 
    (sqrt-iter (improve guess x) x)))
(newline)
(display (sqrt-iter 1 1e-10))
