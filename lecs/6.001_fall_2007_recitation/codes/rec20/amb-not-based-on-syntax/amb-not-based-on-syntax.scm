;; https://rosettacode.org/wiki/Amb
(define %fail-stack '())

(define (%fail!)
  (if (null? %fail-stack)
      (error 'amb "Backtracking stack exhausted!")
      (let ((backtrack (car %fail-stack)))
        (set! %fail-stack (cdr %fail-stack))
        (backtrack backtrack) ; just continue to use cc
        )))

; (number? (values 1))

;; achieve the same behavior as that based on syntax-rules (so same basic ideas)
;; 1. (cdr choices)->... in syntax-rules
;; 2. use %fail-stack to go back.
;; 3. (set! %fail-stack (cons cc %fail-stack))->(SET! FAIL K-FAILURE)
;; 4. (set! %fail-stack (cdr %fail-stack))->(SET! FAIL FAIL-SAVE)
(define (amb choices)
  ;; Here values just return cc back which can be verified by (number? (values 1))
  ; (let ((cc (call-with-current-continuation values)))
  ;; here cc is (let ((cc _)) ...)
  (let ((cc (call-with-current-continuation (lambda (x) x))))
    ;; when (backtrack backtrack) goes here, the choices in env has been changed.
    (if (null? choices)
        (%fail!)
        (let ((choice (car choices)))
          (set! %fail-stack (cons cc %fail-stack))
          (set! choices (cdr choices))
          choice))))

(define (assert! condition)
  (unless condition (%fail!)))

;;; The list can contain as many lists as desired.
(define words (list '("the" "that" "a")
                    '("frog" "elephant" "thing")
                    '("walked" "treaded" "grows")
                    '("slowly" "quickly")))
(define (joins? a b)
  (char=? (string-ref a (sub1 (string-length a))) (string-ref b 0)))

;; added
(define (sub1 x)
  (- x 1))

;; use Solution 3
(let ((sentence (map amb words)))
  (fold
    (lambda (latest prev)
      (assert! (joins? prev latest))
      latest)
    (car sentence)
    (cdr sentence))
  sentence)