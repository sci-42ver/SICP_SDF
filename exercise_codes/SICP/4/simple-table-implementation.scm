;; similar to 3_25_roytobin_based_on_meteorgan.scm
(define visited '())
;;;;;;;;; modify the interface
(define (put k v)
  (let ((val (assq k visited)))
    (if val 
      (begin
        (set-cdr! val v)
        (display visited)
        )
      (set! visited (cons (cons k v) visited))))
  ; (set! visited (cons (cons k v) visited))
  )   ; an interface to visited for convenience 
(define (get k) 
  (let ((val (assq k visited)))
    (and val (cdr val))))     ; an interface to visited for convenience 
(define (delete k) (set! visited (remove (lambda (elm) (eq? k (car elm))) visited)) (display (get k)))

(put 'a 1)
(put 'a 2)
(delete 'a)