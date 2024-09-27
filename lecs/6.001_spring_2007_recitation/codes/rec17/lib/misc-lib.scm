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
(define (person? obj)
  (and (instance? obj)
       (ask obj 'IS-A 'person)))

