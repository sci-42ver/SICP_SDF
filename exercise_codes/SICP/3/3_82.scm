(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "3_5.scm")
(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "book-stream-lib.scm")

;; x1>x2 y1>y2
(define (estimate-integral p x1 x2 y1 y2) 
  (let ((area (* (- x2 x1) (- y2 y1))) 
        (randoms (stream-map (lambda (ignore) (random-point x1 x2 y1 y2)) ones))) 
    ; (display (list area (stream-head randoms 100)))
    (scale-stream (monte-carlo (stream-map p randoms) 0 0) area)))

; wrong since unit-circle-test use the wrong "x1 x2"...
; (stream-ref (estimate-integral unit-circle-test 2.0 0 2.0 0) 100)
(define (general-unit-circle-test point x1 x2 y1 y2 radius)
  (let ((x (x-point point))
        (y (y-point point))
        (center-x (average x1 x2))
        (center-y (average y1 y2))
        )
    (<= (+ (square (- x center-x)) (square (- y center-y))) (square radius))))
(define (3-82-test point)
  (general-unit-circle-test point 2.0 0 2.0 0 1))
(stream-ref (estimate-integral 3-82-test 2.0 0 2.0 0) 100)

;; wiki meteorgan
(define (random-in-range low high) 
  (let ((range (- high low))) 
    (+ low (* (random range))))) ; changed
(define (random-number-pairs low1 high1 low2 high2) 
  (cons-stream (cons (random-in-range low1 high1) (random-in-range low2 high2)) 
              (random-number-pairs low1 high1 low2 high2))) 

(define (estimate-integral p x1 x2 y1 y2) 
  (let ((area (* (- x2 x1) (- y2 y1))) 
        (randoms (random-number-pairs x1 x2 y1 y2)))
    ; (display (list area (stream-head randoms 100)))
    (scale-stream (monte-carlo (stream-map p randoms) 0 0) area))) 

;; test. get the value of pi 
(define (sum-of-square x y) (+ (* x x) (* y y))) 
(define f 
  (lambda (x) 
    (not (> (sum-of-square (- (car x) 1) (- (cdr x) 1)) 
            1)))) 
(define pi-stream (estimate-integral f 0 2.0 0 2.0))
(stream-head pi-stream 100)

;; meteorgan modification
(define (random-number-pair low1 high1 low2 high2) 
  (cons (random-in-range low1 high1) (random-in-range low2 high2))) 
(define (estimate-integral p x1 x2 y1 y2) 
  (let ((area (* (- x2 x1) (- y2 y1))) 
        (randoms (stream-map (lambda (ignore) (random-number-pair x1 x2 y1 y2)) ones))) 
    ; (display (list area (stream-head randoms 100)))
    (scale-stream (monte-carlo (stream-map p randoms) 0 0) area)))
; (stream-head (estimate-integral unit-circle-test 0 2.0 0 2.0) 100)
(stream-head (estimate-integral f 0 2.0 0 2.0) 100)