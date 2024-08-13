(load "Huffman-lib.scm")
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

;; Here I mimic sample-tree and Initial leaves ... .
;; Assume pair-lst is increasing.
;; See "The idea is to arrange ..." for how to write this part
(define (successive-merge leaf-lst)
  ;; Add "((null? leaf-set) nil)" to be more general (see wiki jirf's.)
  (if (= 1 (length leaf-lst))
    (car leaf-lst)
    (let ((min-leaf (car leaf-lst))
          (second-min-leaf (cadr leaf-lst)))
      (successive-merge (adjoin-set (make-code-tree min-leaf second-min-leaf) (cddr leaf-lst))))))

(generate-huffman-tree '((A 4) (B 2) (C 1) (D 1)))