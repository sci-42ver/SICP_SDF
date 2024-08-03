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

I haven't learnt data structure. I am learning SICP and SDF as the preparation for CRLS recommended by https://ocw.mit.edu/courses/6-046j-introduction-to-algorithms-sma-5503-fall-2005/pages/syllabus/ (I didn't choose the python related book as https://ocw.mit.edu/courses/6-006-introduction-to-algorithms-fall-2011/pages/syllabus/ requires since many say SICP is better). I have self-learnt discrete mathematics by reading Discrete Mathematics and Its Applications and mcs which covers a bit about tree although not detailed about "weight-balanced tree".

1. Thanks for your implementation of `alistq-update` which "returns a new structure" as "immutable data structures" requires. *Then* `fold` assigns the whole new data to `alist` (So the above problem due to immutablity doesn't exist. These 2 cases are almost same as 2 examples in https://www.cronj.com/blog/immutable-mutable-data-structures-functional-javascript/ "Mutable Data Structure" and "Immutable ..." from https://medium.com/@livajorge7/immutable-data-structure-enhancing-performance-and-data-integrity-97cf07e1cb1). This func combines `list-set!` and `list-index` together.

2. ";;; No idea why these aren't provided by MIT Scheme already" may be due to the doc https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Advanced-Operations-on-Weight_002dBalanced-Trees.html#index-wt_002dtree_002ffold already has this func as one reference.