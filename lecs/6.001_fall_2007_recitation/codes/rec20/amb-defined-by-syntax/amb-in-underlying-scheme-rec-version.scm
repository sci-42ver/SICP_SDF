;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; from rec (not work when transforming from define-macro to define-syntax)
;; i.e. (define (amb-fail) (error "amb tree exhausted")) in racket implementation
;; https://github.com/sicp-lang/sicp/blob/5ba7b852855cf107892244b37d6a1ffbef14d595/sicp/main.rkt#L42-L61
(define amb-fail '*)
(define initialize-amb-fail
  (lambda ()
    (set! amb-fail
      (lambda ()
        (error "amb tree exhausted")))))
(initialize-amb-fail)
;; See r16 with exercise_codes/SICP/3/cons-stream-as-syntax.scm
; (define-macro amb
;               (lambda alts
;; just same as racket implementation where it uses ... instead of map.
;; > ((pattern3) ...)
;; this from hipster link will match () so same for "alt ..." in racket
(define-syntax amb
  (syntax-rules ()
    ;; https://stackoverflow.com/q/79098453/21294350
    ;; https://hipster.home.xs4all.nl/lib/scheme/gauche/define-syntax-primer.txt
    ;; > will expand to a list
    ((amb . alts)
     (let ((+prev-amb-fail amb-fail))
        (call/cc
          (lambda (success)
            (map (lambda (alt)
                     (call/cc
                        (lambda (fail)
                          (set! amb-fail
                            (lambda ()
                              (set! amb-fail +prev-amb-fail)
                              (fail 'fail)))
                          (success alt))))
                   (list . alts))
            (+prev-amb-fail))))
     )
    ))
(list (amb 1 2) (amb 2 3))
; ((let ((+prev-amb-fail amb-fail)) 
;   (call/cc (lambda (success) 
;     (call/cc (lambda (fail) (set! amb-fail (lambda () (set! amb-fail +prev-amb-fail) (fail (quote fail)))) (success 1))) 
;     (call/cc (lambda (fail) (set! amb-fail (lambda () (set! amb-fail +prev-amb-fail) (fail (quote fail)))) (success 2))) (+prev-amb-fail)))) (let ((+prev-amb-fail amb-fail)) (call/cc (lambda (success) (call/cc (lambda (fail) (set! amb-fail (lambda () (set! amb-fail +prev-amb-fail) (fail (quote fail)))) (success 2))) (call/cc (lambda (fail) (set! amb-fail (lambda () (set! amb-fail +prev-amb-fail) (fail (quote fail)))) (success 3))) (+prev-amb-fail)))))
