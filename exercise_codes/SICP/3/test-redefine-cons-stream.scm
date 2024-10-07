;; case 1
(define (stream-enumerate-interval low high)
  (if (> low high)
    the-empty-stream
    (cons-stream
      low
      (stream-enumerate-interval (+ low 1) high))))

(stream-enumerate-interval 0 10)

(define (cons-stream a b)
  (display "call cons-stream")
  (cons a (delay b)))

(stream-enumerate-interval 0 10)
; not output "call cons-stream"

;; case 1.1
(define (cons-stream a b)
  (display "call cons-stream")
  (cons a (delay b)))

(define (stream-enumerate-interval low high)
  (if (> low high)
    the-empty-stream
    (cons-stream
      low
      (stream-enumerate-interval (+ low 1) high))))

(stream-enumerate-interval 0 10)
; output "call cons-stream"

;; case 2
(define (cons-stream-1 a b)
  (display "call cons-stream")
  (cons a (delay b)))

(define (stream-enumerate-interval low high)
  (if (> low high)
    the-empty-stream
    (cons-stream-1
      low
      (stream-enumerate-interval (+ low 1) high))))

(stream-enumerate-interval 0 10)

(define (cons-stream-1 a b)
  (display "call cons-stream-1")
  (cons a (delay b)))

(stream-enumerate-interval 0 10)
; will use the new "cons-stream-1" by outputing "call cons-stream-1".

;; case 3
(define (test-redefine-+ . args)
  (display (apply + args)))

(test-redefine-+ 2 3 4)
(define (+ . args)
  (apply * args))
(test-redefine-+ 2 3 4)
; redefinition works by outputing 24.
