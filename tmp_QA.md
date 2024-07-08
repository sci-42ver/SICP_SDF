[One straightforward implementation][1] is
```scheme
(define (logb b n)
  (/ (log n) (log b)))
```

But this is not exact as [schemewiki][2] says:
> (cdr (cons 11 17) will get 16 as output
```
(logb 3 (expt 3 17))
;Value: 16.999999999999996
```

It is not straightforward whether we need to do `ceiling` or `floor`.

---

I am learning SICP. Is there one elegant way to implement the exact logarithm? 

Any complex implementation is welcome but I may not dig into it now if it is beyond what SICP desires to teach too much. Please show some references to help understand that  complex implementation. I will read it in the future.

  [1]: https://stackoverflow.com/a/47879957/21294350
  [2]: http://community.schemewiki.org/?sicp-ex-2.5