(define (cont-frac n d k)
  (define (helper i)
    (if (> i k)
      0
      (/ (n i) (+ (d i) (helper (+ i 1))))))
  (helper 1))

(define k 10)
(- (cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           k) 
   0.6180339887498948) ; 1/\varphi

;;; Compared with
;;; > A correct recursive version requires the recursive procedure to be defined inside the cont-frac procedure in order to use an ascending index value
;;; the latter has one less iteration due to `i=k`

;;; Also see
;;; > A recursive solution that doesn't require a helper function, but is somewhat awkward:

;;; As the reference Mathematics Stack Exchange link shows, for iter, we should
;;; > the fraction accumulates from the inside to the outside
