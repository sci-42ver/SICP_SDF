;; similar to element-of-set?
(define (lookup x set)
  ;; See wiki, we should use `entry`.
  ;; lacks checking "((eq? parent '()) #f)".
  ; (let ((cur-key (key (car set-of-records))))
  (let ((cur-key (key (entry set-of-records))))
    (cond 
      ((null? set) false)
      ((= x cur-key) (car set-of-records))
      ((< x cur-key)
        (lookup x (left-branch set)))
      ((> x cur-key)
        (lookup x (right-branch set))))))