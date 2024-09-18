;; book
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

;; modified based on the book
(define (adjoin-set x set entry-keys<* entry-keys=* entry-vals=* leaf-branch null?*)
  (cond ((null?* set) (make-tree x leaf-branch leaf-branch))
        ((entry-keys=* x (entry set)) 
          (if (entry-vals=* x (entry set))
            set
            (set! set x)))
        ((entry-keys<* x (entry set))
         (make-tree (entry set) 
                    (adjoin-set x (left-branch set) entry-keys<* entry-keys=* entry-vals=* leaf-branch null?*)
                    (right-branch set)))
        ((entry-keys<* (entry set) x)
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set) entry-keys<* entry-keys=* entry-vals=* leaf-branch null?*)))))

;; http://community.schemewiki.org/?sicp-ex-2.66
(define (lookup-bst given-key set-of-records empty-entry get-key <* =* null?*)  
  (if (null?* set-of-records) #f ; reach the branch of leaf.
      (let ((parent (entry set-of-records))) 
        (cond ((eq? parent empty-entry) #f) 
              ((=* given-key (get-key parent)) parent) 
              (else 
              (lookup-bst given-key 
                      (if (<* given-key (get-key parent)) 
                          (left-branch set-of-records) 
                          (right-branch set-of-records))
                      empty-entry get-key <* =* null?*)))))) 