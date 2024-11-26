;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; copy these before the exercise in this subsection.
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
;; wiki list-amb is better to have one "systematic search" and ensures each time (generate) will have the same result.
;; Here random may be better for 4.50 as footnote implies. But this won't work for the structure like an-integer-between as revc says.
(define (parse-word word-list)
  (list (car word-list) (list-ref (cdr word-list) (random (- (length word-list) 1)))))
(define (generate)
  (parse-sentence))
(generate)
(generate)
try-again

;; wiki
(define (list-amb li) 
  (if (null? li) 
      (amb) 
      (amb (car li) (list-amb (cdr li)))))
(define (parse-word word-list)
  (list (car word-list) (list-amb (cdr word-list))))
(generate)
(generate)
try-again

;;; wiki test
(define (parse-word word-list)
  (require (not (null? *unparsed*)))
  (require (memq (car *unparsed*) (cdr word-list)))
  (let ((found-word (car *unparsed*)))
    (set! *unparsed* (cdr *unparsed*))
    (list-amb (cdr word-list))))   ;; change
(parse '(the student for the student studies for the student))
try-again
;; the last is changed to professor.
; (sentence (noun-phrase (simple-noun-phrase the student) (prep-phrase for (simple-noun-phrase the student))) (verb-phrase studies (prep-phrase for (simple-noun-phrase the professor))))

;;; also see 4_50_revc_mod_for_4_49.scm
;;; test
;; use more nouns to see the difference https://www.talkenglish.com/vocabulary/top-1500-nouns.aspx
(define nouns '(noun student professor cat class history way art world information map)) ;  10 nouns
;; https://www.enchantedlearning.com/wordlist/verbs.shtml
(define verbs '(verb studies lectures eats sleeps accept ache acknowledge act add admire admit admonish)) ; 12 verbs
(define articles '(article the a an)) ; just 3
;; https://www.englishclub.com/grammar/prepositions-list.php
(define prepositions '(prep for to in by with aboard about above across after against along amid among)) ; 14 preps.
;; To avoid duplicate tag influencing comparison.
(define (parse-simple-noun-phrase)
  (list (parse-word articles)
        (parse-word nouns)))
(define (parse-noun-phrase)
  (define (maybe-extend noun-phrase)
    (amb noun-phrase
         (maybe-extend (list noun-phrase
                             (parse-prepositional-phrase)))))
  (maybe-extend (parse-simple-noun-phrase)))
(define (parse-prepositional-phrase)
  (list (parse-word prepositions)
        (parse-noun-phrase)))
(define (parse-sentence)
  (list (parse-noun-phrase)
        (parse-verb-phrase)))
(define (parse-verb-phrase)
  (define (maybe-extend verb-phrase)
    (amb verb-phrase
         (maybe-extend (list verb-phrase
                             (parse-prepositional-phrase)))))
  (maybe-extend (parse-word verbs)))
(parse '(the student for the student studies for the student))
(parse '(the student for the student studies for the student))
(parse '(the student for the student studies for the student))
(parse '(the student for the student studies for the student))
(parse '(the student for the student studies for the student))
;; All are "(((the student) (for (the student))) (studies (for (the student))))"...

;; donald
;; Wrong.
(define (parse-word word-list) 
  ; (require (not (null? *unparsed*))) 
  ; (set! *unparsed* (cdr *unparsed*))
  (list (car word-list) (amb (cdr word-list))))
(generate)
(generate)
try-again
try-again
