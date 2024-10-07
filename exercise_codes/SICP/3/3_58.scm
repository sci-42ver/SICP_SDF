(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "book-stream-lib.scm")

(define (expand num den radix)
  (cons-stream
    (quotient (* num radix) den)
    (expand (remainder (* num radix) den) den radix)))

;; https://stackoverflow.com/questions/78597962/1-01e-100-1-in-mit-scheme/78626541#comment138620089_78597962
;; > The initial simplest form...
;; similar to stream here but with one more scalar, 10^3.
;; > You also can roll ...
;; The latter 5 Will Ness's comments (by the context of %) is about scaling num and den both. Also see round-prec.scm.
;; Not about stream. So only the 1st and the last comments of Will Ness's are about stream.
;; > (a%b) * (c%b)= ( round( (a*c)/b ) % b )
;; b corresponds to 10^prec in https://stackoverflow.com/a/76920203/21294350.
(define (stream-/ num den radix)
  (cons-stream
    (quotient num den)
    (expand (remainder num den) den radix)))

(load "../lib.scm")

;; 1. For simplicity, here very large number will not be considered since we only want to calculate 1+1/n, n->\infty.
;; 2. As one demo, here we won't implement Fast Carry using Propagator.
(define zeroes (cons-stream 0 zeroes))
(define decimal-idx 10)
;; up to prec-1 after the decimal point
(define prec 400)
;; 1. based on carry save https://en.wikipedia.org/wiki/Carry-save_adder#Technical_details (see point 3)
;; similar to the propagate between 2 "carry save adders" https://electronics.stackexchange.com/q/727175/341985.
;; 2. stream-head is fine since we are using "every" which must check all elements.
(define (carry-propagate mixed-fraction prec idx)
  (let ((integer-sum (cons-stream (stream-car mixed-fraction) zeroes))
        (decimal-fractions (stream-cdr mixed-fraction)))
    (let ((carry (stream-map (lambda (val) (quotient val idx)) decimal-fractions))
          (sum (cons-stream 0 (stream-map (lambda (val) (remainder val idx)) decimal-fractions)))
          )
      (let ((res (add-streams integer-sum carry sum)))
        (if (every (lambda (val) (< val idx)) (cdr (stream-head res prec)))
          res
          (carry-propagate res prec idx))))))
;; 1. each addend is (cons-stream integer proper-fraction) maybe got from stream-/ https://en.wikipedia.org/wiki/Fraction#Mixed_numbers
;; 2. prec means the digit pos of the minimal ulp among all addends where digit pos means cnt at the right of the decimal point starting from 1.
(define (add-streams-with-carry idx prec . addends)
  (let ((intermediate-res (apply stream-map + addends)))
    (carry-propagate intermediate-res prec idx)))
(define (->stream obj)
  (cond 
    ((stream-pair? obj) obj)
    ((number? obj) (cons-stream obj zeroes))
    (else (error "wrong type" obj))
    ))
(define (stream-+ a b)
  ; (assert (and (stream-pair? b) (number? a)))
  (let ((a (->stream a))
        (b (->stream b))
        )
    ;; len will be min(len(a), len(b)).
    (add-streams-with-carry decimal-idx prec a b)
    ; (cons-stream (+ (stream-car a) (stream-car b)) (stream-cdr b))
    )
  )

(loop-cnt-ref 1000
  (let ((res (stream-+ 1 (stream-/ 1 4938928 10))))
    (lambda (idx) 
      (if (= idx 1)
        (display "."))
      (display (stream-ref res idx)))))
(newline)

;; Emm... expt should calculate from right to left due to multiplication inherent properties.
;; TODO1 So we need to set the ulp.

;; See https://github.com/sci-42ver/csapp3e_COD_and_OSTEP/blob/d270199d8a98201be35f87ba099babfe82d4c478/asm/README.md?plain=1#L4912-L4952
;; the former 2 has no software optimization, the 3rd is about concurrency which is off topic for this QA target.
;; TODO2 The 4th can be done with `add-streams`.

