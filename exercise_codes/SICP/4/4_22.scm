;; > uses the same data structures, syntax procedures
;; http://community.schemewiki.org/?sicp-ex-4.6
(define (let? expr) (tagged-list? expr 'let)) 
(define (let-vars expr) (map car (cadr expr))) 
(define (let-inits expr) (map cadr (cadr expr))) 
(define (let-body expr) (cddr expr)) 

(define (let->combination expr) 
  (cons (make-lambda (let-vars expr) (let-body expr)) 
        (let-inits expr)))

;; add to analyse
; ((let? exp) (analyze-let exp))

;; similar to wiki meteorgan's.
(define (analyze-let expr)
  (analyze-application (let->combination expr)))