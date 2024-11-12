;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; copy these before the exercise in this subsection.
(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "amb-lib.scm")
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
;; TODO Here random may be better for 4.50 as footnote implies.
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

;; donald
(define (parse-word word-list) 
  ; (require (not (null? *unparsed*))) 
  ; (set! *unparsed* (cdr *unparsed*))
  (list (car word-list) (amb (cdr word-list))))
(generate)
(generate)
try-again
try-again
