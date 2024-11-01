(let ((u '*unassigned*)
      (v '*unassigned*))
  (set! u 'test)
  (set! v u)
  (display (list u v)))

;; simultaneous -> <e1>,<e2> are all based on u,v equal to '*unassigned*
;; sequential -> <e2> will based on based u equal to <e1>

;; output "(test test)"
;; So here we only ensure "truly simultaneous scope" but not "simultaneous definition".

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; TODO1
;; > Our intention here is that the name odd? in the body of the procedure even? should *refer to* the procedure odd? that is defined *after even?*.
;; Can be done by the book *unassigned* version, i.e. 
;; > we see that the *only* satisfactory interpretation of the two defines is to regard them as if the names even? and odd? were being added to the environment simultaneously.
;; IGNORE: IMHO the environment model already meets that requirement since `odd?` is just one pair (proc,env) which when evaluated will search for the env where proc is created.
  ;; So 
;; See
;; > As it happens, our interpreter will evaluate calls to f correctly, but for an ``accidental'' reason: Since the definitions of the internal procedures *come first*
;; So if we define even? and then call something like (even? 4), then "sequential evaluation" will fail.
;; But "simultaneous" will work since simultaneous will call set! all together.
(define f 
  (lambda (x)
    (let ((even? '*unassigned*)
          (odd? '*unassigned*))
      (set! even? 
        (lambda (n)
          (if (= n 0)
              true
              (odd? (- n 1)))))
      (set! odd?
        (lambda (n)
          (if (= n 0)
            false
            (even? (- n 1)))))
      (even? x))))
(f 4)
(define f 
  (lambda (x)
    (let ((even? '*unassigned*)
          (odd? '*unassigned*))
      (set! even? 
        (lambda (n)
          (if (= n 0)
              true
              (odd? (- n 1)))))
      (even? x)
      (set! odd?
        (lambda (n)
          (if (= n 0)
            false
            (even? (- n 1)))))
      )))
(f 4)
; throw error
;The object *unassigned* is not applicable.