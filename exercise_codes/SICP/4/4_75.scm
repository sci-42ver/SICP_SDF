(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

;; 0. same interface as negate due to similarity
;; Also said by exercise
;; > is should take as input the contents (cdr) of the unique ...
;; 1. "extensions to the frame" implies direct compatibility with and.
(define (uniquely-asserted operands frame-stream)
  (stream-flatmap
   (lambda (frame)
     ;; mod
     (let ((res 
              (qeval (negated-query operands)
                              (singleton-stream frame))))
      ;; 0. see wiki singleton-stream? to check null before access.
      ;; 1. Here not use stream-length since that won't work for infinite stream.
      (if (stream-null? (stream-cdr res))
         ;; > and the people who fill them.
         res
         the-empty-stream)))
   frame-stream))

(put 'unique 'qeval uniquely-asserted)

(query-driver-loop)
;; > all people who supervise precisely one person.
(and (supervisor ?x ?j) (unique (supervisor ?anyone ?j)))
;; similar to
(and (job ?x ?j) (unique (job ?anyone ?j)))

;; from wiki
;; use ?bosses instead of ?boss for the latter to consider more possibilities.
(and (supervisor ?person ?boss) (unique (outranked-by ?person ?bosses)))