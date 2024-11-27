(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

; (trace qeval)

;; > Indeed, whether the system will find the simple answer (married Minnie Mickey) before it goes into the loop depends on implementation details *concerning the order in which the system checks the items in the data base*.
;; this should cause no results outputted at all since we always try rules first which will go into loop.
;; The original one works due to for each recursive calls checking (married ?who Mickey) when substituted with frame bindings,
;; it will check assertion *first* before the next recursive call.
; (define (simple-query query-pattern frame-stream)
;   (stream-flatmap
;    (lambda (frame)
;     (stream-append-delayed
;       (apply-rules query-pattern frame)
;       (delay (find-assertions query-pattern frame))))
;    frame-stream))

(query-driver-loop)
(assert! (married Minnie Mickey))
(assert! (rule (married ?x ?y)
               (married ?y ?x)))

; (married Mickey ?who)

;; 4.71 ericwen229
;; similar to son...
(assert! (rule (job ?x ?y)
               (job ?x ?y)))
; (job ?x ?y)
;; > But the query (not (son ?x ?y)) can avoid the infinite loop thanks to lazy evaluation.
;; Since partial info is enough for stream-null?.
(not (job ?x ?y))
