; constructor for stack objects with a maximum depth
(define (make-stack max-depth)
  ; private local state
  (let ((data '()))
    ;; base hepler
    (define (have-room?)
      (< (length data) max-depth))
    ; method implementations
    (define (empty?) (null? data))
    (define (clear)
      (set! data '())
      ;; sol return one msg symbol.
      ;; similar for push
      )
    (define (peek)
      (if (empty?)
        (error "stack underflow")
        (car data)))
    (define (push elt)
      (if (have-room?)
        (set! data (cons elt data))
        'do-nothing))
    (define (pop)
      ;; > Remember to program defensively.
      (if (empty?)
        ;; sol: done implicitly in peek.
        (error "stack underflow")
        (let ((top (peek)))
          (set! data (cdr data))
          top)))
    (define (push-all-args . args)
      ;; https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Mapping-of-Lists.html#index-for_002deach
      ;; > in order
      (for-each (lambda (arg) (push arg)) args))
    (define (push-all-list lst)
      (apply push-all-args lst))
    ; create the message handler that we 'll return
    (define (msg-handler msg . args)
      (case msg
        ((empty?)
         (empty?))
        ((clear) (clear))
        ((peek) (peek))
        ;; sol `( push ( car args ))` is defensive.
        ((push) (apply push args))
        ((pop) (pop))
        ((push-all-args) (apply push-all-args args))
        ((push-all-list) 
          (for-each 
            (lambda (arg-lst) (push-all-list arg-lst))
            args))

        ((data) data)
        (else (error " stacks can 't " msg))))
    ; any additional initialization , parameter checking , etc .
    ; return the message handler
    msg-handler))
(define my-stack (make-stack 10))

;; > Draw the environment diagram resulting from evaluating (define s (make-stack 10)).
;; GE: s, make-stack
;; E1-GE: max-depth -> 10
;; E2-E1: data -> '(), have-room? ..., final value: msg-handler.
;; SOL: The above shares the same ideas. 

(my-stack 'empty?) ; --># t
(my-stack 'push 10)
; -->pushed
(my-stack 'empty?) ; --># f
(my-stack 'push 20)
; -->pushed
(my-stack 'peek)
; -->20
(my-stack 'pop)
; -->20
(my-stack 'peek)
; -->10

(my-stack 'push-all-list (list 1 2 3))
(my-stack 'push-all-args 1 2 3)

;; > Implement a procedure pop-all which takes a ...
(define (pop-all stack)
  (define (reverse-lst)
    (do ((lst '()))
      ((stack 'empty?) lst)
      ;; keep order beginning from top
      ; (append lst (list (pop stack)))
      ;; reversed order
      (set! lst (cons (stack 'pop) lst))
      ))
  (reverse (reverse-lst))
  )
(my-stack 'data)
(my-stack 'empty?)
(pop-all my-stack)
(my-stack 'empty?)