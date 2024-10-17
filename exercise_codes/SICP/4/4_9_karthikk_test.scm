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

;; but directly not in one procedure is fine.
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

;; karthikk correction
(define (test)
  ;; from woofy
  (define i 0)
  ;; similar to 
  (let ((while-rec '*unassigned*))
    ())
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
  )
(test)