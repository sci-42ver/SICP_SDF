(define (make-point x y)
  (list x y))
(define (point-x pt)
  (car pt))
(define (point-y pt)
  (cadr pt))

(define (make-line-segment pt1 pt2)
  (cons pt1 pt2))
(define (line-segment-start pt)
  (car pt))
(define (line-segment-end pt)
  (cdr pt))

(define (intersection s1 s2)
  (let ((x1 (point-x (line-segment-start s1)))
        (x2 (point-x (line-segment-end s1)))
        (x3 (point-x (line-segment-start s2)))
        (x4 (point-x (line-segment-end s2)))
        (y1 (point-y (line-segment-start s1)))
        (y2 (point-y (line-segment-end s1)))
        (y3 (point-y (line-segment-start s2)))
        (y4 (point-y (line-segment-end s2))))
    (let ((n1 (- (* (- x4 x3) (- y1 y3))
                 (* (- y4 y3) (- x1 x3))))
          (n2 (- (* (- x2 x1) (- y1 y3))
                 (* (- y2 y1) (- x1 x3))))
          (d (- (* (- y4 y3) (- x2 x1))
                (* (- x4 x3) (- y2 y1)))))
      (if (zero? d) #f
        (let ((u1 (/ n1 d))
              (u2 (/ n2 d)))
          (if (or (< u1 0) (< u2 0)
                  (> u1 1) (> u2 1))
            #f
            (make-point (+ x1 (* u1 (- x2 x1)))
                        (+ y1 (* u1 (- y2 y1))))))))))

(define p1 (make-point 0 0))
(define p2 (make-point 2 2))
(define p3 (make-point 2 0))
(define p4 (make-point 0 2))
(define L1 (make-line-segment p1 p2))
(define L2 (make-line-segment p3 p4))
(intersection L1 L2)