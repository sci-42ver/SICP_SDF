;; nopnopnoop
;; `not` doesn't work since it must use the former frame-stream to do filter instead of the the-empty-stream singleton-stream. 
(define (and-frame-stream frame-stream1 frame-stream2) 
  (if (or (null-stream? frame-stream1) (null-stream? frame-stream2)) ; short-circuit
    null-stream
    ;; interleave is implied in stream-flatmap already for infinite stream.
    (interleave-stream-delayed 
      (flatmap-stream 
        (lambda (frame) 
          (let ((unified-frame (unify-frame (car-stream frame-stream1) 
                                            frame))) 
            (if (eq? unified-frame 'failed) 
              null-stream 
              (singleton-stream unified-frame)))) 
        frame-stream2) 
      (delay (and-frame-stream (cdr-stream frame-stream1) 
                               frame-stream2)))))

(define (conjoin conjuncts frame-stream) 
        ;;;平行的计算所有conjunct的frame-stream并合并它们,但这有个问题,即像not,lisp-value这些"过滤器"会可能会导致匹配失败,因为当输入为空framestream时,输出也为空frame-stream. 
        (define (conjoin-frame frame) 
                (define (loop conjuncts conjuncted-frame-stream) 
                        (if (null? conjuncts) 
                            conjuncted-frame-stream 
                            (loop (rest-conjuncts conjuncts) 
                                  ;; The idea is same as the rest to unify one by one with base (singleton-stream '()).
                                  (and-frame-stream conjuncted-frame-stream 
                                                    (qeval (first-conjunct conjuncts) 
                                                          ;; All use the same frame.
                                                          (singleton-stream frame)))))) 
                (loop conjuncts (singleton-stream '()))) 
        (flatmap-stream conjoin-frame frame-stream))

;; closeparen
;; 0. evaluated-streams are the list of frame-stream's got from each conjunct
;; 1. `(stream-flatmap prepend (car streams))` does prepend for each frame from the 1st frame-stream.
;; so frames-from-cartesian returns all permutations for frames with the nth frame from the nth frame-stream
;; 2. reconcile-frames combines *all* frames for one frames-from-cartesian elem by (fold-left append '() frames).
;; So that is all bindings for one frames-from-cartesian elem.
;; Then reconcile is just one wrapper of extend-if-consistent.

;; As queens problem shows, listing all permutations and then filtering is inefficient.
;; Similar to fiveguys_bcb's to use cartesian. IMHO better to do filter at the same time when construction.
;; IMHO they are same.
