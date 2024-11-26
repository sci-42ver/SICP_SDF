(define (parse-verb-phrase)
  (define (maybe-extend verb-phrase)
    (amb verb-phrase
         (maybe-extend (list 'verb-phrase
                             verb-phrase
                             (parse-prepositional-phrase)))))
  (maybe-extend (parse-word verbs)))
;; becomes
(define (parse-verb-phrase)
  (amb (parse-word verbs)
      (maybe-extend (list 'verb-phrase
                          (parse-word verbs)
                          (parse-prepositional-phrase))))
  )
;; then
(define (parse-verb-phrase)
  (amb (parse-word verbs)
      (amb (list 'verb-phrase
                          (parse-word verbs)
                          (parse-prepositional-phrase))
        (maybe-extend (list 'verb-phrase
                            (list 'verb-phrase
                              (parse-word verbs)
                              (parse-prepositional-phrase))
                            (parse-prepositional-phrase))))
      )
  )
;; then
(define (parse-verb-phrase)
  (amb (parse-word verbs)
      (amb (list 'verb-phrase
                          (parse-word verbs)
                          (parse-prepositional-phrase))
        (amb (list 'verb-phrase
                            (list 'verb-phrase
                              (parse-word verbs)
                              (parse-prepositional-phrase))
                            (parse-prepositional-phrase))
          (maybe-extend (list 'verb-phrase
                              (list 'verb-phrase
                                (list 'verb-phrase
                                  (parse-word verbs)
                                  (parse-prepositional-phrase))
                                (parse-prepositional-phrase))
                              (parse-prepositional-phrase)))))
      )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; compare with
(define (parse-verb-phrase)
  (amb (parse-word verbs)
       (list 'verb-phrase
             (parse-verb-phrase)
             (parse-prepositional-phrase))))
;; then
(define (parse-verb-phrase)
  (amb (parse-word verbs)
       (list 'verb-phrase
             (amb (parse-word verbs)
              (list 'verb-phrase
                    (parse-verb-phrase)
                    (parse-prepositional-phrase)))
             (parse-prepositional-phrase))))
;; which shares the former 3 cands

;;; If just see the codes, "either a verb or a verb phrase followed by a prepositional phrase" is done
;; The "any number of prepositional phrases" is implied by recursive calls.

;;; > Does the program's behavior change if we interchange the order of expressions in the amb?
;; obviously won't just like the combination doesn't change by ordering.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; see wiki. The above is wrong.
;;; > Does this work?
;; see meteorgan's which will occur when `(parse-word verbs)` fails, then calling `(parse-verb-phrase)` again will evaluate that again...
;;; > Does the program's behavior change if we interchange the order of expressions in the amb?
;; See woofy's.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; repo
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

;; added
(define (parse-verb-phrase)
  (amb (parse-word verbs)
       (list 'verb-phrase
             (parse-verb-phrase)
             (parse-prepositional-phrase))))
;; this is not one counterexample
(parse '(the professor lectures to the student with the cat))
;; use this
; (parse '(the professor to the student with the cat))