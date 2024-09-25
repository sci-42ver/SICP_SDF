;; Use `(type-extend '[^(]*)([^()]+)` -> `$1(list $2)` to ensure type-extend work.
(load "objsys.scm")

;; Lect16 p2
(define (create-person name)
  (create-instance person name))
(define (person self name)
  (let (
        (root-part (root-object self)) ; modified for compatibility
        )
    (lambda (message)
      (case message
        ((TYPE) (lambda () (type-extend 'person (list root-part))))
        ((WHOAREYOU?)
         (lambda () name))
        ((SAY)
         (lambda (stuff) stuff))
        ((QUESTION)
         (lambda (of-whom query)
           ; person, list -> list
           ;; ask of-whom to answer self's query.
           (ask of-whom 'answer self query)))
        ((ANSWER)
         (lambda (whom query)
           ; person, list -> list
           (ask self 'say
                (cons (ask whom 'whoareyou?)
                      (append '(i do not know about)
                              query)))))
        (else (get-method message root-part))))))

(define p1 (create-person 'joe))
(ask p1 'whoareyou?)
; ; ; ; ; ; ; ; ; ; ⇒ joe
(ask p1 'say '(the sky is blue))
; ; ; ; ; ; ; ; ; ; ⇒ (the sky is blue)

(define (create-professor name)
  (create-instance professor name))

;; self will be modified by `(set-instance-handler! instance handler)`, so it will use the most parent handler.
(define (professor self name)
  (let ((person-part (person self name)))
    (lambda (message)
      (case message
        ((TYPE)
         (lambda () (type-extend 'professor (list person-part))))
        ((WHOAREYOU?)
         (lambda () (list 'prof
                          (ask person-part 'WHOAREYOU?))))
        ((LECTURE)
         (lambda (notes)
           ;; See lec p3
           (cons 'therefore (ask self 'say notes))))
        (else (get-method message person-part))))))

(define prof1 (create-professor 'fred))
(ask prof1 'say '(the sky is blue))

(define prof1 (create-professor 'fred))
(ask prof1 'whoareyou?)
; ; ; ; ; ; ; ; ⇒ (prof fred)
(ask prof1 'lecture '(the sky is blue))
; ; ; ; ; ; ; ; ⇒ (therefore the sky is blue)

(define (arrogant-prof self name)
  (let ((prof-part (professor self name)))
    (lambda (message)
      (case message
        ((TYPE)
         (lambda () (type-extend 'arrogant-prof (list prof-part))))
        ((SAY) (lambda (stuff)
                 (append (ask prof-part 'say stuff)
                         (list 'obviously))))
        ((ANSWER)
         (lambda (whom query)
           (cond ((ask whom 'is-a 'student)
                  (ask self 'say
                       '(this should be obvious to you)))
                 ((ask whom 'is-a 'professor)
                  (ask self 'say
                       (append '(but you wrote a paper about)
                               query)))
                 (else (ask prof-part 'answer whom query)))))
        (else (get-method message prof-part))))))

(define (create-singer)
  (create-instance singer))
(define (singer self)

  (let ((root-part (root-object self)))
    (lambda (message)
      (case message
        ((TYPE)
         (lambda () (type-extend 'singer (list root-part))))
        ((SAY)
         (lambda (stuff) (append stuff '(tra la la))))
        ((SING)
         (lambda () (ask self 'say '(the hills are alive))))
        (else (get-method message root-part))))))

(define (create-singing-arrogant-prof name)
  (create-instance singing-arrogant-prof name))
(define (singing-arrogant-prof self name)
  (let ((singer-part (singer self))
        (arr-prof-part (arrogant-prof self name)))
    (lambda (message)
      (case message
        ((TYPE)
         (lambda () (type-extend 'singing-arrogant-prof
                                 (list 
                                   singer-part
                                   arr-prof-part))))
        (else (get-method message singer-part
                          arr-prof-part))))))

(define sap1 (create-singing-arrogant-prof 'zoe))
(ask sap1 'whoareyou?)
(ask sap1 'TYPE)

(define (create-named-object name)
  (create-instance named-object name))
(define (named-object self name)
  (let ((root-part (root-object self)))
    (lambda (message)
      (case message
        ((TYPE)
         (lambda () (type-extend 'named-object (list root-part))))
        ((NAME) (lambda () name))
        (else (get-method message root-part))))))
(define (names-of objects)
  ; Given a list of objects, returns a list of their names.
  (map (lambda (x) (ask x 'NAME)) objects))

(load "~/SICP_SDF/exercise_codes/SICP/lib.scm")

(define (create-person name)
  (create-instance person name))
(define (person self name)
  (let ((named-part (named-object self name))
        (mother nil)
        (father nil)
        (children nil))
    (lambda (message)
      (case message
        ((TYPE) (lambda () (type-extend 'person (list named-part))))
        ((SAY) (lambda (stuff) (display stuff)))
        ((MOTHER) (lambda () mother))
        ((FATHER) (lambda () father))
        ((CHILDREN) (lambda () children))
        ((SET-MOTHER!) (lambda (mom) (set! mother mom)))
        ((SET-FATHER!) (lambda (dad) (set! father dad)))
        ((ADD-CHILD)
         (lambda (child)
           (set! children (cons child children))
           child))
        (else (get-method message named-part))))))

(define (create-mother name)
  (create-instance mother name))
(define (mother self name)
  (let ((person-part (person self name)))
    (lambda (message)
      (case message
        ((TYPE) (lambda () (type-extend 'mother (list person-part))))
        ((HAVE-CHILD)
         (lambda (dad child-name)
           (let ((child (create-person child-name)))
             (ask child 'set-mother! self)
             (ask child 'set-father! dad)
             (ask self 'add-child child)
             (ask dad 'add-child child))))
        (else (get-method message person-part))))))

(define a (create-mother 'anne))
(define b (create-person 'bob))
(ask a 'name) ;Value: anne
(ask b 'name) ;Value: bob
(ask a 'type)
;Value: (mother person named-object root)
(ask b 'type)
;Value: (person named-object root)
(define c (ask a 'have-child b 'cindy))
(define d (ask a 'have-child b 'dan))
(names-of (ask a 'children))
;Value: (dan cindy)
(names-of (ask b 'children))
;Value: (dan cindy)
(ask d 'name)
;Value: dan
(ask (ask d 'mother) 'name)
;Value: anne
