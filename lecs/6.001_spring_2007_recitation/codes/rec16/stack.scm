;; Use `sed -i -f ~/SICP_SDF/lecs/6.001_spring_2007_recitation/codes/rec13/format.sed *.scm;for i in *.scm; do vim -c "execute 'normal gg=G'| update | quitall" $i;done` to format.
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
        (raise "stack underflow when peek")
        (car data)))
    (define (push elt)
      (if (have-room?)
        (set! data (cons elt data))
        ; 'do-nothing
        ;; to be compatible with test
        ;; See https://standards.scheme.org/corrected-r7rs/r7rs-Z-H-8.html#TAG:__tex2page_index_910. Use raise to output some useful infos. 
        (raise "stack overflow when push")
        ))
    (define (pop)
      ;; > Remember to program defensively.
      (if (empty?)
        ;; sol: done implicitly in peek.
        (raise "stack underflow when pop")
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
        ;; sol `(push (car args))` is defensive.
        ((push) (apply push args))
        ((pop) (pop))
        ((push-all-args) (apply push-all-args args))
        ;; sol: ` (for-each push (car args))` only considers one list.
        ((push-all-list) 
         (for-each 
           (lambda (arg-lst) (push-all-list arg-lst))
           args))

        ((data) data)
        (else (raise (list "stacks can't " msg)))))
    ; any additional initialization , parameter checking , etc .
    ;; sol `(< max-depth 0)`
    (if (< max-depth 0)
      (raise (list "max-depth must be non-negative , not :" max-depth)))

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
      ;; sol is better where we cons the first to the rest instead of lst here.
      ;; > What 's (potentially) wrong with getting rid ...?
      ;; See https://stackoverflow.com/a/5522061/21294350
      ))
  (reverse (reverse-lst))
  )
(my-stack 'data)
(my-stack 'empty?)
(pop-all my-stack)
(my-stack 'empty?)

;; to be compatible with test
(define (reverse-using-stack lst)
  (let ((stack (make-stack (length lst))))
    (stack 'push-all-list lst)
    (pop-all stack)
    ))
