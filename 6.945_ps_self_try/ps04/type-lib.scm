;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; vending-machine
; (define vending-machine:things
;   (make-property 'things
;                  'predicate (is-list-of thing?)
;                  'default-value '()))

(define vending-machine?
  (make-type 'vending-machine (list)))

;; put before type-instantiator to ensure properties are inherited.
(set-predicate<=! vending-machine? container?)
(set-predicate<=! vending-machine? thing?)

(define make-vending-machine
  (type-instantiator vending-machine?))

; (define get-things
;   (property-getter vending-machine:things vending-machine?))

; (define add-thing!
;   (property-adder vending-machine:things vending-machine? thing?))

; (define remove-thing!
;   (property-remover vending-machine:things vending-machine? thing?))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; food
(define food:health-addition-value
  (make-property 'health-addition-value
                 'predicate number?
                 'default-value 1))

(define food:price
  (make-property 'price
                 'predicate number?
                 'default-value 2))

(define food?
  (make-type 'food (list food:health-addition-value food:price)))
(set-predicate<=! food? mobile-thing?)
(define make-food
  (type-instantiator food?))

(define get-health-addition-value
  (property-getter food:health-addition-value food?))
(define set-health-addition-value!
  (property-setter food:health-addition-value food? number?))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; money
(define money:denomination
  (make-property 'denomination
                 'predicate number?
                 'default-value 1))

(define money?
  (make-type 'money (list money:denomination)))
(set-predicate<=! money? mobile-thing?)
(define make-money
  (type-instantiator money?))
(define (create-money denomination place)
  (make-money
    'name (symbol 'money- denomination)
    'denomination denomination
    'location place))

(define get-denomination
  (property-getter money:denomination money?))

(define set-denomination!
  (property-setter money:denomination money? number?))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; person
(define person:wallet
  (make-property 'wallet
                 'predicate (lambda (x) (bag? x))
                 'default-supplier
                 (lambda () 
                  (let ((bag 
                          (make-bag 
                            'name 'my-wallet)))
                    (create-money 10 bag)
                    bag))))
(define person?
  (make-type 'person (list person:health person:bag person:wallet)))
(set-predicate<=! person? mobile-thing?)

;; the original is still kept for avatar, etc.
(define-generic-procedure-handler set-up! (match-args person?)
  (lambda (super person)
    (super person)
    (tell-money! person #t)
    ;; to make increment-wallet-money! work.
    (register-with-clock! person (get-clock))))
(define-generic-procedure-handler set-up!
  (match-args autonomous-agent?)
  (lambda (super agent)
    (super agent)))

(define get-wallet
  (property-getter person:wallet person?))
(define set-things!
  (property-setter container:things container? (is-list-of thing?)))