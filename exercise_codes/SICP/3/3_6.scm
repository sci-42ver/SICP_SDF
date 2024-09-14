;; inspired by repo
; https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Random-Number-Generation.html#index-random
(define (rand message)
  (let ((range 100.0))
    (case message
      ;; https://stackoverflow.com/a/77430176
      ((generate) (* range (random-real)))
      ;; https://srfi.schemers.org/srfi-27/srfi-27.html
      ;; Here i and j decides the sequence.
      ((reset)
       ;; Here same as repo we view new-value as seed instead of "starting from a given value".
       (lambda (new-value) 
         (random-source-pseudo-randomize! default-random-source new-value new-value)))
      )))

((rand 'reset) 1)
(rand 'generate)
(rand 'generate)
((rand 'reset) 1)
(rand 'generate)
(rand 'generate)
