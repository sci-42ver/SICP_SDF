; (define (2args-followed-by-lst arg1 arg2 lst)
;   (cons arg1 (cons arg2 lst)))
; ; ;; see Exercise 3.50 Shade
; (define map
;   ;; having-ensured-equal-len is always #t for unary func since we don't need to ensure equal-len for that func.
;   (lambda (proc having-ensured-equal-len #!rest items)
;     ;; not stream, so assert equal lengths for all args.
;     ;; https://stackoverflow.com/a/7323738/21294350
;     (if (or having-ensured-equal-len (apply = (apply map (2args-followed-by-lst length #t items))))
;         (if (null? (car items))
;           nil
;           (cons (apply proc (apply map (2args-followed-by-lst car #t items)))
;                 ;; follow the apply structure in evaluator
;                 ;; Wrong. This (apply map (2args-followed-by-lst cdr #t items)) will be kept expanding but doing nothing.
;                 (apply map (2args-followed-by-lst proc #t (apply map (2args-followed-by-lst cdr #t items))))))
;         'arg-error)))

; (trace map)

; length
; car
; cdr

; (map square #f (iota 10))
;; not throw errors.
;Aborting!: maximum recursion depth exceeded

; (map (lambda (x y z) (+ x y z)) #f (iota 10) (map square #f (iota 10)) (map (lambda (x) (+ x x)) #f (iota 10)))

(define nil '())
(define unary-map
  (lambda (proc items)
    (if (null? items)
        nil
        (cons (proc (car items))
              (unary-map proc (cdr items))))))

(define map
  ;; Similar to Exercise 3.50 Shade
  (lambda (proc having-ensured-equal-len #!rest items)
    ;; not stream, so assert equal lengths for all args.
    ;; https://stackoverflow.com/a/7323738/21294350
    (if (or having-ensured-equal-len (apply = (unary-map length items)))
        (if (null? (car items))
          nil
          (cons (apply proc (unary-map car items))
                ;; follow the apply structure in evaluator
                (apply map (cons proc (cons #t (unary-map cdr items))))))
        'arg-error)))
; (trace map)
(map square #f (iota 10))

(define lst0 (iota 10))
(define lst1 (map square #f (iota 10)))
(define lst2 (map (lambda (x) (+ x x)) #f (iota 10)))
lst0
lst1
lst2
(map (lambda (x y z) (+ x y z)) #f lst0 lst1 lst2)
; 1 ]=> lst0
; ;Value: (0 1 2 3 4 5 6 7 8 9)

; 1 ]=> lst1
; ;Value: (0 1 4 9 16 25 36 49 64 81)

; 1 ]=> lst2
; ;Value: (0 2 4 6 8 10 12 14 16 18)

; 1 ]=> (map (lambda (x y z) (+ x y z)) #f lst0 lst1 lst2)
; ;Value: (0 4 10 18 28 40 54 70 88 108)