#lang racket
; (cd "~/SICP_SDF/lecs/CS_61A/lib")
; (load "obj.scm")
; (require "obj.rkt")

;; TODO no use https://stackoverflow.com/a/45344192
(load "~/SICP_SDF/lecs/CS_61A/lib/obj.rkt")
; (require "~/SICP_SDF/lecs/CS_61A/lib/obj.rkt")

;; https://docs.scheme.org/guide/macros/ MIT scheme doesn't support this.
;; This structure is very similar to SICP (define (make-account balance) ...).
(define-class (account balance)
              (method (deposit amount)
                      (set! balance (+ amount balance))
                      balance)
              (method (withdraw amount)
                      (if (< balance amount)
                        "Insufficient funds"
                        (begin
                          (set! balance (- balance amount))
                          balance))) )
(define Matt-Account (instantiate account 1000))
