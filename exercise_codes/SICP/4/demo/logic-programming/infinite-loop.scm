(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

; (trace qeval)

;;;
;; > Indeed, whether the system will find the simple answer (married Minnie Mickey) before it goes into the loop depends on implementation details *concerning the order in which the system checks the items in the data base*.
;; > in a breadth-first rather than a *depth-first order*
;; implied by recursive calls
;; > on low-level details concerning the order in which the system processes queries.
;; whether to continue nested queries when the parent query still has one simpler assertion un-checked.

;; this should cause no results outputted at all since we always try rules first which will go into loop.
;; The original one works due to for each recursive calls checking (married ?who Mickey) when substituted with frame bindings,
;; it will check assertion *first* before the next recursive call.
(define (simple-query query-pattern frame-stream)
  (stream-flatmap
   (lambda (frame)
    (stream-append-delayed
      (apply-rules query-pattern frame)
      (delay (find-assertions query-pattern frame))))
   frame-stream))

;; use append
; (define (flatten-stream stream)
;   (if (stream-null? stream)
;       the-empty-stream
;       (stream-append-delayed
;        (stream-car stream)
;        (delay (flatten-stream (stream-cdr stream))))))

(query-driver-loop)
(assert! (married Minnie Mickey))
(assert! (rule (married ?x ?y)
               (married ?y ?x)))

;; loop if reorder rule and assertion in simple-query.
(married Mickey ?who)

;;; 4.71 ericwen229
;; similar to son...
(assert! (rule (job ?x ?y)
               (job ?x ?y)))
; (job ?x ?y)
;; > But the query (not (son ?x ?y)) can avoid the infinite loop thanks to lazy evaluation.
;; Since partial info is enough for stream-null?.
(not (job ?x ?y))

;;; no result at all
;; due to seemingly call itself (append-to-form ?v ?y ?z).
; (append-to-form ?x (2 3) ?z)

;;; > whether the system will find the simple answer (married Minnie Mickey) before it goes into the loop depends on implementation details concerning the order in which the system checks the items in the data base.
(assert! (married Foo Mickey))
;; interleave makes both results can be outputted.
; (married Mickey ?who)
;; loop
; (married mickey foo)
; (married mickey minnie)

;; append still outputs both since each application of rule can generate both once.
; (married Mickey ?who)
