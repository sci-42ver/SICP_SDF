(define (make-interval a b)
  (cons a b))

(define (lower-bound i)
  (car i))

(define (upper-bound i)
  (cdr i))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (make-center-percent c p)
  (make-interval (- c (* c p)) (+ c (* c p))))

(define (percent i)
  (/ (width i) (center i)))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                  (+ (upper-bound x) (upper-bound y))))

; (define (max a b)
;   (if (> a b)
;       a
;       b))

; (define (min a b)
;   (if (< a b)
;       a
;       b))

(define (mul-interval x y)
  (if (and (>= (upper-bound x) (lower-bound x)) (>= (upper-bound y) (lower-bound y)))
      (let ((p1 (* (lower-bound x) (lower-bound y)))
            (p2 (* (lower-bound x) (upper-bound y)))
            (p3 (* (upper-bound x) (lower-bound y)))
            (p4 (* (upper-bound x) (upper-bound y))))
        (make-interval (min (min p1 p2) (min p3 p4))
                        (max (max p1 p2) (max p3 p4))))
      ;; weird implementation. Not work for 0<ux<lx, 0<ly<uy. Then up of the result should be lx*uy.
      (make-interval (min (* (lower-bound x) (lower-bound y))
                          (* (upper-bound x) (upper-bound y)))
                      (max (* (lower-bound x) (lower-bound y))
                          (* (upper-bound x) (upper-bound y))))))

;; debug 1
(define (old-mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    ; (make-interval (min (min p1 p2) (min p3 p4))
    ;                 (max (max p1 p2) (max p3 p4)))))
    ;; comment the above self-defined min and max
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define test_x (make-interval 2 1))
(define test_y (make-interval 1 2))
(old-mul-interval test_x test_y)
(mul-interval test_x test_y)

; (define (mul-interval x y)
;   (let ((p1 (* (lower-bound x) (lower-bound y)))
;         (p2 (* (lower-bound x) (upper-bound y)))
;         (p3 (* (upper-bound x) (lower-bound y)))
;         (p4 (* (upper-bound x) (upper-bound y))))
;     (make-interval (min (min p1 p2) (min p3 p4))
;                     (max (max p1 p2) (max p3 p4)))))

;; debug 2 This is just one wrapper of the original book code.
(define inverse-obj
  (lambda (i) (cons (/ 1 (lower-bound i)) (/ 1 (upper-bound i)))))        

(define (div-interval x y)
  (if (<= (* (upper-bound y) (lower-bound y)) 0)
      (display "error")
      (mul-interval
        x
        (inverse-obj y))))

(div-interval test_x test_x)
(div-interval test_y test_y)
  
(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval
      one (add-interval (div-interval one r1)
                        (div-interval one r2)))))

(define r1 (make-center-percent  500 0.88))
(define r2 (make-center-percent 3000 0.42))

(par1 r1 r2)
(par2 r1 r2)