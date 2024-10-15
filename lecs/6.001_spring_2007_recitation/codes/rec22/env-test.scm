;; GE -> env1 with cnt
(define test
  (let ((cnt 0))
    (lambda () (set! cnt (+ 1 cnt)) cnt)
    ))


(define (test2)
  (define cnt 5)
  (test))

;; GE -> env2 for test2 -> env11 for (test)
;; env11 since "enclosing environment the environment part of the procedure object being applied." https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-21.html#%_sec_3.2
(test2)