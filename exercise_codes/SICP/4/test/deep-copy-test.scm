;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; misc test
;;; promise
(define test-pair-with-promise (cons 1 (delay (lambda (x) x))))
(define copy (list-copy test-pair-with-promise))
;; trivially, delay is like number can't be easily deep copied.
(force (cdr test-pair-with-promise))
copy
;;; proc
(define test-pair-with-proc (cons 1 (lambda (x) x)))
(define copy (list-copy test-pair-with-proc))
;; trivially, delay is like number can't be easily deep copied.
(set-cdr! test-pair-with-proc 2)
test-pair-with-proc
copy

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; definition
(define (full-copy pair)
  (if (list? pair) 
    (cons (full-copy (car pair)) (full-copy (cdr pair)))
    pair))

(define test-pair (cons 'a (lambda (x) x)))
(eq? test-pair (full-copy test-pair))

; (set-cdr! (full-copy test-pair) 'used)

; (define (list-copy list)
;   (if (null? list)
;       '()
;       (cons (car list)
;             (list-copy (cdr list)))))

(define (list-copy items)
  (if (pair? items)
    (let ((head (cons (car items) '())))
      (let loop ((list (cdr items)) (previous head))
        (if (pair? list)
          (let ((new (cons (car list) '())))
            (set-cdr! previous new)
            (loop (cdr list) new))
          (set-cdr! previous list)))
      head)
    items))

;; 0. https://stackoverflow.com/a/67626797/21294350
;; Here we don't have (id children) structure, so the traversal method needs small modification.
;; The basic ideas are same.
;; 1. See http://community.schemewiki.org/?sicp-ex-4.34 LisScheSic's 2nd comment point 1.
;; Notice make-hash-table in MIT/GNU Scheme can't work one for one key being infinite list or circular.
;; One workaround is to use one naive alist, but that may be inefficient then...
;; Anyway this manipulation should be done for hash-table APIs, so I won't dig into that.
(define (list-copy items)
  ;; These 2 both won't work for circular list at least.
  ; (define get hash-table-ref/default)
  ; (define put! hash-table-set!)
  ; (define constructor make-hash-table)

  ; (define get 1d-table/get)
  ; (define put! 1d-table/put!)
  ; (define constructor make-1d-table)

  ;; similar to wiki
  (define constructor (lambda () (list 'ignore)))
  ;; last-pair returns one reference which can be checked by
  ; (define tmp-table (list 1 2))
  ; (set-cdr! (last-pair tmp-table) (list (cons 2 3)))
  (define (put! table k v) 
    (let ((val (assq k (cdr table))))
      (if val 
        (set-cdr! val v)
        (set-cdr! (last-pair table) (list (cons k v)))))
    )
  (define (get table k default) 
    (let ((val (assq k (cdr table))))
      (or (and val (cdr val)) default)))

  (define (list-copy-internal items visited)
    ;; Here we ensure all car/cdr won't be duplicately visited.
    (if (pair? items)
      (or 
        (get visited items #f)
        (let ((head (cons (list-copy-internal (car items) visited) '())))
          ;; mark as visited and store the value which will be fulfilled later.
          (put! visited items head)
          (let loop ((list (cdr items)) (previous head))
            (if (pair? list)
              (let ((res (get visited list #f)))
                (if res
                  ;; avoid duplicately visiting the same sub-list.
                  (set-cdr! previous res)
                  ;; 0. The original one doesn't consider the case where (car list) is also one list. 
                  ;; 1. The new object is implied by cons.
                  (let ((new (cons (list-copy-internal (car list) visited) '())))
                    (set-cdr! previous new)
                    (loop (cdr list) new))))
              (set-cdr! previous list)))
          head)
        )
      ;; 0. non-pair input. This is general.
      ;; 1. This can't cause the circular case, so no need to track that by hash-table.
      ;; And it is allowed to duplicately visit one number in one traversal.
      items))
  (list-copy-internal items (constructor))
  )

(define (test)
  (assert (eq? 1 (list-copy 1)))

  (define counter 1)
  (define (check-equal-and-not-eqv left right)
    (write-line (list "test" counter "th"))
    (assert (equal? left right))
    (assert (not (eqv? left right)))
    (set! counter (+ 1 counter))
    )

  (define test-pair (cons 'a (lambda (x) x)))
  (set-cdr! (list-copy test-pair) 'used)
  (check-equal-and-not-eqv test-pair (list-copy test-pair))
  
  (define nested-pair (cons (cons 1 2) 3))
  (check-equal-and-not-eqv (car nested-pair) (car (list-copy nested-pair)))
  
  (define circular-list (cons 1 2))
  (set-cdr! circular-list circular-list)
  (check-equal-and-not-eqv circular-list (list-copy circular-list))
  )
(test)

;; check cons
(eqv? test-pair (cons (car test-pair) (cdr test-pair)))
(eq? test-pair (cons (car test-pair) (cdr test-pair)))

;; core dump
; (define (test-hash)
;   (define tmp-table (make-hash-table))
;   (hash-table-set! tmp-table circular-list circular-list)
;   ; (hash-table-ref/default tmp-table (cdr circular-list) #f)
;   )
; ; (test-hash)

(define circular-list (cons 1 2))
(set-cdr! circular-list circular-list)
(list-copy circular-list)
; #0=(1 . #0#)
(eqv? (list-copy circular-list) circular-list)
; #f
