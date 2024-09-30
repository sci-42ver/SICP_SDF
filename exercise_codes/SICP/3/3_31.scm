(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "circuit-lib.scm")

(define the-agenda (make-agenda))
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)

(define input-1 (make-wire))
(define input-2 (make-wire))
(define sum (make-wire))
(define carry (make-wire))
(define (test)
  (probe 'sum sum)
  ; sum 0  New-value = 0
  (probe 'carry carry)
  ; carry 0  New-value = 0

  (half-adder input-1 input-2 sum carry)
  ; ok
  (set-signal! input-1 1)
  ; done
  (propagate)

  (set-signal! input-2 1)
  ; done
  (propagate)
  )

(test)

(define (make-wire)
  (let ((signal-value 0) (action-procedures '()))
    (define (set-my-signal! new-value)
      (if (not (= signal-value new-value))
        (begin (set! signal-value new-value)
               (displayln (list "set to new-value" new-value))
               (call-each action-procedures))
        'done))
    (define (accept-action-procedure! proc)
      ;; later is first manipulated. See `call-each`. But `add-to-agenda!` will sort it.
      (set! action-procedures (cons proc action-procedures))
      ; (proc)
      )
    (define (dispatch m)
      (cond ((eq? m 'get-signal) signal-value)
            ((eq? m 'set-signal!) set-my-signal!)
            ((eq? m 'add-action!) accept-action-procedure!)
            (else (error "Unknown operation -- WIRE" m))))
    dispatch))

(define the-agenda (make-agenda))
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)

(define input-1 (make-wire))
(define input-2 (make-wire))
(define sum (make-wire))
(define carry (make-wire))
(test)
