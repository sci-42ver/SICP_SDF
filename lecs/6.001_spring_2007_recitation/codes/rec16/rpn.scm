;; Run scheme --interactive --eval '(load "rpn.scm")' '(rpn)' '10 2 + 6 /'
(load "stack.scm")

(cd "~/SICP_SDF/exercise_codes/SICP")
(load "lib.scm")

;; https://cookbook.scheme.org/split-string/
(define (string-split string delimiter)
  (define (maybe-add a b parts)
    ;; https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Strings.html#index-substring
    ;; not include b-idx char.
    (if (= a b) parts (cons (substring string a b) parts)))
  (define (char-delimiter? char)
    (char=? char delimiter))
  (let ((n (string-length string)))
    (let loop ((a 0) (b 0) (parts '()))
      (if (< b n)
          (if (not (char-delimiter? (string-ref string b)))
              (loop a (+ b 1) parts)
              (loop (+ b 1) (+ b 1) (maybe-add a b parts)))
          (reverse (maybe-add a b parts))))))

(define (string-split-pred string char-delimiter?)
  (define (maybe-add a b parts)
    ;; https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Strings.html#index-substring
    ;; not include b-idx char.
    (if (= a b) parts (cons (substring string a b) parts)))
  (let ((n (string-length string)))
    (let loop ((a 0) (b 0) (parts '()))
      (if (< b n)
          (if (not (char-delimiter? (string-ref string b)))
              (loop a (+ b 1) parts)
              (loop (+ b 1) (+ b 1) (maybe-add a b parts)))
          (reverse (maybe-add a b parts))))))

(define max-depth 100)
(define (transform-num-proc str)
  (define (num-str? str)
    (= 1 (length (string-split-pred str (lambda (char) (not (char-numeric? char)))))))
  (cond 
    ((num-str? str) (string->number str))
    ((= 1 (string-length str)) 
      ;; TODO case str fails.
      
      ;; https://stackoverflow.com/a/53487618/21294350
      (let ((match 
              ; (string-ref str 0)
              (string->symbol str)
              ; str ; fail
              ))
        (case match
          ; ((#\+) +)
          ; ((#\-) -)
          ; ((#\*) *)
          ; ((#\/) /)
          ; (("+") +)
          ; (("-") -)
          ; (("*") *)
          ; (("/") /)
          ((+) +)
          ((-) -)
          ((*) *)
          ((/) /)
          (else (error "wrong stack elt" str match))
          ))
        )
    (else (error "wrong stack elt" str))))
(define rpn
  ; not put define here, since `define rpn ...` expects one expr.
  (let ((stack (make-stack max-depth)))
    (define (calc lst)
      (define (iter visited-lst rest-lst)
        (if (null? rest-lst)
          (error "operator should be put at last.")
          (let* ((top-str (car rest-lst))
                (top (transform-num-proc top-str)))
            (cond 
              ((compiled-procedure? top) 
                (let ((res (apply top (reverse visited-lst))))
                  (if (= 1 (length rest-lst))
                    (displayln (list "result:" res))
                    (iter (list res) (cdr rest-lst)))))
              ((number? top)
                (iter (cons top visited-lst) (cdr rest-lst)))
              (else (error "wrong arg" top))
              ))))
        (iter '() lst))
    (define (iter)
      (displayln "expr:")
      ;; https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Input-Procedures.html#index-read_002dline
      (let* ((msg-str (read-line))
            ;  (msg-str (symbol->string msg))
             )
        (cond 
          ((equal? "finish" msg-str) 'done)
          ;; for simplicity I won't check the wrong syntax inputs.
          (else
            (displayln (list "input is" msg-str))
            (let ((operand-lst (string-split msg-str #\space)))
              ;; Here stack will have polish notation.
              (stack 'push-all-list operand-lst)
              ;; Dut to calculation order, we need to reverse back.
              ;; pop-all implicitly clears the stack.
              (calc (reverse (pop-all stack)))
              ; (stack 'clear)
              (iter)
              )))))
    iter)
  )

; 10 2 + 6 / 3 * 2 -
; (result: 4)
