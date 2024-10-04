(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "book-stream-lib.scm")

(define (show x)
  (display-line x)
  x)

(define (test)
  (define x (stream-map show (stream-enumerate-interval 0 10)))
  (display-line "to run ref")
  (stream-ref x 5)
  (stream-ref x 7)
  )

(test)

(load "book-stream-lib-reimplement-mit-scheme.scm")
;; see https://stackoverflow.com/q/79053667/21294350
(load "book-stream-lib.scm")

(test)