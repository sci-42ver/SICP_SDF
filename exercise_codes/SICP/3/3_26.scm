;; based on 3_25_roytobin.scm

;; > keys can be ordered in some way 
;; IMHO we can't use each element of the key list as the key to branch at each entry.
;; Since that will be based on the first element first and then the 2nd in that subtree ... So this still have redundancy.
;; So we just let key-list as the key to branch.
(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "binary-tree-lib.scm")
(define nil-elem 'nil-elem) ; to differentiate from '()
(define (null?* lst)
  (equal? lst nil-elem))
(define (safe-car lst)
  (if (null? lst)
    lst
    (car lst)))
(define (make-table)
  (define (make-entry keys value)
    (list keys value))
  (define (set-entry-value entry value)
    (set-car! (cdr entry) value))
  (define empty-entry
    (make-entry (list nil-elem) nil-elem))
  (define leaf-branch nil-elem)
  (define table (make-tree empty-entry leaf-branch leaf-branch))
  
  (define (get-key entry)
    (car entry))
  (define (get-val entry)
    (cadr entry))
  
  (define (object->str obj)
    (symbol->string (symbol obj)))
  (define (keys-comparison keys1 keys2)
    (let ((str1 (object->str (safe-car keys1)))
          (str2 (object->str (safe-car keys2)))
          (keys1-len (length keys1))
          (keys2-len (length keys2))
          )
      ;; Use list order comparing in Discrete_Mathematics_and_Its_Applications_8th based on memory (sorry temporarily I can't find the exact page).
      ;; based on list len and each consecutive element comparison.
      (cond 
        ((and (= 0 keys1-len) (= 0 keys2-len)) '=)
        ;; Here we won't do "case-folding". see string-ci=? https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Strings.html#index-string_002dcompare_002dci
        ((or (< keys1-len keys2-len) (string<? str1 str2)) '<)
        ((or (> keys1-len keys2-len) (string>? str1 str2)) '>)
        ((string=? str1 str2)
          (keys-comparison (cdr keys1) (cdr keys2))))))
  (define (keys<? keys1 keys2)
    (case (keys-comparison keys1 keys2)
      ((<) #t)
      ((>) #f)
      (else (error "keys1 keys2 are equal and shouldn't use this comparison operator"))))
  (define (keys=? keys1 keys2)
    (eq? (keys-comparison keys1 keys2) '=))
  (define (entry-keys=? entry1 entry2)
    (let ((entry-lst (list entry1 entry2)))
      (apply keys=? (map get-key entry-lst))))
  (define (entry-vals=? entry1 entry2)
    (let ((entry-lst (list entry1 entry2)))
      (apply equal? (map get-val entry-lst))))
  (define (entry-keys<? entry1 entry2)
    (let ((entry-lst (list entry1 entry2)))
      ;; no duplicate keys
      (apply keys<? (map get-key entry-lst))))
  
  (define (lookup keys)
    (let ((record (lookup-bst keys table leaf-branch get-key keys<? keys=? null?*)))
      (and record (get-val record))))
  (define (insert keys value)
    (let ((record (lookup-bst keys table leaf-branch get-key keys<? keys=? null?*)))
      (cond (record  
              (set-entry-value record value))
            (else    
              (set! table (adjoin-set (make-entry keys value) table entry-keys<? entry-keys=? entry-vals=? leaf-branch null?*))))))
  (define (dispatch m)
    (cond ((eq? m 'lookup) lookup)
          ((eq? m 'insert) insert)
          ((eq? m 'table-contents) table)
          (else (error "Unknown request -- NTABLE" m))))
  dispatch)
(define (insert! nt keys value)  ((nt 'insert) keys value) value)
(define (lookup  nt keys)        ((nt 'lookup) keys))
(define (table-contents table)
  (table 'table-contents))

(load "../lib.scm") ; for displayln
(load "3_25_test_step.scm")