;; TODO3 use fast-expt https://stackoverflow.com/questions/78597962/1-01e-100-1-in-mit-scheme/78626541#comment138620051_78597962

;; TODO '("1" meaning, it's 0.3141592 * 10^1)' should be 1.314...

;; https://stackoverflow.com/a/76920203/21294350
;; > mult( Ratio(a,b), Ratio(c,d)) = Ratio( (a*c), (b*d) )
;; inappropriate here since num is much less than den.
;; `round-prec` just uses large integer for fraction.
;; > sum( Ratio(a,b), Ratio(c,d)) = Ratio( (a*d + c*b), (b*d) )
;; appropriate for 1+1/n but maybe overkill.

;; modified based on https://stackoverflow.com/a/30561923/21294350. Also see related https://stackoverflow.com/questions/59942574/create-an-infinite-stream-from-a-list
;; still return one stream.
(define (append-streams . streams)
  (let* ((valid-streams (remove stream-null? streams))
         (cur-stream (car valid-streams))
         (rest-streams (cdr valid-streams)))
    (if (= 1 (length valid-streams))
      cur-stream
      (cons-stream (stream-car cur-stream)
        ;; notice to use apply.
        (apply append-streams (cons (stream-cdr cur-stream) rest-streams))))))

;; TODO optimization without using one long list.
(define (number-cnt num cnt)
  ;; not optimized
  ; (fold cons-stream the-empty-stream (make-list 0 cnt))
  ;; similar to append-streams
  (define (iter n)
    ;; Emm... not use cnt here otherwise, this is infinite...
    (if (= 0 n)
      the-empty-stream
      (cons-stream num (iter (- n 1)))))
  (iter cnt)
  )
(define (scale-frac-stream stream scalar prefix-zero-cnt suffix-zero-cnt)
  (assert (stream-pair? stream))
  (let ((non-zero-digits (scale-stream stream scalar)))
    ; (bkpt "1" (stream-cdr non-zero-digits))
    (append-streams (number-cnt 0 prefix-zero-cnt) non-zero-digits (number-cnt 0 suffix-zero-cnt)))
  )

;; prec same as the above definition.
(define (prec->mul-ulp prec)
  (- (* 2 prec) 1))
(define (stream-* a b prec)
  (let ((a (->stream a))
        (b (->stream b))
        (digit-cnt-after-decimal-point (- prec 1))
        (ulp (prec->mul-ulp prec))
        )
    (let ((addends 
            (map 
              (lambda (idx) 
                (scale-frac-stream a (stream-ref b idx) idx (- digit-cnt-after-decimal-point idx))
                )
              (iota prec))))
      ; (for-each (lambda (addend) (stream-ref addend 100) (display (stream-head addend 10)) (newline)) addends)
      ; (bkpt "1" a b)
      (apply add-streams-with-carry decimal-idx ulp addends))
    ))
;; http://community.schemewiki.org/?sicp-ex-1.16
(define (iter-fast-expt-stream b n prec) 
  (define (stream-square a)
    (stream-* a a prec))
  (define (iter N B A) 
    (cond ((= 0 N) A) 
          ((even? N) (iter (/ N 2) (stream-square B) A)) 
          (else (iter (- N 1) B (stream-* B A prec))))) 
  (iter n b (cons-stream 1 zeroes)))

(define n 4938928)
(loop-cnt-ref (prec->mul-ulp prec)
  (let ((res (iter-fast-expt-stream (stream-+ 1 (stream-/ 1 n 10)) n prec)))
    (lambda (idx) 
      (if (= idx 1)
        (display "."))
      (display (stream-ref res idx)))))

; (trace add-streams-with-carry)

; (define test-stream-num-1 (stream-/ 1 3 10))
; (stream-ref test-stream-num-1 100)
; test-stream-num-1

; (stream-* (stream-/ 1 3 10) (stream-/ 1 3 10) prec)
