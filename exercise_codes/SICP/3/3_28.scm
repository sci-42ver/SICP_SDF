(define (or-gate a1 a2 output)
  (define (or-action-procedure)
    (let ((new-value
            ;; trivial logical-or implementation is skipped by using cond
            ;; See wiki using `or` is more elegant
            (logical-or (get-signal a1) (get-signal a2))))
      ;; outside variable "or-gate-delay"
      (after-delay or-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  'ok)
