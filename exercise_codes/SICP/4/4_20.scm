;;; let
(let
  ((fact (lambda (n)
           (if (= n 1) 1 (* n (fact (- n 1)))))))
  (fact 10))
;; i.e. 
((lambda (fact) (fact 10)) 
 ;; this can't access the above fact arg.
 (lambda (n)
   (if (= n 1) 1 (* n (fact (- n 1))))))

;;; letrec
;; but this can
((lambda (fact) 
   (set! fact
     (lambda (n)
       (if (= n 1) 1 (* n (fact (- n 1)))))
     )
   (fact 10)) 
 '*unassigned*)
