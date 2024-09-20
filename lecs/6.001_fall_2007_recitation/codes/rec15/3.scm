(define (rb-dequeue! rb)
  (cond ((not (ring-buffer? rb))
         (error "not a ring buffer"))
        ((rb-empty? rb)
         (error "buffer empty"))
        (else
          ;; See sol for 2 lacked set-car!'s.
          (set-car! (rb-number-filled-pair rb)
                    (- (car (rb-number-filled-pair rb)) 1))
          (car (car (rb-next-read-pair rb)))
          )))
