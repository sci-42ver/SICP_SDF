;;; simplification with the same main part as 4_48.scm
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; attributive adjective
(define attributive-adjectives '(attributive-adjective main))
;; i.e. both "dark thing" and "thing is dark" are fine
(define normal-adjectives '(normal-adjective blue beautiful dark stormy))
;; @recognize: one or more adjectives before one noun
(define (parse-attributive-adjective)
  (amb (parse-adj-word-check-ordering attributive-adjectives) (parse-adj-word-check-ordering normal-adjectives)))
;; Here gives one demo for ranks between 2 types: "Issues of opinion" and "Size and length".
(define rank-1-adjs '(opinion-adj interesting attractive))
(define rank-2-adjs '(size-adj large long))
(define normal-adjectives (append normal-adjectives (cdr rank-1-adjs) (cdr rank-2-adjs)))
(define (adjective-rank adjective)
  (cond 
    ((memq adjective (cdr rank-1-adjs)) 1)
    ((memq adjective (cdr rank-2-adjs)) 2)
    (else 0) ;; no requirement about the relevant ordering
    ))
(define *old-rank-number* 0)
(define (parse-adj-word-check-ordering word-list)
  (require (not (null? *unparsed*)))
  (require (memq (car *unparsed*) (cdr word-list)))
  (let ((found-word (car *unparsed*)))
    (set! *unparsed* (cdr *unparsed*))
    (let ((rank (adjective-rank found-word)))
      (let ((no-rank-checking (= rank 0)))
        (display (list found-word rank *old-rank-number*))
        (require (or no-rank-checking (>= rank *old-rank-number*)))
        ;; will be automatically restored when backtracking similar to *unparsed*
        ;; This set! is only restored when we can backtrack, i.e. no abort when "There are no more values of".
        ;; And also we won't backtrack when finding one valid solution. So see "Same as parse".
        (set! *old-rank-number* rank)
        (list (car word-list) found-word)
        )
      )))
;; pass procedure to ensure evaluation ordering.
(define (parse-adjs specific-parse-proc connector-proc)
  ;; Same as parse, reinit when doing one new parse-adjs.
  (set! *old-rank-number* 0)
  ;;; Similar to maybe-extend. But here we consider these words (instead of phrases) as the parallel relation instead of nested relations by adding one tag each recursion.
  (define (list-of phrase-lst)
    (amb phrase-lst
         (append 
          phrase-lst 
          (connector-proc) 
          (list-of (list (specific-parse-proc)))
          )))
  (list-of (list 'adjective (specific-parse-proc)))
  )
(define (parse-attributive-adjective-noun-phrase)
  (list 'attributive-adjective-noun-phrase
        (parse-word articles)
        (parse-adjs parse-attributive-adjective (lambda () 'parse-nothing '()))
        (parse-word nouns)))

(define (parse-noun-phrase)
  ;; unchanged
  (define (maybe-extend noun-phrase)
    (amb noun-phrase
         (maybe-extend (list 'noun-phrase
                             noun-phrase
                             (parse-prepositional-phrase)))))
  (amb 
    (maybe-extend (parse-simple-noun-phrase))
    ;; added
    (maybe-extend (parse-attributive-adjective-noun-phrase))
    )
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; test1
;; notice to put verb etc as car as parse-word requires.
(define verbs (append verbs '(appears)))
(define nouns (append nouns '(cloud west)))
(parse '(the blue beautiful cloud appears in the west))
'(sentence 
  (attributive-adjective-noun-phrase 
    (article the)
    (adjective (normal-adjective blue) (normal-adjective beautiful)) 
    (noun cloud)) 
  (verb-phrase (verb appears) (prep-phrase (prep in) (simple-noun-phrase (article the) (noun west)))))
;; test ordering
(parse '(the blue interesting cloud appears in the west))
'(sentence 
  (attributive-adjective-noun-phrase (article the) 
    (adjective (normal-adjective blue) (normal-adjective interesting)) (noun cloud)) 
  (verb-phrase (verb appears) (prep-phrase (prep in) (simple-noun-phrase (article the) (noun west)))))
(parse '(the blue interesting large cloud appears in the west))
;; has
'(adjective (normal-adjective blue) (normal-adjective interesting) (normal-adjective large))
(parse '(the blue large interesting cloud appears in the west)) ; fail
(define (original-demo-test)
  (assert 
    (equal? 
      (parse '(the student with the cat sleeps in the class))
      '(sentence (noun-phrase (simple-noun-phrase (article the) (noun student)) (prep-phrase (prep with) (simple-noun-phrase (article the) (noun cat)))) (verb-phrase (verb sleeps) (prep-phrase (prep in) (simple-noun-phrase (article the) (noun class)))))
      )))
(original-demo-test)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; predicative adjective
(define predicative-verbs '(predicative-verb be is are am was were seem appear become get look feel sound taste smell))
;; after be, got etc
(define predicative-adjectives '(predicative-adjective afraid))
(define predicative-adjective-connector '(predicative-adjective-connector and))

(define (parse-predicative-adjective)
  (amb (parse-word predicative-adjectives) (parse-word normal-adjectives)))
(define (parse-predicative-adjective-phrase)
  ;; From ucl link: 1. for verb
  ;; > When two or more adjectives come after one of these verbs, they should be separated by and ("The sky looked dark and stormy")
  (parse-adjs parse-predicative-adjective (lambda () (list (parse-word predicative-adjective-connector)))))
(define (parse-predicative-verb-with-adj)
  ;; Similar to wiki parse-simple-verb.
  (define (maybe-add verb-phrase)
    (amb verb-phrase
         (maybe-add (list 'predicative-verb-phrase
                             verb-phrase
                             (parse-predicative-adjective-phrase)))))
  (maybe-add (parse-word predicative-verbs)))
(define (parse-verb-phrase)
  (define (maybe-extend verb-phrase)
    (amb verb-phrase
         (maybe-extend (list 'verb-phrase
                             verb-phrase
                             (parse-prepositional-phrase)))))
  (maybe-extend 
    (amb 
      (parse-word verbs)
      ;; similar to parse-noun-phrase.
      (parse-predicative-verb-with-adj)
      )))

(original-demo-test)
(define nouns (append nouns '(sky)))
;; here use look due to the above predicative-verbs as one demo.
(parse '(the blue beautiful sky look dark and stormy in the west))
'(sentence 
  (attributive-adjective-noun-phrase (article the) (adjective (normal-adjective blue) (normal-adjective beautiful)) (noun sky)) 
  (verb-phrase 
    (predicative-verb-phrase 
      (predicative-verb look) 
      (adjective (normal-adjective dark) (predicative-adjective-connector and) (normal-adjective stormy))) 
    (prep-phrase (prep in) (simple-noun-phrase (article the) (noun west)))))