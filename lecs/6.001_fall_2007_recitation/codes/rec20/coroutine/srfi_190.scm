(make-coroutine-generator
  (lambda (yield)
    (do ((i 0 (+ i 1)))
      ((<= 3 i))
      (yield i))))

(define print display)
(define (test)
  (define test-coroutine-1
    (make-coroutine-generator
      (lambda (yield)
        (print "HELLO!")
        (yield 1)
        (print "WORLD!")
        (yield 2)
        (print "SORRY, I'M OUT")
        ))
    )

  (assert (not (= (test-coroutine-1) 2)))
  (assert (not (= (test-coroutine-1) 1)))
  (write-line "to run the last")
  (test-coroutine-1)
  (test-coroutine-1)
  (test-coroutine-1)
  )
(test)

;; from https://git.savannah.gnu.org/cgit/mit-scheme.git/tree/src/runtime/generator.scm#n135
;; same as https://github.com/scheme-requests-for-implementation/srfi-158/blob/32aed996ecc98680c65848c54f23121adb1ba692/srfi-158-impl.scm#L77-L87
;; but 
;; 0. using explicit unspecific for "(if #f #f)"
(define (make-coroutine-generator proc)
  (let ((return #f)
        (resume #f))

    (define (yield v)
      (call/cc
        (lambda (k)
          (set! resume k)
          (return v))))

    (lambda ()
      (call/cc
        (lambda (cc)
          (set! return cc)
          (if resume
            ;; This won't update return.
            (resume unspecific)
            (begin
              (proc yield)
              (write-line "finish proc")
              ;; This may be false since this must use the 1st cc due to finishing (proc yield).
              ;; But return may have been updated later.
              ; (assert (eq? cc return))
              ;; 0. This also won't update return.
              ;; 1. To make all later calls to this proc do nothing.
              (set! resume
                (lambda (v)
                  (declare (ignore v))
                  (return (eof-object))))
              ;; IGNORE Here return is cc, so we can just use implicit return. So no need to update resume before.
              (return (eof-object))
              ; (eof-object)
              )))))))
(test)

syntax-rules
;; fail due to no syntax-case.
;; Anyway this is just one wrapper.
; syntax-case
; (define-syntax coroutine-generator
;   (lambda (stx)
;     (syntax-case stx ()
;       ((_ . body)
;        #'(make-coroutine-generator
;           (lambda (%yield)
;             (syntax-parameterize ((yield (identifier-syntax %yield)))
;               . body)))))))
