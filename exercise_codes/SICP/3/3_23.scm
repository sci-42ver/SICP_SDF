(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "queue-lib.scm")
(define make-deque make-queue)

(define front-deque front-ptr)
(define rear-deque rear-ptr)

(define empty-deque? empty-queue?)
;; all the above won't
;; > not to make the interpreter try to print a structure that contains *cycles*.

(define rear-insert-deque! insert-queue!)
(define (front-insert-deque! deque item)
  (let ((new-deque-lst (cons item (front-deque deque))))
    (cond ((empty-deque? deque)
           (set-front-ptr! deque new-deque-lst)
           (set-rear-ptr! deque new-deque-lst)
           deque)
          (else
            (set-front-ptr! deque new-deque-lst)
            deque))))

(define front-delete-deque! delete-queue!)
(define (rear-delete-deque! queue)
  (cond ((empty-queue? queue)
         (error "DELETE! called with an empty queue" queue))
        (else
          ;; > All operations should be accomplished in Θ(1) steps
          ;; ... there seems no official implementation to car/cdr etc. back.
          (set-front-ptr! queue (cdr (front-ptr queue)))
          queue)))

;; ignore all the above implementations based on the above "...".
;; > Show how to represent deques using pairs
;; I assume it means "the first and last pairs ..."

;; front, the one before rear, rear
(define (make-deque) (list '() '() '()))
(define front-deque front-ptr)
(define (second-rear-deque deque) (cadr deque)) ; ... beyond the book specification.
(define (rear-deque deque) (caddr deque))

;; see wiki based on decell similar to the above but has bidirectional ptr for each item.
