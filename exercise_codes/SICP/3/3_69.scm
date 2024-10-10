(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "3_68.scm")

;; i=j=k / i=j<k / i<j<=k

;; wrong since no `(stream-cdr s)`...
(define (triples s t u)
  (cons-stream
    (list (stream-car s) (stream-car t) (stream-car u))
    (interleave 
      (stream-map (lambda (x) (list (stream-car s) (stream-car t) x))
                   (stream-cdr u))
      (stream-map 
        (lambda (x) (cons (stream-car s) x))
        (pairs (stream-cdr t) (stream-cdr u))
        )
      )
    ))

;; wiki meteorgan + adams's.
(define (triples s t u) 
  (cons-stream 
    (list (stream-car s) 
          (stream-car t) 
          (stream-car u)) 
    (interleave 
      ;; all triples starting with `(stream-car s)` except for the 1st.
      (stream-map (lambda (x) (cons (stream-car s) x)) 
                            (stream-cdr (pairs t u)))
      ;; all triples starting with `(stream-cdr s)` implying `(stream-cdr t)`...
      (triples (stream-cdr s) 
                (stream-cdr t) 
                (stream-cdr u))))) 