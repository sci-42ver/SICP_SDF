(define (rb-enqueue! rb e)
  (cond ((not (ring-buffer? rb))
         (error "not a ring buffer"))
        ((rb-full? rb)
         (error "too many elements"))
        (else 
          (let ((fill-ring (rb-next-fill-pair rb)))
            (set-car! (car fill-ring) e)
            ;; See sol better to use abstraction rotate-left.
            (set-car! (rb-next-fill-pair rb) (cdr fill-ring))
            ;; See sol, by contract `rb-number-filled-pair` also needs to be changed.
            ))))
