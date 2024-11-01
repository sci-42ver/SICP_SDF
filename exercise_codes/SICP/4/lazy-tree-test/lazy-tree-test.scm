(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "normal-tree-test.scm")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; infinite car
(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "book-stream-lib.scm")
(define nested-ones (cons-stream ones nested-ones))
(car nested-ones)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; paper
(define custom-car stream-car)
(define custom-cdr stream-cdr)

(define (prune max-depth tree)
  (define (iter depth subtree)
    (if (= depth max-depth)
      '() ; no children
      (cons-stream (custom-car subtree) (flatmap-only-nil (lambda (child) (iter (+ 1 depth) child)) (custom-cdr subtree)))))
  (iter 0 tree)
  )

;; from book
(define (flatmap-only-nil proc seq)
  (fold-right 
    (lambda (elm lst) 
      (if (null? elm)
        ; (append elm lst)
        lst
        (cons-stream elm lst)
        )) 
    '()
    (map proc seq)))

(define (demo-tree)
  (cons-stream 0 
        (list 
          (cons-stream 1   
                (list 
                  (cons-stream 3 
                        (list 
                          (cons-stream 5 (list (cons-stream 7 '()) (cons-stream 8 '()))) 
                          (cons-stream 6 '()))) 
                  (cons-stream 4 '()))) 
          (cons-stream 2 '()))))
(demo-tree)
;; not infinite
(define test-stream (prune 3 (demo-tree)))
; (stream-head test-stream (stream-length test-stream))
(stream->list test-stream)
(stream-cdr (stream-car (stream-cdr test-stream)))

;; Since the rest is always one list when forced.
; (define map stream-map)
;; just store a list of children. Delay will be done by cons-stream.
; (define list stream)