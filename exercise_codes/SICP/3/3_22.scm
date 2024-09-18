(define (make-queue)
  (let ((front-ptr '() )
        (rear-ptr '() ))
    (define (set-front-ptr! queue item)
      (set! front-ptr item))
    (define (set-rear-ptr! queue item)
      (set! rear-ptr item))
    (define (dispatch m) 
      (case m
        ((front-ptr) front-ptr)
        ((rear-ptr) rear-ptr)
        ((set-front-ptr!) set-front-ptr!)
        ((set-rear-ptr!) set-rear-ptr!)
        ))
    dispatch))

;; trivial by mimicking
(define (front-ptr queue) (queue 'front-ptr))
(define (rear-ptr queue) (queue 'rear-ptr))
;; Scheme: variable required in this context https://stackoverflow.com/a/59493589/21294350
; (define (set-front-ptr! queue item) (set! (front-ptr queue) item))
; (define (set-rear-ptr! queue item) (set! (rear-ptr queue) item))
(define (set-front-ptr! queue item) ((queue 'set-front-ptr!) queue item))
(define (set-rear-ptr! queue item) ((queue 'set-rear-ptr!) queue item))

;; same
(define (empty-queue? queue) (null? (front-ptr queue)))
(define (front-queue queue)
  (if (empty-queue? queue)
    (error "FRONT called with an empty queue" queue)
    (car (front-ptr queue))))
(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)
          (else
            (set-cdr! (rear-ptr queue) new-pair)
            (set-rear-ptr! queue new-pair)
            queue))))
(define (delete-queue! queue)
  (cond ((empty-queue? queue)
         (error "DELETE! called with an empty queue" queue))
        (else
          (set-front-ptr! queue (cdr (front-ptr queue)))
          queue))) 

;; tests
(define (print-queue queue)
  (cons (front-ptr queue) (rear-ptr queue)))

(define q (make-queue)) 
(empty-queue? q)      ; #t 

(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "../lib.scm")
(assert-predicate equal? '((a) a) (print-queue (insert-queue! q 'a)))   ; ((a) a) 
(q 'front)           ; a 
(empty-queue? q)      ; #f      
(assert-predicate equal? '((a b) b) (print-queue (insert-queue! q 'b)))   ; ((a b) b) 
(q 'front)           ; a 

(assert-predicate equal? '((b) b) (print-queue (delete-queue! q)))     ; ((b) b) 
(assert-predicate equal? '(() b) (print-queue (delete-queue! q)))     ; (()) 
