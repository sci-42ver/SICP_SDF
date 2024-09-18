; Exercise 3.26
; To search a table as implemented above, one needs to scan through the list of
; records.  This is basically the unordered list representation of section 2.3.3.  For
; large tables, it may be more efficient to structure the table in a different manner.
; Describe a table implementation where the (key, value) records are organized
; using a binary tree, assuming that keys can be ordered in some way (e.g., nu-
; merically or alphabetically).  (Compare exercise 2.66 of chapter 2.)

(define (numcmp a b) (- a b))
(define (strcmp a b) 
  (cond ((string<? a b) -1)
        ((string>? a b) +1)
        (else 0)))

(define (make-table cmpfunc)
  (define root-tree '())
  (define st-uninitialized #f)  ; the result returned for unsuccessful lookup
  (define (st-beget k v)  (list k '() '() v))
  (define (st-get-key st)   (car st))    ; 1st element
  (define (st-lefthead st)  (cdr st))    ; 2nd element
  (define (st-righthead st) (cddr st))   ; 3rd element
  (define (st-get-value st) (cadddr st)) ; 4th element
  (define (st-leftsubtree st)  (car (st-lefthead st)))
  (define (st-rightsubtree st) (car (st-righthead st)))
  (define (st-set-value st val) (set-car! (cdddr st) val))

  ;; Here head is one lst, so car to get the element.
  ;; The basic ideas of the following 2 funcs plus "st-root-insert" are same as adjoin-set.
  (define (st-graft head k v)
    (if (null? (car head))
      (set-car! head (st-beget k v)) ; reach leaf.
      (st-insert (car head) k v))
    )
  (define (st-insert st key val)  ; contract is "st (the subtree) is always non-null"
    (let ((result (cmpfunc (st-get-key st) key)))
      (cond ((< result 0) (st-graft (st-righthead st) key val))
            ((> result 0) (st-graft (st-lefthead st) key val))
            (else (st-set-value st val))))
    )
  ;; basic idea is same as http://community.schemewiki.org/?sicp-ex-2.66.
  (define (st-lookup st key)  ; contract is "st may or may not be null"
    (if (null? st)
      st-uninitialized
      (let ((result (cmpfunc (st-get-key st) key)))
        (cond ((< result 0) (st-lookup (st-rightsubtree st) key))
              ((> result 0) (st-lookup (st-leftsubtree st)  key))
              (else (st-get-value st)))))
    )
  (define (st-root-insert key val)
    (if (null? root-tree)
      (set! root-tree (st-beget key val))
      (st-insert root-tree key val))
    )
  (define (dispatch m)
    (cond ((eq? m 'insert) st-root-insert)
          ((eq? m 'lookup) (lambda (key) (st-lookup root-tree key)))
          ((eq? m 'dump) root-tree) ; debugging
          (else (error "Error: unknown dispatch message -- btable" m)))
    )
  dispatch
  )
(define (insert! bt key val) ((bt 'insert) key val))
(define (lookup  bt key)     ((bt 'lookup) key))

; Usage
; (define (strcmp a b) (cond ((string<? a b) -1) ((string>? a b) +1) (else 0)))
; (define t1 (make-table strcmp))
; (insert! t1 "bugs" "bunny")
; (insert! t1 "taz" "devil")
; (lookup t1 "bugs")
; (lookup t1 "wile e.")

;(print (lookup t1 42))
;(insert! t1 "love" "marriage")
;(insert! t1 "horse" "carriage")
;(insert! t1 "bert" "ernie")
;(insert! t1 "sonny" "cher")
;(insert! t1 "bonnie" "clyde")
;(print (t1 'dump))
;(print (lookup t1 5))
;(print (lookup t1 7))
;(insert! t1 3 '())
;(insert! t1 4 #t)
;(insert! t1 9 'nine)
;(print (lookup t1 3))
;(print (lookup t1 4))
;(print (lookup t1 9))

(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "../lib.scm") ; for displayln
; (load "3_25_test_step.scm")
(load "3_26_roytobin_tests.scm")