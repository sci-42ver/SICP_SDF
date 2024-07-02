#lang racket

; (require berkeley)
(require (planet dyoo/simply-scheme))
(provide (all-defined-out))

; Exercise 1 - Define describe-time
(define (describe-time secs)
  ; your code here
  (define seconds (remainder secs 60))
  (define minutes (remainder (quotient secs 60) 60))
  (define hours (remainder (quotient (quotient secs 60) 60) 24))
  (define days (quotient (quotient (quotient secs 24) 60) 60))
  (define data_list (list days hours minutes seconds))
  (define print_list (list 'DAYS 'HOURS 'MINUTES 'SECONDS))
  (define (date_print date_data print_list cnt)
    (cond  ((= cnt 0)
            '())
      ((and (list? date_data) (= (length date_data) cnt))
       (begin 
         (define first (car date_data))
         (if (> first 0)
           (sentence first (car print_list) (date_print (cdr date_data) (cdr print_list) (- cnt 1)))
           (date_print (cdr date_data) (cdr print_list) (- cnt 1)))))
      (else 'error)))
  ;; TODO here "SECONDS" unit, etc., differ. So it can't use recursive if no arg is tracking this value.
  (if (number? secs)
    (date_print data_list print_list 4)
    (error "Not yet implemented"))
  )

(equal? (describe-time 22222) '(6 HOURS 10 MINUTES 22 SECONDS))
(equal? (describe-time 550441) '(6 DAYS 8 HOURS 54 MINUTES 1 SECONDS))

; Exercise 2 - Define remove-once
(define (remove-once wd sent)
  ; your code here
  (define first_wd (first sent))
  (if (and (word? wd) (sentence? sent))
    (if (equal? wd first_wd)
      (bf sent)
      (sentence first_wd (remove-once wd (bf sent))))
    (error "Not yet implemented"))
  )
(equal? (remove-once 'morning '(good morning good morning)) '(good good morning))

; Exercise 3 - Define differences
(define (second wd)
  (first (bf wd)))
(define (differences nums)
  ;your code here
  (define len (length nums))
  (if (and (sentence? nums) (>= len 2))
    (let ((first_num (first nums))
          (second_num (second nums)))
      (if (= len 2)
        (- second_num first_num)
        (sentence (- second_num first_num) (differences (bf nums)))))
    (error "Not yet implemented"))
  )

(equal? (differences '(4 23 9 87 6 12)) '(19 -14 78 -81 6))

; Exercise 4 - Define location
(define (location small big)
  ; your code here
  (define (idx small big)
    (cond ((empty? big) 1) 
      ((equal? small (first big)) 1)
      (else (+ 1 (idx small (bf big))))))
  (if (and (word? small) (sentence? big))
    (if (> (idx small big) (length big))
      #f
      (idx small big))
    (error "Not yet implemented"))
  )

(= (location 'me '(you never give me your money)) 4)
(equal? (location 'i '(you never give me your money)) #f)
(= (location 'the '(the fork and the spoon)) 1)

; Exercise 5 - Define initials
(define (initials sent)
  ; your code here
  (if (sentence? sent)
    (if (equal? sent '())
      '()
      (sentence (first (first sent)) (initials (bf sent))))
    (error "Not yet implemented"))
  )
(equal? (initials '(if i needed someone)) '(i i n s))

; Exercise 6 - Define copies
(define (copies num wd)
  ; your code here
  (if (and (number? num) (word? wd) (>= num 0))
    (if (= num 0)
      '()
      (sentence wd (copies (- num 1) wd)))
    (error "Not yet implemented"))
  )

(equal? (copies 8 'spam) '(spam spam spam spam spam spam spam spam))

; Exercise 7 - Define gpa
;; TODO here I use one simple cond to return idx. In python there is one function to do this.
;; Here errors are thrown when using the wrong argument
(define (gpa grades)
  ; your code here
  (define (base-grade grade)
    (define first_char (first grade))
    (cond ((equal? 'A first_char) 4)
      ((equal? 'B first_char) 3)
      ((equal? 'C first_char) 2)
      ((equal? 'D first_char) 1)
      ((equal? 'E first_char) 0)
      (else 'error)))
  (define (grade-modifier grade)
    (define (second_char grade) 
      ; (if (= (string-length grade) 2)
      ;; TODO use count
      (if (empty? (bf grade))
        "" ; output of (word), i.e. empty word.
        (second grade)))
    (cond ((equal? (base-grade grade) 'error) 'error)
      ((equal? '- (second_char grade)) -.33)
      ((equal? '+ (second_char grade)) .33)
      ((equal? "" (second_char grade)) 0)
      (else 'error))
    )
  ; (trace base-grade)
  ; (trace grade-modifier)
  (define (gpa_helper grades)
    (if (sentence? grades)
      (if (= (length grades) 0)
        0
        ;; TODO I must use define after if https://stackoverflow.com/a/19743220/21294350 https://stackoverflow.com/a/59803561/21294350
        (+ (base-grade (first grades)) 
           (grade-modifier (first grades)) 
           (gpa_helper (bf grades))))
      (error "Not yet implemented")))
  ;; https://stackoverflow.com/a/16302176/21294350
  (define (round-off z n)
    (let ((power (expt 10 n)))
      (/ (round (* power z)) (* power 1.0))))
  (round-off (/ (gpa_helper grades) (length grades)) 2)
  )

; Here is not rounding up.
(= (gpa '(A A+ B+ B)) 3.66)

; Exercise 8 - Define repeat-words
(define (repeat-words sent)
  ; your code here
  (if (sentence? sent)
    (if (= (length sent) 0)
      '()
      (let ((first_wd (first sent)))
        (if (number? first_wd)
          (sentence (copies first_wd (second sent)) (repeat-words (bf (bf sent))))
          (sentence first_wd (repeat-words (bf sent))))))
    (error "Not yet implemented"))
  )

(equal? (repeat-words '(4 calling birds 3 french hens)) '(calling calling calling calling birds french french french hens))
(equal? (repeat-words '(the 7 samurai)) '(the samurai samurai samurai samurai samurai samurai samurai))

; Exercise 9 - Define same-shape?
(define (same-shape? sent1 sent2)
  ; your code here
  (if (and (sentence? sent1) (sentence? sent2))
    (if (not (= (length sent1) (length sent1)))
      #f
      (if (or (= (length sent1) 0) (= (length sent2) 0))
        #t
        (and (= (count (first sent1)) (count (first sent2))) (same-shape? (bf sent1) (bf sent2)))))
    (error "Not yet implemented"))
  )

(equal? (same-shape? '(the fool on the hill) '(you like me too much)) #t)
(equal? (same-shape? '(the fool on the hill) '(and your bird can sing)) #f)
