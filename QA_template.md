Recently when I self-learnt MIT 6.5151 course, I first read CS 61AS Unit 0 as the preparation. Then I have read SICP 1 to 2.1 (with related lecture notes) as [ps0][1] requires (also read 2.2.1 as [CS 61A notes][2] requires) and then [Software Design for Flexibility (SDF)][3] Prologue, chapter 1 and partly Appendix on Scheme. I use MIT-Scheme as the course recommends.

Currently I am reading SDF chapter 2 and doing exercise 2.11 (f).
> f. Another big extension is to build make-converter so that it
can derive compound conversions, as required, from previously
registered conversions. This will require *a graph search*.

I want to make `unit-conversion-key-graph` constructed from `unit-conversion-pairs` equal to `(((quote tonne) ((quote kg) (quote g))) ((quote celsius) ((quote kelvin) (quote fahrenheit))))` in the following code.

But using `set-car!` in `fold` will throw errors since `res` may be used like the *state* variable in `fold` (This is similar to `for i in range(10): i=i+1; print(i)` in python but the latter doesn't throw errors and `i=i+1` does nothing at all.). This is one restriction. It will throw error ";The object #!unspecific, passed as the first argument to car, is not the correct type." sometime after `set-car!`.

The following `unit-conversion-list` is to be consistent with [this code block in the code base][4] where each unit pair is paired with some conversion procedure.

```scheme
(define (displayln x)
      (newline)
      (display x))

(define unit-conversion-list '((('celsius . 'kelvin) . 1) (('tonne . 'kg) . 2)
                                (('tonne . 'g) . 3) (('celsius . 'fahrenheit) . 4)))
(define unit-conversion-pairs (map car unit-conversion-list))
(displayln unit-conversion-pairs)
; display:
; (((quote celsius) quote kelvin) ((quote tonne) quote kg) ((quote tonne) quote g) ((quote celsius) quote fahrenheit))

;; https://stackoverflow.com/a/7382392/21294350
(define (list-set! lst k val)
    (if (zero? k)
        (begin
          (displayln "set to")
          (displayln val)
          (set-car! lst val))
        (list-set! (cdr lst) (- k 1) val)))

;; https://cookbook.scheme.org/find-index-of-element-in-list/
(define (list-index fn lst)
  (displayln lst)
  (let iter ((lst lst) (index 0))
    (if (null? lst)
        -1
        (let ((item (car lst)))
          (if (fn item)
              index
              (iter (cdr lst) (+ index 1)))))))

(define (adjacency-pairs-to-adjacency-list adjacency-pairs)
  (fold 
    (lambda (adjacency-pair res) 
      (let* ((from (car adjacency-pair))
            (to (cdr adjacency-pair))
            (from-idx 
              (list-index 
                (lambda (adjacent-list-elem) (equal? from (car adjacent-list-elem))) 
                res)))
        (if (>= from-idx 0)
          (begin 
            (displayln from-idx) 
            (list-set! res from-idx (list from (list (cadr (list-ref res from-idx)) to)))
            (displayln res)
            (displayln "ending"))
          (cons (list from to) res))))
    '()
    adjacency-pairs))

(define unit-conversion-key-graph (adjacency-pairs-to-adjacency-list unit-conversion-pairs))
(displayln unit-conversion-key-graph)
```

---

We can define one iterative function to *solve with the above problem* with the same underlying basic ideas:
```scheme
(define (adjacency-pairs-to-adjacency-list adjacency-pairs)
  (let iter ((rest-adjacency-pairs adjacency-pairs)
              (res '()))
    (if (null? rest-adjacency-pairs)
      res
      (let* ((adjacency-pair (car rest-adjacency-pairs)))
        (let* ((from (car adjacency-pair))
              (to (cdr adjacency-pair))
              (from-idx 
                (list-index 
                  (lambda (adjacent-list-elem) (equal? from (car adjacent-list-elem))) 
                  res)))
          (let ((rest-adjacency-pairs (cdr rest-adjacency-pairs)))
            (if (>= from-idx 0)
              (begin 
                (displayln from-idx) 
                (list-set! res from-idx (list from (list (cadr (list-ref res from-idx)) to)))
                (displayln res)
                (displayln "ending")
                (iter rest-adjacency-pairs res))
              (iter rest-adjacency-pairs (cons (list from to) res))))))))
)
```

Then is there some internal MIT Scheme function similar to the above `fold` (both books recommends functional programming) but without the above restriction to make `unit-conversion-key-graph` right?


  [1]: https://groups.csail.mit.edu/mac/users/gjs/6.945/psets/ps00/dh.pdf
  [2]: https://people.eecs.berkeley.edu/~bh/61a-pages/Volume2/notes.pdf
  [3]: https://mitpress.ublish.com/ebook/software-design-for-flexibility-preview/12618/27
  [4]: https://github.com/sci-42ver/SDF_exercise_solution/blob/1673ef69165bb83232c38f4d9292819949e1ef22/software/sdf/wrappers/units.scm#L77-L83

---

In MIT Scheme, it have one `make-list` defined by SRFI 1 https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/SRFI-1.html#index-make_002dlist-2.

@EricPostpischil Thanks. 1. Could you give one example for "crude routines that attempt to determine whether a number that has been computed with *floating-point rounding* is a result that would have equaled another number if it had been computed with *real-number arithmetic instead*."? 2. I updated my post with one testing file.

@EricPostpischil Thanks for your detailed description. I have read your answer link and understood the reasons behind. Numerical analysis is beyond what the book I am reading intends to teach, so I won't dig into it.