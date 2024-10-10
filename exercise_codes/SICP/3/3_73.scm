;; see wiki, here we can use `integral` from the book.
(define (RC R C dt)
  (lambda (current-stream v0) 
    (define int
      (let* ((initial-current (stream-car current-stream))
             (initial-value v0))
        (cons-stream 
          initial-value
          (scale-stream
            (add-streams 
              (scale-stream integrand dt)
                        int)
            (/ 1 C))))
      )
    (add-streams (scale-stream current-stream R) int))
  )