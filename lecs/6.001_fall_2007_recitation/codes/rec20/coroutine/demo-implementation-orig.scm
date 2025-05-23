(define (coroutine routine)
   (let ((current routine)
         (status 'suspended))
     (lambda args
       (cond ((null? args) 
              (if (eq? status 'dead)
                  (error 'dead-coroutine)
                  (let ((continuation-and-value
                         (call/cc (lambda (return)
                                    (let ((returner
                                           (lambda (value)
                                             (call/cc (lambda (next)
                                                        (return (cons next value)))))))
                                      (current returner)
                                      (set! status 'dead))))))
                    (if (pair? continuation-and-value)
                        (begin (set! current (car continuation-and-value))
                               (cdr continuation-and-value))
                        continuation-and-value))))
             ((eq? (car args) 'status?) status)
             ((eq? (car args) 'dead?) (eq? status 'dead))
             ((eq? (car args) 'alive?) (not (eq? status 'dead)))
             ((eq? (car args) 'kill!) (set! status 'dead))
             (true nil)))))

(define test-coroutine-1
     (coroutine (lambda (yield)
                  (print "HELLO!")
                  (yield 1)
                  (print "WORLD!")
                  (yield 2)
                  (print "SORRY, I'M OUT"))))

(define print write-line)
; (test-coroutine-1)
; (test-coroutine-1)

(= (test-coroutine-1) 2) ; 1
(= (test-coroutine-1) 1) ; 2
;; Should be both false if with the correct implementation.
