(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

;; Notice simple-query doesn't always return one "singleton stream" for each frame.
(define (simple-stream-flatmap proc s)
  (simple-flatten (stream-map proc s)))
(define (simple-flatten stream)
  (stream-map stream-car
              (stream-filter (lambda (s)
                               (not (stream-empty? s)))
                             stream)))

(define (negate operands frame-stream)
  (simple-stream-flatmap
   (lambda (frame)
     ;; negated-query implies only one operand.
     (if (stream-null? (qeval (negated-query operands)
                              (singleton-stream frame)))
         ;; from 4.75
         ;; > passed back
         (singleton-stream frame)
         ;; > eliminated
         the-empty-stream))
   frame-stream))

;; test to show repo related description.
(trace conjoin)
(query-driver-loop)
(and (not (job Cratchet ?y)) ; pass (singleton-stream frame)
  (job ?x ?y))
;; pass "a stream of frame"
; [Entering #[compound-procedure 13 conjoin]
;     Args: ((job (? x) (? y)))
;           {() ...}]