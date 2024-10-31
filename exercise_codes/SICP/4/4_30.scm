(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "Lazy_Evaluation_lib.scm")
(load "test-lib.scm")

;; modified version for run-program-list in the 2nd comment of mine in http://community.schemewiki.org/?sicp-ex-4.26
(define (test)
  (run-program-list 
    '((define (for-each proc items)
        (if (null? items)
            'done
            (begin (proc (car items))
                  (for-each proc (cdr items)))))
      (for-each (lambda (x) ((lambda (y) y) (newline)) (display x))
            (list 57 321 88)))
    the-global-environment)
  )
(test)
; ok5732188
; done
;Unspecified return value

(define (test-from-exercise)
  (run-program-list 
    '((define (p1 x)
        (set! x (cons x '(2)))
        x)

      (define (p2 x)
        (define (p e)
          e
          x)
        (p (set! x (cons x '(2)))))
      (p1 1)
      ; (display (car (p2 1))) ; here car will force (p2 1)...
      (p2 1)
      )
    the-global-environment)
  )
(test-from-exercise)

(define (eval-sequence exps env)
  (cond ((last-exp? exps) (eval (first-exp exps) env))
        (else (actual-value (first-exp exps) env)
              (eval-sequence (rest-exps exps) env))))

(test)
; ok
; 57
; 321
; 88
; done
;Unspecified return value

(test-from-exercise)

