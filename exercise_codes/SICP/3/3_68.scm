(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "book-stream-lib.scm")

(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    ;; modified to have the same interleave order as the 2nd.
    (pairs (stream-cdr s) (stream-cdr t))
    (stream-map (lambda (x) (list (stream-car s) x))
                (stream-cdr t))
    )
    ))

(define n 1000)
(stream-head (pairs integers integers) n)

(define (pairs s t)
  (interleave
   (stream-map (lambda (x) (list (stream-car s) x))
               t)
   ;; keeping recursion due to infinite stream, but no `cons-stream` to stop at once after one calculation.
   ;; Same as wiki meteorgan's.
   ;; Similar to LisScheSic's in http://community.schemewiki.org/?sicp-ex-3.55.
   (pairs (stream-cdr s) (stream-cdr t))))
(stream-head (pairs integers integers) n)