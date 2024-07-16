#lang racket

; (require berkeley)
(require (planet dyoo/simply-scheme))
(provide (all-defined-out))

;Exercise 0
;Write 5 expressions whose values are the number ten:
;1. Atom
10
;2. Compound Expression (3 Atoms)
(+ 7 3)
;3. Compound Expression (4 Atoms)
(+ 4 3 3)
;4. Compound Expression (1 Atom and 2 subexpressions)
(+ 4 (+ 2 1) (+ 2 1))
;5. Any Other Kind Expression
(+ 2 2 (+ 2 1) (+ 2 1))

;Exercise 1
(define (second wd)
  (first (bf wd)))

;;; TODO I don't know how to differentiate between word and sentence.
;1. Define first-two
(define (first-two wd)
  ; your code here
  ;; https://docs.racket-lang.org/manual@simply-scheme/index.html#%28form._%28%28lib._simply-scheme%2Fmain..rkt%29._length%29%29
  ;; Also see Booleans and Predicates -> Type Checkers
  (if (word? wd)
    (word (first wd) (second wd))
    (error "Not yet implemented"))
  )

;;2. Define two-first
(define (two-first x y)
  ; your code here
  (if (and (word? x) (word? y))
    (word (first x) (first y))
    (error "Not yet implemented"))
  )

;;3. Define two-first-sent
(define (two-first-sent sent)
  ; your code here
  (if (and (sentence? sent) (= (length sent) 2))
    (word (first (first sent)) (first (second sent)))
    (error "Not yet implemented"))
  )

; in zsh: num=2;sudo racket -tm ~/SICP/CS_61AS_chapter_0/hw0-1/grader.rkt -- hw0-${num}-tests.rkt hw0-${num}.rkt "teen?"
;Exercise 2 - Define teen?
(define (teen? num)
  ; your code here
  (if (number? num)
    (if (and (>= num 13) (<= num 19))
      #t
      #f)
    (error "Not yet implemented"))
  )

;Exercise 3 - Define indef-article
(define (vowel? letter)
  (member? letter 'aeiouAEIOU))
(define (indef-article wd)
  ; your code here
  (if (word? wd)
    (if (vowel? (first wd))
      (sentence 'an wd)
      (sentence 'a wd))
    (error "Not yet implemented"))
  )

;Exercise 4 - Define insert-and
;; i.e. before the last word
(define (insert-and sent)
  ; your code here
  (if (and (sentence? sent) (>= (length sent) 2))
    (sentence (butlast sent) 'and (last sent))
    (error "Not yet implemented"))
  )

;Exercise 5 - Define query
(define (query sent)
  ; your code here
  (if (sentence? sent)
    (sentence (second sent) (first sent) (bl (bf (bf sent))) (word (last sent) '?))
    (error "Not yet implemented"))
  )

;Exercise 6 - Define european-time and american-time
;; a.m. p.m. is very confusing. https://qr.ae/psl1KH https://www.lsoft.com/resources/24hours.asp
(define (european-time time)
  ; your code here
  (define last_wd (last time))
  (define first_wd (first time))
  (if (and (sentence? time) 
           (or (equal? last_wd 'am) 
               (equal? last_wd 'pm)) 
           (= (length time) 2)
           (number? first_wd)
           (and (<= first_wd 12) (>= first_wd 1)))
    (if (equal? last_wd 'am)
      (if (= 12 first_wd) 
        0
        first_wd)
      (if (= 12 first_wd) 
        12
        (+ first_wd 12)))
    (error "Not yet implemented"))
  )

(define (american-time time)
  ; your code here
  (if (number? time)
    (cond ((= time 12) (sentence time 'pm))
      ((= time 0) '(12 am))
      ((and (<= time 11) (>= time 1)) (sentence time 'am))
      ((and (<= time 23) (>= time 13)) (sentence (- time 12) 'pm))
      (else (error "Not yet implemented")))
    (error "Not yet implemented"))
  )

;Exercise 7 - Define describe-time
(define (describe-time secs)
  ; your code here
  (define seconds secs)
  (define minutes (/ secs 60.0))
  (define hours (/ (/ secs 60.0) 60.0))
  (define days (/ (/ (/ secs 24.0) 60.0) 60.0))
  (if (number? secs)
    (cond ((and (>= secs 0) (< secs 60)) (sentence secs 'seconds))
;; Here I follow the test using only one unit.
      ((< minutes 60) (sentence minutes 'minutes))
      ((< hours 24) (sentence hours 'hours))
      ((< days 365.25) (sentence days 'days))
      (else (error "Not yet implemented")))
    (error "Not yet implemented"))
  )

;Exercise 8 - Explain why superlative doesnt work:
(define (superlative adjective object)
  (se (word adjective 'est) object))

#|

Explanation here.

|#
