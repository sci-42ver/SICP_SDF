;; from https://stackoverflow.com/a/79061354/21294350 and same as 3_58.scm by deleting unrelated things.
;;; book-stream-lib.scm

;; modified based on 
(define (add-streams . addends)
  (apply stream-map + addends))

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

;;; ../lib.scm
(define (displayln x)
  (newline)
  (display x))

;;; main.scm
(define decimal-idx 10)
;; up to prec-1 after the decimal point
(define prec 100)

(define (exact-quotient a b)
  (inexact->exact (quotient a b)))
(define (exact-remainder a b)
  (inexact->exact (remainder a b)))

(define (expand num den radix)
  (cons-stream
    (exact-quotient (* num radix) den)
    (expand (exact-remainder (* num radix) den) den radix)))

(define (stream-/ num den radix)
  (cons-stream
    (exact-quotient num den)
    (expand (exact-remainder num den) den radix)))

;; 1. For simplicity, here very large number will not be considered since we only want to calculate 1+1/n, n->\infty.
;; 2. As one demo, here we won't implement Fast Carry using Propagator.
(define zeroes (cons-stream 0 zeroes))
;; 1. based on carry save https://en.wikipedia.org/wiki/Carry-save_adder#Technical_details (see point 3)
;; similar to the propagate between 2 "carry save adders" https://electronics.stackexchange.com/q/727175/341985.
;; 2. stream-head is fine since we are using "every" which must check all elements.
(define (carry-propagate mixed-fraction prec idx)
  (let ((integer-sum (cons-stream (stream-car mixed-fraction) zeroes))
        (decimal-fractions (stream-cdr mixed-fraction)))
    (let ((carry (stream-map (lambda (val) (exact-quotient val idx)) decimal-fractions))
          (sum (cons-stream 0 (stream-map (lambda (val) (exact-remainder val idx)) decimal-fractions)))
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
  (let ((a (->stream a))
        (b (->stream b))
        )
    (add-streams-with-carry decimal-idx prec a b)
    )
  )

;; modified based on https://stackoverflow.com/a/30561923/21294350. Also see related https://stackoverflow.com/questions/59942574/create-an-infinite-stream-from-a-list
;; still return one stream.
(define (append-streams . streams)
  (let* ((valid-streams (remove stream-null? streams))
         (cur-stream (car valid-streams))
         (rest-streams (cdr valid-streams)))
    (if (= 1 (length valid-streams))
      cur-stream
      (cons-stream (stream-car cur-stream)
        (apply append-streams (cons (stream-cdr cur-stream) rest-streams))))))

(define (number-cnt num cnt)
  ;; similar to append-streams
  (define (iter n)
    (if (= 0 n)
      the-empty-stream
      (cons-stream num (iter (- n 1)))))
  (iter cnt)
  )

(define (scale-frac-stream stream scalar prefix-zero-cnt suffix-zero-cnt)
  (assert (stream-pair? stream))
  (let ((non-zero-digits (scale-stream stream scalar)))
    (append-streams (number-cnt 0 prefix-zero-cnt) non-zero-digits (number-cnt 0 suffix-zero-cnt)))
  )

;; prec same as the above definition.
(define (prec->mul-ulp prec)
  (- (* 2 prec) 1))
;; For `(stream-* A B prec)`:
;; A and B may have very large ulp-digit-pos.
;; Then due to `(stream-ref b idx)`, we may have the drop like 1.00...01->1 which actually drops adding A*.00...01.
;; This can have big effects after many exp operations.
;; Actually to have no loss, (prec->mul-ulp prec)>=1+ulp-digit-pos-A+ulp-digit-pos-B where ulp-digit-pos-B contributes prefix zeroes of x * A where x is the rightmost digit of B.
;; So 
;; 1. use one very large prec compared with the possible ulp-digit-pos of A,B during the exp process.
;; 2. Make A,B have no 0 digits always.
;; point 2 is reasonable.
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; test
;; see comment of stream-* for why to use random here. But actually not big difference for whether random maybe due to A,B ulp will be smaller much quickly...
(define range 1e50)
(define (test-n n)
  (define res (iter-fast-expt-stream (stream-+ 1 (stream-/ 1 n 10)) n prec))
  ;; first transform to str since that has no precision restriction.
  (let ((res-str
          (fold-right 
            (lambda (idx fold-res) 
              (let ((num-str (number->string (stream-ref res idx))))
                (string-append
                  (if (= idx 0)
                    (string-append num-str ".")
                    num-str)
                  fold-res
                  )))
            ""
            (iota (prec->mul-ulp prec)))))
    (displayln res-str)
    (string->number res-str)))

(define exact-30-digit-e 2.718281828459045235360287471352)

(define n (round (random range)))
(define res1 (test-n n))
; 2.718281828459045442758934615002006527126240527982458701098393907032273107905652826337000531516697130792087466273220790017741994288184439199673939792332212143904701689873406611016744157146734142700200
;; correct up to 2.718281828459045.
(define n range)
(define res2 (test-n n))
; 2.718281828459045442758934615002006527126240527982478429890253640900175140704741819620318549177823255409548230084118712275829443036711865187384775705871084526522810837887447798081277039531818193655490
(abs (- res1 exact-30-digit-e))
; 4.440892098500626e-16
(abs (- res2 exact-30-digit-e))
; 4.440892098500626e-16
(< (abs (- res1 exact-30-digit-e)) (abs (- res2 exact-30-digit-e)))
; #f