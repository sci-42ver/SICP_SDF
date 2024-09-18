;#! /bin/s9

; Exercise 3.23 SICP 1st & 2nd Ed
; If using racket include a compatability package like this:  racket -p neil/sicp
; dqi- (DeQue Internal) is the prefix (name space) for helper procedures.

(define (dqi-make-node payload) (list '() payload '()))
(define (dqi-node-left    node) (car node))
(define (dqi-node-payload node) (cadr node))
(define (dqi-node-right   node) (caddr node))
(define (dqi-node-set-left!  node v) (set-car! node v))
(define (dqi-node-set-right! node v) (set-car! (cddr node) v))
(define (dqi-print dq)
  (define (mk-list n xs)
    (if (null? n)
      xs
      (mk-list (dqi-node-left n) (cons (dqi-node-payload n) xs))
      ))

  (if (empty-deque? dq)
    (display 'empty)
    (display (mk-list (right-ptr dq) '())))
  (newline))

; These are pretty much straight from SICP, global environment pollution and all.
(define (left-ptr dq)   (car dq))
(define (right-ptr dq)  (cdr dq))
(define (set-left-ptr! dq item)  (set-car! dq item))
(define (set-right-ptr! dq item) (set-cdr! dq item))

(define (dqi-insert dq payload m)
  (define (establish dq node)
    (set-left-ptr! dq node)
    (set-right-ptr! dq node))

  (define (insert dq m newnode)
    (let ((head 'dontcare))
      (cond ((eq? m 'left)
             (set! head (left-ptr dq))
             (dqi-node-set-right! newnode head)
             (dqi-node-set-left! head newnode)
             (set-left-ptr! dq newnode))
            ((eq? m 'right)
             (set! head (right-ptr dq))
             (dqi-node-set-left! newnode head)
             (dqi-node-set-right! head newnode)
             (set-right-ptr! dq newnode))
            (else (error "Internal Error: bad message" m)))))

  (let ((newnode (dqi-make-node payload)))
    (if (empty-deque? dq)
      (establish dq newnode)
      (insert dq m newnode))))

(define (dqi-delete dq m)
  (define (reset dq)
    (set-left-ptr! dq '())
    (set-right-ptr! dq '()))

  (define (delete dq m)
    (cond ((eq? m 'left) 
           (set-left-ptr! dq (dqi-node-right (left-ptr dq)))
           (dqi-node-set-left! (left-ptr dq) '()))
          ((eq? m 'right) 
           (set-right-ptr! dq (dqi-node-left (right-ptr dq)))
           (dqi-node-set-right! (right-ptr dq) '()))
          (else  (error "Internal Error: bad message" m))))

  ; A delete operation on an empty deque is a NOP, not an error
  (if (eq? (left-ptr dq) (right-ptr dq))
    (reset dq)
    (delete dq m)))

; Below are the exported procedures of the API
;
(define (make-deque)  (cons '() '()))
(define (front-insert-deque! dq item) (dqi-insert dq item 'left)  'ok)
(define (rear-insert-deque!  dq item) (dqi-insert dq item 'right) 'ok)
(define (front-delete-deque! dq)      (dqi-delete dq 'left)  'ok)
(define (rear-delete-deque!  dq)      (dqi-delete dq 'right) 'ok)

(define (empty-deque? dq)
  (define (nn? b)  (not (null? b)))
  (cond ((and (null? (car dq))  (null? (cdr dq)))  #t)
        ((and (nn?   (car dq))  (nn?   (cdr dq)))  #f)
        (else (error "Internal Error: empty consistency" dq))))

(define (front-deque dq)
  (if (empty-deque? dq)
    (error "FRONT called with an empty deque" dq)
    (dqi-node-payload (left-ptr dq))))

(define (rear-deque dq)
  (if (empty-deque? dq)
    (error "REAR called with an empty deque" dq)
    (dqi-node-payload (right-ptr dq))))
