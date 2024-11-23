;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Core implementation of streams in DrScheme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; macro for cons-stream -- you are *not* expected to know how to implement 
;   macros for this class.  You can think of it as a way for us to create new
;   special forms _within_ DrScheme.  Any time DrScheme sees an expression of
;   the form
;      (cons-stream a b)
;   it will desugar it to
;      (cons a (delay b))
;   Note that explicit lazy evaluation via delay is built into DrScheme, otherwise
;   this wouldn't work.
(define-syntax cons-stream
  (syntax-rules ()
                ((cons-stream a b)
                 (cons a (delay b)))))

; selectors are simpler
(define (stream-car x)
  (car x))

(define (stream-cdr x)
  (force (cdr x)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Let's create a convention for empty streams
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define the-empty-stream '*empty-stream*)

(define (empty-stream? x) (eq? x the-empty-stream))
 
; Note: making a good stream? predicate is actually hard since we're using cons
;       cells to represent our stream pairs and thunks are allowed in other contexts
;       by DrScheme.  We'll just skirt the issue for now.
;; So this stream can be seen as just one normal pair.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Handy procedures
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Converts the first n elements of a stream to a list.
(define (print-stream s n)
  (if (= n 0)
      '()
      (cons (stream-car s) (print-stream (stream-cdr s) (- n 1)))))

(load "map-streams.scm")
(load "add-streams.scm")

;; The next 2 are already in the book codes
; Like list-ref, but for streams.  Returns the idx-th element of a stream. 0-indexed.
(define (stream-ref stream idx)
  (if (<= idx 0)
      (stream-car stream)
      (stream-ref (stream-cdr stream) (- idx 1))))

; Multiplies every element of the input stream by some factor
(define (scale-stream stream factor)
  ; Note: this null test is only needed if you want to deal with finite streams
  (if (empty-stream? stream)
      the-empty-stream
      (cons-stream (* (stream-car stream) factor)
                   (scale-stream (stream-cdr stream) factor))))

;; Also work for circular due to lazy.
(define (list->stream lst)
  ; Lists are always finite, so we must have a null check
  (if (null? lst)
      the-empty-stream
      (cons-stream (car lst) 
                   (list->stream (cdr lst)))))

;; trivially not work for infinite since list can't represent infinite
(define (stream->list stream)
  (if (empty-stream? stream)
      '()
      (cons (stream-car stream) 
            (stream->list (stream-cdr stream)))))

; Returns a new stream that only contains elements of stream that are not #f according 
; to the procedure pred.
(define (stream-filter pred stream)
  (cond ((empty-stream? stream) 
         the-empty-stream)
        ((pred (stream-car stream)) 
         (cons-stream (stream-car stream)
                      (stream-filter pred (stream-cdr stream))))
        (else
         (stream-filter pred (stream-cdr stream)))))
      

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Some handy streams
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load "assert.scm")

(define ones (cons-stream 1 ones))
(assert-equal (stream-car ones)              1)
(assert-equal (stream-car (stream-cdr ones)) 1)
(assert-equal (stream-ref ones 10)           1)

(define zeros (cons-stream 0 zeros))
(assert-equal (stream-ref zeros    0) 0)
(assert-equal (stream-ref zeros    1) 0)
(assert-equal (stream-ref zeros 1000) 0)

(define twos (add-streams ones ones))
(assert-equal (stream-ref twos 10) 2)

(define integers (add-streams ones (cons-stream 0 integers)))
(assert-equal (stream-ref integers  0)  1)
(assert-equal (stream-ref integers  1)  2)
(assert-equal (stream-ref integers  2)  3)
(assert-equal (stream-ref integers  3)  4)
(assert-equal (stream-ref integers 10) 11)
