(cd "~/SICP_SDF/SDF_exercises/chapter_3")
(load "../software/sdf/manager/load.scm")
(manage 'new 'user-defined-types)
(load "section-3-5-lib/adventure-lib.scm")

(cd "~/SICP_SDF/6.945_ps_self_try/ps04")
;; > each character has a “wallet” with an inital amount of money
;; See person:wallet
(load "type-lib.scm")
;; > a mechanism where money in a wallet is incrementally increased with time
;; See increment-wallet-money!
(load "money-misc-lib.scm")
(load "ui-lib.scm")
(load "adventure-init-lib.scm")

;; See SDF_exercises 3_17.scm for why I put this after the above type-lib.scm.
(cd "~/SICP_SDF/SDF_exercises/chapter_3")
(load "section-3-5-lib/person-lib.scm")
(load "section-3-5-lib/troll-bite-lib.scm")

;; See 3_18.scm
(define *max-health* 3)
;; See 3_17.scm
(define (what-to-do-when-troll-bite person)
  (if (n:> (get-health person) 0)
    (begin
      (tell-health person)
      (set! failure-to-survive #f))
    (set! failure-to-survive #t)))
(define (what-to-do person)
  (wait-for-troll-bite 
    person 
    what-to-do-when-troll-bite)
  )

(define failure-to-survive #t)
;; similar to retry-until-survive.
(do ()
  ((not failure-to-survive) 'done)
  (displayln "retry")
  (start-adventure-with-troll-place-and-mine 'anonymous 'little-dome 'little-dome)
  ;; specific to this code
  ;; > a few vending machines on the campus that have “food”
  (add-vending-machines all-places 'little-dome 'lobby-10)
  (let ((troll (find-object-by-name 'registrar all-people)) ; see start-adventure-with-troll-place-and-mine
        (troll-food-name 'pork-steak)
        (vending-machine-0 (find-thing 'vending-machine-0 (here))))
    (buy! troll vending-machine-0 troll-food-name)

    ;; > Perhaps money can be exchanged among characters?
    ;; cases:
    ;; price -> 20, then "insufficient"
    ;; reply c
    ;; nested reply n and then y.

    ;; Here we need to set price < 5 to make the following codes work.
    (negotiate-price (find-thing troll-food-name troll) troll my-avatar (n:+ 1 (get-food-price troll-food-name)))
    ; I want to sell pork-steak with price 11. Do you want it (y/n/c) (If not, please reply with your expected price like 'n-5'), anonymous ?n-4

    ; Do you accept the purchaser recommendation price 4, registrar ?y

    ; Deal!
    ; anonymous bought honey-bread and his bag has (#[food #[instance-data #[compound-procedure 16]] honey-bread] #[food #[instance-data #[compound-procedure 15]] pork-steak])
    
    ;; > can be purchased with “money”
    (buy! my-avatar vending-machine-0 'honey-bread)
    (what-to-do my-avatar)
    ;; > Eating food may increase one’s health
    (eat! my-avatar 'honey-bread)))