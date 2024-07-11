(define (make-interval a b) (cons a b))

(define (lower-bound x)
  (car x))

(define (upper-bound x)
  (cdr x))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (make-center-percent c p)
  (make-interval (* c (- 1 (/ p 100))) (* c (+ 1 (/ p 100)))))

(define (percentage i)
  (let ((i-up (upper-bound i))
        (i-lo (lower-bound i)))
    (* (/ (- i-up i-lo) (+ i-up i-lo)) 100)))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (add-interval x 
                (make-interval (- (upper-bound y))
                               (- (lower-bound y)))))

(define (mul-interval x y)
  (let* ((x-up (upper-bound x))
         (x-lo (lower-bound x))
         (y-up (upper-bound y))
         (y-lo (lower-bound y))
         (x-sign (cond ((and (< x-lo 0) (< x-up 0)) -1)
                       ((and (< x-lo 0) (> x-up 0)) 0)
                       (else 1)))
         (y-sign (cond ((and (< y-lo 0) (< y-up 0)) -1)
                       ((and (< y-lo 0) (> y-up 0)) 0)
                       (else 1))))
    (cond ((< x-sign 0)
           (cond ((< y-sign 0) ; (- -) * (- -)
                  (make-interval (* x-up y-up) 
                                 (* x-lo y-lo)))
                 ((= y-sign 0) ; (- -) * (- +)
                  (make-interval (* x-lo y-up) 
                                 (* x-lo y-lo)))
                 (else         ; (- -) * (+ +)
                  (make-interval (* x-lo y-up) 
                                 (* x-up y-lo)))))
          ((= x-sign 0)
           (cond ((< y-sign 0) ; (- +) * (- -)
                  (make-interval (* x-up y-lo) 
                                 (* x-lo y-lo))) 
                 ((= y-sign 0) ; (- +) * (- +)
                  (make-interval (min (* x-up y-lo) (* x-lo y-up))
                                 (max (* x-lo y-lo) (* x-up y-up))))
                 (else         ; (- +) * (+ +)
                  (make-interval (* x-lo y-up)
                                 (* x-up y-up)))))
          (else ; x: (+ +)
           (cond ((< y-sign 0) ; (+ +) * (- -)
                  (make-interval (* x-up y-lo) 
                                 (* x-lo y-up)))
                 ((= y-sign 0) ; (+ +) * (- +)
                  (make-interval (* x-up y-lo)
                                 (* x-up y-up)))
                 (else         ; (+ +) * (+ +)
                  (make-interval (* x-lo y-lo)
                                 (* x-up y-up))))))))

(define (div-interval x y)
  (let ((y-up (upper-bound y))
        (y-lo (lower-bound y)))
    (if (> (* y-up y-lo) 0)
        (mul-interval x 
                      (make-interval (/ 1.0 y-up)
                                     (/ 1.0 y-lo)))
        (error "Argument y spans zero"))))

(define (print-c-p i)
  (newline)
  (display (center i))
  (display " +- ")
  (display (percentage i))
  (display "%"))

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1))) 
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

(print-c-p
 (par1 (make-center-percent 10. 2.) (make-center-percent 15. 2.)))
; 6.009603841536615 +- 5.993607670795042%

(print-c-p
 (par2 (make-center-percent 10. 2.) (make-center-percent 15. 2.)))
; 6. +- 1.9999999999999944%

;;; See wiki 1st comment by LisScheSic
(print-c-p
 (par1 (make-center-percent 10. 50.) (make-center-percent 15. 80.)))

(print-c-p
 (par2 (make-center-percent 10. 50.) (make-center-percent 15. 80.)))