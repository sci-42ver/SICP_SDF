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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Adjective
;; https://www.britannica.com/dictionary/eb/qa/where-to-place-adjectives
;; Adjective
;; 0. for noun: *multiple* adjectives placed in front of nouns
;; 0.a. ordering.
;; 0.b. (skipped. see below.) can also after (i.e. "postpositive") https://www.ucl.ac.uk/internet-grammar/adjectiv/postpos.htm
;; 1. See the following "verb with Adjective" for adjectives *after* the verb.

;; So in summary, we only consider 
;; 0. Adjective number
;; 1. Adjective location.
;; 2. Adjective ordering.

;; see ucl link "main reason"
;; > Most adjectives can freely occur in both the attributive and the predicative positions.
;; > However, a small number of adjectives are restricted to *one position only*.
(define attributive-adjectives '(attributive-adjective main))

;; > obligatory when the adjective modifies a *pronoun*
;; > found together with *superlative, attributive* adjectives:
;; "something useful"
;; skipped due to "pronoun" and "superlative"
; (define postpositive-adjectives '(postpositive-adjective useful possible))

;; i.e. both "dark thing" and "thing is dark" are fine
(define normal-adjectives '(normal-adjective blue beautiful dark stormy))

;; IGNORE: Since these adjectives are not describing with each other, so maybe-extend is not appropriate IMHO.
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
  ;;; 0. check 4.47 problem existence by searching internal definitions. This probably works since we probably write recursion based on that assumption.
  ;; Same as the book original one, immediate abortion when connector-proc/specific-parse-proc fails.
  ;;; 1. Similar to maybe-extend. But here we consider these words (instead of phrases) as the parallel relation instead of nested relations by adding one tag each recursion.
  (define (list-of phrase-lst)
    (amb phrase-lst
         (append 
          phrase-lst 
          (connector-proc) 
          (list-of (list (specific-parse-proc)))
          ; (list (specific-parse-proc))
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; verb with Adjective
;; from britannica
; (define be '(be is are am was were))
; (define predicative-verbs '(predicative-verb be seem appear become get look feel sound taste smell))
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
  ;; 0. same structure as maybe-extend. So no 4.47 problem existence.
  ;; 1. Similar to wiki parse-simple-verb.
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; adverb
;; https://dictionary.cambridge.org/us/grammar/british-grammar/adverbs-and-adverb-phrases-position
;; > We can put adverbs and adverb phrases at the front, in the middle or at the end of a clause.
;; 1. *Suddenly* I felt afraid.
;; 2. you always have to eat *fast*.
;; 3. Apples *always* taste best
;; Similar to adj (parse-verb-phrase), just add 3 cases with amb in (parse-sentence),

;; > Adverbs usually come after the main verb be, *except* in emphatic clauses:
;; > When be is emphasised, the adverb comes before the verb:
;; Just use 2 cases based on whether adv is emphatic like the above attributive vs predicative.

;; > Where there is more than one verb, mid position means after the first auxiliary verb or after a modal verb:
;; skipped due to "more than one verb"

;; > In questions, mid position is between the subject and the main verb:
;; skipped due to "questions".

;; "Position with here and there" is related with pronoun, skipped.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Compound sentence
;; IGNORE: This is already contained in the 2nd link. Compound sentence https://www.grammarly.com/blog/sentences/compound-sentence/
  ;; > Compound sentences are easy to identify because they usually use a coordinating conjunction, which you may remember as FANBOYS: for, and, nor, but, or, yet, and so. 
  ;; > However, compound sentences can also use a *semicolon* to connect two clauses, in which case no conjunction is necessary.
  ;; i.e.
  ;; > When creating compound sentences, there are two punctuation rules
;;; Notice
;; 0. Not have run-on sentence https://www.niu.edu/writingtutorial/punctuation/run-on-sentences.shtml
;; 1. I don't know what "confusingly long compound sentences" means.
;; Compound-Complex Sentences means Complex for "dependent clauses" like "... if ..."
;;; (Can be implemented similar to parse-adjs above) examples
;; "Compound sentence examples" only shows the cases where 2 independent clauses.
;; "three independent clauses" or more see https://academicmarker.com/grammar-practice/sentences/sentence-structures/simple-and-compound-sentences/how-can-form-accurate-compound-sentences/
;; Implementation similar to parse-adjs above:
;; connector-proc just outputs (list (parse-word ,) (parse-word coordinating-conjunctions))
;; specific-parse-proc -> parse-sentence.
;; Then use (list-of (list 'compound-sentence (specific-parse-proc))).
;;; IGNORE: Why but is related with Compound sentence instead of complex sentence https://www.grammarly.com/blog/sentences/complex-sentence/
;; > A dependent clause, also known as a subordinate clause, is a clause that *cannot stand alone* as a complete sentence.
;; See https://prowritingaid.com/can-you-start-a-sentence-with-and-or-but#:~:text=But%20is%20another%20coordinating%20conjunction,stand%20alone%20as%20complete%20sentences.
;; > But is another coordinating conjunction. Like and, it’s perfectly acceptable to begin a sentence with but. But can *also act like a subordinating conjunction*.
;; 0. independent clause -> "But if you aren’t feeling well, I understand."
;; 1. dependent clause https://ell.stackexchange.com/q/359171/248956
  ;; These don't have many examples. https://www.grammarly.com/blog/parts-of-speech/subordinating-conjunctions/ https://spcollege.libguides.com/c.php?g=254288&p=1695264  https://www.monmouth.edu/resources-for-writers/documents/conjunctions.pdf/ 
;; writing recommendation
;; > In any sort of *formal* writing, do not use and or but to begin a sentence because they create sentence fragments.


;;; See this for all cases "four techniques" https://www.sjsu.edu/writingcenter/docs/handouts/Independent%20Clauses%20in%20Compound%20Sentences.pdf which is better
;; for -> 9. day, for he
;; nor -> needs change the ordering (implementation is skipped due to it needs something like "did" or "does" extracted from verb)
;; https://harpercollege.pressbooks.pub/lessonsonverbs/chapter/lesson-5-word-order-in-nor/
;; see https://www.hancockcollege.edu/writing/documents/FANBOYS.pdf for more examples.
;;; implementation for "four techniques"
;; Similar to the above with amb extension for "(list (parse-word ,) (parse-word coordinating-conjunctions))"
;;; "show contrast or relation between two ideas." etc can't be implemented with just sentences offered without *semantic analysis* which is beyond what this subsection teaches.
;; As footnote 53 says "interpretation of meaning".