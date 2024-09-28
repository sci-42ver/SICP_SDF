(define (ripple-carry-adder Ak-lst Bk-lst Sk-lst C)
  (let ((Ak-lst-len (length Ak-lst))
        (Bk-lst-len (length Bk-lst))
        (Sk-lst-len (length Sk-lst))
        ; (Ck-lst (make-list Ak-lst-len 0))
        (Ck-lst (map (lambda (x) (make-wire)) Ak-lst))
        )
    (assert (= Ak-lst-len Bk-lst-len Sk-lst-len))
    ;; IGNORE: not use map to ensure ordering.
    ;; This is unnecessary. See LisScheSic's 1st comment in wiki.
    (for-each 
      (lambda (Ak Bk Sk C-in-idx)
        (full-adder Ak Bk 
          (list-ref Ck-lst C-in-idx)
          Sk 
          (if (= C-in-idx 0)
            (list-ref Ck-lst (- C-in-idx 1))
            C)
          )
        )
      ;; See http://community.schemewiki.org/?sicp-ex-2.18
      ;; https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Miscellaneous-List-Operations.html#index-reverse
      ;; although "newly allocated", each element is just the copy of the related lst.
      (reverse Ak-lst)
      (reverse Bk-lst)
      (reverse Sk-lst)
      (reverse (iota Ak-lst-len))
      )
    'ok)
  )