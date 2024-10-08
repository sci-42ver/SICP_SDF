(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "book-stream-lib.scm")

;; 3.59
;; a) 
(define (integrate-series s) 
  (stream-map * (stream-map / ones integers) s)) 

;; b) 
(define sine-series 
  (cons-stream 0 (integrate-series cosine-series))) 
(define cosine-series 
  (cons-stream 1 (integrate-series 
                  (scale-stream sine-series -1)))) 

;; 3.60
(define (mul-series s1 s2) 
  (cons-stream (* (stream-car s1) (stream-car s2)) 
              (add-streams 
                (scale-stream (stream-cdr s2) (stream-car s1)) 
                (mul-series (stream-cdr s1) s2))))

;; 3.61
(define (reciprocal-series series) 
  (define inverted-unit-series 
    (cons-stream 
    1 
    (scale-stream (mul-series (stream-cdr series) 
                                inverted-unit-series) 
                  -1))) 
  inverted-unit-series) 

(define (div-series s1 s2) 
  (let ((c (stream-car s2))) 
    (if (= c 0) 
        (error "constant term of s2 can't be 0!") 
        (scale-stream 
          (mul-series s1 (reciprocal-series 
                          (scale-stream s2 (/ 1 c)))) 
          (/ 1 c))))) 

(define tane-series (div-series sine-series cosine-series))

(stream-head tane-series 20)