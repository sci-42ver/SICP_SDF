;; from https://www.sfu.ca/~tjd/383summer2019/scheme-amb.html
;; added
(define (1+ n)
  (+ 1 n))

(define (assert pred)
  (or pred (amb)))
(define (prime? n)
  (let ((m (sqrt n)))
    (let loop ((i 2))
      (or (< m i)
          (and (not (zero? (modulo n i)))
               (loop (+ i (if (= i 2) 1 2))))))))
(define (number-between a b)
  (let loop ((i a))
    (if (> i b)
        (amb)
      (amb i (loop (1+ i))))))
(define-syntax setof
  (syntax-rules ()
    ((_ s)
      (let ((acc '()))
        (amb (let ((v s))
               (set! acc (cons v acc))
               (fail))
             (reverse! acc))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; orig
(define (sum-prime n)
 (let* ((i (number-between 1 n))
        (j (number-between i n)))
   (assert (prime? (+ i j)))
   (list i j)))

;; e.g. (setof (factor 10)) returns all factors of 10
(define (factor n)
    (let* ((a (number-between 1 n))
           (b (number-between 1 n))
          )
        (assert (= n (* a b)))
        (assert (<= a b))
        (list a b)
    )
)

(define (truth-value)
    (amb #f #t)
)

;; (p and (q or (not p)))
(define (prob1)
    (let* ((p (truth-value))
           (q (truth-value)))
    (assert (and p (or q (not p))))
    (list p q)
))

(define (bit)
    (amb 0 1)
)

;; generate bit strings of length n
(define (nbits n)
    (cond
        ((= n 0)
            '())
        (else
            (cons (bit) (nbits (- n 1))))
    )
)

;; added
(define (test)
  (write-line (setof (sum-prime 10)))
  (write-line (setof (factor 10)))
  ; (assert (eq? '(#t #t) (prob1))) ; only (#t #t)
  (assert (equal? (list #t #t) (prob1))) ; only (#t #t)
  (write-line "will retry test due to using amb inside")
  (write-line (nbits 2))
  (write-line (amb))
  (write-line "this won't be run")
  (write-line (amb))
  )

;; from lecs/6.001_fall_2007_recitation/codes/rec20/amb-defined-by-syntax/amb-in-underlying-scheme.scm
;; not use define to avoid the above situation where (amb) will retry the entire problem. See lecs/6.001_fall_2007_recitation/codes/rec20/amb-defined-by-syntax/amb-retry-procedure/amb-in-underlying-scheme-minimal-debug.scm
; (define (set!-test)
(define-syntax set!-test
  (syntax-rules ()
    ((_)
      ;; https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Pattern-Language.html#index-syntax_002drules
      ;; Here the *entire* template must be wrapped in the parenthesis or just "an identifier, a constant"
      ;; This seems to not said in https://hipster.home.xs4all.nl/lib/scheme/gauche/define-syntax-primer.txt which said more about examples until "The template has either (begin form . forms)".
      ;; But this again is one procedure application...
      ;; 1.a. This is also implicitly shown in (pattern [guard] *exp*) https://www.gnu.org/software/guile/manual/html_node/Syntax-Case.html#index-syntax_002dcase
      (let ()
        (define global-x '(0))
        (define (test y)
          (define (demo-set! x)
            ;; since this is one special form, we can't pass one proc.
            ; (set! global-x (cons x global-x))
            (amb-set! global-x (cons x global-x))
            (write-line "finish amb-set!")
            global-x)
          (demo-set! y))
        (write-line (test (amb 1 2)))
        (write-line (amb))
        (write-line "finish all")
        ; (assert (eq? '(1 0) (test (amb 1 2))))
        ; (assert (eq? '(2 0) (amb)))
        )
      )
    )
  )
