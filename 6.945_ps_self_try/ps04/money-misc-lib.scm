;; increment amount per one denomination
(define interest 0.1)
(define (get-money moneys)
  (fold + 0 (map get-denomination moneys)))
(define (get-person-money person)
  (get-money (get-things (get-wallet person))))
(define (set-wallet-money wallet money-num)
  (set-things! wallet (list))
  (create-money money-num wallet))
(define (set-person-money person money-num)
  (set-wallet-money (get-wallet person) money-num))

(define (not-have-enough-money person price)
  (n:< (get-person-money person) price))
(define (tell-money-insufficient! person)
  (tell! (list "Your money is insufficient.") person))
;; > a mechanism where money in a wallet is incrementally increased with time
;; For simplicity, here we think of money as digital money, so it can have any positive denomination
(define (increment-wallet-money! person)
  (let* ((wallet (get-wallet person))
         (moneys (get-things wallet))
         (money-held (get-money moneys)))
    (set-wallet-money wallet (* money-held (+ 1 interest)))
    (tell! (list "Your money is increased with time") person)
    (tell-money! person #f)))
(define-clock-handler person? increment-wallet-money!)

;; > Perhaps money can be exchanged among characters
;; Here I assume exchange other things like food for money.
;; Here I assume seller is avatar then we can view the process.
(define (reply-yes? reply)
  (equal? reply "y"))
(define (reply-cancel? reply)
  (equal? reply "c"))
(define (reply-no? reply)
  (let ((loc (string-search-forward "n-" reply)))
    (and
      loc
      (n:= 0 loc))))

(define (tell-money! person whether-init)
  (tell! (list "Your money now is" (get-person-money person) (if whether-init "initially" "")) person))

(define deal!
  (most-specific-generic-procedure 'deal! 1
                                   (constant-generic-procedure-handler #f)))
(define-generic-procedure-handler deal!
                                  (match-args person? thing? person? number?)
                                  (lambda (seller to-sell-thing purchaser price)
                                    (tell! (list "Deal!") seller)
                                    (let ((seller-bag (get-bag seller))
                                          (purchaser-bag (get-bag purchaser)))
                                      (remove-thing! seller-bag to-sell-thing)
                                      (set-person-money seller (+ (get-person-money seller) price))
                                      (add-thing! purchaser-bag to-sell-thing)
                                      (set-person-money purchaser (- (get-person-money purchaser) price))
                                      )
                                    ))
(define-generic-procedure-handler deal!
                                  (match-args vending-machine? thing? person? number?)
                                  (lambda (vending-machine-seller to-sell-thing purchaser price)
                                    (tell! (list "Deal!") purchaser)
                                    (let ((vending-machine-seller-things (get-things vending-machine-seller))
                                          (purchaser-bag (get-bag purchaser)))
                                      (remove-thing! vending-machine-seller to-sell-thing)
                                      (create-money price vending-machine-seller)
                                      (add-thing! purchaser-bag to-sell-thing)
                                      (narrate! (list purchaser "bought" to-sell-thing "and his bag has" (get-things purchaser-bag)) purchaser)
                                      (set-person-money purchaser (- (get-person-money purchaser) price))
                                      (tell-money! purchaser #f)
                                      )
                                    ))

(define (read-string)
  (symbol->string (read)))

(define (negotiate-price to-sell-thing seller purchaser price)
  (define (error-msg)
    (displayln "please say (y/n target-price)")
    ;; TODO add one goto like C to go to the appropriate restart location.
    )
  (define (target-price-from-reply reply)
    (substring reply 2))
  (guarantee thing? to-sell-thing)
  (guarantee number? price)
  (narrate! 
    (list 
      "I want to sell" to-sell-thing "with price" (string-append (number->string price) ".")
      ;; ref-1: https://stackoverflow.com/a/22998125/21294350
      ;; > But if the user types two names, like 'Ron Paul', as first + last, then you'll get an unexpected result.
      "Do you want it (y/n/c) (If not, please reply with your expected price like 'n-5')," purchaser "?") 
    seller)
  ;; ref-1
  ;; > will return a symbol?
  (let ((reply (read-string)))
    (cond 
      ((reply-yes? reply)
       (if (not-have-enough-money purchaser price)
         (tell-money-insufficient! purchaser)
         (deal! seller to-sell-thing purchaser price)))
      ;; For simplicity, here I assume we read "n target-price" as expected although we can use regex to ensure that.
      ((reply-no? reply)
       (let* ((target-price-str (target-price-from-reply reply))
              (target-price (string->number target-price-str)))
         (narrate! (list (string-append "Do you accept the purchaser recommendation price " target-price-str ",") seller "?") seller)
         (let ((seller-reply (read-string)))
           (cond 
             ((reply-yes? seller-reply)
              (if (not-have-enough-money purchaser target-price)
                (tell-money-insufficient! purchaser)
                (deal! seller to-sell-thing purchaser target-price)))
             ((reply-no? seller-reply)
              (negotiate-price to-sell-thing seller purchaser (string->number (target-price-from-reply seller-reply))))
             ((reply-cancel? reply) 'cancelled)
             (else (error-msg))))))
      ((reply-cancel? reply) 'cancelled)
      (else (error-msg)))))

;; other misc
;; > have “food” that can be purchased with “money”
(define (buy! person vending-machine food-name)
  (let ((food-price (get-food-price food-name)))
    (if (not-have-enough-money person food-price)
      (tell-money-insufficient! person)
      (let* ((foods (get-things vending-machine))
             (food (find-object-by-name food-name foods)))
        (if food
          (deal! vending-machine food person food-price)
          (narrate! (list vending-machine (string-apped "doesn't have" food-name)) person))))))
