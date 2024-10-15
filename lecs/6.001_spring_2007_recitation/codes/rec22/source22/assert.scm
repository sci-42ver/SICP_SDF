;; see SICP_SDF/exercise_codes/SICP/lib.scm for MIT/GNU Scheme `assert-throws`.
; See stack.scm in recitation 16 for an explanation of what assert-throws does

; Complains if val and expected are not equal?
; See notes at the end if you want to understand the implementation.
(define (assert-equal val expected)
  (if (equal? val expected)
      val
      (raise (list "expected " expected ", but got " val))))

; Complains if evaluating expr does not result in a complaint.
; See notes at the end if you want to understand the implementation.
(define (assert-throws expr)
  ; This assert evaluates the given expression and then makes sure that
  ; it raises an exception.
  ; ...black magic lies herein
  (let ((exception-thrown #f))
    (with-handlers (((lambda (exn) #t) ; filter all exceptions
                     (lambda (exn) 
                       ; Uncomment the next line to have suppressed exceptions
                       ; get printed anyway.
                       ;(display (vector-ref (struct->vector exn) 1)) (newline)
                       (set! exception-thrown #t))))
      (eval expr)) ; try evaluating
    (if (not exception-thrown)
        (error "The following expression should have raised an exception:" expr))))

