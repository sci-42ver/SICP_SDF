Recently when I self-learnt MIT 6.5151 course, I first read CS 61AS Unit 0 as the preparation. Then I have read SICP 1 to 2.1 (with related lecture notes) as [ps0][1] requires (also read 2.2.1 as [CS 61A notes][2] requires) and then [Software Design for Flexibility (SDF)][3] Prologue, chapter 1 and partly Appendix on Scheme.

Currently I am reading SDF chapter 2 and doing exercise 2.5 (b).

The following code has weird results throwing error ";The object square is not applicable." and ";The object (lambda (x) (square x)) is not applicable.":
```scheme
(define (compose f g)
  (define (the-composition . args)
    (call-with-values (lambda () (apply g args))
      f))
  the-composition)

(define (iterate n)
  (define (the-iterator f)
    (if (= n 0)
        identity
        (compose f ((iterate (- n 1)) f))))
  the-iterator)

(define (identity x) x)

(define (func_polynomial_minimal_unit . func_pow_pair_lst)
  (if (null? (car func_pow_pair_lst)) ; contain one null pair
    identity
    (let ((cur_func_pow (caar func_pow_pair_lst)))
      (newline)
      (display cur_func_pow)
      (compose 
        ((iterate (cdr cur_func_pow)) (car cur_func_pow)) 
        (func_polynomial_minimal_unit (cdr func_pow_pair_lst))))))

;; equivalent lambda for the following `func_polynomial_minimal_unit`.
((lambda (x) (expt (* x 9) (expt 2 3))) 3)
;; these works
((compose ((iterate 3) (lambda (x) (square x))) (lambda (x) (* 3 x))) 3)
((compose ((iterate 3) square) (lambda (x) (* 3 x))) 3)

;; these doesn't work
((func_polynomial_minimal_unit '((square . 3) ((lambda (x) (* 3 x)) . 2))) 3)
((func_polynomial_minimal_unit '(((lambda (x) (square x)) . 3) ((lambda (x) (* 3 x)) . 2))) 3)
```

But as the above code shows, these procedures can be applicable. So why are these errors thrown?

  [1]: https://groups.csail.mit.edu/mac/users/gjs/6.945/psets/ps00/dh.pdf
  [2]: https://people.eecs.berkeley.edu/~bh/61a-pages/Volume2/notes.pdf
  [3]: https://mitpress.ublish.com/ebook/software-design-for-flexibility-preview/12618/27

---

1. The 2nd link is not archived by wayback machine. 2. Do your NOTE mean something like [`s/([0-9])[ ]([0-9])/\1,\2/g`](https://stackoverflow.com/a/66882016/21294350) for "sub-patterns in substitution text" although sed also supports something same as "back-references in REs" like [`/^(.)o\1$/p`](https://www.gnu.org/software/sed/manual/html_node/Back_002dreferences-and-Subexpressions.html)? ([some `sed` implementation doesn't support](https://stackoverflow.com/a/70838821/21294350) back-reference)

Both sed and RE have the back-reference number limit https://stackoverflow.com/a/4318157/21294350.