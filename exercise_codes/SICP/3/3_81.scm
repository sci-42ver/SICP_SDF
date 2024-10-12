;; from wiki meteorgan's.
(define (random-update x) 
  (remainder (+ (* 13 x) 5) 24)) 
(define random-init (random-update (expt 2 32))) 

;; assume the operation 'generator and 'reset is a stream, 
;; and if the command is 'generator, the element of 
;; stream is a string, if the command is 'reset, 
;; it is a pair whose first element is 'reset, 
;; the other element is the reset value. 
(define (random-number-generator command-stream) 
  (define (manipulate-cmd number command)
    (cond ((eq? command 'generate) 
          (random-update number)) 
          ((and (pair? command) 
                (eq? (car command) 'reset)) 
          (cadr command))
          ;; not allow empty command as the first command.
          (else (error "bad command -- " command))))
  (define random-number 
    (stream-map 
      (lambda (number command) 
        (manipulate-cmd number command)) 
      (cons-stream random-init random-number)
      command-stream)
    ; (if (stream-null? command-stream)
    ;   command-stream
    ;   (cons-stream
    ;     (manipulate-cmd random-init (stream-car command-stream))
    ;     (stream-map 
    ;       (lambda (number command) 
    ;         (manipulate-cmd number command)) 
    ;       random-number
    ;       (stream-cdr command-stream))))
    ) 
  random-number)

(define s1 
  (random-number-generator 
    (stream '(reset 2010)
            'generate
            'generate
            'generate
            '(reset 2020)
            'generate
            'generate
            '(reset 2010)
            'generate
            'generate)))

(stream-head s1 10)

(define s2
  (random-number-generator 
    (stream 'generate
            'generate
            'generate
            `(reset ,random-init)
            'generate
            'generate
            'generate
            '(reset 2010)
            'generate
            'generate)))

(stream-head s2 10)