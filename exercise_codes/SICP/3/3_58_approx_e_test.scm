(cd "~/SICP_SDF/exercise_codes/SICP/3")
(load "3_58.scm")

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