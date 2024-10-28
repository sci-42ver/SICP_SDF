;; https://en.wikipedia.org/wiki/Tail_call#C_example
(define (duplicate ls)
  (let ((head (list 1)))
    (let dup ((ls  ls)
              (end head))
      (cond
        ((not (null? ls))
         ;; > appending this value at the end of the growing list on entry into the recursive call
         (set-cdr! end (list (car ls)))
         (dup (cdr ls) (cdr end)))))
    (cdr head)))