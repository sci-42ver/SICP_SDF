(define FOOD-PRICE-ALIST
  (list
    (list 'orange-juice 2 3)
    (list 'honey-bread 3 5)
    (list 'pork-steak 4 10)
    (list 'beef-steak 6 15)
    (list '10-biscuits 4 8)
    ))
(define (get-food-price food-name)
  (let ((entry (assoc food-name FOOD-PRICE-ALIST)))
    (if entry
      (food-price entry)
      (displayln (list food-name "unavailable")))))
(define (food-price entry)
  (caddr entry))
(define (food-health-addition-value entry)
  (cadr entry))
;; similar to make-metadata-association.
;; assoc as both get and has?
;; put! can be done by cons to add and assoc to replace.
(define (create-food name place)
  (let ((entry (assoc name FOOD-PRICE-ALIST)))
    (if entry
      (make-food 
        'name name
        'health-addition-value (food-health-addition-value entry)
        'price (food-price entry)
        'location place
        )
      (displayln (list name "unavailable")))))
(define (food-1 place)
  (create-food 'orange-juice place))
(define (food-2 place)
  (create-food 'honey-bread place))
(define (food-3 place)
  (create-food 'pork-steak place))
(define (food-4 place)
  (create-food 'beef-steak place))
(define (food-5 place)
  (create-food '10-biscuits place))
(define foods-factory-list
  (list food-1 food-2 food-3 food-4 food-5))

(define vending-machine-foods-table 
  (list
    (list 
      1
      2
      3
      )
    (list 
      4
      2
      3
      )
    (list 
      4
      0
      3
      )))
(define (create-vending-machine name place)
  (make-vending-machine
    'name ; not omit it.
    name
    'location
    place))

;; > a few vending machines on the campus that have “food”
(define (add-vending-machines all-places . place-names)
  (for-each
    (lambda (place-name idx)
      (assert (find-place-name place-name all-places))
      (let* ((vending-machine-idx (remainder idx (length vending-machine-foods-table)))
             (foods-indices-list (list-ref vending-machine-foods-table vending-machine-idx))
             (cur-vending-machine 
               (create-vending-machine
                 (symbol 'vending-machine- vending-machine-idx)
                 (find-place-name place-name all-places))))
        (for-each
          (lambda (food-idx) ((list-ref foods-factory-list food-idx) cur-vending-machine))
          foods-indices-list)))
    place-names
    (iota (length place-names))))
