(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

;; IGNORE: based on recursion, the right frame will be larger than the left.
;; So we 
;; 0. and will implicitly finish when having frame-stream being the-empty-stream at some time.
;; 1. Here we assume frame1 is the frame-stream merged before which gets passed here. 
(define (merge-frame-stream-pair frame-stream1 frame-stream2)
  ;; ideally, "n^2 /k^2" checks implied by the nested loop
  (stream-flatmap
    (lambda (frame1)
      (stream-flatmap
        (lambda (frame2)
          (merge-frame-pair frame1 frame2)
          )
        frame-stream2)
      )
    frame-stream1))

;; as repo shows, better to check null for frame2.
(define (merge-frame-pair frame1 frame2)
  (if (null? frame1)
    ;; return stream
    (singleton-stream frame2)
    (let* ((binding1 (car frame1))
           (var (car binding1))
           (val (cdr binding1))
           (extended-res (extend-if-possible var val frame2))
           )
      ;; similar to apply-a-rule
      (if (eq? extended-res 'failed)
        the-empty-stream
        (merge-frame-pair (cdr frame1) extended-res))
      ))
  )

(define (first-conjunct exps) (car exps))
(define (second-conjunct exps) (cadr exps))
(define (conjuncts-after-second exps) (cddr exps))
(define (len=1? exps)
  (null? (cdr exps)))

(define (conjoin conjuncts frame-stream)
  (if (empty-conjunction? conjuncts)
    frame-stream
    ;; IGNORE: Without delay, this will at last evaluate the last conjunction first unexpectedly.
    ;; With delay, we can ensure independent evaluation from left to right.
    ;; Due to independence, whether evaluation from left to right or reverse doesn't matter.
    ;; Here we can't exit delay due to they are all evaluabled independently based on the *same* frame-stream.
    ; (merge-frame-pair
    ;   (qeval (first-conjunct conjuncts)
    ;                 frame-stream)
    ;   (conjoin (rest-conjuncts conjuncts)
    ;          frame-stream))

    ;; n^2/k is due to the many output frames. This won't happen if each query is based on the mere the-empty-stream singleton-stream.
    ;; This is just what the above does.
    ;; But this may also lose the short-circuit property.
    ;; So I combine them in the following.

    ;; The above is not good due to no short-circuit property.
    (cond 
      ((len=1? conjuncts) (qeval (first-conjunct conjuncts)
                                 frame-stream))
      (else
        (let ((frame-stream-for-pair 
                (merge-frame-stream-pair
                  (qeval (first-conjunct conjuncts)
                         frame-stream)
                  (qeval (second-conjunct conjuncts)
                         frame-stream))))
          (conjoin (conjuncts-after-second conjuncts) frame-stream-for-pair))))
    ))
; (put 'and 'qeval conjoin)

(query-driver-loop)

(and (job ?person (computer programmer))
     (address ?person ?where))

;; test from poly
(and (append-to-form (1 2) (3 4) ?x) 
    (append-to-form (1) ?y ?x))

(assert! (rule (reverse () ())))
(assert! (rule (reverse (?x . ?y) ?z) 
          (and (reverse ?y ?v) 
                (append-to-form ?v (?x) ?z))))
;; infinite loop since (append-to-form ?v (?x) ?z) must use ?v from the former.
;; If not, then (append-to-form ?v (?x) ?z) will have ?v and ?z unknown, so infinite cases (Just think it with maths).
;; Otherwise, only ?z is unknown based on induction which can be decided by the former 2.
(reverse (1 2 3) ?x)