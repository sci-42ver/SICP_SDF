I have read some SO posts about "Error: Unbound variable". 
1. https://stackoverflow.com/q/42458019/21294350  This is about `define`.
2. https://stackoverflow.com/q/26319422/21294350 about `set!`.
3. https://stackoverflow.com/q/37240707/21294350 about wrong usage of `define`.

But this error seems to be very general and they are not same as the context here using `lambda`.

I am reading SICP and read [this recitation][1]. I am stuck at 


  [1]: https://people.csail.mit.edu/jastr/6001/fall07/rec2.pdf

---

<!-- This is solved by self. -->
```scheme
(define (order-cost order)
  (let ((digit 1)
      (size (order-size order))
      (cost 0)))
  ; (= digit 1)
  ; (= size (order-size order))
  ; (= cost 0)
  (define (digit_combo order digit)
    (quotient (remainder order (expt 10 digit)) (expt 10 (- digit 1))))
  (if (> digit size)
    ((= cost (+ cost (combo-price (digit_combo order digit))))(= digit (+ digit 1))) ; O(1) space since no call to self, i.e. no stack accumulation.
    cost))
```
The above will cause error ";Unbound variable: order-cost".
It should be to correctly use `let` with local variables although the logic is wrong.
```scheme
(define (order-cost order)
  (let ((digit 1)
      (size (order-size order))
      (cost 0))
  ; (= digit 1)
  ; (= size (order-size order))
  ; (= cost 0)
  (define (digit_combo order digit)
    (quotient (remainder order (expt 10 digit)) (expt 10 (- digit 1))))
  (if (> digit size)
    ((= cost (+ cost (combo-price (digit_combo order digit))))(= digit (+ digit 1))) ; O(1) space since no call to self, i.e. no stack accumulation.
    cost)))
```