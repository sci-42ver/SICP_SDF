(define (project obj)
  (apply-generic 'project obj))
(define (droppable? obj)
  (cond ((not (memq (type-tag obj) numeric-tower)) #f)
        ((eq? (type-tag obj) (car numeric-tower)) #f)
        ((equ? obj (raise-type (project obj))) #t)
        (else #f)))
(define (drop obj)
  (if (droppable? obj)
    (drop (project obj))
    obj))

(define (thingy-source thingy)
  (cond ((lambda? thingy) (list "lambda" (lambda-source thingy)))
        ((procedure? thingy) (list "procedure" (procedure-name thingy)))
        ((pair? thingy) (list "pair" (pair-source thingy)))
        (else "No source? refactor")))

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (accumulate op (op initial (car sequence)) (cdr sequence))))
(define false #f)
(define true  #t)
(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
          (let ((record (assoc key-2 (cdr subtable))))
            (if record
              (cdr record)
              false))
          false)))
    (define (insert! key-1 key-2 value)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
          (let ((record (assoc key-2 (cdr subtable))))
            (if record
              (set-cdr! record value)
              (set-cdr! subtable
                        (cons (cons key-2 value)
                              (cdr subtable)))))
          (set-cdr! local-table
                    (cons (list key-1
                                (cons key-2 value))
                          (cdr local-table)))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

(define coercion-table (make-table))
(define get-coercion (coercion-table 'lookup-proc))
(define put-coercion (coercion-table 'insert-proc!))

(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (cond ((pair? datum) (car datum))
        ((exact-integer? datum) 'integer)
        ((real? datum) 'scheme-number)
        (error "Bad tagged datum -- TYPE-TAG" datum)))

(define (contents datum)
  (cond ((pair? datum) (cdr datum))
        ((integer? datum) datum)
        ((real? datum) datum)
        (else (error "Bad tagged datum -- CONTENTS" datum))))

(define (integer? x)
  (eq? (type-tag x) 'integer))
(define (rectangular? z)
  (eq? (type-tag z) 'rectangular))

(define (polar? z)
  (eq? (type-tag z) 'polar))


(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))

(define (equ? x y)
  (apply-generic 'equ? x y))
(define (zero? x) (apply-generic 'zero? x))

(define (exp x y) (apply-generic 'exp x y))

(define (install-scheme-number-package)
  (define (tag x)
    (attach-tag 'scheme-number x))
  (put 'add '(scheme-number scheme-number)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(scheme-number scheme-number)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number)
       (lambda (x y) (tag (* x y))))
  (put 'div '(scheme-number scheme-number)
       (lambda (x y) (tag (/ x y))))
  (put 'make 'scheme-number
       (lambda (x) (tag x)))
  (put 'equ? '(scheme-number scheme-number)
       (lambda (x y) (= x y)))
  (put 'zero? '(scheme-number)
       (lambda (x) (= 0 x)))
  (put 'exp '(scheme-number scheme-number)
       (lambda (x y) (tag (expt x y))))
  (put 'project '(scheme-number)
       (lambda (x)
         (make-rational
           (exact (numerator x))
           (exact (denominator x)))))
  (put 'sine '(scheme-number) sin)
  (put 'cosine '(scheme-number) cos)
  (put 'square-root '(scheme-number) sqrt)
  (put 'arctangent '(schemer-number) atan)
  'done)

(define (sine x) (apply-generic 'sine x))
(define (cosine x) (apply-generic 'cosine x))
(define (square-root x) (apply-generic 'square-root x))
(define (arctangent x) (apply-generic 'arctangent x))

(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))

(define (install-rational-package)
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (make-rat n d)
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))
  (define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))))
  (define (div-rat x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y))))

  (define (tag x) (attach-tag 'rational x))
  (put 'add '(rational rational)
       (lambda (x y) (tag (add-rat x y))))
  (put 'sub '(rational rational)
       (lambda (x y) (tag (sub-rat x y))))
  (put 'mul '(rational rational)
       (lambda (x y) (tag (mul-rat x y))))
  (put 'div '(rational rational)
       (lambda (x y) (tag (div-rat x y))))

  (put 'make 'rational
       (lambda (n d) (tag (make-rat n d))))
  (put 'equ? '(rational rational)
       (lambda (x y) (= 0 (numer (sub-rat x y)))))
  (put 'zero? '(rational) (lambda (x) (= 0 (numer x))))
  (put 'project '(rational) (lambda (x)
                              (exact (truncate (/ (numer x) (denom x))))))
  (put 'to-real '(rational) (lambda (x) (/ (numer (contents x)) (denom (contents x)))))
  'done)

(define (make-rational n d)
  ((get 'make 'rational) n d))

(define (install-rectangular-package)

  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (make-from-real-imag x y) (cons x y))
  (define (magnitude z)
    (square-root (add (square (real-part z))
                      (square (imag-part z)))))
  (define (angle z)
    (arctangent (imag-part z) (real-part z)))
  (define (make-from-mag-ang r a)
    (cons (mul r (cosine a)) (mul r (sine a))))

  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle '(rectangular) angle)
  (put 'make-from-real-imag 'rectangular
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

(define (install-polar-package)

  (define (magnitude z) (car z))
  (define (angle z) (cdr z))
  (define (make-from-mag-ang r a) (cons r a))
  (define (real-part z)
    (mul (magnitude z) (cosine (angle z))))
  (define (imag-part z)
    (mul (magnitude z) (sine (angle z))))
  (define (make-from-real-imag x y)
    (cons (square-root (add (square x) (square y)))
          (arctangent y x)))

  (define (tag x) (attach-tag 'polar x))
  (put 'real-part '(polar) real-part)
  (put 'imag-part '(polar) imag-part)
  (put 'magnitude '(polar) magnitude)
  (put 'angle '(polar) angle)
  (put 'make-from-real-imag 'polar
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'polar
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

(define (install-complex-package)
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))
  (define (add-complex z1 z2)
    (make-from-real-imag (add (real-part z1) (real-part z2))
                         (add (imag-part z1) (imag-part z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag (sub (real-part z1) (real-part z2))
                         (sub (imag-part z1) (imag-part z2))))
  (define (mul-complex z1 z2)
    (make-from-mag-ang (mul (magnitude z1) (magnitude z2))
                       (add (angle z1) (angle z2))))
  (define (div-complex z1 z2)
    (make-from-mag-ang (div (magnitude z1) (magnitude z2))
                       (sub (angle z1) (angle z2))))
  (define (tag z) (attach-tag 'complex z))
  (put 'add '(complex complex)
       (lambda (z1 z2) (tag (add-complex z1 z2))))
  (put 'sub '(complex complex)
       (lambda (z1 z2) (tag (sub-complex z1 z2))))
  (put 'mul '(complex complex)
       (lambda (z1 z2) (tag (mul-complex z1 z2))))
  (put 'div '(complex complex)
       (lambda (z1 z2) (tag (div-complex z1 z2))))
  (put 'make-from-real-imag 'complex
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'complex
       (lambda (r a) (tag (make-from-mag-ang r a))))
  (put 'equ? '(complex complex)
       (lambda (x y) (and (= 0 (real-part (sub-complex x y)))
                          (= 0 (imag-part (sub-complex x y))))))
  (put 'equ? '(rectangular polar) equ?)
  (put 'equ? '(polar rectangular) equ?)
  (put 'zero? '(complex)
       (lambda (x) (equ? (tag x) (tag (make-from-real-imag 0 0)))))
  (put 'project '(complex) (lambda (z) (real-part z)))
  'done)

(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))

(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))

(install-rectangular-package)
(install-polar-package)
(install-rational-package)
(install-scheme-number-package)
(install-complex-package)

(put 'real-part '(complex) real-part)
(put 'imag-part '(complex) imag-part)
(put 'magnitude '(complex) magnitude)
(put 'angle '(complex) angle)

(define (apply-generic op . args)
  #;(show #t "apply-generic:entry\n")
  #;(error "debug")
  (define (variable poly) (car poly))
  (define (all-argtypes-same? . args)
    (let ((type (type-tag (car args))))
      (accumulate (lambda (x y) (and x y)) #t (map (lambda (x) (eq? type x)) args))))
  (define (coercion-if-exists? type arg-tags)
    (let ((coercion-list (map (lambda (x)
                                (if (eq? type x)
                                  identity
                                  (get-coercion x type))) arg-tags)))
      (if (accumulate (lambda (x y) (and x y)) #t coercion-list)
        coercion-list
        #f)))
  (drop (let* ((type-tags (map type-tag args))
               (proc (get op type-tags)))
          #;(show #t "apply-generic: type-tags="
          (displayed type-tags)
          " proc=" (written proc)
          " proc-source=" (thingy-source proc) "\n")
        (cond (proc (apply proc (map contents args)))
              ((= 1 (length args))
               #;(show #t "No proc found for op=" op ", type-tags=" type-tags ", arg=" (displayed args) "\n")
               (apply-generic op (raise-type (car args))))
              ((= 2 (length args))
               (cond ((and (eq? 'polynomial (car type-tags))
                           (numeric? (cadr type-tags)))
                      (apply-generic op
                                     (car args)
                                     (make-polynomial (variable (contents (car args)))
                                                      (list (list 0 (cadr args))))))
                     ((and (numeric? (car type-tags))
                           (eq? 'polynomial (cadr type-tags)))
                      (apply-generic op
                                     (make-polynomial (variable (contents (cadr args)))
                                                      (list (list 0 (car args))))
                                     (cadr args)))
                     ((and (get-coercion (car type-tags) (cadr type-tags))
                           (not (eq? (car type-tags) (cadr type-tags))))
                      (apply-generic op
                                     ((get-coercion
                                        (car type-tags)
                                        (cadr type-tags)) (car args))
                                     (cadr args)))
                     ((and (get-coercion (cadr type-tags) (car type-tags))
                           (not (eq? (car type-tags) (cadr type-tags))))
                      (apply-generic op
                                     (car args)
                                     ((get-coercion
                                        (cadr type-tags)
                                        (car type-tags)) (cadr args) )))
                     ((comparable? (car type-tags) (cadr type-tags))
                      (if
                        (type1<=type2? (car type-tags) (cadr type-tags))
                        (apply-generic op (raise-type (car args)) (cadr args))
                        (apply-generic op (car args)  (raise-type (cadr args)))))
                     (else (error "apply-generic:Incomparable types: (type-tags,args)=" type-tags args))))
              ((and (> (length args) 2) (not (all-argtypes-same? args)))
               (let types-loop ((types type-tags))
                 (let ((list-of-coercion-functions
                         (coercion-if-exists? (car types) type-tags)))
                   (if list-of-coercion-functions
                     (apply apply-generic (cons op (map (lambda (fun arg) (fun arg))
                                                        list-of-coercion-functions
                                                        args)))
                     (if (not (null? (cdr types)))
                       (types-loop (cdr types))
                       (error "apply-generic:Even coercions failed. No method for these types."))))))
              (else (error "apply-generic:No method for these types"
                           (list op type-tags)))))))
(define (scheme-number->complex n)
  (make-complex-from-real-imag (contents n) 0))
(put-coercion 'scheme-number
              'complex
              scheme-number->complex)

(put 'max3-magnitude '(complex complex complex) (lambda (z1 z2 z3)
                                                  (max (magnitude z1) (magnitude z2) (magnitude z3))))
(define (max3-magnitude x1 x2 x3) (apply-generic 'max3-magnitude x1 x2 x3))
(define (identity x) x)

(define numeric-tower (list 'integer 'rational 'scheme-number 'complex))
(define (comparable? type1 type2) (and (memq type1 numeric-tower) (memq type2 numeric-tower)))
#;(define (higher-type x)
(show #t "higher-type:x=" (displayed x) "\n")
(define (find-higher-type x types)
  (cond ((or (null? types) (null? (cdr types))) (error "No type higher than given" x types))
        ((eq? x (car types)) (cadr types))
        (else (find-higher-type x (cdr types)))))
(find-higher-type x numeric-tower))

(define (numeric? x)
  (memq x numeric-tower))
(define (polynomial? x)
  (eq? (type-tag x) 'polynomial))
(define (higher-type x)
  (let ((tail (memq x numeric-tower)))
    (cond ((eq? #f tail) (error "Type not in the tower" x))
          ((null? (cdr tail)) (error "Already the highest type:" x))
          (else (cadr tail)))))

(show #t "Test: Higher than 'integer: " (higher-type 'integer) "\n")
#;(show #t "Test: Higher than 'complex: " (higher-type 'complex) "\n")

(define (type1<=type2? type1 type2)
  (if (not (memq type1 numeric-tower))
    (error "Type 1 not in the numeric tower"))
  (if (not (memq type2 numeric-tower))
    (error "Type 2 not in the numeric tower"))
  (let loop ((types numeric-tower))
    (cond ((null? types) (error "Type 1 and type 2 are incomparable" type1 type2))
          ((eq? (car types) type1) #t)
          ((eq? (car types) type2) #f)
          (else (loop (cdr types))))))

(define (integer->rational x)
  (make-rational x 1))

(define (rational->scheme-number x)
  (make-scheme-number ((get 'to-real '(rational)) x)))
(put-coercion 'integer 'rational integer->rational)
(put-coercion 'rational 'scheme-number rational->scheme-number)

(define (raise-type x)
  #;(show #t "Raising type of: " (displayed x) "\n")
  (let ((converter (get-coercion (type-tag x) (higher-type (type-tag x)))))
    (if converter
      (converter x)
      (error "No coercion found for x" (type-tag x) x))))


(define (remainder-integer a b)
  (when (or (not (integer? a)) (not (integer? b)))
    (error "Arguments must be integers" a b))
  (remainder a b))

(put 'remainder '(integer integer) remainder-integer)
(define (remainder-generalized a b) (apply-generic 'remainder a b))


(show #t "Test 1: Subtracting complex numbers: "
      (sub
        (make-complex-from-real-imag 1.1 2)
        (make-complex-from-real-imag 0 2)) "\n")
(define (install-polynomial-package)
  #;(define (contents generic-object)
  (cdr generic-object))
(define (make-poly variable term-list)
  (cons variable term-list))
(define (variable p) (car p))
(define (term-list p)
  (cdr p))
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
(define (=number? exp num)
  (and (number? exp) (= exp num)))
(define (the-empty-termlist) '())

(define (rest-terms term-list) (cdr term-list))
(define (empty-termlist? term-list) (null? term-list))

(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))
(define (tag p) (attach-tag 'polynomial p))
(put 'make 'polynomial
     (lambda (var terms) (tag (make-poly var terms))))
#;(continued on next page)

(define (add-poly p1 p2)
  #;(show #t "add-poly: p1=" p1 ", p2=" p2 "\n")
  (if (same-variable? (variable p1) (variable p2))
    (make-poly (variable p1)
               (add-terms (term-list p1)
                          (term-list p2)))
    (let ((res (cdr (if (variable_1-order<variable_2-order (variable p1) (variable p2))
                      (add (tag p1) (tag (make-poly (variable p1) (list (make-term 0 (tag p2))))))
                      (add (tag (make-poly (variable p2) (list (make-term 0 (tag p1))))) (tag p2))))))
      #;(show #t "add-poly:result: " (displayed res) "\n") res)))

      (show #t "TestY2: poly of poly: "
            (make-poly 'x (list
                            (make-term 3 (make-poly
                                           'y (list (make-term 1 1) (make-term 0 1))))
                            (make-term 1 2)
                            (make-term 0 4))) "\n")

      (define (sub-poly p1 p2)
        (add-poly p1 (mul-poly p2 (make-poly (variable p2) (list (make-term 0 -1))))))
      (define (add-terms L1 L2)
        (cond ((empty-termlist? L1) L2)
              ((empty-termlist? L2) L1)
              (else
                (let ((t1 (first-term L1)) (t2 (first-term L2)))
                  (cond ((> (order t1) (order t2))
                         (adjoin-term
                           t1 (add-terms (rest-terms L1) L2)))
                        ((< (order t1) (order t2))
                         (adjoin-term
                           t2 (add-terms L1 (rest-terms L2))))
                        (else
                          (adjoin-term
                            (make-term (order t1)
                                       (add (coeff t1) (coeff t2)))
                            (add-terms (rest-terms L1)
                                       (rest-terms L2)))))))))


      (define (mul-poly p1 p2)
        (if (same-variable? (variable p1) (variable p2))
          (make-poly (variable p1)
                     (mul-terms (term-list p1)
                                (term-list p2)))
          (contents (if (variable_1-order<variable_2-order (variable p1) (variable p2))
                      (mul (tag p1)
                           (make-polynomial (variable p1)
                                            (adjoin-term
                                              (make-term 0
                                                         (tag p2)) (the-empty-termlist))))
                      (mul (tag p2)
                           (make-polynomial (variable p2)
                                            (adjoin-term
                                              (make-term 0
                                                         (tag p1)) (the-empty-termlist))))))
          #;(error "Polys not in same var -- MUL-POLY"
          (list p1 p2))))
    (define (div-poly p1 p2)
      (if (same-variable? (variable p1) (variable p2))
        (let ((quotient-and-remainder (div-terms (term-list p1)
                                                 (term-list p2))))
          (list (make-poly (variable p1) (car  quotient-and-remainder))
                (make-poly (variable p1) (cadr quotient-and-remainder))))
        (error "div-poly: Polys not in the same var" p1 p2)))
    (define (div-terms L1 L2)
      (if (empty-termlist? L1)
        (list (the-empty-termlist) (the-empty-termlist))
        (let ((t1 (first-term L1))
              (t2 (first-term L2)))
          (if (> (order t2) (order t1))
            (list (the-empty-termlist) L1)
            (let ((new-c (div (coeff t1) (coeff t2)))
                  (new-o (- (order t1) (order t2))))
              (let ((rest-of-result (div-terms (term-list
                                                 (sub-poly
                                                   (make-poly 'fake-var L1)
                                                   (mul-poly
                                                     (make-poly 'fake-var (list (make-term new-o new-c)))
                                                     (make-poly 'fake-var L2))))
                                               L2)
                                    ))
                #;(show #t "div-terms: rest-of-result: " (displayed rest-of-result) "\n")
                (list (adjoin-term (make-term new-o new-c) (car rest-of-result)) (cadr rest-of-result))
                ))))))
    (define (mul-terms L1 L2)
      (if (empty-termlist? L1)
        (the-empty-termlist)
        (add-terms (mul-term-by-all-terms (first-term L1) L2)
                   (mul-terms (rest-terms L1) L2))))

    (define (mul-term-by-all-terms t1 L)
      (if (empty-termlist? L)
        (the-empty-termlist)
        (let ((t2 (first-term L)))
          (adjoin-term
            (make-term (+ (order t1) (order t2))
                       (mul (coeff t1) (coeff t2)))
            (mul-term-by-all-terms t1 (rest-terms L))))))
    (define (zero-poly? poly)
      #;(show #t "zero-poly?: poly=" (displayed poly) "\n")
      (cond ((empty-termlist? (term-list poly)) #t)
            ((not (zero? (coeff (first-term (term-list poly))))) #f)
            (else (zero-poly?
                    (make-poly (variable poly)
                               (rest-terms (term-list poly)))))))

    (define (termlist-type-of term-list)
      #;(show #t "t-t-o: term-list=" (displayed term-list) "\n")
      (cond ((null? term-list) 'sparse)
            ((pair? (car term-list)) 'sparse)
            ((list? term-list) 'dense)
            (else (error "Unknown type of list" term-list))))
    (define (adjoin-term term term-list)
      ((get 'adjoin-term (termlist-type-of term-list)) term term-list))
    (define (first-term term-list)
      ((get 'first-term (termlist-type-of term-list)) term-list))
    (define (variable_1-order<variable_2-order variable_1 variable_2)
      #;(show #t "var_1-..: variable_1=" variable_1 " variable_2=" variable_2 "\n")
      #;(show #t "var12string=" (symbol->string variable_1) "var22string=" (symbol->string variable_2) "\n")
      (string<=? (symbol->string variable_1) (symbol->string variable_2)))
    (define (normalize-fully poly)
      (if (normal-polynomial? poly)
        poly
        (normalize-fully (normalize-once poly))))
    (put 'add '(polynomial polynomial)
         (lambda (p1 p2)
           #;(show #t "generic-add-poly:Polynomial dispatch found: p1="
           (displayed p1) " p2=" (displayed p2) "\n")
         (normalize-fully (tag (add-poly p1 p2)))))
  (put 'mul '(polynomial polynomial)
       (lambda (p1 p2) (normalize-fully (tag (mul-poly p1 p2)))))
  (put 'sub '(polynomial polynomial)
       (lambda (p1 p2) (tag (sub-poly p1 p2))))

  (put 'zero? '(polynomial) zero-poly?)
  (put 'div '(polynomial polynomial) div-poly)
  #;(put-coercion 'rational 'scheme-number rational->scheme-number)
  (define (monomial-flip-variables monomial)
    #;(show #t "m-f-v: monomial=" monomial "\n")
    (let* ((mono (contents monomial))
           (inner-polynomial (contents (coeff (first-term (term-list mono)))))
           (inner-poly (contents inner-polynomial))
           (outer-order (order (first-term (term-list mono))))
           (outer-var (variable mono))
           (inner-var (variable inner-polynomial))
           (inner-term-list (term-list inner-poly)))
      #;(show #t "m-f-v: inner-poly=" inner-poly "\n")
      (if (same-variable? inner-var outer-var)
        (mul
          (make-polynomial outer-var (adjoin-term (make-term outer-order 1) (the-empty-termlist)))
          (tag inner-polynomial))
        (tag (make-poly inner-var
                        (mul-term-by-all-terms (make-term
                                                 0
                                                 (make-polynomial
                                                   outer-var
                                                   (list (make-term
                                                           outer-order
                                                           1)))) inner-poly))))))
  #;(show #t "TestXX: sorting variables: Is 'x < 'y?: "
  (variable_1-order<variable_2-order 'x 'y) "\n")
#;(show #t "TestXX: sorting variables: Is 'z < 'y?: "
(variable_1-order<variable_2-order 'z 'y) "\n")
#;(show #t "TestXX: (adding two basic poly): "
(add (make-polynomial 'x (list (make-term 1 2) (make-term 0 4)))
     (make-polynomial 'y (list (make-term 2 3) (make-term 0 5)))) "\n")

(define (polynomial->sum-of-first-and-rest poly)
  #;(show #t "p->s-o-f-a-r: " (displayed poly) "\n")
  (if (zero? poly)
    poly
    (let* ((poly1 (contents poly))
           (first-monomial (tag
                             (make-poly
                               (variable poly1)
                               (list (first-term (term-list poly1)))))))
      #;(show #t "p->s-o-f-a-r: " (displayed first-monomial) "\n")
      (add
        first-monomial
        (polynomial->sum-of-first-and-rest
          (tag (make-poly (variable poly1) (rest-terms (term-list poly1)))))))))

(show #t "Test13: Expanding a polynomial as monomials: "
      (displayed
        (polynomial->sum-of-first-and-rest
          (make-polynomial 'y
                           (list (make-term 2 (make-polynomial
                                                'x
                                                (list (make-term 2 1) (make-term 0 1))))
                                 (make-term 0 2))))) "\n")

(show #t "\nTest20: start monomial: "
      (displayed (make-polynomial 'x
                                  (list
                                    (make-term
                                      2
                                      (make-polynomial
                                        'y
                                        (list
                                          (make-term 2 1) (make-term 0 1))))))) "\n")
(show #t "Test20: Flipping a monomial variable: "
      (displayed
        (monomial-flip-variables
          (make-polynomial 'x
                           (list (make-term 1 (make-polynomial
                                                'y
                                                (list
                                                  (make-term 2 1)
                                                  (make-term 0 1)))))))) "\n\n")


(define (normal-polynomial? poly)
  #;(show #t "n-p?: poly=" poly "\n")
  (cond ((not (polynomial? poly)) #t)
        ((null? (term-list (contents poly))) #t)
        (else (let* ((poly1 (contents poly))
                     (outer-var (variable poly1)))
                #;(show #t "Inner-let: outer-var=" (displayed outer-var) "\n")
                (let loop ((terms (term-list poly1)))
                  #;(show #t "n-p?-loop: terms=" (displayed terms) "\n")
                  (cond ((null? terms) #t)
                        ((not (polynomial? (coeff (first-term terms)))) (loop (rest-terms terms)))
                        ((not (variable_1-order<variable_2-order
                                outer-var
                                (variable (contents (coeff (first-term terms)))))) (begin #;(show #t "wrong variable order \n") #f))
                                                                                          ((not (normal-polynomial? (coeff (first-term terms)))) (begin #;(show #t "not normal poly\n") #f))
                                                                                                                                                        (else (loop (rest-terms terms)))))
                                                                                          ))))
                (define (normalize-once poly)
                  #;(show #t "normalize-once poly= " (displayed poly) "\n")
                  (if (zero? poly)
                    poly
                    (let* ((poly1 (contents poly))
                           (first-monomial (tag
                                             (make-poly
                                               (variable poly1)
                                               (list (make-term
                                                       (order (first-term (term-list poly1)))
                                                       (if (polynomial? (coeff (first-term (term-list poly1))))
                                                         (normalize-once (coeff (first-term (term-list poly1))))
                                                         (coeff (first-term (term-list poly1))))))))))
                      #;(show #t "p->s-o-f-a-r: " (displayed first-monomial) "\n")
                      (add
                        (if (and (polynomial?
                                   (coeff
                                     (first-term
                                       (term-list
                                         (contents first-monomial)))))
                                 (variable_1-order<variable_2-order
                                   (variable
                                     (contents
                                       (coeff
                                         (first-term
                                           (term-list
                                             (contents first-monomial))))))
                                   (variable
                                     (contents first-monomial))))
                          (monomial-flip-variables first-monomial)
                          first-monomial)
                        (polynomial->sum-of-first-and-rest
                          (tag (make-poly (variable poly1) (rest-terms (term-list poly1)))))))))

                (show #t "Test21: normal-polynomial?:start: " (displayed (make-polynomial 'y
                                                                                          (list (make-term 2 (make-polynomial
                                                                                                               'x
                                                                                                               (list (make-term 2 1) (make-term 0 1))))
                                                                                                (make-term 0 2)))) "\n")
                (show #t "Test21: normal-polynomial?:result:" (normal-polynomial? (make-polynomial 'y
                                                                                                   (list (make-term 2 (make-polynomial
                                                                                                                        'x
                                                                                                                        (list (make-term 2 1) (make-term 0 1))))
                                                                                                         (make-term 0 2)))) "\n")
                (show #t "Test22: normal-polynomial?-good:start: "
                      (displayed
                        (make-polynomial 'x
                                         (list (make-term 2 (make-polynomial
                                                              'y
                                                              (list (make-term 2 1) (make-term 0 1))))
                                               (make-term 0 2)))) "\n")
                (show #t "Test22: normal-polynomial?-good:result:"
                      (normal-polynomial?
                        (make-polynomial 'x
                                         (list (make-term 2 (make-polynomial
                                                              'y
                                                              (list (make-term 2 1) (make-term 0 1))))
                                               (make-term 0 2)))) "\n")

                (show #t "Test23:input: normalizing a bad polynomial: "
                      (make-polynomial 'y
                                       (list (make-term 2 (make-polynomial
                                                            'x
                                                            (list (make-term 2 1) (make-term 0 1))))
                                             (make-term 0 2))) "\n")
                (show #t "Test23:result: normalizing a bad polynomial: "
                      (normalize-once (make-polynomial 'y
                                                       (list (make-term 2 (make-polynomial
                                                                            'x
                                                                            (list (make-term 2 1) (make-term 0 1))))
                                                             (make-term 0 2)))) "\n")
                (show #t "Test24:input: normalizing a bad polynomial: "
                      (make-polynomial 'x
                                       (list (make-term 2 (make-polynomial
                                                            'x
                                                            (list (make-term 2 1) (make-term 0 1))))
                                             (make-term 0 2))) "\n")
                (show #t "Test24:result: normalizing a bad polynomial: "
                      (normalize-once (make-polynomial 'x
                                                       (list (make-term 2 (make-polynomial
                                                                            'x
                                                                            (list (make-term 2 1) (make-term 0 1))))
                                                             (make-term 0 2)))) "\n")


                (show #t "Test24:input: normalize-fully a bad polynomial: "
                      (make-polynomial 'y
                                       (list (make-term 2 (make-polynomial
                                                            'x
                                                            (list (make-term 2 1) (make-term 0 1))))
                                             (make-term 0 2))) "\n")
                (show #t "Test24:result: normalize-fully a bad polynomial: "
                      (normalize-fully (make-polynomial 'y
                                                        (list (make-term 2 (make-polynomial
                                                                             'x
                                                                             (list (make-term 2 1) (make-term 0 1))))
                                                              (make-term 0 2)))) "\n")



                'done)


              (define (install-polynomial-sparse-package)
                (define (coeff term) (cadr term))
                (define (first-term-sparse term-list) (car term-list))
                (define (adjoin-term-sparse term term-list)
                  (if (zero? (coeff term))
                    term-list
                    (cons term term-list)))
                (put 'adjoin-term 'sparse adjoin-term-sparse)
                (put 'first-term 'sparse first-term-sparse)
                'done)
              (install-polynomial-sparse-package)

              (define (install-polynomial-dense-package)
                (define (make-term order coeff) (list order coeff))
                (define (order term) (car term))
                (define (coeff term) (cadr term))

                (define (adjoin-term-dense term term-list)
                  (if (zero? (coeff term))
                    term-list
                    (if (> (order term) (length term-list))
                      (append (list (coeff term))
                              (make-list (- (order term) (length term-list)) 0)
                              term-list)
                      (error "adjoin-term:Appending a smaller order term. Recheck."))))
                (define (first-term-dense term-list)
                  #;(show #t "first-term-dense: " (displayed (make-term (car term-list) (length (cdr term-list)))) "\n")
                  (make-term (length (cdr term-list)) (car term-list) ))
                (put 'adjoin-term 'dense adjoin-term-dense)
                (put 'first-term 'dense first-term-dense)
                'done)
              #;(install-polynomial-dense-package)

              (define (make-polynomial var terms)
                ((get 'make 'polynomial) var terms))

              (install-polynomial-package)


              #;(show #t "Test 2: Making polynomials: "
              (make-polynomial 'x (list (list 5 1) (list 4 2))) "\n")
        #;(show #t "Test 3: Zero?: "
        (zero? (make-polynomial 'x (list (list 5 1) (list 4 2)))) "\n")
  #;(show #t "Test 4: Adding polynomials: "
  (add (make-polynomial 'x '((5 1) (4 2) (0 1)))
       (make-polynomial 'x '((5 1)))) "\n")
#;(show #t "Test 4: Zero?: " (zero? (make-polynomial 'x '((5 0) (3 1)))) "\n")

#;(show #t "Test 5: Subtracting polynomials: "
(sub (make-polynomial 'x '((5 1) (4 2) (0 1)))
     (make-polynomial 'x '((0 1)))) "\n")

#;(show #t "Test 6: Making a dense polynomial: " (make-polynomial 'x '(1 2 3 4 5)) "\n")
#;(show #t "Test 7: zero? dense polynomial: " (displayed (zero? (make-polynomial 'x '(0)))) "\n")
#;(show #t "Test 8: zero? dense polynomial: " (displayed (zero? (make-polynomial 'x '(1)))) "\n")
#;(show #t "Test 9: Adding dense polynomials: "
(add (make-polynomial 'x '(1 2 0 0 0 1))
     (make-polynomial 'x '(1 0 0 0 0 0))) "\n")
#;(show #t "Test10: Subtracting dense polynomials: "
(sub (make-polynomial 'x '(1 2 0 0 0 1))
     (make-polynomial 'x '(1 0 0 0 0 0))) "\n")
#;(show #t "Test11: Subtracting dense and sparse polynomials: "
(sub (make-polynomial 'x '(1 2 0 0 0 1))
     (make-polynomial 'x '((4 2)))) "\n")
#;(show #t "Test12: Dividing x^2 + 2x + 1 by x+1: "
(displayed
  (div (make-polynomial 'x '((2 1) (1 2) (0 1)))
       (make-polynomial 'x '(      (1 1) (0 1)))) ) "\n")
#;(show #t "Test14: Adding polynomials of two variables: "
(displayed
  (add (make-polynomial 'x '((1 1)))
       (make-polynomial 'y '((1 1))))))
#;(show #t "Test14: Adding polynomials of two variables, when one of them is nonexistant: "
(displayed
  (add (make-polynomial 'x '((1 1)))
       (make-polynomial 'y '((0 1))))))
(show #t "Test25: multiplying different variables: "
      (displayed (mul (make-polynomial 'x '((1 1)))
                      (make-polynomial 'y '((1 1))))) "\n")
