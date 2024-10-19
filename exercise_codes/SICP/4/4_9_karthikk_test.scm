;; > cause serious nameclash issues if there are *two while loops in a single procedure*!
;; the problem pointed out by karthikk
; (define (test)
;   ;; from woofy
;   (define i 0)
;   (define (while-iter)
;     (if (< i 100)
;       (begin
;         (display i)  
;         (set! i (+ i 1))
;         (while-iter)
;         )
;       'done))
;   (while-iter)

;   (newline)
;   (define (while-iter)
;     (if (< i 200)
;       (begin
;         (display i)  
;         (set! i (+ i 1))
;         (while-iter)
;         )
;       'done))
;   (while-iter)
;   )
; (test)
; duplicate internal definitions for (#[uninterned-symbol 12 .while-iter.1]) in test

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; but directly not in one procedure is fine.
(define i 0)
(define (while-iter)
  (if (< i 100)
    (begin
      (display i)  
      (set! i (+ i 1))
      (while-iter)
      )
    'done))
(while-iter)

(newline)
(define (while-iter)
  (if (< i 200)
    (begin
      (display i)  
      (set! i (+ i 1))
      (while-iter)
      )
    'done))
(while-iter)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; karthikk correction
(define (test)
  ;; from woofy
  (define i 0)
  ;; similar to https://stackoverflow.com/a/11833038/21294350
  (let ((while-iter '*unassigned*))
    (set! while-iter
      (lambda () 
        ;; same
        (if (< i 100)
          (begin
            (display i)  
            (set! i (+ i 1))
            (while-iter)
            ))
        ))
    (while-iter)
    )

  (newline)
  
  (let ((while-iter '*unassigned*))
    (set! while-iter
      (lambda () 
        ;; same
        (if (< i 100)
          (begin
            (display i)  
            (set! i (+ i 1))
            (while-iter)
            ))
        ))
    (while-iter)
    )
  )
(test)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; woofy's is also fine.
(define (test)
  (define i 0)
  ((lambda () 
    (define (while-iter)
      (if (< i 100)
        (begin
          (display i)  
          (set! i (+ i 1))
          (while-iter)
          )
        'done))
    (while-iter)))

  (newline)
  ((lambda () 
    (define (while-iter)
      (if (< i 100)
        (begin
          (display i)  
          (set! i (+ i 1))
          (while-iter)
          )
        'done))
    (while-iter)))
  )
(test)