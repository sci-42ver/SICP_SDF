; (cd "~/SICP_SDF/exercise_codes/SICP/4")
; (load "lib/amb/amb-lib.scm")
;; here load can't pass definitions to (driver-loop)...
; (driver-loop)
; (load "parse-lib.scm")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; parse
(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "lib/amb/amb-lib.scm")
(driver-loop)

(define (require p)
  (if (not p) (amb)))

;; parse
(define nouns '(noun student professor cat class))
(define verbs '(verb studies lectures eats sleeps))
(define articles '(article the a))

(define (parse-word word-list)
  (require (not (null? *unparsed*)))
  (require (memq (car *unparsed*) (cdr word-list)))
  (let ((found-word (car *unparsed*)))
    (set! *unparsed* (cdr *unparsed*))
    (list (car word-list) found-word)))
(define *unparsed* '())
(define (parse input)
  (set! *unparsed* input)
  (let ((sent (parse-sentence)))
    (require (null? *unparsed*))
    sent))

(define prepositions '(prep for to in by with))
(define (parse-prepositional-phrase)
  (list 'prep-phrase
        (parse-word prepositions)
        (parse-noun-phrase)))
(define (parse-sentence)
  (list 'sentence
         (parse-noun-phrase)
         (parse-verb-phrase)))
;; complex version
(define (parse-verb-phrase)
  (define (maybe-extend verb-phrase)
    (amb verb-phrase
         (maybe-extend (list 'verb-phrase
                             verb-phrase
                             (parse-prepositional-phrase)))))
  (maybe-extend (parse-word verbs)))

(define (parse-simple-noun-phrase)
  (list 'simple-noun-phrase
        (parse-word articles)
        (parse-word nouns)))
;; complex version
(define (parse-noun-phrase)
  (define (maybe-extend noun-phrase)
    (amb noun-phrase
         (maybe-extend (list 'noun-phrase
                             noun-phrase
                             (parse-prepositional-phrase)))))
  (maybe-extend (parse-simple-noun-phrase)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; main
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; also see https://wizardbook.wordpress.com/2011/01/15/exercise-4-45/
;; I won't give one maths proof that there are actually only 5 possible interpretations.
(parse '(The professor lectures to the student in the class with the cat))
;; this means professor and cat "lectures" in the class to the student which may be outside.
; (sentence 
;   (simple-noun-phrase (article the) (noun professor)) 
;   (verb-phrase 
;     (verb-phrase 
;       (verb-phrase (verb lectures) (prep-phrase (prep to) (simple-noun-phrase (article the) (noun student)))) 
;       (prep-phrase (prep in) (simple-noun-phrase (article the) (noun class)))) 
;     (prep-phrase (prep with) (simple-noun-phrase (article the) (noun cat)))))
try-again
;; The professor lectures to the student in the class where the cat sits in.
; (sentence 
;   (simple-noun-phrase (article the) (noun professor)) 
;   (verb-phrase 
;     (verb-phrase (verb lectures) (prep-phrase (prep to) (simple-noun-phrase (article the) (noun student)))) 
;     (prep-phrase (prep in) 
;       (noun-phrase (simple-noun-phrase (article the) (noun class)) (prep-phrase (prep with) (simple-noun-phrase (article the) (noun cat)))))))
try-again
;; professor and cat "lectures to the student" which is "in the class".
; (sentence 
;   (simple-noun-phrase (article the) (noun professor)) 
;   (verb-phrase 
;     (verb-phrase (verb lectures) (prep-phrase (prep to) 
;       (noun-phrase (simple-noun-phrase (article the) (noun student)) (prep-phrase (prep in) (simple-noun-phrase (article the) (noun class)))))) 
;     (prep-phrase (prep with) (simple-noun-phrase (article the) (noun cat)))))
try-again
;; "The professor lectures to the student" which is "in the class" and "with the cat".
; (sentence 
;   (simple-noun-phrase (article the) (noun professor)) 
;   (verb-phrase (verb lectures) 
;     (prep-phrase (prep to) 
;       (noun-phrase 
;         (noun-phrase (simple-noun-phrase (article the) (noun student)) (prep-phrase (prep in) (simple-noun-phrase (article the) (noun class)))) 
;         (prep-phrase (prep with) (simple-noun-phrase (article the) (noun cat)))))))
try-again
;; "The professor lectures to the student" which is "in the class" "where the cat sits in".
; (sentence 
;   (simple-noun-phrase (article the) (noun professor)) 
;   (verb-phrase (verb lectures) 
;     (prep-phrase (prep to) 
;       (noun-phrase (simple-noun-phrase (article the) (noun student)) 
;         (prep-phrase (prep in) 
;           (noun-phrase (simple-noun-phrase (article the) (noun class)) 
;             (prep-phrase (prep with) (simple-noun-phrase (article the) (noun cat)))))))))
try-again
;;; There are no more values of