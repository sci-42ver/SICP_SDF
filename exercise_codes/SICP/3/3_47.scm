(define (make-semaphore n)
  ;; similar to make-mutex
  (let ((mutex (make-mutex)))            
    (define (the-semaphore m)
      (cond ((eq? m 'acquire)
            ;; See wiki. Here `n` should be protected.
             (set! n (- n 1))
             ;; This should be <0 corresponding to wiki "(semaphore 'acquire)" which pends the addition until "release".
             (if (= n 0)
              (mutex 'acquire))
             ) ; retry
            ((eq? m 'release) 
              (set! n (+ n 1))
              (if (= n 1)
                (mutex 'release))
              )))
    the-semaphore))

(define (make-semaphore n)
  ;; similar to make-mutex
  (let ((cell (list false)))            
    (define (the-semaphore m)
      (cond ((eq? m 'acquire)
             (set! n (- n 1))
             (if (= n 0)
              ;; changed
              (if (test-and-set! cell)
                 (the-semaphore 'acquire))
              )
             )
            ((eq? m 'release) 
              (set! n (+ n 1))
              (if (= n 1)
                ;; changed
                (clear! cell)
                )
              )))
    the-semaphore))

;; wiki gws's.
(define (1+ a)
  (+ 1 a))
(define (1- a)
  (- a 1))
(define (make-semaphore n) 
  (let ((lock (make-mutex)) 
        (taken 0)) 
    (define (semaphore command) 
      (cond ((eq? command 'acquire) 
            (lock 'acquire) 
            (if (< taken n) 
                (begin (set! taken (1+ taken)) (lock 'release)) 
                (begin (lock 'release) (semaphore 'acquire)))) 
            ((eq? command 'release) 
            (lock 'acquire) 
            (set! taken (1- taken)) 
            (lock 'release)))) 
    semaphore))

;; leafac's
(define (make-semaphore maximum-clients) 
  (let ((access-mutex (make-mutex)) 
        (exceeded-mutex (make-mutex)) 
        (clients 0)) 
    (define (the-semaphore message) 
      (cond ((eq? message 'acquire) 
            (access-mutex 'acquire) 
            (cond ((> clients maximum-clients) 
                    (access-mutex 'release) 
                    (exceeded-mutex 'acquire) 
                    (the-semaphore 'acquire)) 
                  (else 
                    (set! clients (+ clients 1)) 
                    (if (= clients maximum-clients) 
                        (exceeded-mutex 'acquire)) 
                    (access-mutex 'release)))) 
            ((eq? message 'release) 
            (access-mutex 'acquire) 
            (set! clients (- clients 1)) 
            (exceeded-mutex 'release) 
            (access-mutex 'release)))) 
    the-semaphore)) 