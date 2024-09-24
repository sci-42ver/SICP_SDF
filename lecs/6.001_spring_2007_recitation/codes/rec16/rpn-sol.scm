;;; This reverse polish notation (postfix) calculator is an interesting
;;; use of our stack object .
(load "stack.scm")
(define (make-calculator)
  ; an RPN calculator
  (let ((stack (make-stack 100)))
    (define (eval-binary-op op)
      ; This helper handles the stack manipulation and evaluation of binary
      ; RPN operations
      (let ((second-arg (stack 'POP))
            (first-arg (stack 'POP)))
        ; For non-commutative operations , we need to reverse the arguments so
        ; that , for example 5 , then 2, then - gives (- 5 2)
        (stack 'push (op first-arg second-arg))))
    ;; same return object type as make-stack
    (lambda (message . args)
      ; The procedure created by this lambda is returned by make-calculator .
      ; It 's a message handler with a variable-length argument list . Note :
      ; In order to focus on the basic concepts , we haven 't bothered checking
      ; the length of args (e.g. for a CLEAR message args should be nil , for
      ; NUMBER-INPUT args should be a list of exactly one number .
      (case message
        ((ANSWER)
         (if (stack 'EMPTY?)
           'empty-stack
           (stack 'peek)))
        ((CLEAR)
         (stack 'clear)
         'cleared)
        ((NUMBER-INPUT) (stack 'PUSH (car args)))
        ((ADD) (eval-binary-op +))
        ((SUB) (eval-binary-op -))
        ((MUL) (eval-binary-op *))
        ((DIV) (eval-binary-op /))
        (else (error " calculator doesn't " message))))))
(define c (make-calculator))
(c 'ANSWER) ; empty-stack
(c 'NUMBER-INPUT 4) ; pushed
(c 'ANSWER) ; 4
(c 'NUMBER-INPUT 5) ; pushed
(c 'ANSWER) ; 5
(c 'ADD) ; pushed
(c 'ANSWER) ; 9
(c 'NUMBER-INPUT 7) ; pushed
(c 'SUB) ; pushed
(c 'ANSWER) ; 2
(c 'CLEAR) ; cleared
(c 'ANSWER) ; empty-stack
(c 'ANSWER-MY-HOMEWORK) ; error
