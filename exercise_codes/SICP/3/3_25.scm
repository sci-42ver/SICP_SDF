(define (remove-last-elem lst)
  (reverse (cdr (reverse lst))))
(define (subtable? table)
  (and 
    (pair? (cdr table))
    (pair? (cadr table)) ; either record-or-subtable or subtable.
    ))
(define (add-subtable table key-lst value)
  (set-cdr! table
            (cons 
              (fold-right list (cons (last key-lst) value) (remove-last-elem key-lst))
              (cdr table))))
(define (add-record table key value)
  (set-cdr! table
            (cons (cons key value)
                  (cdr table))))
(define (assoc-all key alist)
  (filter (lambda (entry) (equal? (car entry) key)) alist))
(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup . keys)
      (let loop 
        ((key-lst keys)
          (table local-table))
        (let* ((key 
                (if (null? key-lst)
                  key-lst
                  (car key-lst)))
                (find-subtable 
                  (subtable? table))
                (record-or-subtable 
                  ;; See Figure 3.23
                  (if 
                    ;; to avoid match record-or-subtable `(#t romeo juliet)` as the subtable in test.
                    find-subtable
                    (assoc-all key alist (cdr table))
                    ;; i.e. we reach one key-value pair.
                    ;; But if this is matched with key-lst, then we will actually `(set-cdr! record-or-subtable value)` instead of keeping calling loop.
                    ;; So it is not matched.
                    #f)))
          ;; the if order can't be changed to ensure `(loop (cdr key-lst) record-or-subtable)` work.
          (if record-or-subtable
            (if (>= 1 (length key-lst))
              (cdr record-or-subtable)
              (loop (cdr key-lst) record-or-subtable))
            false))))
    (define (insert! value . keys)
      (let loop 
        ((key-lst keys)
          (table local-table))
        (let* ((key 
                (if (null? key-lst)
                  key-lst
                  (car key-lst))
                ; (car key-lst)
                )
                (find-subtable 
                  (subtable? table))
                (record-or-subtable 
                  ;; See Figure 3.23
                  (if 
                    ;; to avoid match record-or-subtable `(#t romeo juliet)` as the subtable in test.
                    find-subtable
                    (assoc key (cdr table))
                    ;; i.e. we reach one key-value pair.
                    ;; But if this is matched with key-lst, then we will actually `(set-cdr! record-or-subtable value)` instead of keeping calling loop.
                    ;; So it is not matched.
                    #f)))
          ;; only this part is changed
          (if record-or-subtable
            ;; = 0: only done for the input '() since key-lst with keys will either match or not (i.e. record-or-subtable either with value or #f).
            (if (or (= 0 (length key-lst)) (= 1 (length key-lst)))
              (if (subtable? record-or-subtable)
                (add-record table key value)
                (set-cdr! record-or-subtable value))
              (if (subtable? record-or-subtable)
                (loop (cdr key-lst) record-or-subtable)
                (add-subtable table key-lst value)))
            (cond 
              ((or (= 0 (length key-lst)) (= 1 (length key-lst)))
                (add-record table key value))
              (else
                (add-subtable table key-lst value)))))
          )
      'ok)    
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            ((eq? m 'local-table) local-table)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

;; to be compatible with the test
(define (insert! table keys value)
  (apply (table 'insert-proc!) (cons value keys)))

(define (lookup table keys)
  (apply (table 'lookup-proc) keys))

(define (assert-lookup table keys value)
  (if (not (equal? (lookup table keys) value))
    (bkpt "error" (list table keys value))))


; (define assert-lookup-counting 
;   (let ((count 0))
;     (lambda (table keys value)
;       (set! count (+ 1 count))
;       (if (not (equal? (lookup table keys) value))
;         (bkpt "error" (list count table keys value))))))

(define count 0)
(define (assert-lookup-counting table keys value) 
  (set! count (+ 1 count))
  (if (not (equal? (lookup table keys) value))
    (error "error" (list count table keys value))))

(define (table-contents table)
  (table 'local-table))

(load "3_25_test_step.scm")

; (*table* (() ("cord" . dog)) ((romeo juliet) (1.4142 (#[compiled-procedure 12 ("list" #x93) #x1c #xe49a74] (7 (1.618 . "yarn"))))) (1.4142 . pig) ((one) ((larry moe curly) . #[compiled-procedure 16 ("list" #x2) #x1c #xe2d89c])) (#[compiled-procedure 13 ("list" #x9) #x1c #xe2db7c] (1.7321 ("yarn" (cow . #t))) (7 (#[compiled-procedure 15 ("list" #x1) #x1c #xe2d824] (cow . 2))) (#[compiled-procedure 14 ("arith" #x140) #x1c #xb86784] (2.2361 (1.618 (1.4142 . 1))))) ((a . b) (#[compiled-procedure 13 ("list" #x9) #x1c #xe2db7c] . #[compiled-procedure 15 ("list" #x1) #x1c #xe2d824])) (6 (owl (#[compiled-procedure 16 ("list" #x2) #x1c #xe2d89c] ("yarn" . 2)))) (3 (cat (4 . dog))) (4 (#[compiled-procedure 13 ("list" #x9) #x1c #xe2db7c] (jay (#[compiled-procedure 16 ("list" #x2) #x1c #xe2d89c] ("twine" . #[compiled-procedure 12 ("list" #x93) #x1c #xe49a74]))))) (2.2361 (() (4 (#[compiled-procedure 14 ("arith" #x140) #x1c #xb86784] . "twine"))) (eel . #t)) ("rope" (2.2361 (cow (#t . #[compiled-procedure 16 ("list" #x2) #x1c #xe2d89c])))) (#t . 3.1416) (dog (#[compiled-procedure 12 ("list" #x93) #x1c #xe49a74] (cat (1.618 ((larry moe curly) . 3))))) (#[compiled-procedure 12 ("list" #x93) #x1c #xe49a74] ((a . b) (2 . 1)) (pig ("cord" . cat) ((1 . 2) (() (2.2361 . 3))))) (pig (eel (3 (1.618 . #[compiled-procedure 13 ("list" #x9) #x1c #xe2db7c])))) (eel (3 . 1.4142)) (3.1416 (4 . pig) (#t . #[compiled-procedure 15 ("list" #x1) #x1c #xe2d824])) (cat . 1.7321) (3 . 3.1416) (jay (6 . 1.7321) ((1 . 2) ((romeo juliet) . #[compiled-procedure 15 ("list" #x1) #x1c #xe2d824])) (#[compiled-procedure 13 ("list" #x9) #x1c #xe2db7c] ((a . b) ((larry moe curly) . 2.2361)))) ("cord" (1.4142 (1.7321 . 1.618)) (6 ((romeo juliet) (1 (4 . #t)))) (2 (1.7321 (#[compiled-procedure 12 ("list" #x93) #x1c #xe49a74] ("yarn" . 3))))) ((one) . 1) (#[compiled-procedure 14 ("arith" #x140) #x1c #xb86784] . 1.7321) (owl (fox . 4) (#[compiled-procedure 12 ("list" #x93) #x1c #xe49a74] ("twine" ("rope" . 2.2361))) (cat . 1.7321)) (#t romeo juliet) (eel . "yarn") (3 . "twine") (6 . 1.7321) (#[compiled-procedure 15 ("list" #x1) #x1c #xe2d824] ((romeo juliet) ("cord" (1.4142 (6 . 3)))) (fox 1 . 2)) (#[compiled-procedure 16 ("list" #x2) #x1c #xe2d89c] (fox (dog ((one) . #[compiled-procedure 13 ("list" #x9) #x1c #xe2db7c]))) (1.618 ((larry moe curly) ("rope" (5 . cat))))) (5 . 7) ((1 . 2) . 4) (#[compiled-procedure 13 ("list" #x9) #x1c #xe2db7c] . pig) (pig . #[compiled-procedure 15 ("list" #x1) #x1c #xe2d824]) (1 . #[compiled-procedure 16 ("list" #x2) #x1c #xe2d89c]) (2 (5 (#[compiled-procedure 16 ("list" #x2) #x1c #xe2d89c] . #[compiled-procedure 13 ("list" #x9) #x1c #xe2db7c]))) (1.618 (5 (#[compiled-procedure 13 ("list" #x9) #x1c #xe2db7c] ((romeo juliet) (7 . 4))))) (4 . 6) (jay . "rope") ("twine" (5 . cow) (#[compiled-procedure 16 ("list" #x2) #x1c #xe2d89c] . owl) (dog . "rope")) ((a . b) . 1) (fox (#[compiled-procedure 12 ("list" #x93) #x1c #xe49a74] (1.7321 ((larry moe curly) . 7))) (1 (#t ("cord" ("rope" one))))) (7 (2 (3 (6 (#[compiled-procedure 14 ("arith" #x140) #x1c #xb86784] . jay)))) (3 (6 (5 one))) (1.618 (4 (2 . pig)))) (dog . jay) ("yarn" (cow (#[compiled-procedure 13 ("list" #x9) #x1c #xe2db7c] . 1.7321)) ("cord" . 3)) (2.2361 larry moe curly) (1.7321 . 7) (() . 1.618))