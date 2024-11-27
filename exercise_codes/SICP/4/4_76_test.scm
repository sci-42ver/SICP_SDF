;; IGNORE
(define (independent-conjunct-test ignore-contents ignore-frame-stream)
  ; '((and (job (fect cy d) (computer programmer)) (address (fect cy d) (cambridge (ames street) 3)))
  ;   (and (job (hacker alyssa p) (computer programmer)) (address (hacker alyssa p) (cambridge (mass ave) 78))))
  
  (and (job ?person (computer programmer))
     (address ?person ?where))

  ;; test from poly
  (and (append-to-form (1 2) (3 4) ?x) 
      (append-to-form (1) ?y ?x)))