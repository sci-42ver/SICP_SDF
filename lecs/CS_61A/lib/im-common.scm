#| Common code between the client and server

WARNING: requests cannot contain invalid read characters.
e.g. don't try to send procedure objects or other objects that
STk prints as #[...]

Example misuse:
(send-request (make-request 'dummy1 'dummy2 'send-msg car))
|#

(define nil '())

;; REQUEST ADT
(define (make-request src dst action data)
  (list src dst action data))

(define (request-src req) (list-ref req 0))
(define (request-dst req) (list-ref req 1))
(define (request-action req) (list-ref req 2))
(define (request-data req) (list-ref req 3))


;; SEND/GET Request from ports
(define (send-request req write-port)
  (if (and (not (null? write-port)) (not (port-closed? write-port)))
    (begin (format write-port "~S" req)
           (flush write-port)
           'okay)
    (begin (format #t "Could not send request to port.~%")
           #f)))

(define (get-request read-port)
  (if (and (not (null? read-port)) (not (port-closed? read-port)))
    (let ((result #f))
      (with-exception-handler (lambda (c)
                                (format #t "Could not get request from port (bad input)~%"))
                              (lambda ()
                                (let ((raw-msg (read read-port)))
                                  (if (eof-object? raw-msg)
                                    (format #t "Could not get request from port (EOF)~%")
                                    (set! result raw-msg)))))
      result)
    (begin (format #t "Could not get request from port (EOF)~%")
           #f)))

;; from book
(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "serializer-lib.scm")

;; https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Format.html
(load-option 'format)
