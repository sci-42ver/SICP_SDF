(define (user-print-general object)
  (cond 
    ((compound-procedure? object)
      (newline)
      (display (list 'compound-procedure
                     (procedure-parameters object)
                     (procedure-body object)
                     '<procedure-env>)))
    ((thunk? object)
      (newline)
      (display (list 'thunk
                     (thunk-exp object)
                     '<thunk-env>)))
    (else 
      (newline)
      (display object)
      )))

;; see http://community.schemewiki.org/?sicp-ex-4.26 which explicitly uses this.
(define (run-program-list program-lst env)
  (for-each 
    (lambda (exp) 
      ;; add user-print-general
      (user-print-general (eval exp env))) 
    program-lst)
  )

(define (run-program-list-force program-lst env)
  (for-each 
    (lambda (exp)
      (user-print-general (force-it (eval exp env)))) 
    program-lst)
  )

;; https://stackoverflow.com/q/2195105/21294350
;; Or use MIT/GNU Scheme internal func https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Machine-Time.html#index-measure_002dinterval
(define (implemented-measure-interval hairy-computation start-time)
  (begin
    (hairy-computation)
    (report-prime (- (runtime) start-time))))
;; https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-11.html#%_sec_1.2.6
(define (report-prime elapsed-time)
  (newline)
  (display " *** ")
  (display elapsed-time)
  (newline)
  )

(define (elapsed-time-test program)
  (implemented-measure-interval
    (lambda () (run-program-list program the-global-environment))
    (runtime))
  )