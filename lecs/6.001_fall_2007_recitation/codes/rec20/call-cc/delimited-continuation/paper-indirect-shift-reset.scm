; https://web.archive.org/web/20110718075439/http://www-pu.informatik.uni-tuebingen.de/users/sperber/papers/shift-reset-direct.pdf
;; actually same as lecs/6.001_fall_2007_recitation/codes/rec20/call-cc/delimited-continuation/indirect-shift-reset.scm when expansion.

(define-syntax reset
  (syntax-rules ()
    ((reset ?e) (*reset (lambda () ?e)))))
(define-syntax shift
  (syntax-rules ()
    ((shift ?k ?e) (*shift (lambda (?k) ?e)))))

(define (*meta-continuation* v)
  (error "You forgot the top-level reset..."))

(define (*abort thunk)
  (let ((v (thunk)))
    (*meta-continuation* v)))

(define (*reset thunk)
  (let ((mc *meta-continuation*))
    (call-with-current-continuation
      (lambda (k)
        (begin
          (set! *meta-continuation*
            (lambda (v)
              (set! *meta-continuation* mc)
              (k v)))
          (*abort thunk))))))

(define (*shift f)
  (call-with-current-continuation
    (lambda (k)
      (*abort (lambda ()
                (f (lambda (v)
                    ;; > Therefore, it is surrounded by a reset that moves this continuation into *meta-continuation*, effectively protecting it.
                    ;; i.e. -> (*reset (lambda () (k v)))
                    ;; -> (call/cc ... (k v) ...) where (k v) is stored in *meta-continuation*.
                     (reset (k v)))))))))
