;; from rec
(load "stack.scm")
; (define top-env (the-environment))

; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tests your recitation instructor used to make sure the code actually
;; worked correctly .
; Complains if val and expected are not equal?
; See notes at the end if you want to understand the implementation .
(define (assert-equal val expected)
  (if (not (equal? val expected))
    ;; https://standards.scheme.org/corrected-r7rs/r7rs-Z-H-8.html#TAG:__tex2page_index_912
    ;; Let internal "handler" manipulate.
    (raise (list " expected " expected ", but got " val))))
; Complains if evaluating expr does not result in a complaint .
; See notes at the end if you want to understand the implementation .
(define (assert-throws expr)
  ; This assert evaluates the given expression and then makes sure that
  ; it raises an exception .
  ; ... black magic lies herein
  (let ((exception-thrown #f))
    ;; IGNORE: https://practical-scheme.net/wiliki/schemexref.cgi?with-handlers 
    ; (with-handlers ((
    ;                  (lambda (exn) #t) ; filter all exceptions
    ;                 ;  #t
    ;                  (lambda (exn)
    ;                    ; Uncomment the next line to have suppressed exceptions
    ;                    ; get printed anyway .
    ;                    ;(display (vector-ref (struct->vector exn) 1)) (newline)
    ;                    (set! exception-thrown #t))))
    ;                ;; https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Environment-Operations.html#index-eval
    ;                ;; TODO directly call `(the-environment)` here won't work.
    ;                (eval expr top-env)
    ;           ) ; try evaluating

    ;; Since I use MIT-scheme instead of DrScheme (i.e. Drracket now)
    ;; https://standards.scheme.org/corrected-r7rs/r7rs-Z-H-8.html#TAG:__tex2page_index_910 hinted by https://practical-scheme.net/wiliki/schemexref.cgi?with-handlers -> https://practical-scheme.net/wiliki/schemexref.cgi?with-exception-handler
    (call-with-current-continuation
      (lambda (k)
        (with-exception-handler
          (lambda (x)
            (newline)
            (display "thrown by: ")
            (write x)
            (set! exception-thrown #t)
            ;; return the appropriate value to avoid throwing errors
            (k 'exception))
          (lambda ()
            (eval expr top-env)))))
    (if (not exception-thrown)
      (error " The following expression should have raised an exception :" expr))))
; (assert-throws '(+ 1 2)) ; uncomment this line to test assert-throws : (+ 1 2) is
; a valid expression , so it will fail to throw an exception ,
; and thus assert-throws will complain .

(assert-throws '(1 +))

; Test stack methods
(define s (make-stack 10))
(assert-equal (s 'empty?) #t)
(s 'push 10)
(assert-equal (s 'empty?) #f)
(s 'push 20)
(assert-equal (s 'empty?) #f)
(assert-equal (s 'peek) 20)
(assert-equal (s 'peek) 20)
(assert-equal (s 'pop) 20)
(assert-equal (s 'peek) 10)
(s 'clear)
(assert-equal (s 'empty?) #t)
(s 'push-all-list '(1 2 3 4 5))
(assert-equal (s 'peek) 5)
(s 'clear)
(assert-equal (s 'empty?) #t)
(s 'push-all-args '(1 2 3 4 5))
(assert-equal (s 'peek) '(1 2 3 4 5))
; Test pop-all procedure
(s 'clear)
6
(s 'push-all-args 1 2 3 4 5)
(assert-equal (pop-all s) '(5 4 3 2 1))
(assert-equal (s 'empty?) #t)
; Test reverse-using-stack
(define lst '(1 2 3 4 5 6 7 8 9 10))
(assert-equal (reverse-using-stack lst) (reverse lst))
; Make sure errors are generated appropriately .
(define s (make-stack 10))
(assert-throws '(s 'push-all-list '(1 2 3 4 5 6 7 8 9 10 11)))
(assert-throws '(define s (make-stack -10))) ; -->error
; You do * not * need to understand the following for this course , but it 's
; provided here for the curious ...
;
; Explanation of what all this (raise ...) and (with-handlers ...) stuff is:
; When you use the (error ...) procedure , an error is " thrown " or " raised ."
; This is an object . By default , this object is caught by a global error
; handler that prints out the error message with the little ladybug and so
; forth . It 's possible to catch an error in your own code as well . This is
; done with the with-handlers special form in DrScheme . Its first parameter
; is a list of two procedures . The first is a predicate that tells DrScheme
; which errors we want catch . The second element in the list is a procedure
; that 's called if an error is thrown and the predicate returned #t (or
; anything other than #f probably). The remaining arguments to with-handlers
; are its body . The body is evaluated . If any errors are raised , execution
; stops and the handler predicate is used . If #f is returned , the next
; enclosing with-handlers is looked at. In this case , we just have our
; with-handlers and the default one that 's implicitly used for all evaluations .
; For generating errors , I happened to use (raise ...) instead of (error ...)
; because I had trouble finding documentation on the data type of an error
; object . (raise ...) is a more flexible way of generating the objects .
;
; assert-throws is a little procedure that makes sure that evaluating its
; argument will throw an error . If an error is thrown by evaluating its
; argument , it returns silently . If an error is not thrown , it complains .
; Since it is supposed make sure errors are generated and suppress them , quote
; the expression in question instead of evaluating it in the global environment .
; (eval ...) is a special form that takes an object and evaluates it using the
; interpreter . We 'll be doing stuff like this this week in class .