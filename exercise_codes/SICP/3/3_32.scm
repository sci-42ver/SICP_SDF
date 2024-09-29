(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "circuit-lib.scm")

(define the-agenda (make-agenda))
(define and-gate-delay 3)

(define input-1 (make-wire))
(define input-2 (make-wire))
(define output (make-wire))

(define (3_32_test)
  (probe 'output output)
  ;; All the following 5 will call action-procedure. Since we haven't called propagate, delay starting time haven't changed.
  (and-gate input-1 input-2 output)

  (set-signal! input-1 1)
  (set-signal! input-2 0)

  (set-signal! input-2 1)
  (set-signal! input-1 0)
  )

(3_32_test)
(propagate)

;; deque
;; will cause one loop unable to be checked by 3_19_AntonKolobov_mod.
; (load "3_23_roytobin.scm")
(load "3_23_wtative.scm")

(define empty-queue? empty-deque?)
(define rear-queue rear-deque)
(define delete-queue! rear-delete-deque!)
(define insert-queue! front-insert-deque!)

;; last in, first out
(define (remove-first-agenda-item! agenda)
  (let ((q (segment-queue (first-segment agenda))))
    (delete-queue! q)
    (if (empty-queue? q)
        (set-segments! agenda (rest-segments agenda)))))

(define (first-agenda-item agenda)
  (if (empty-agenda? agenda)
      (error "Agenda is empty -- FIRST-AGENDA-ITEM")
      (let ((first-seg (first-segment agenda)))
        (set-current-time! agenda (segment-time first-seg))
        (rear-queue (segment-queue first-seg)))))

;; reinit
(define the-agenda (make-agenda))
(define and-gate-delay 3)

(define input-1 (make-wire))
(define input-2 (make-wire))
(define output (make-wire))

(3_32_test)
(load "3_19_AntonKolobov_mod.scm")
;; TODO I don't know why insertion above will cause the loop...
(if (has-cycle? the-agenda)
  'skipped
  (propagate))
;; See repo which doesn't use deque for LIFO.

; (3 (3 (#[compound-procedure 14] #[compound-procedure 15] #[compound-procedure 16] #[compound-procedure 17]) 
;   #[compound-procedure 17]))