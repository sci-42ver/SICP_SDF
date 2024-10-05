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