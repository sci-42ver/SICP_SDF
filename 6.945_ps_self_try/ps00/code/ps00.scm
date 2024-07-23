(load "load.scm")

;;; 1
(modulo 13 8)
; -> ?
(remainder 13 8)
; -> ?
(modulo -13 8)
; -> ?
(remainder -13 8) ; -> ?
(modulo -13 -8)
; -> ?
(remainder -13 -8) ; -> ?

;; > What is the difference between remainder and modulo?
;; See https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_8.html#IDX212
;; From now on, all >> in the code means reference in the link instead of the pdf.
;; >> n_m has the same sign as n2. 
; modulo is better.

(define +mod
  (lambda (a b n)
    (modulo (+ a b) n)))
(define -mod
  (lambda (a b n)
    (modulo (- a b) n)))
(define *mod
  (lambda (a b n)
    (modulo (* a b) n)))
(= (+mod 7 5 8) 4)
(= (+mod 10 10 3) 2)
(= (-mod 5 12 2) 1)
(= (*mod 6 6 9) 0)
(+mod 99 99 100) ; -> ?
(*mod 50 -3 100) ; -> ?

;; Notice that the procedures you wrote for modular addition, subtraction, and multiplication are almost all the same. Time for abstraction!
(define (modular n op)
  (lambda (a b)
    (modulo (op a b) n)))
(define *mod
  (lambda (a b n)
    ((modular n *) a b)))
(= (*mod 6 6 9) 0)
(*mod 50 -3 100)

(define +m12 (modular 12 +))
(define -m12 (modular 12 -))
(define *m12 (modular 12 *))

(= (-m12 (*m12 (+m12 5 8) 3) 7) 8)

(= ((modular 17 +) 13 11) 7)
(= ((modular 17 -) 13 11) 2)
(= ((modular 17 *) 13 11) 7)

;;; 2
(trace slow-exptmod)
((slow-exptmod 10) 2 14)
;; both \Theta(log n). recursive
(define (exptmod p)
  (let ((mod* (modular p *)))
    (define (square x)
      (mod* x x))
    (define (em base exponent)
      ;; copyed from SICP fast-expt.
      (cond ((= exponent 0) 1)
            ((even? exponent) (square (em base (/ exponent 2))))
            (else (mod* base (em base (- exponent 1)))))) ; not use * directly.
    em))

(= ((exptmod 10) 2 0) 1)
(= ((exptmod 10) 2 3) 8)
(= ((exptmod 10) 3 4) 1)
(= ((exptmod 100) 2 15) 68)
(= ((exptmod 100) -5 3) 75)

;;; 3
(define radix 10)
;; Here all call internal functions `map, random, iota, `, assume it to be \Theta(1) complexity.
(define (random-k-digit-number k)
  (define (random-k-digits)
    (map (lambda (num) (random radix)) (iota k)))
  ;; from `p0utils.scm`.
  (join-numbers (random-k-digits) radix))
(random-k-digit-number 1) 
(random-k-digit-number 3) ; -> 620 
(random-k-digit-number 3) ; -> 588 (is it different?): Yes
(random-k-digit-number 50)

;; Here all call internal functions, assume it to be same as `split-number` \Theta(log n).
(define (count-digits num)
  (length (split-number num radix)))

(= (count-digits 3) 1)
(= (count-digits 2007) 4)
(= (count-digits 123456789) 9)

;; Same as `count-digits` plus `random-k-digit-number` although the tried count depends on probability.
;; \Theta(log n)
(define (big-random max)
  (define digit (count-digits max))
  ;; This is a bit unnecessarily complexer. See 6.945_assignment_solution which uses func parameter to ensure only one call of `random-k-digit-number`.
  (define (try)
    (let ((random_num (random-k-digit-number digit)))
      (if (< random_num max) ; ensure "[0, p − 1]".
        random_num
        (try))))
  (try))

(big-random 100) ; -> ?? (1-2 digit number)
(big-random 100) ; -> ?? (is it different?): Yes
(= (big-random 1) 0)
(= (big-random 1) 0)
(big-random (expt 10 40)) ; -> ????... (roughly 40-digit number)

;;; 4
;; > “We only have to check factors less than or equal to √n.”
;; \Theta(\sqrt{n}).

;; > “We only have to check odd factors (and 2, as a special case).”
;; Still \Theta(n).

;; > Test Fermat’s Little Theorem using your exptmod procedure and a few suitable choices of a and p.
(define prime_lst '(5 23 829 7243))
(define a 67)
(map (lambda (num) (= ((exptmod num) a num) ((exptmod num) a 1))) prime_lst)

;; from SICP
;; depends on `exptmod`, i.e. `big-random`. So \Theta(log n).
(define (fermat-test n)
  ;; https://stackoverflow.com/q/78767596/21294350
  (define (expmod a exp base)
    ((exptmod base) a exp))
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (big-random (- n 1)))))
(fermat-test 2)
; (fermat-test 1) ; this will have the endless loop due to `(< random_num max)`.

(define prime-test-iterations 20)
;; This has the same complexity as `fermat-test` \Theta(log n). iterative.
(define (prime? p)
  (define (fast-prime? n times)
    (cond ((= times 0) true)
          ((fermat-test n) (fast-prime? n (- times 1)))
          (else false)))
  (if (< p 2)
    #f
    (fast-prime? p prime-test-iterations)))

