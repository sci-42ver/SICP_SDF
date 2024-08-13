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

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))
(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))