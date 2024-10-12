;; same as meteorgan's and repo.
(define (solve-2nd a b y0 dy0 dt)
  ;; use delay version. Notice to use delay.
  (define y (integral (delay dy) y0 dt))
  (define dy (integral (delay ddy) dy0 dt))
  (define ddy 
    (add-streams 
      (scale-stream dy a)
      (scale-stream y b)
      ))
  y)