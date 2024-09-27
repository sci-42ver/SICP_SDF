(define (named-object self name)
  (let ((root-part (root-object self)))
    (make-handler
      'named-object
      (make-methods
        'NAME    (lambda () name)
        ;; added
        'NAME-STR    (lambda () (symbol->string name))
        'INSTALL (lambda () 'installed)
        'DESTROY (lambda () 'destroyed))
      root-part)))

;; similar to SDF
(define (type? obj type)
  (and (instance? obj)
       (ask obj 'IS-A type)))
(define (person? obj)
  (type? obj 'person))

(define (not-empty? lst)
  (not (null? lst)))

(define (autonomous-person? obj)
  (type? obj 'autonomous-person))