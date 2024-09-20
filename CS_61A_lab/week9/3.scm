(define list1 (list (list 'a) 'b))
(define list2 (list (list 'x) 'y))
(set-cdr! (car list1) (car list2))
(set-cdr! (car list2) (cdr list1))
list1
list2