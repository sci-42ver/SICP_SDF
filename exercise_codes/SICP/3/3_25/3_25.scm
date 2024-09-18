(define (remove-last-elem lst)
  (reverse (cdr (reverse lst))))
(define (subtable? table)
  (and
    (pair? (cdr table))
    (pair? (cadr table)) ; either record-or-subtable-s or subtable.
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

;; same behavior with assoc to return #f if failure.
(define (assoc-all key alist)
  (let ((entries (filter (lambda (entry) (equal? (car entry) key)) alist)))
    (if (null? entries)
      #f
      entries)))
(define (length<=1? lst)
  ;; = 0: only done for the input '() since key-lst with keys will either match or not (i.e. record-or-subtable-s either with value or #f).
  (or (= 0 (length lst)) (= 1 (length lst))))
(define (safe-key-lst lst)
  (if (null? lst) lst (car lst)))

; (cd "~/SICP_SDF/exercise_codes/SICP/3")
; (load "../lib.scm") ; for displayln
(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup-return-pair . keys)
      (let loop 
        ((key-lst keys)
         (table local-table))
        (let* ((key 
                 (safe-key-lst key-lst))
               (find-subtable 
                 (subtable? table))
               (record-or-subtable-s 
                 ;; See Figure 3.23
                 (if 
                   ;; to avoid match record-or-subtable-s `(#t romeo juliet)` as the subtable in test.
                   find-subtable
                   (assoc-all key (cdr table))
                   ;; i.e. we reach one key-value pair.
                   ;; But if this is matched with key-lst, then we will actually `(set-cdr! record-or-subtable-s value)` instead of keeping calling loop.
                   ;; So it is not matched.
                   #f)))
          ;; the if order can't be changed to ensure `(loop (cdr key-lst) record-or-subtable-s)` work.
          ; (displayln (list "record-or-subtable-s" record-or-subtable-s))
          (if record-or-subtable-s
            (if (>= 1 (length key-lst))
              (let ((records (filter (lambda (entry) (not (subtable? entry))) record-or-subtable-s)))
                ; (displayln (list "records" records))
                (if (= 1 (length records))
                  (car records)
                  false ; = 0
                  )
                )
              (fold 
                (lambda (record-or-subtable res) 
                  (or (loop (cdr key-lst) record-or-subtable) res))
                #f
                record-or-subtable-s))
            false)))
      )
    (define (lookup . keys)
      (let ((pair (apply lookup-return-pair keys)))
        (and pair
             (cdr pair))))
    ;; return (table key-lst) where `key-lst` is to be looked up in table.
    (define (common-prefix-lsts . keys)
      (let loop 
        ((key-lst keys)
         (table local-table))
        (let* ((key 
                 (safe-key-lst key-lst))
               (find-subtable 
                 (subtable? table))
               ;; won't search in record
               (record-or-subtable-s 
                 (if 
                   find-subtable
                   (assoc-all key (cdr table))
                   #f))
               )
          (if record-or-subtable-s
            (let ((records (filter (lambda (entry) (not (subtable? entry))) record-or-subtable-s))
                  (subtables (filter (lambda (entry) (subtable? entry)) record-or-subtable-s)))
              (if (>= 1 (length key-lst))
                (list (cons table key-lst))
                (append
                  (if (null? records)
                    '()
                    (list (cons table key-lst)) ; to avoid destroying the current record (see add-record)
                    )
                  (append-map
                    (lambda (subtable) 
                      (loop (cdr key-lst) subtable))
                    subtables
                    ))
                ))
            (list (cons table key-lst)))))
      )
    (define (find-longest-common-prefix-lst . keys)
      ; (displayln (list "(apply common-prefix-lsts keys)" keys ":" (apply common-prefix-lsts keys)))
      (let ((cand-common-prefix-lsts (apply common-prefix-lsts keys)))
        (car
          (sort 
            cand-common-prefix-lsts
            < 
            (lambda (pair) (length (cdr pair)))))))
    (define (insert! value . keys)
      ; (displayln (list "insert!" value keys))
      (let ((final-record (apply lookup-return-pair keys)))
        (if final-record
          (begin
            ; (displayln "set final-record")
            (set-cdr! final-record value))
          (let loop 
            ((key-lst keys)
             (table local-table))
            ;; Based on having checked final-record, here loop must find one record before using all key-lst or doesn't find at all.
            ;; So it must add-subtable or add-record. We just need to find where to add.
            (let* ((dest-table-keys (apply find-longest-common-prefix-lst key-lst))
                   (dest-table (car dest-table-keys))
                   (rest-key-lst (cdr dest-table-keys))
                   (cur-key 
                     (safe-key-lst rest-key-lst)))
              (if (length<=1? rest-key-lst)
                (begin
                  ; (displayln (list "add-record" value))
                  (add-record dest-table cur-key value))
                (begin
                  ; (displayln (list "add-subtable" dest-table ":" rest-key-lst value))
                  (add-subtable dest-table rest-key-lst value))))
            )))
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

(define (table-contents table)
  (table 'local-table))

(define (display-table-contents table)
  (displayln (table-contents table)))

(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "3_25_test_step.scm")
