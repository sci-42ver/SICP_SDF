;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; call/cc return
(define return #f) 

(+ 1 (call/cc 
      (lambda (cont) 
        (set! return cont) 
        1)))
; 2
;; So (call/cc foo) returns (foo cont) result.

(define use-set! true)
(define (call/cc-do-other-stuff do-other-stuff)
  (if use-set!
    (set! do-other-stuff (call/cc do-other-stuff))
    (call/cc do-other-stuff)))

(define (hefty-computation do-other-stuff) 
  (let loop ((n 5)) 
    (display "Hefty computation: ") 
    (display n) 
    (newline) 
    ; (set! do-other-stuff (call/cc do-other-stuff))
    (call/cc-do-other-stuff do-other-stuff)
    (display "Hefty computation (b)")  
    (newline) 
    ; (set! do-other-stuff (call/cc do-other-stuff))
    (call/cc-do-other-stuff do-other-stuff)
    (display "Hefty computation (c)") 
    (newline) 
    ; (set! do-other-stuff (call/cc do-other-stuff))
    (call/cc-do-other-stuff do-other-stuff)
    (if (> n 0) 
        (loop (- n 1))))) 
;; notionally displays a clock 
(define (superfluous-computation do-other-stuff) 
  (let loop () 
    (for-each (lambda (graphic) 
                (display graphic) 
                (newline) 
                ; (set! do-other-stuff (call/cc do-other-stuff))
                (call/cc-do-other-stuff do-other-stuff)
                ) 
              '("Straight up." "Quarter after." "Half past."  "Quarter til.")) 
    (loop))) 

(hefty-computation superfluous-computation)