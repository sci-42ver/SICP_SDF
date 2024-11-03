;; https://stackoverflow.com/q/79150263/21294350
(define (prune max-depth tree)
  (if (= 0 max-depth)
    (cons-stream (stream-car tree) the-empty-stream)
    (cons-stream (stream-car tree) (stream-map (lambda (subtree) (prune (- max-depth 1) subtree)) (stream-cdr tree))))
  )

(define infinite-width-leaves
  (cons-stream (cons-stream 1 the-empty-stream) infinite-width-leaves))

(define demo-tree-with-infinite-depth-and-width
  (cons-stream 0 (cons-stream demo-tree-with-infinite-depth-and-width infinite-width-leaves)))

(define test-stream-2 (prune 10 demo-tree-with-infinite-depth-and-width))
test-stream-2
;Value: {0 ...}
(stream->list (prune 0 demo-tree-with-infinite-depth-and-width))
;Value: (0)

;; return val
; (define (stream-min stream)
;   (max ()))
; (define (maximize tree)
;   (if (null? (stream-cdr tree))
;     (stream-car tree)
;     (max (stream-map minimize (stream-cdr tree)))))

; ;; maximize'
; (define (maximize* tree)
;   (if (null? (stream-cdr tree))
;     (stream-car tree)
;     (mapmin (stream-map minimize* (stream-cdr tree)))))
; (define (stream-fold )
;   )
; (define (mapmin stream-min-stream)
;   )

; (define (minimize tree)
;   (if (null? (stream-cdr tree))
;     (stream-car tree)
;     (min (stream-map maximize (stream-cdr tree)))))