(eq? (prime? 2) #t) ; -> #t
(eq? (prime? 4) #f) ; -> #f
(eq? (prime? 1) #f) ; -> #f
(eq? (prime? 0) #f) ; -> #f
(eq? (prime? 200) #f) ; -> ?
(eq? (prime? 199) #t) ; -> ?

;;; 5

;; > In what ways can your random-prime procedure fail?
;; As "; Not always 100." implies since the range starts from 0.
;; See 6.945_assignment_solution for the more serious error.
(define random-k-digit-prime
  (lambda (k)
    (define max_num (expt radix k))
    ;; here giving one function without parameter may be unnecessary. See 6.945_assignment_solution.
    (define (try)
      (let ((cand (big-random max_num)))
        (if (prime? cand)
          cand
          (try))))
    (try)))
(random-k-digit-prime 1)
(random-k-digit-prime 2)
(random-k-digit-prime 10)
; (count-digits (random-k-digit-prime 100)) ; Not always 100.
; 100
; (count-digits (random-k-digit-prime 100)) 
; 99

;;; 6: This is just the Euclidean_algorithm since gcd(a,b)=1 -> ax+by=1
;; from SICP
(define (gcd a b)
  (if (= b 0)
    a
    (gcd b (remainder a b))))
;; Need a small tweak to output more infos.
(define ax+by=1
  (lambda (a b)
    (let ((rem (remainder a b))
          (quot (quotient a b)))
      (cond ((= rem 0) (list 0 0)) ; implies error
            ((= rem 1) (list 1 (- quot)))
            (else (let* ((res (ax+by=1 b rem))
                         (x_quote (car res))
                         (y_quote (cadr res)))
                    (list y_quote (- x_quote (* quot y_quote)))))))))
(ax+by=1 17 13)
;; https://stackoverflow.com/a/1450776/21294350
; (eq? (ax+by=1 17 13) '(-3 4))
(equal? (ax+by=1 17 13) '(-3 4))
(ax+by=1 7 3)
(equal? (ax+by=1 7 3) '(1 -2))
(ax+by=1 10 27)
(equal? (ax+by=1 10 27) '(-8 3))

;; based on `ax+by=1`, error -> 0 since 0+n*k\neq 1
(define (inversemod n)
  (lambda (e)
    (modulo (car (ax+by=1 e n)) n)))

(= ((inversemod 11) 5) 9) ; -> 9 5*9 = 45 = 1 (mod 11)
(= ((inversemod 11) 9) 5) ; -> 5
(= ((inversemod 11) 7) 8) ; -> 8 7*8 = 56 = 1 (mod 11)
(= ((inversemod 12) 5) 5) ; -> 5 5*5 = 25 = 1 (mod 12)
(= ((inversemod 12) 8) 0) ; -> error gcd(8,12)=4, so no inverse exists
(define tmp_rdm (random-k-digit-prime 2))
(= (*mod tmp_rdm ((inversemod 101) tmp_rdm) 101) 1)

;;; 7
(define (eg-send-message message receiver)
  (let (
        ; (public-key (car receiver))
        ;; from `Eve`.
        (public-key (eg-receiver-public-key receiver))
        (decryption-procedure (eg-receiver-decryption-procedure receiver))
        )
    (let ((dh-system (car public-key)) ; See 6.945_assignment_solution. Here abstraction is better.
          (advertised-number (cdr public-key)) ; P
          )
      (let* ((root (dh-system-primitive-root dh-system)) ; same as `p0utils.scm`
             ;; borrowed from `p0utils.scm`
             (k (dh-system-size dh-system))
             (p (dh-system-prime dh-system))
             (my-secret (random-k-digit-number k)) ; T
             (mod-expt (exptmod p))
             (mod-* (modular p *))
             )
        (let* ((x (mod-expt root my-secret))

               (m_num (string->integer message))
               (y (mod-* m_num (mod-expt advertised-number my-secret)))

               (encrypt_msg (cons x y)) ; better eg-make-ciphertext
               )
          (decryption-procedure encrypt_msg))))))

(define dh-system
  (public-dh-system 100))

(define Alyssa
  (eg-receiver dh-system))

(eg-send-message "Hi there." Alyssa)
;; > Demonstrate your eg-send-message with a few short strings sent from Ben to Alyssa.
;; Same as `p0utils.scm` output.
(eg-send-message "\u3293\u5953\uabab" Alyssa) ; len: 15
(eg-send-message "\u0000\u0000\u0000" Alyssa)

;; depends on `join-numbers` base.
(string->integer "") ; -> 1

;; > What is the longest string you can send that will be correctly decrypted with a 100 digit system?
;; \lceil \log_{256}(10^{100}-1)\rceil
(floor (/ (log (- (expt 10 100) 1)) (log 256)))

(define (Eve receiver)
  (let ((receiver-public-key
          (eg-receiver-public-key receiver))
        (receiver-decryption-procedure
          (eg-receiver-decryption-procedure receiver)))
    (let ((my-spying-procedure
            (lambda (ciphertext)
              (write ciphertext) ; find the msg is one integer pair with almost 100 digits
              (newline)
              ; (receiver-decryption-procedure ciphertext))))

              (define rdm_num (random-k-digit-number 100))
              (define (mod_num num)
                (abs (- num rdm_num))) ; same as ciphertext: > 0, 
              ;; > Modify the Eve program to make it possible for Eve to make trouble in the relationship.
              ;; just change the integer
              ;; The simple method is to drop some numbers

              ;; better use `eg-send-message` to select the receiver so that Eve can act as one 
              (receiver-decryption-procedure (cons (mod_num (car ciphertext)) (mod_num (cdr ciphertext)))))))
      (eg-make-receiver receiver-public-key
                        my-spying-procedure))))
(define Alyssa (Eve Alyssa))
(eg-send-message "Hi there." Alyssa)
; > Explain and demonstrate your nasty trick.
; very weird output like ".¯\x9e;éªÄØs \x9e;ÈBrÐ%çªÛd\x12;MeX&·©z\x19;ãôWUß\x93;;/\x11;軧e\x1;" 
; Here I won't dig into the reason since it depends on `random` and terminal output cfg.
