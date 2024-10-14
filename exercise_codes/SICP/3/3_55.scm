;; as wiki dzy says, this is wrong.
(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "book-stream-lib.scm")
(load "../lib.scm")

(trace add-streams)

(define (partial-sums S)
  (cons-stream (stream-car S) (add-streams (stream-cdr S) (partial-sums S))))

(define (test)
  (define ps (partial-sums (list->stream (iota 5))))
  (stream-ref ps 2)
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ref 1: 
; (add-streams {1 ...} (cons-stream 0 (add-streams {1 ...} ...))) (**)
; -> (cons-stream (map + 1 0) (stream-map + {2 ...} (**)))
; ref 2 (here (**) refer to the above result but will be recalculated): 
; (stream-map + {2 ...} (**)) (***)
; -> (cons-stream (map + 2 1) (stream-map + {3 ...} (***)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
(test)
;; run 2 duplicate `add-streams`.

(define (partial-sums S)
  (define res (cons-stream (stream-car S) (add-streams (stream-cdr S) res)))
  res
  )
(test)
;; only 1 `add-streams` as expected since the 2nd `add-streams` is avoided due to res having already calculated that one and can be reused.

;; huntzhan shares the same structure as meteorgan's.
;; i.e. (s0+s1, s0+s1+s2, s0+s1+s2+s3, ...) = (s0, s0+s1, s0+s1+s2, ...) + (s1, s2, s3, ...).

;; dekuofa1995 correction.
(define (partial-sums S)
  (let ((a (stream-car s)))
    (cons-stream
      a
      (add-streams (scale-stream a ones)
                   (partial-sums (stream-cdr s)))))) 
