(define run_flamingo #f)
(define run_gws #f)
(define run_joe #t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; flamingo
(if run_flamingo
  ;; https://stackoverflow.com/a/16221820/21294350
  ;; Emm... but this will create one new env.
  ;; maybe necessary to avoid influence the outside env, so not allow define in "if" if not creating one new env using something like let.
  (let ()
    ;; node == ( ( pair key value ) left-ptr right-ptr ) 

    (define (entry tree) (car tree)) 
    (define (left-branch tree) (cadr tree)) 
    (define (right-branch tree) (caddr tree)) 

    (define (make-tree entry left right) 
      (list entry left right)) 

    (define (adjoin-set x set) 
      (cond ((null? set) (make-tree x '() '())) 
            ((= (car x) (car (entry set))) set) 
            ((< (car x) (car (entry set))) 
             (make-tree (entry set) 
                        (adjoin-set x (left-branch set)) 
                        (right-branch set))) 
            ((> (car x) (car (entry set))) 
             (make-tree (entry set) 
                        (left-branch set) 
                        (adjoin-set x (right-branch set)))))) 

    (define (make-table) 
      (let ((local-table '())) 

        (define (lookup key records) 
          (cond ((null? records) #f) 
                ((= key (car (entry records))) (entry records)) 
                ((< key (car (entry records))) (lookup key (left-branch records))) 
                ((> key (car (entry records))) (lookup key (right-branch records))))) 

        (define (insert! key value) 
          (let ((record (lookup key local-table))) 
            (if record 
              (set-cdr! record value) 
              (set! local-table (adjoin-set (cons key value) local-table))))) 

        (define (get key) 
          (lookup key local-table)) 

        (define (dispatch m) 
          (cond ((eq? m 'get-proc) get) 
                ((eq? m 'insert-proc) insert!) 
                ((eq? m 'print) local-table) 
                (else (error "Undefined operation -- TABLE" m)))) 
        dispatch)) 

    ; (define table (make-table)) 
    ; (define get (table 'get-proc)) 
    ; (define put (table 'insert-proc))

    (define (insert! nt keys value)  ((nt 'insert-proc) keys value) value)
    (define (lookup  nt keys)        ((nt 'get-proc) keys))
    (cd "~/SICP_SDF/exercise_codes/SICP/3/3_26_tests")
    (load "../3_25_test_step.scm")
    (load "3_25_test_step_no_nil_keys.scm")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; gws
(if run_gws
  (let ()
    (define nil '())
    ; helper methods 

    (define (make-record key value) 
      (list (cons key value) nil nil)) 
    (define (get-key record) (caar record)) 
    (define (get-value record) (cdar record)) 
    (define (set-key! record new-key) (set-car! (car record) new-key)) 
    (define (set-value! record new-value) (set-cdr! (car record) new-value)) 
    (define (get-left record) (cadr record)) 
    (define (get-right record) (caddr record)) 
    (define (set-left! record new-left) (set-car! (cdr record) new-left)) 
    (define (set-right! record new-right) (set-car! (cddr record) new-right)) 

    (define (assoc key records) 
      (cond ((null? records) false) 
            ((equal? key (get-key records)) (get-value records)) 
            ((< key (get-key records)) (assoc key (get-left records))) 
            (else (assoc key (get-right records))))) 

    (define (add-record key value table) 
      (define (iter record parent set-action) 
        (cond ((null? record) (let ((new (make-record key value))) 
                                (set-action parent new) 
                                (car new))) 
              ((equal? key (get-key record)) (set-value! record value) 
                                             (car record)) 
              ((< key (get-key record)) (iter (get-left record) record set-left!)) 
              (else (iter (get-right record) record set-right!)))) 
      (iter (cdr table) table set-cdr!)) 

    ; the procedure 

    (define (make-table) 

      (let ((local-table (list '*table*))) 

        (define (lookup keys) 
          (define (iter keys records) 
            (if (null? keys) records 
              (let ((found (assoc (car keys) records))) 
                (if found (iter (cdr keys) found) 
                  false)))) 
          (iter keys (cdr local-table))) 

        (define (insert! keys value) 
          (define (iter keys subtable) 
            (cond ((null? (cdr keys)) (add-record (car keys) value subtable)) 
                  (else (let ((new (add-record (car keys) nil subtable))) 
                          (iter (cdr keys) new))))) 
          (iter keys local-table) 
          'ok) 

        (define (print) (display local-table) (newline)) 

        (define (dispatch m) 
          (cond ((eq? m 'lookup-proc) lookup) 
                ((eq? m 'insert-proc!) insert!) 
                ((eq? m 'print) print) 
                (error "Unknown operation - TABLE" m))) 
        dispatch)) 

    ;  (define operation-table (make-table)) 
    ;  (define get (operation-table 'lookup-proc)) 
    ;  (define put (operation-table 'insert-proc!)) 
    ;  (define print-table (operation-table 'print)) 

    (define (insert! nt keys value)  ((nt 'insert-proc!) keys value) value)
    (define (lookup  nt keys)        ((nt 'lookup-proc) keys))
    (load "../3_25_test_step.scm")
    (load "3_25_test_step_no_nil_keys.scm")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sam
;; as report says, wrong.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; GP
;; see report. This only passes integer key torture test.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; joe w
; (define (make-table) 
;   (define (make-entry key value) (cons key value)) 
;   (define (entry tree) (caar tree)) 
;   (define (left-branch tree) (cadr tree)) 
;   (define (right-branch tree) (caddr tree)) 
;   (define (make-tree entry left right) 
;     (list entry left right)) 
;   (define (make-tree-node x) (make-tree x '() '())) 

;   (define (set-left-branch! tree entry) (set-car! (cdr tree) entry)) 
;   (define (set-right-branch! tree entry) (set-car! (cddr tree) entry)) 

;   (let ((table (list '*table*))) 

;     (define (lookup keys) 
;       (let ((record (assoc keys (cdr table)))) 
;         (if record 
;           (cdr record) 
;           false))) 

;     (define (assoc keys records) 
;       (define (handle-matches keys record) 
;         (cond ((null? keys) record) 
;               ((pair? (cdr record)) (assoc keys (cdr record))) 
;               (else #f))) 
;       (display (list "assoc params" "KEYS:" keys "RECORDS:" records))(newline) 
;       (cond ((or (null? records) (null? (car records))) false) 
;             ((equal? (car keys) (caar records)) 
;              (handle-matches (cdr keys) (car records))) 
;             ((< (car keys) (caar records)) 
;              (assoc keys (left-branch records)))         
;             (else (assoc keys (right-branch records))))) 

;     (define (nest-trees-for-remaining-keys keys value) 
;       (display (list "null-set-handler params" "keys:" keys "value:" value)) 
;       (newline) 
;       (if (null? keys) value 
;         (make-tree-node (make-entry (car keys) (nest-trees-for-remaining-keys (cdr keys) value))))) 

;     ;(keys) -> atom b-> atom b|table a b-> atom b|table a b  
;     (define (match-handler keys value entry) 
;       (display (list "match-handler params" "keys:" keys "entry:" entry)) 
;       (newline) 
;       (cond ((null? keys) value) 
;             ((pair? entry) (adjoin-set! keys value entry)) 
;             (else (nest-trees-for-remaining-keys keys value)))) 

;     (define (adjoin-set! keys value set) 
;       (display (list "adjoin-set:" set)) 
;       (newline) 
;       (let ((new-key (car keys))) 
;         (cond ((null? set) (nest-trees-for-remaining-keys keys value)) 
;               ((eq? new-key (caar set)) 
;                (set-cdr! (car set) (match-handler (cdr keys) value (cdar set))) 
;                set) 
;               ((< new-key (entry set)) 
;                (set-left-branch! set (adjoin-set! keys value (left-branch set))) 
;                set) 
;               ((> new-key (entry set)) 
;                (set-right-branch! set (adjoin-set! keys value (right-branch set))) 
;                set)))) 

;     (define (insert-tree! keys value) 
;       (display (list "INSERT TREE PARAMS:" keys value table)) 
;       (set-cdr! table (adjoin-set! keys value (cdr table))) 
;       (display table) 
;       'ok) 

;     (define (print) (display table)(newline)) 
;     (define (dispatch m) 
;       (cond ((eq? m 'lookup) (lambda (keys)(lookup keys))) 
;             ((eq? m 'print) print) 
;             ((eq? m 'insert) (lambda (keys value) (insert-tree! keys value))) 
;             (else "Invalid command"))) 
;     dispatch)) 

; ;PROCEDURAL INTERFACES 
; (define t4 (make-table)) 
; (define (insert! table keys value) 
;   ((table 'insert) keys value)) 
; (define (print table) 
;   ((table 'print))) 
; (define (lookup table keys) 
;   ((table 'lookup) keys)) 
; (load "../3_25_test_step.scm")
; (load "3_25_test_step_no_nil_keys.scm")

;The object #[compiled-procedure 12 ("list" #x2) #x1c #xe2d89c], passed as the first argument to integer-less?, is not the correct type.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; x3v
; (define (make-table) 
;   (let ((head '())) 
;     (define (make-node key value) 
;       (list key value '() '())) ;; (key value left right) 
;     (define (get-key node) (car node)) 
;     (define (get-value node) (cadr node)) 
;     (define (left node) (caddr node)) 
;     (define (right node) (cadddr node)) 
;     (define (set-left! node ptr) (set-car! (cddr node) ptr)) 
;     (define (set-right! node ptr) (set-car! (cdddr node) ptr)) 
;     (define (set-value! node val) (set-car! (cdr node) val)) 
;     (define (leaf? node) 
;       (and (null? (left node)) (null? (right node)))) 
;     (define (lookup key) ;; returns value if key in tree else #f 
;       (define (iter node) 
;         (cond ((null? node) #f) 
;               ((eq? key (get-key node)) (get-value node)) 
;               ((leaf? node) #f) 
;               (else (iter (if (> key (get-key node)) 
;                             (right node) 
;                             (left node)))))) 
;       (iter head)) 
;     (define (insert key value)  
;       (let ((new-node (make-node key value))) 
;         (define (iter node) 
;           (cond ((= key (get-key node)) (set-value! node value)) 
;                 ((> key (get-key node)) 
;                  (if (null? (right node)) 
;                    (set-right! node new-node) 
;                    (iter (right node)))) 
;                 (else (if (null? (left node)) 
;                         (set-left! node new-node) 
;                         (iter (left node)))))) 
;         (if (null? head) 
;           (set! head new-node) 
;           (iter head)))) 
;     (define (dispatch m) 
;       (cond ((eq? m 'insert) insert) 
;             ((eq? m 'lookup) lookup) 
;             ((eq? m 'head) head) 
;             (else (error "incorrect usage" m)))) 
;     dispatch)) 

; (define table (make-table)) 
; (define (insert! table key value) 
;   ((table 'insert) key value)) 
; (define (lookup table key) 
;   ((table 'lookup) key)) 

; (load "../3_25_test_step.scm")
; (load "3_25_test_step_no_nil_keys.scm")

; both -> error (#[compound-procedure 13 dispatch] (2 eel fox) cat)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 