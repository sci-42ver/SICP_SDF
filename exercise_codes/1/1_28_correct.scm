(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
          (remainder (* base (expmod base (- exp 1) m))
                     m))))

#|
NOTICE this is right while the above based on the book is wrong
Thanks to tiendo1011.
|#
(define (display-all . vs) 
  (for-each display vs)) 

(define (find-e-k n) 
  (define (find-e-k-iter possible-k possible-e) 
    (if (= (remainder possible-k 2) 0) 
      (find-e-k-iter (/ possible-k 2) (+ possible-e 1)) 
      (values possible-e possible-k))) 
  (find-e-k-iter (- n 1) 0)) 

; first-witness-case-test: (a ^ k) mod n # 1 
(define (first-witness-case-test a k n) 
  (not (= (expmod a k n) 1))) 

; second-witness-case-test: all a ^ ((2 ^ i) * k) (with i = {0..e-1}) mod n # (n - 1) 
(define (second-witness-case-test a e k n) 
  (define (second-witness-case-test-iter a i k n) 
    (cond ((= i -1) true) 
          (else (let () 
                  (define witness (not (= (expmod a (* (fast-expt 2 i) k) n) (- n 1)))) 
                  (if witness 
                    (second-witness-case-test-iter a (- i 1) k n) 
                    false))))) 
  (second-witness-case-test-iter a (- e 1) k n)) 

(define (miller-rabin-test n) 
  (define (try-it a e k) 
    (if (and (first-witness-case-test a k n) (second-witness-case-test a e k n)) 
      (begin
        (display-all "\nis not prime, with a = " a)
        ; (try-it (+ a 1) e k)) ; track all a to test "at least half the numbers a < n" in SO.
        ())
      (if (< a (- n 1)) 
        (try-it (+ a 1) e k) ; (+ a 1) up to n-1
        (display "is prime\n")))) 
  (cond ((< n 2) (display "not prime")) ; assume n>0
        ((= (remainder n 2) 0) (display "not prime\n")) 
        (else (let () 
                ; This is R7RS https://docs.scheme.org/guide/multiple-values/ https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/R7RS.html
                (define-values (e k) (find-e-k n)) 
                (try-it 1 e k))))) 
(miller-rabin-test 9)
