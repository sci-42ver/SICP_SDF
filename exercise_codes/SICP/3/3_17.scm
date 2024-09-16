(define (count-pairs x)
  (define (make-visited-cnt-pair visited cnt)
    (cons visited cnt))
  (define (get-visited pair)
    (car pair))
  (define (get-cnt pair)
    (cdr pair))
  (define (iter visited lst)
    (let ((next-visited (cons lst visited)))
      (if (or (not (pair? lst)) (memq lst visited))
        (make-visited-cnt-pair next-visited 0) 
        (let* ((left-iter (iter next-visited (get-visited lst)))
               (right-iter (iter (get-visited left-iter) (get-cnt lst))))
          (make-visited-cnt-pair 
            (append (get-visited right-iter) (get-visited left-iter))
            (+ (get-cnt left-iter)
               (get-cnt right-iter)
               1)))
        )))
  (get-cnt (iter '() x))
  ) 

(define str1 '(foo bar baz)) 


(define x '(foo)) 
(define y (cons x x)) 
(define str2 (list y)) 

(define x '(foo)) 
(define y (cons x x)) 
(define str3 (cons y y)) 

(define str4 '(foo bar baz)) 
(set-cdr! (cddr str4) str4) 

(define (test)
  (assert (= 3 (count-pairs str1))) ; 3 
  (assert (= 3 (count-pairs str2))) ; 4 
  (assert (= 3 (count-pairs str3))) ; 7 
  (assert (= 3 (count-pairs str4))) ; maximum recursion depth exceeded
  )
(test)

;; wiki: More elegant since "encountered" is passed between `helper` implicitly.
(define (count-pairs x) 
  (let ((encountered '())) 
    (define (helper x) 
      (if (or (not (pair? x)) (memq x encountered)) 
        0 
        (begin 
          (set! encountered (cons x encountered)) 
          (+ (helper (car x)) 
             (helper (cdr x)) 
             1)))) 
    (helper x))) 

(test)
