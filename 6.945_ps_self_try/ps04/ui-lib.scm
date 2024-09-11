(define max-health 3) ; same as the original

;; > Eating food may increase one’s health ... This can decrease mortality due to troll bites
(define (eat! person food-name)
  ;; See move-internal!
  (let* ((food (find-thing food-name person))
         (bag (get-bag person))
         (food-health-addition-value (get-health-addition-value food)))
    (if food
      (begin
        (remove-thing! bag food)
        (increment-health person food-health-addition-value max-health)
        (tell! (list "You have eaten" food) person)
        (tell-health person))
      (tell! (list (string-append "You don't have such a food naming " food-name)) person))))