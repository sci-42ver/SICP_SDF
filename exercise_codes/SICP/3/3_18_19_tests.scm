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

;; I don't know why above cycle-1 is tested separately. I review this when 4.34 wiki revc's uses hash table to implement this.
(define (full-test func)
  (test func)
  (assert (func cycle-1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;; See 3_32.scm TODO semmingly fail for one special case.
;; fail for 
; (0 (3 #0=(() #[compound-procedure 18] #1=(#0# #[compound-procedure 19] #2=(#1# #[compound-procedure 20] #3=(#2# #[compound-procedure 21] (#3# #[compound-procedure 22] ()))))) #3# #[compound-procedure 22] ()))
;; i.e.
; (0 (3 #0=(() 18 #1=(#0# 19 #2=(#1# 20 #3=(#2# 21 (#3# 22 ()))))) #3# 22 ()))
;; but not
; (0 (3 #0=((#[compound-procedure 18]) . #1=((#[compound-procedure 19] . #0#) . #2=((#[compound-procedure 20] . #1#) . #3=((#[compound-procedure 21] . #2#) (#[compound-procedure 22] . #3#))))) (#[compound-procedure 22] . #3#)))

(define 3-32-cycle 
  (list 0 (list 3 
    (list '() 18 (list 'sharp-0 19 (list 'sharp-1 20 (list 'sharp-2 21 (list 'sharp-3 22 '())))))
    'sharp-3 22 '())))
3-32-cycle
(define sharp-0 (cadadr 3-32-cycle))
(set-car! (caddr sharp-0) sharp-0)
3-32-cycle
(define 3-32-cycle-with-only-sharp-0 3-32-cycle)
(define (next-sharp current-sharp)
  (define next-sharp (caddr current-sharp))
  (set-car! (caddr next-sharp) next-sharp)
  next-sharp)

; (define sharp-1 (next-sharp sharp-0))
; (define sharp-2 (next-sharp sharp-1))
; (define sharp-3 (next-sharp sharp-2))
; 3-32-cycle
; (set-car! (cddadr 3-32-cycle) sharp-3)
; 3-32-cycle
3-32-cycle

;; minimal pattern, i.e. with only sharp-0.

(define (full-test-with-3-32-test func)
  (full-test func)
  (assert (func 3-32-cycle-with-only-sharp-0)))