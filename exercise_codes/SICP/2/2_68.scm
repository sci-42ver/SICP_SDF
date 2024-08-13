(load "Huffman-lib.scm")
(load "2_67.scm")

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

;; almost same as x3v's.
(define (encode-symbol symbol tree)
  (if (leaf? tree)
    '() ; must be the correct leaf by memq.
    (if (memq symbol (symbols tree))
      (if (memq symbol (symbols (left-branch tree)))
        (cons 0 (encode-symbol symbol (left-branch tree)))
        (cons 1 (encode-symbol symbol (right-branch tree))))
      (error "no such a symbol"))))

(assert (equal? sample-message (encode '(a d a b b c a) sample-tree)))