(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "lib.scm")
(define book-testcase (make-cycle (list 'a 'b 'c)))
(define t1-lst (list 'a 'b))
(define t2-lst (list t1-lst t1-lst))
(define normal-list (list 1 1))

(define x '(a b c)) 
(define y '(d e f)) 
(set-car! (cdr x) y)
x
(set-car! x (cdr x)) ; change 2
x
(set-cdr! (last-pair y) (cdr y))
x
; (cycle? x)
; (displayln (list "x is" x))
x
; (((d . #0=(e f . #0#)) c) (d . #0#) c)
;; Here "((d . #0=(e f . #0#)) c)" is done by change 2 where a is changed.

(define (test func)
  (assert (func x)) ; x from mbndrk's following comment.
  (assert (func book-testcase))
  (assert (not (func t2-lst)))
  (assert (not (func normal-list))))

(define cycle-1 (cons 'a (cons (cons 'a 'b) 'b)))
(set-car! (cdr cycle-1) cycle-1)
; (assert (inf_loop? cycle-1))