;; helper
(define (assert-lookup table keys value)
  (if (not (equal? (lookup table keys) value))
    (bkpt "error" (list table keys value))))

(define count 0)
(define (assert-lookup-counting table keys value) 
  (set! count (+ 1 count))
  (if (not (equal? (lookup table keys) value))
    (error "error" (list count table keys value))))

;; 
(define t1 (make-table))  ; EDIT HERE: the constructor
(define t2 (make-table))  ; EDIT HERE: the constructor

; (insert! t1 '() 'special-case)
; ; (displayln (table-contents t1))
; (if (equal? 'special-case (lookup t1 '())) 'match (error "Error: Mismatch special case" (lookup t1 '())))

(insert!  t2  (list  2 'eel 'fox )  'cat )                   ;klist length= 3
(assert-lookup   t2  (list  2 'eel 'fox )  'cat )
(insert!  t2  (list  cdr )  3 )                              ;klist length= 1 
(assert-lookup   t2  (list  cdr )  3 )
(insert!  t2  (list  1.4142 )  'fox )                        ;klist length= 1 
(assert-lookup   t2  (list  1.4142 )  'fox )
(insert!  t1  (list  1.7321 '(1 . 2) 'cat 4 'eel )  car )    ;klist length= 5 
(assert-lookup   t1  (list  1.7321 '(1 . 2) 'cat 4 'eel )  car )
(insert!  t2  (list  car cdr list '(one) 2.2361 )  'cow )    ;klist length= 5 
(assert-lookup   t2  (list  car cdr list '(one) 2.2361 )  'cow )
(insert!  t1  (list  2.2361 'fox 3 'cat )  1.618 )           ;klist length= 4 
(assert-lookup   t1  (list  2.2361 'fox 3 'cat )  1.618 )
(insert!  t2  (list  list 'dog '(romeo juliet) assoc 1.7321 )  6 ) ;klist length= 5 
(assert-lookup   t2  (list  list 'dog '(romeo juliet) assoc 1.7321 )  6 )
(insert!  t1  (list  "yarn" "cord" )  3 )                    ;klist length= 2 
(assert-lookup   t1  (list  "yarn" "cord" )  3 )
(insert!  t1  (list  'dog 'jay cdr 6 )  1.618 )              ;klist length= 4 
(assert-lookup   t1  (list  'dog 'jay cdr 6 )  1.618 )
(insert!  t1  (list  7 1.618 4 2 )  'pig )                   ;klist length= 4 
(assert-lookup   t1  (list  7 1.618 4 2 )  'pig )
(insert!  t1  (list  'fox 1 #t "cord" "rope" )  '(one) )     ;klist length= 5 
(assert-lookup   t1  (list  'fox 1 #t "cord" "rope" )  '(one) )
(insert!  t2  (list  "cord" 6 "rope" )  4 )                  ;klist length= 3 
(assert-lookup   t2  (list  "cord" 6 "rope" )  4 )
(insert!  t1  (list  '(a . b) 'jay cdr '(larry moe curly) )  car ) ;klist length= 4 
(assert-lookup   t1  (list  '(a . b) 'jay cdr '(larry moe curly) )  car )
(insert!  t2  (list  'cow 1.618 '(a . b) )  list )           ;klist length= 3 
(assert-lookup   t2  (list  'cow 1.618 '(a . b) )  list )
(insert!  t2  (list  'cat 3.1416 )  'pig )                   ;klist length= 2 
(assert-lookup   t2  (list  'cat 3.1416 )  'pig )
(insert!  t1  (list  7 3 6 5 )  '(one) )                     ;klist length= 4
; (display-table-contents t1)
(assert-lookup   t1  (list  7 3 6 5 )  '(one) )
(insert!  t1  (list  'dog )  'jay )                          ;klist length= 1 
(assert-lookup   t1  (list  'dog )  'jay )
(insert!  t2  (list  6 '() 'owl )  3 )                       ;klist length= 3 
(assert-lookup   t2  (list  6 '() 'owl )  3 )
(insert!  t1  (list  "twine" 'dog )  "rope" )                ;klist length= 2 
(assert-lookup   t1  (list  "twine" 'dog )  "rope" )
(insert!  t2  (list  'cat 7 2.2361 sin 1.4142 )  'jay )      ;klist length= 5 
(assert-lookup   t2  (list  'cat 7 2.2361 sin 1.4142 )  'jay )
(insert!  t1  (list  'jay )  "rope" )                        ;klist length= 1 
(assert-lookup   t1  (list  'jay )  "rope" )
(insert!  t1  (list  4 )  6 )                                ;klist length= 1 
(assert-lookup   t1  (list  4 )  6 )
(insert!  t1  (list  7 2 3 6 sin )  'jay )                   ;klist length= 5 
(assert-lookup   t1  (list  7 2 3 6 sin )  'jay )
(insert!  t1  (list  1.618 5 list '(romeo juliet) 7 )  4 )   ;klist length= 5 
(assert-lookup   t1  (list  1.618 5 list '(romeo juliet) 7 )  4 )
(insert!  t1  (list  2 5 cdr )  list )                       ;klist length= 3 
(assert-lookup   t1  (list  2 5 cdr )  list )
(insert!  t1  (list  1.7321 car '(1 . 2) )  '(larry moe curly) ) ;klist length= 3 
(assert-lookup   t1  (list  1.7321 car '(1 . 2) )  '(larry moe curly) )
(insert!  t1  (list  '(a . b) )  'jay )                      ;klist length= 1 
(assert-lookup   t1  (list  '(a . b) )  'jay )
(insert!  t1  (list  1 3 #t 1.618 )  1.4142 )                ;klist length= 4 
(assert-lookup   t1  (list  1 3 #t 1.618 )  1.4142 )
(insert!  t1  (list  'fox assoc 1.7321 '(larry moe curly) )  7 ) ;klist length= 4 
(assert-lookup   t1  (list  'fox assoc 1.7321 '(larry moe curly) )  7 )
(insert!  t2  (list  1.4142 7 )  6 )                         ;klist length= 2 
(assert-lookup   t2  (list  1.4142 7 )  6 )
(insert!  t1  (list  '(a . b) )  1 )                         ;klist length= 1 
(assert-lookup   t1  (list  '(a . b) )  1 )
(insert!  t2  (list  '(romeo juliet) 'dog 'owl 2 '(a . b) )  "twine" ) ;klist length= 5 
(assert-lookup   t2  (list  '(romeo juliet) 'dog 'owl 2 '(a . b) )  "twine" )
(insert!  t2  (list  "twine" list )  'jay )                  ;klist length= 2 
(assert-lookup   t2  (list  "twine" list )  'jay )
(insert!  t1  (list  'pig )  car )                           ;klist length= 1 
(assert-lookup   t1  (list  'pig )  car )
(insert!  t2  (list  'fox )  'cow )                          ;klist length= 1 
(assert-lookup   t2  (list  'fox )  'cow )
(insert!  t2  (list  "yarn" 3 1.4142 )  'pig )               ;klist length= 3 
(assert-lookup   t2  (list  "yarn" 3 1.4142 )  'pig )
(insert!  t1  (list  list 'eel 'cow "twine" '(one) )  "yarn" ) ;klist length= 5 
(assert-lookup   t1  (list  list 'eel 'cow "twine" '(one) )  "yarn" )
(insert!  t1  (list  '(1 . 2) 3.1416 )  1.4142 )             ;klist length= 2 
(assert-lookup   t1  (list  '(1 . 2) 3.1416 )  1.4142 )
(insert!  t2  (list  '(larry moe curly) 'cat 2.2361 "yarn" '(a . b) )  '(one) ) ;klist length= 5 
(assert-lookup   t2  (list  '(larry moe curly) 'cat 2.2361 "yarn" '(a . b) )  '(one) )
(insert!  t1  (list  5 )  'cat )                             ;klist length= 1 
(assert-lookup   t1  (list  5 )  'cat )
(insert!  t2  (list  car '(a . b) list 3 )  'jay )           ;klist length= 4 
(assert-lookup   t2  (list  car '(a . b) list 3 )  'jay )
(insert!  t2  (list  'cat '(romeo juliet) )  "yarn" )        ;klist length= 2 
(assert-lookup   t2  (list  'cat '(romeo juliet) )  "yarn" )
(insert!  t1  (list  cdr 1.618 '(larry moe curly) "rope" 5 )  'cat ) ;klist length= 5 
(assert-lookup   t1  (list  cdr 1.618 '(larry moe curly) "rope" 5 )  'cat )
(insert!  t1  (list  car 'fox )  '(1 . 2) )                  ;klist length= 2 
(assert-lookup   t1  (list  car 'fox )  '(1 . 2) )
(insert!  t2  (list  #t )  1.4142 )                          ;klist length= 1 
(assert-lookup   t2  (list  #t )  1.4142 )
(insert!  t2  (list  list 'fox sin )  6 )                    ;klist length= 3 
(assert-lookup   t2  (list  list 'fox sin )  6 )
(insert!  t2  (list  '(1 . 2) 7 3 'owl 'dog )  4 )           ;klist length= 5 
(assert-lookup   t2  (list  '(1 . 2) 7 3 'owl 'dog )  4 )
(insert!  t2  (list  'cow )  #t )                            ;klist length= 1 
(assert-lookup   t2  (list  'cow )  #t )
(insert!  t2  (list  '(larry moe curly) 'pig 'dog 'fox assoc )  'cat ) ;klist length= 5 
(assert-lookup   t2  (list  '(larry moe curly) 'pig 'dog 'fox assoc )  'cat )
(insert!  t1  (list  6 #t '(romeo juliet) )  'eel )          ;klist length= 3 
(assert-lookup   t1  (list  6 #t '(romeo juliet) )  'eel )
(insert!  t2  (list  6 2 1 assoc )  2.2361 )                 ;klist length= 4 
(assert-lookup   t2  (list  6 2 1 assoc )  2.2361 )
(insert!  t1  (list  3 )  "twine" )                          ;klist length= 1 
(assert-lookup   t1  (list  3 )  "twine" )
(insert!  t1  (list  'eel )  "yarn" )                        ;klist length= 1 
(assert-lookup   t1  (list  'eel )  "yarn" )
(insert!  t2  (list  1.7321 '(a . b) 4 '() 1.4142 )  sin )   ;klist length= 5 
(assert-lookup   t2  (list  1.7321 '(a . b) 4 '() 1.4142 )  sin )
(insert!  t2  (list  3 #t 5 '(one) 4 )  'jay )               ;klist length= 5 
(assert-lookup   t2  (list  3 #t 5 '(one) 4 )  'jay )
(insert!  t1  (list  cdr 'fox 'dog '(one) )  list )          ;klist length= 4 
(assert-lookup   t1  (list  cdr 'fox 'dog '(one) )  list )
(insert!  t2  (list  2.2361 3 'jay 1.618 )  'owl )           ;klist length= 4 
(assert-lookup   t2  (list  2.2361 3 'jay 1.618 )  'owl )
(insert!  t1  (list  'jay )  "rope" )                        ;klist length= 1 
(assert-lookup   t1  (list  'jay )  "rope" )
(insert!  t1  (list  1 )  cdr )                              ;klist length= 1 
(assert-lookup   t1  (list  1 )  cdr )
(insert!  t2  (list  'pig #t )  1 )                          ;klist length= 2 
(assert-lookup   t2  (list  'pig #t )  1 )
(insert!  t1  (list  #t list 1.7321 7 'jay )  sin )          ;klist length= 5 
(assert-lookup   t1  (list  #t list 1.7321 7 'jay )  sin )
(insert!  t1  (list  'owl 'cat )  1.7321 )                   ;klist length= 2 
(assert-lookup   t1  (list  'owl 'cat )  1.7321 )
(insert!  t2  (list  1.4142 )  2.2361 )                      ;klist length= 1 
(assert-lookup   t2  (list  1.4142 )  2.2361 )
(insert!  t1  (list  sin "cord" '() )  5 )                   ;klist length= 3 
(assert-lookup   t1  (list  sin "cord" '() )  5 )
(insert!  t2  (list  5 '(a . b) '(romeo juliet) )  assoc )   ;klist length= 3 
(assert-lookup   t2  (list  5 '(a . b) '(romeo juliet) )  assoc )
(insert!  t1  (list  list cdr car 1.4142 sin )  '() )        ;klist length= 5 
(assert-lookup   t1  (list  list cdr car 1.4142 sin )  '() )
(insert!  t2  (list  '(1 . 2) 6 "yarn" list )  'cow )        ;klist length= 4 
(assert-lookup   t2  (list  '(1 . 2) 6 "yarn" list )  'cow )
(insert!  t2  (list  3 7 )  4 )                              ;klist length= 2 
(assert-lookup   t2  (list  3 7 )  4 )
(insert!  t1  (list  '(one) )  'cow )                        ;klist length= 1 
(assert-lookup   t1  (list  '(one) )  'cow )
(insert!  t2  (list  2 "yarn" 6 )  car )                     ;klist length= 3 
(assert-lookup   t2  (list  2 "yarn" 6 )  car )
(insert!  t1  (list  'owl assoc "twine" "rope" )  2.2361 )   ;klist length= 4 
(assert-lookup   t1  (list  'owl assoc "twine" "rope" )  2.2361 )
(insert!  t1  (list  "cord" 2 1.7321 assoc "yarn" )  3 )     ;klist length= 5 
(assert-lookup   t1  (list  "cord" 2 1.7321 assoc "yarn" )  3 )
(insert!  t2  (list  '(larry moe curly) car '(a . b) 'jay )  cdr ) ;klist length= 4 
(assert-lookup   t2  (list  '(larry moe curly) car '(a . b) 'jay )  cdr )
(insert!  t1  (list  'jay list '(a . b) '(larry moe curly) )  2.2361 ) ;klist length= 4 
(assert-lookup   t1  (list  'jay list '(a . b) '(larry moe curly) )  2.2361 )
(insert!  t2  (list  'jay cdr )  '(larry moe curly) )        ;klist length= 2 
(assert-lookup   t2  (list  'jay cdr )  '(larry moe curly) )
(insert!  t1  (list  #t )  '(romeo juliet) )                 ;klist length= 1 
(assert-lookup   t1  (list  #t )  '(romeo juliet) )
(insert!  t2  (list  1.618 )  7 )                            ;klist length= 1 
(assert-lookup   t2  (list  1.618 )  7 )
(insert!  t2  (list  2 '(romeo juliet) #t 1.7321 'cat )  "yarn" ) ;klist length= 5 
(assert-lookup   t2  (list  2 '(romeo juliet) #t 1.7321 'cat )  "yarn" )
(insert!  t2  (list  1 'cat #t 3.1416 '(larry moe curly) )  "cord" ) ;klist length= 5 
(assert-lookup   t2  (list  1 'cat #t 3.1416 '(larry moe curly) )  "cord" )
(insert!  t1  (list  3 '() 3.1416 )  '(larry moe curly) )    ;klist length= 3 
(assert-lookup   t1  (list  3 '() 3.1416 )  '(larry moe curly) )
(insert!  t2  (list  '() 1 2.2361 "yarn" 6 )  'owl )         ;klist length= 5 
(assert-lookup   t2  (list  '() 1 2.2361 "yarn" 6 )  'owl )
(insert!  t2  (list  'fox )  7 )                             ;klist length= 1 
(assert-lookup   t2  (list  'fox )  7 )
(insert!  t1  (list  "yarn" 'cow list )  1.7321 )            ;klist length= 3 
(assert-lookup   t1  (list  "yarn" 'cow list )  1.7321 )
(insert!  t1  (list  'cat 6 assoc "cord" )  "yarn" )         ;klist length= 4 
(assert-lookup   t1  (list  'cat 6 assoc "cord" )  "yarn" )
; (display "working state")
; (display (table-contents t1))
; (newline)

(insert!  t2  (list  'cow "cord" '(1 . 2) )  1.618 )         ;klist length= 3 
(assert-lookup   t2  (list  'cow "cord" '(1 . 2) )  1.618 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  1.7321 "yarn" )  3 )                    ;klist length= 2 
(assert-lookup   t1  (list  1.7321 "yarn" )  3 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  'jay 7 'cat )  3.1416 )                 ;klist length= 3 
(assert-lookup   t2  (list  'jay 7 'cat )  3.1416 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  "twine" cdr )  'owl )                   ;klist length= 2 
(assert-lookup   t1  (list  "twine" cdr )  'owl )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  'jay "cord" )  2 )                      ;klist length= 2 
(assert-lookup   t2  (list  'jay "cord" )  2 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  1.7321 "cord" '(larry moe curly) 3.1416 )  "twine" ) ;klist length= 4 
(assert-lookup   t2  (list  1.7321 "cord" '(larry moe curly) 3.1416 )  "twine" )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  3.1416 #t )  car )                      ;klist length= 2 
(assert-lookup   t1  (list  3.1416 #t )  car )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  cdr )  list )                           ;klist length= 1 
(assert-lookup   t2  (list  cdr )  list )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  list )  #t )                            ;klist length= 1 
(assert-lookup   t2  (list  list )  #t )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  "yarn" 'eel 'jay '(larry moe curly) 'dog )  'pig ) ;klist length= 5 
(assert-lookup   t2  (list  "yarn" 'eel 'jay '(larry moe curly) 'dog )  'pig )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  sin '(larry moe curly) '(one) '(a . b) 'pig )  1.7321 ) ;klist length= 5 
(assert-lookup   t2  (list  sin '(larry moe curly) '(one) '(a . b) 'pig )  1.7321 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  list #t "cord" )  1.4142 )              ;klist length= 3 
(assert-lookup   t2  (list  list #t "cord" )  1.4142 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  'cow 3 3.1416 '(1 . 2) car )  2 )       ;klist length= 5 
(assert-lookup   t2  (list  'cow 3 3.1416 '(1 . 2) car )  2 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  "cord" )  1.618 )                       ;klist length= 1 
(assert-lookup   t2  (list  "cord" )  1.618 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  '(one) 'cow )  'dog )                   ;klist length= 2 
(assert-lookup   t2  (list  '(one) 'cow )  'dog )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  'jay "yarn" '(romeo juliet) 'cow assoc )  6 ) ;klist length= 5 
(assert-lookup   t2  (list  'jay "yarn" '(romeo juliet) 'cow assoc )  6 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  '() )  2 )                              ;klist length= 1 
(assert-lookup   t2  (list  '() )  2 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  2.2361 )  '(larry moe curly) )          ;klist length= 1 
(assert-lookup   t1  (list  2.2361 )  '(larry moe curly) )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  '(a . b) '(1 . 2) 'eel )  'cow )        ;klist length= 3 
(assert-lookup   t2  (list  '(a . b) '(1 . 2) 'eel )  'cow )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  'eel 3 )  1.4142 )                      ;klist length= 2 
(assert-lookup   t1  (list  'eel 3 )  1.4142 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  'pig 'eel 3 1.618 )  list )             ;klist length= 4 
(assert-lookup   t1  (list  'pig 'eel 3 1.618 )  list )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  "rope" '(one) )  'cow )                 ;klist length= 2 
(assert-lookup   t2  (list  "rope" '(one) )  'cow )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  assoc 'pig '(1 . 2) '() 2.2361 )  3 )   ;klist length= 5 
(assert-lookup   t1  (list  assoc 'pig '(1 . 2) '() 2.2361 )  3 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  '(1 . 2) '(romeo juliet) 'dog )  #t )   ;klist length= 3 
(assert-lookup   t1  (list  '(1 . 2) '(romeo juliet) 'dog )  #t )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  5 )  7 )                                ;klist length= 1 
(assert-lookup   t1  (list  5 )  7 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  "cord" 6 '(romeo juliet) 1 4 )  #t )    ;klist length= 5 
(assert-lookup   t1  (list  "cord" 6 '(romeo juliet) 1 4 )  #t )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  '(one) )  1 )                           ;klist length= 1 
(assert-lookup   t1  (list  '(one) )  1 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  cdr 2.2361 2 )  sin )                   ;klist length= 3 
(assert-lookup   t2  (list  cdr 2.2361 2 )  sin )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  3 )  3.1416 )                           ;klist length= 1 
(assert-lookup   t1  (list  3 )  3.1416 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  list )  'pig )                          ;klist length= 1 
(assert-lookup   t1  (list  list )  'pig )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  assoc 1 )  cdr )                        ;klist length= 2 
(assert-lookup   t2  (list  assoc 1 )  cdr )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  6 )  1.7321 )                           ;klist length= 1 
(assert-lookup   t1  (list  6 )  1.7321 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  assoc '(a . b) 2 )  1 )                 ;klist length= 3 
(assert-lookup   t1  (list  assoc '(a . b) 2 )  1 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  'dog assoc 'cat 1.618 '(larry moe curly) )  3 ) ;klist length= 5 
(assert-lookup   t1  (list  'dog assoc 'cat 1.618 '(larry moe curly) )  3 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  assoc 'eel '(one) )  '(larry moe curly) ) ;klist length= 3 
(assert-lookup   t2  (list  assoc 'eel '(one) )  '(larry moe curly) )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  1.618 car 'pig 1.4142 )  '(a . b) )     ;klist length= 4 
(assert-lookup   t2  (list  1.618 car 'pig 1.4142 )  '(a . b) )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  #t 1.4142 '() list '(larry moe curly) )  'owl ) ;klist length= 5 
(assert-lookup   t1  (list  #t 1.4142 '() list '(larry moe curly) )  'owl )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  'jay 'eel cdr '(one) )  5 )             ;klist length= 4 
(assert-lookup   t2  (list  'jay 'eel cdr '(one) )  5 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  3.1416 '() 'pig car 1.7321 )  '(1 . 2) ) ;klist length= 5 
(assert-lookup   t2  (list  3.1416 '() 'pig car 1.7321 )  '(1 . 2) )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  'cat 3 'pig 'owl 4 )  cdr )             ;klist length= 5 
(assert-lookup   t2  (list  'cat 3 'pig 'owl 4 )  cdr )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  6 sin 'fox )  7 )                       ;klist length= 3 
(assert-lookup   t2  (list  6 sin 'fox )  7 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  "rope" 2.2361 'cow #t )  cdr )          ;klist length= 4 
(assert-lookup   t1  (list  "rope" 2.2361 'cow #t )  cdr )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  'eel 4 )  '(one) )                      ;klist length= 2 
(assert-lookup   t2  (list  'eel 4 )  '(one) )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  2.2361 'eel )  #t )                     ;klist length= 2 
(assert-lookup   t1  (list  2.2361 'eel )  #t )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  'cat )  6 )                             ;klist length= 1 
(assert-lookup   t2  (list  'cat )  6 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  1.7321 4 'fox 'cat '(one) )  cdr )      ;klist length= 5 
(assert-lookup   t2  (list  1.7321 4 'fox 'cat '(one) )  cdr )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  1.4142 1.7321 'pig '(one) )  'cat )     ;klist length= 4 
(assert-lookup   t2  (list  1.4142 1.7321 'pig '(one) )  'cat )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  '(a . b) "twine" '(romeo juliet) 1.4142 list )  'eel ) ;klist length= 5 
(assert-lookup   t2  (list  '(a . b) "twine" '(romeo juliet) 1.4142 list )  'eel )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  1.7321 )  #t )                          ;klist length= 1 
(assert-lookup   t1  (list  1.7321 )  #t )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  4 list 'jay cdr "twine" )  assoc )      ;klist length= 5 
(assert-lookup   t1  (list  4 list 'jay cdr "twine" )  assoc )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  "cord" 1.4142 1.7321 )  1.618 )         ;klist length= 3 
(assert-lookup   t1  (list  "cord" 1.4142 1.7321 )  1.618 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  3 'cat 4 )  'dog )                      ;klist length= 3 
(assert-lookup   t1  (list  3 'cat 4 )  'dog )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  1.7321 )  'cow )                        ;klist length= 1 
(assert-lookup   t1  (list  1.7321 )  'cow )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  "twine" 5 )  'cow )                     ;klist length= 2 
(assert-lookup   t1  (list  "twine" 5 )  'cow )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  #t )  3.1416 )                          ;klist length= 1 
(assert-lookup   t1  (list  #t )  3.1416 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  6 'owl cdr "yarn" )  2 )                ;klist length= 4 
(assert-lookup   t1  (list  6 'owl cdr "yarn" )  2 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  1.7321 )  7 )                           ;klist length= 1 
(assert-lookup   t1  (list  1.7321 )  7 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  '(romeo juliet) "rope" )  #t )          ;klist length= 2 
(assert-lookup   t2  (list  '(romeo juliet) "rope" )  #t )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  'cow #t 'cat '(1 . 2) )  1.7321 )       ;klist length= 4 
(assert-lookup   t2  (list  'cow #t 'cat '(1 . 2) )  1.7321 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  '(a . b) list )  car )                  ;klist length= 2 
(assert-lookup   t1  (list  '(a . b) list )  car )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  3.1416 4 )  'pig )                      ;klist length= 2 
(assert-lookup   t1  (list  3.1416 4 )  'pig )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  "cord" )  'owl )                        ;klist length= 1 
(assert-lookup   t2  (list  "cord" )  'owl )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  2.2361 '() 4 sin )  "twine" )           ;klist length= 4 
(assert-lookup   t1  (list  2.2361 '() 4 sin )  "twine" )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  '(1 . 2) )  4 )                         ;klist length= 1 
(assert-lookup   t1  (list  '(1 . 2) )  4 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  car '(romeo juliet) "cord" 1.4142 6 )  3 ) ;klist length= 5 
(assert-lookup   t1  (list  car '(romeo juliet) "cord" 1.4142 6 )  3 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  1.618 1.4142 'cow "yarn" )  assoc )     ;klist length= 4 
(assert-lookup   t2  (list  1.618 1.4142 'cow "yarn" )  assoc )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  4 'dog "rope" )  "yarn" )               ;klist length= 3 
(assert-lookup   t2  (list  4 'dog "rope" )  "yarn" )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  list sin 2.2361 1.618 1.4142 )  1 )     ;klist length= 5 
(assert-lookup   t1  (list  list sin 2.2361 1.618 1.4142 )  1 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  list 7 car 'cow )  2 )                  ;klist length= 4 
(assert-lookup   t1  (list  list 7 car 'cow )  2 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  list '(a . b) )  1 )                    ;klist length= 2 
(assert-lookup   t2  (list  list '(a . b) )  1 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  '(one) '(larry moe curly) )  cdr )      ;klist length= 2 
(assert-lookup   t1  (list  '(one) '(larry moe curly) )  cdr )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  sin )  1.7321 )                         ;klist length= 1 
(assert-lookup   t1  (list  sin )  1.7321 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  assoc 'pig "cord" )  'cat )             ;klist length= 3 
(assert-lookup   t1  (list  assoc 'pig "cord" )  'cat )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  '(romeo juliet) "yarn" )  5 )           ;klist length= 2 
(assert-lookup   t2  (list  '(romeo juliet) "yarn" )  5 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  'jay '(1 . 2) '(romeo juliet) )  car )  ;klist length= 3 
(assert-lookup   t1  (list  'jay '(1 . 2) '(romeo juliet) )  car )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  '(one) '(larry moe curly) 'jay 2 6 )  '(1 . 2) ) ;klist length= 5 
(assert-lookup   t2  (list  '(one) '(larry moe curly) 'jay 2 6 )  '(1 . 2) )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  list 1.7321 "yarn" 'cow )  #t )         ;klist length= 4 
(assert-lookup   t1  (list  list 1.7321 "yarn" 'cow )  #t )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  'owl 'fox )  4 )                        ;klist length= 2 
(assert-lookup   t1  (list  'owl 'fox )  4 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  '(a . b) 1 7 1.4142 )  car )            ;klist length= 4 
(assert-lookup   t2  (list  '(a . b) 1 7 1.4142 )  car )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  'jay 6 )  1.7321 )                      ;klist length= 2 
(assert-lookup   t1  (list  'jay 6 )  1.7321 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  "cord" )  sin )                         ;klist length= 1 
(assert-lookup   t2  (list  "cord" )  sin )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  'jay cdr )  '(one) )                    ;klist length= 2 
(assert-lookup   t2  (list  'jay cdr )  '(one) )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  1.4142 )  'pig )                        ;klist length= 1 
(assert-lookup   t1  (list  1.4142 )  'pig )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  '(romeo juliet) 1.4142 assoc 7 1.618 )  "yarn" ) ;klist length= 5 
(assert-lookup   t1  (list  '(romeo juliet) 1.4142 assoc 7 1.618 )  "yarn" )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  '() )  1.618 )                          ;klist length= 1 
(assert-lookup   t1  (list  '() )  1.618 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  '() "cord" )  'dog )                    ;klist length= 2 
(assert-lookup   t1  (list  '() "cord" )  'dog )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  'jay '() 2 )  7 )                       ;klist length= 3 
(assert-lookup   t2  (list  'jay '() 2 )  7 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  3.1416 '(one) '(larry moe curly) 'eel "rope" )  '(1 . 2) ) ;klist length= 5 
(assert-lookup   t2  (list  3.1416 '(one) '(larry moe curly) 'eel "rope" )  '(1 . 2) )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  'cat )  1.7321 )                        ;klist length= 1 
(assert-lookup   t1  (list  'cat )  1.7321 )
; (displayln (table-contents t1))
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
; error (89 #[compound-procedure 18 dispatch] (cat 6 #[compiled-procedure 17 ("list" #x93) #x1c #xe49a74] "cord") "yarn")
; (displayln (table-contents t1))

(insert!  t2  (list  assoc '(romeo juliet) sin 5 )  2 )      ;klist length= 4 
(assert-lookup   t2  (list  assoc '(romeo juliet) sin 5 )  2 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  1 "twine" 'jay 3 '(1 . 2) )  list )     ;klist length= 5 
(assert-lookup   t1  (list  1 "twine" 'jay 3 '(1 . 2) )  list )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  7 1.7321 list )  '(romeo juliet) )      ;klist length= 3 
(assert-lookup   t2  (list  7 1.7321 list )  '(romeo juliet) )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  '(larry moe curly) )  2 )               ;klist length= 1 
(assert-lookup   t2  (list  '(larry moe curly) )  2 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  'owl "cord" 1.4142 1.618 car )  3 )     ;klist length= 5 
(assert-lookup   t2  (list  'owl "cord" 1.4142 1.618 car )  3 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  2 '(larry moe curly) assoc 6 )  '(romeo juliet) ) ;klist length= 4 
(assert-lookup   t2  (list  2 '(larry moe curly) assoc 6 )  '(romeo juliet) )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  'cow 'dog 1.4142 )  '(1 . 2) )          ;klist length= 3 
(assert-lookup   t1  (list  'cow 'dog 1.4142 )  '(1 . 2) )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  3 )  '() )                              ;klist length= 1 
(assert-lookup   t1  (list  3 )  '() )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  'eel "cord" )  3 )                      ;klist length= 2 
(assert-lookup   t2  (list  'eel "cord" )  3 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  "rope" 'cat )  'jay )                   ;klist length= 2 
(assert-lookup   t1  (list  "rope" 'cat )  'jay )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  '(1 . 2) '(romeo juliet) )  '(a . b) )  ;klist length= 2 
(assert-lookup   t2  (list  '(1 . 2) '(romeo juliet) )  '(a . b) )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  'fox )  'owl )                          ;klist length= 1 
(assert-lookup   t1  (list  'fox )  'owl )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  '(1 . 2) )  'pig )                      ;klist length= 1 
(assert-lookup   t1  (list  '(1 . 2) )  'pig )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  1.618 'cow 6 '(romeo juliet) )  '(a . b) ) ;klist length= 4 
(assert-lookup   t1  (list  1.618 'cow 6 '(romeo juliet) )  '(a . b) )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  6 )  assoc )                            ;klist length= 1 
(assert-lookup   t1  (list  6 )  assoc )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  7 '() )  5 )                            ;klist length= 2 
(assert-lookup   t2  (list  7 '() )  5 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  '() '(romeo juliet) '(a . b) 1.7321 )  #t ) ;klist length= 4 
(assert-lookup   t2  (list  '() '(romeo juliet) '(a . b) 1.7321 )  #t )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  3 1.618 assoc 'eel "cord" )  'dog )     ;klist length= 5 
(assert-lookup   t2  (list  3 1.618 assoc 'eel "cord" )  'dog )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  "yarn" 'fox car )  list )               ;klist length= 3 
(assert-lookup   t2  (list  "yarn" 'fox car )  list )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  "yarn" list 'owl '() 'jay )  '(larry moe curly) ) ;klist length= 5 
(assert-lookup   t2  (list  "yarn" list 'owl '() 'jay )  '(larry moe curly) )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  '(a . b) 'eel 4 )  'cow )               ;klist length= 3 
(assert-lookup   t1  (list  '(a . b) 'eel 4 )  'cow )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  "cord" 4 assoc )  '(larry moe curly) )  ;klist length= 3 
(assert-lookup   t2  (list  "cord" 4 assoc )  '(larry moe curly) )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  1.4142 2.2361 )  3 )                    ;klist length= 2 
(assert-lookup   t1  (list  1.4142 2.2361 )  3 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  '(1 . 2) '(one) 1.618 "rope" 1 )  'fox ) ;klist length= 5 
(assert-lookup   t2  (list  '(1 . 2) '(one) 1.618 "rope" 1 )  'fox )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  'fox '(a . b) assoc #t "yarn" )  'cat ) ;klist length= 5 
(assert-lookup   t2  (list  'fox '(a . b) assoc #t "yarn" )  'cat )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t1  (list  '() 'cow 'pig 1 )  3.1416 )             ;klist length= 4 
(assert-lookup   t1  (list  '() 'cow 'pig 1 )  3.1416 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )
(insert!  t2  (list  'jay 'fox "rope" '() )  3 )             ;klist length= 4
(assert-lookup   t2  (list  'jay 'fox "rope" '() )  3 )
(assert-lookup-counting   t1  (list  'cat 6 assoc "cord" )  "yarn" )

; (display (table-contents t1))
; (newline)
; (display (table-contents t2))
; (newline)

(if (equal? #f (lookup  t1 (list  cdr list 4 ))   ) 'match (error "Error: Mismatch:" 1))
(if (equal? 'jay  (lookup  t2 (list  "twine" list ))   ) 'match (error "Error: Mismatch:" 2))
(if (equal? '(one)  (lookup  t1 (list  7 3 6 5 ))   ) 'match (error "Error: Mismatch:" 3))
(if (equal? "yarn"  (lookup  t1 (list  'cat 6 assoc "cord" ))   ) 'match (error "Error: Mismatch:" 4))
(if (equal? #f (lookup  t1 (list  "yarn" 2.2361 3.1416 1.7321 ))   ) 'match (error "Error: Mismatch:" 5))
(if (equal? #f (lookup  t1 (list  3.1416 ))   ) 'match (error "Error: Mismatch:" 6))
(if (equal? 3  (lookup  t2 (list  6 '() 'owl ))   ) 'match (error "Error: Mismatch:" 7))
(if (equal? 2.2361  (lookup  t2 (list  1.4142 ))   ) 'match (error "Error: Mismatch:" 8))
(if (equal? #f (lookup  t1 (list  '(romeo juliet) 4 '(a . b) ))   ) 'match (error "Error: Mismatch:" 9))
(if (equal? '(a . b)  (lookup  t2 (list  1.618 car 'pig 1.4142 ))   ) 'match (error "Error: Mismatch:" 10))
(if (equal? #f (lookup  t2 (list  3.1416 '(a . b) 'owl ))   ) 'match (error "Error: Mismatch:" 11))
(if (equal? #f (lookup  t2 (list  '(a . b) ))   ) 'match (error "Error: Mismatch:" 12))
(if (equal? #t  (lookup  t2 (list  list ))   ) 'match (error "Error: Mismatch:" 13))
(if (equal? #f (lookup  t1 (list  1.4142 'fox sin car "cord" ))   ) 'match (error "Error: Mismatch:" 14))
(if (equal? 'jay  (lookup  t1 (list  7 2 3 6 sin ))   ) 'match (error "Error: Mismatch:" 15))
(if (equal? 'cat  (lookup  t2 (list  'fox '(a . b) assoc #t "yarn" ))   ) 'match (error "Error: Mismatch:" 16))
(if (equal? #f (lookup  t2 (list  "rope" '(1 . 2) 6 1.7321 ))   ) 'match (error "Error: Mismatch:" 17))
(if (equal? #f (lookup  t2 (list  'dog 3 'eel ))   ) 'match (error "Error: Mismatch:" 18))
(if (equal? 'pig  (lookup  t2 (list  'cat 3.1416 ))   ) 'match (error "Error: Mismatch:" 19))
(if (equal? 1.7321  (lookup  t1 (list  'owl 'cat ))   ) 'match (error "Error: Mismatch:" 20))
(if (equal? "twine"  (lookup  t2 (list  1.7321 "cord" '(larry moe curly) 3.1416 ))   ) 'match (error "Error: Mismatch:" 21))
(if (equal? 2  (lookup  t2 (list  'cow 3 3.1416 '(1 . 2) car ))   ) 'match (error "Error: Mismatch:" 22))
(if (equal? #f (lookup  t2 (list  assoc 2 ))   ) 'match (error "Error: Mismatch:" 23))
(if (equal? 1.7321  (lookup  t1 (list  sin ))   ) 'match (error "Error: Mismatch:" 24))
(if (equal? #f (lookup  t2 (list  'pig "twine" ))   ) 'match (error "Error: Mismatch:" 25))
(if (equal? #f (lookup  t1 (list  list "cord" ))   ) 'match (error "Error: Mismatch:" 26))
(if (equal? #f (lookup  t1 (list  5 car "yarn" assoc '() ))   ) 'match (error "Error: Mismatch:" 27))
(if (equal? #f (lookup  t2 (list  2 3 assoc ))   ) 'match (error "Error: Mismatch:" 28))
(if (equal? 2.2361  (lookup  t2 (list  6 2 1 assoc ))   ) 'match (error "Error: Mismatch:" 29))
(if (equal? #f (lookup  t1 (list  'pig assoc 'fox 1.4142 ))   ) 'match (error "Error: Mismatch:" 30))
(if (equal? 3  (lookup  t2 (list  'jay 'fox "rope" '() ))   ) 'match (error "Error: Mismatch:" 31))
(if (equal? #f (lookup  t1 (list  'eel 1.7321 '(romeo juliet) car 'jay ))   ) 'match (error "Error: Mismatch:" 32))
(if (equal? 'pig  (lookup  t1 (list  '(1 . 2) ))   ) 'match (error "Error: Mismatch:" 33))
(if (equal? 'owl  (lookup  t1 (list  'fox ))   ) 'match (error "Error: Mismatch:" 34))
(if (equal? 1  (lookup  t2 (list  'pig #t ))   ) 'match (error "Error: Mismatch:" 35))
(if (equal? list  (lookup  t1 (list  1 "twine" 'jay 3 '(1 . 2) ))   ) 'match (error "Error: Mismatch:" 36))
(if (equal? #f (lookup  t1 (list  'dog 'jay ))   ) 'match (error "Error: Mismatch:" 37))
(if (equal? 'jay  (lookup  t1 (list  'dog ))   ) 'match (error "Error: Mismatch:" 38))
(if (equal? 3  (lookup  t1 (list  1.7321 "yarn" ))   ) 'match (error "Error: Mismatch:" 39))
(if (equal? 6  (lookup  t2 (list  list 'dog '(romeo juliet) assoc 1.7321 ))   ) 'match (error "Error: Mismatch:" 40))
(if (equal? '(1 . 2)  (lookup  t1 (list  'cow 'dog 1.4142 ))   ) 'match (error "Error: Mismatch:" 41))
(if (equal? #f (lookup  t1 (list  1.4142 7 ))   ) 'match (error "Error: Mismatch:" 42))
(if (equal? #f (lookup  t2 (list  'dog 6 sin ))   ) 'match (error "Error: Mismatch:" 43))
(if (equal? sin  (lookup  t2 (list  "cord" ))   ) 'match (error "Error: Mismatch:" 44))
(if (equal? 'cow  (lookup  t2 (list  '(1 . 2) 6 "yarn" list ))   ) 'match (error "Error: Mismatch:" 45))
(if (equal? 2  (lookup  t2 (list  '(larry moe curly) ))   ) 'match (error "Error: Mismatch:" 46))
(if (equal? #f (lookup  t2 (list  4 ))   ) 'match (error "Error: Mismatch:" 47))
(if (equal? #f (lookup  t1 (list  car cdr 4 'owl 'cow ))   ) 'match (error "Error: Mismatch:" 48))
(if (equal? #f (lookup  t2 (list  "cord" 2.2361 ))   ) 'match (error "Error: Mismatch:" 49))
(if (equal? 1.618  (lookup  t1 (list  '() ))   ) 'match (error "Error: Mismatch:" 50))
(if (equal? 'dog  (lookup  t2 (list  3 1.618 assoc 'eel "cord" ))   ) 'match (error "Error: Mismatch:" 51))
(if (equal? 3  (lookup  t2 (list  'owl "cord" 1.4142 1.618 car ))   ) 'match (error "Error: Mismatch:" 52))
(if (equal? #f (lookup  t2 (list  3 cdr '() "twine" ))   ) 'match (error "Error: Mismatch:" 53))
(if (equal? assoc  (lookup  t2 (list  5 '(a . b) '(romeo juliet) ))   ) 'match (error "Error: Mismatch:" 54))
(if (equal? #f (lookup  t2 (list  assoc 'owl ))   ) 'match (error "Error: Mismatch:" 55))
(if (equal? #f (lookup  t1 (list  "twine" 'dog '() ))   ) 'match (error "Error: Mismatch:" 56))
(if (equal? #f (lookup  t1 (list  'cat 'jay 3 cdr '(one) ))   ) 'match (error "Error: Mismatch:" 57))
(if (equal? #f (lookup  t2 (list  car 2.2361 'owl 'eel 2 ))   ) 'match (error "Error: Mismatch:" 58))
(if (equal? car  (lookup  t1 (list  '(a . b) 'jay cdr '(larry moe curly) ))   ) 'match (error "Error: Mismatch:" 59))
(if (equal? #f (lookup  t1 (list  2.2361 'pig "twine" 'jay '(larry moe curly) ))   ) 'match (error "Error: Mismatch:" 60))
(if (equal? 3  (lookup  t1 (list  "yarn" "cord" ))   ) 'match (error "Error: Mismatch:" 61))
(if (equal? "yarn"  (lookup  t1 (list  list 'eel 'cow "twine" '(one) ))   ) 'match (error "Error: Mismatch:" 62))
(if (equal? #f (lookup  t1 (list  'cat '(one) 1.7321 #t ))   ) 'match (error "Error: Mismatch:" 63))
(if (equal? 2  (lookup  t2 (list  '() ))   ) 'match (error "Error: Mismatch:" 64))
(if (equal? #f (lookup  t2 (list  "cord" #t 'dog 5 ))   ) 'match (error "Error: Mismatch:" 65))
(if (equal? "twine"  (lookup  t1 (list  2.2361 '() 4 sin ))   ) 'match (error "Error: Mismatch:" 66))
(if (equal? #f (lookup  t2 (list  'jay '(1 . 2) 1 'dog 'pig ))   ) 'match (error "Error: Mismatch:" 67))
(if (equal? #f (lookup  t1 (list  "twine" 1 '(1 . 2) 6 1.4142 ))   ) 'match (error "Error: Mismatch:" 68))
(if (equal? list  (lookup  t2 (list  "yarn" 'fox car ))   ) 'match (error "Error: Mismatch:" 69))
(if (equal? #f (lookup  t1 (list  '(1 . 2) '(romeo juliet) ))   ) 'match (error "Error: Mismatch:" 70))
(if (equal? 1  (lookup  t1 (list  '(one) ))   ) 'match (error "Error: Mismatch:" 71))
(if (equal? #f (lookup  t2 (list  'fox '(a . b) list ))   ) 'match (error "Error: Mismatch:" 72))
(if (equal? 3.1416  (lookup  t1 (list  #t ))   ) 'match (error "Error: Mismatch:" 73))
(if (equal? 4  (lookup  t2 (list  '(1 . 2) 7 3 'owl 'dog ))   ) 'match (error "Error: Mismatch:" 74))
(if (equal? 7  (lookup  t2 (list  'jay '() 2 ))   ) 'match (error "Error: Mismatch:" 75))
(if (equal? '(one)  (lookup  t1 (list  'fox 1 #t "cord" "rope" ))   ) 'match (error "Error: Mismatch:" 76))
(if (equal? #f (lookup  t2 (list  'owl '(1 . 2) sin 7 'cat ))   ) 'match (error "Error: Mismatch:" 77))
(if (equal? 'pig  (lookup  t1 (list  3.1416 4 ))   ) 'match (error "Error: Mismatch:" 78))
(if (equal? #f (lookup  t2 (list  'owl ))   ) 'match (error "Error: Mismatch:" 79))
(if (equal? #f (lookup  t1 (list  'fox "twine" ))   ) 'match (error "Error: Mismatch:" 80))
(if (equal? '(one)  (lookup  t2 (list  'eel 4 ))   ) 'match (error "Error: Mismatch:" 81))
(if (equal? 2.2361  (lookup  t1 (list  'owl assoc "twine" "rope" ))   ) 'match (error "Error: Mismatch:" 82))
(if (equal? car  (lookup  t1 (list  'jay '(1 . 2) '(romeo juliet) ))   ) 'match (error "Error: Mismatch:" 83))
(if (equal? 2  (lookup  t1 (list  6 'owl cdr "yarn" ))   ) 'match (error "Error: Mismatch:" 84))
(if (equal? sin  (lookup  t2 (list  "cord" ))   ) 'match (error "Error: Mismatch:" 85))
(if (equal? #f (lookup  t1 (list  #t 2 '(romeo juliet) 7 ))   ) 'match (error "Error: Mismatch:" 86))
(if (equal? '(larry moe curly)  (lookup  t1 (list  1.7321 car '(1 . 2) ))   ) 'match (error "Error: Mismatch:" 87))
(if (equal? #f (lookup  t2 (list  'fox '() 'eel ))   ) 'match (error "Error: Mismatch:" 88))
(if (equal? #t  (lookup  t2 (list  '(romeo juliet) "rope" ))   ) 'match (error "Error: Mismatch:" 89))
(if (equal? #f (lookup  t2 (list  assoc 1.618 "yarn" ))   ) 'match (error "Error: Mismatch:" 90))
(if (equal? #f (lookup  t1 (list  1 '() ))   ) 'match (error "Error: Mismatch:" 91))
(if (equal? #f (lookup  t2 (list  3.1416 'dog assoc ))   ) 'match (error "Error: Mismatch:" 92))
(if (equal? #f (lookup  t1 (list  'cat #t 'fox ))   ) 'match (error "Error: Mismatch:" 93))
(if (equal? #f (lookup  t1 (list  4 "cord" 5 '() ))   ) 'match (error "Error: Mismatch:" 94))
(if (equal? #f (lookup  t2 (list  sin 'eel 'pig '(romeo juliet) 2.2361 ))   ) 'match (error "Error: Mismatch:" 95))
(if (equal? #f (lookup  t1 (list  "yarn" 2.2361 '(a . b) car 'jay ))   ) 'match (error "Error: Mismatch:" 96))
(if (equal? '(romeo juliet)  (lookup  t2 (list  2 '(larry moe curly) assoc 6 ))   ) 'match (error "Error: Mismatch:" 97))
(if (equal? #f (lookup  t2 (list  #t car 3 ))   ) 'match (error "Error: Mismatch:" 98))
(if (equal? #f (lookup  t1 (list  '(romeo juliet) '(a . b) ))   ) 'match (error "Error: Mismatch:" 99))
(if (equal? 7  (lookup  t2 (list  'fox ))   ) 'match (error "Error: Mismatch:" 100))
(if (equal? #f (lookup  t2 (list  '(1 . 2) #t 6 "yarn" ))   ) 'match (error "Error: Mismatch:" 101))
(if (equal? #f (lookup  t2 (list  1.7321 1.4142 "rope" ))   ) 'match (error "Error: Mismatch:" 102))
(if (equal? "yarn"  (lookup  t1 (list  '(romeo juliet) 1.4142 assoc 7 1.618 ))   ) 'match (error "Error: Mismatch:" 103))
(if (equal? #f (lookup  t2 (list  'jay 4 '(a . b) 1.7321 7 ))   ) 'match (error "Error: Mismatch:" 104))
(if (equal? #f (lookup  t2 (list  'dog assoc sin ))   ) 'match (error "Error: Mismatch:" 105))
(if (equal? "cord"  (lookup  t2 (list  1 'cat #t 3.1416 '(larry moe curly) ))   ) 'match (error "Error: Mismatch:" 106))
(if (equal? '(one)  (lookup  t2 (list  'jay cdr ))   ) 'match (error "Error: Mismatch:" 107))
(if (equal? 6  (lookup  t2 (list  list 'fox sin ))   ) 'match (error "Error: Mismatch:" 108))
(if (equal? 'cat  (lookup  t2 (list  '(larry moe curly) 'pig 'dog 'fox assoc ))   ) 'match (error "Error: Mismatch:" 109))
(if (equal? #f (lookup  t1 (list  "twine" 1.7321 'dog list "yarn" ))   ) 'match (error "Error: Mismatch:" 110))
(if (equal? 1.4142  (lookup  t1 (list  'eel 3 ))   ) 'match (error "Error: Mismatch:" 111))
(if (equal? #f (lookup  t2 (list  1.618 'fox 5 'pig ))   ) 'match (error "Error: Mismatch:" 112))
(if (equal? #f (lookup  t2 (list  'eel 7 'cat 2.2361 ))   ) 'match (error "Error: Mismatch:" 113))
(if (equal? #f (lookup  t2 (list  6 1.7321 cdr 'cow ))   ) 'match (error "Error: Mismatch:" 114))
(if (equal? #f (lookup  t1 (list  1.618 ))   ) 'match (error "Error: Mismatch:" 115))
(if (equal? #f (lookup  t2 (list  'cat 'jay '(one) ))   ) 'match (error "Error: Mismatch:" 116))
(if (equal? car  (lookup  t1 (list  '(a . b) list ))   ) 'match (error "Error: Mismatch:" 117))
(if (equal? 1.7321  (lookup  t1 (list  'cat ))   ) 'match (error "Error: Mismatch:" 118))
(if (equal? #f (lookup  t1 (list  4 car 'cat 'dog ))   ) 'match (error "Error: Mismatch:" 119))
(if (equal? #f (lookup  t1 (list  '(a . b) '(larry moe curly) ))   ) 'match (error "Error: Mismatch:" 120))
(if (equal? 'cat  (lookup  t2 (list  1.4142 1.7321 'pig '(one) ))   ) 'match (error "Error: Mismatch:" 121))
(if (equal? 'owl  (lookup  t2 (list  2.2361 3 'jay 1.618 ))   ) 'match (error "Error: Mismatch:" 122))
(if (equal? #f (lookup  t2 (list  'pig "yarn" 1.4142 ))   ) 'match (error "Error: Mismatch:" 123))
(if (equal? #f (lookup  t2 (list  1 6 ))   ) 'match (error "Error: Mismatch:" 124))
(if (equal? #f (lookup  t2 (list  'eel 4 'owl ))   ) 'match (error "Error: Mismatch:" 125))
(if (equal? 7  (lookup  t1 (list  1.7321 ))   ) 'match (error "Error: Mismatch:" 126))
(if (equal? 'jay  (lookup  t2 (list  car '(a . b) list 3 ))   ) 'match (error "Error: Mismatch:" 127))
(if (equal? #f (lookup  t2 (list  assoc "yarn" 6 ))   ) 'match (error "Error: Mismatch:" 128))
(if (equal? 'cat  (lookup  t1 (list  assoc 'pig "cord" ))   ) 'match (error "Error: Mismatch:" 129))
(if (equal? #f (lookup  t2 (list  "twine" #t 7 "yarn" 'eel ))   ) 'match (error "Error: Mismatch:" 130))
(if (equal? #f (lookup  t1 (list  5 "cord" '(a . b) 'fox list ))   ) 'match (error "Error: Mismatch:" 131))
(if (equal? #f (lookup  t2 (list  '() 'pig 7 2 '(one) ))   ) 'match (error "Error: Mismatch:" 132))
(if (equal? #t  (lookup  t1 (list  "cord" 6 '(romeo juliet) 1 4 ))   ) 'match (error "Error: Mismatch:" 133))
(if (equal? 1.4142  (lookup  t1 (list  '(1 . 2) 3.1416 ))   ) 'match (error "Error: Mismatch:" 134))
(if (equal? 1  (lookup  t2 (list  list '(a . b) ))   ) 'match (error "Error: Mismatch:" 135))
(if (equal? #f (lookup  t1 (list  'eel '(larry moe curly) ))   ) 'match (error "Error: Mismatch:" 136))
(if (equal? 6  (lookup  t2 (list  1.4142 7 ))   ) 'match (error "Error: Mismatch:" 137))
(if (equal? 7  (lookup  t2 (list  6 sin 'fox ))   ) 'match (error "Error: Mismatch:" 138))
(if (equal? #f (lookup  t2 (list  car 5 1.618 sin 2.2361 ))   ) 'match (error "Error: Mismatch:" 139))
(if (equal? '(1 . 2)  (lookup  t2 (list  '(one) '(larry moe curly) 'jay 2 6 ))   ) 'match (error "Error: Mismatch:" 140))
(if (equal? 'fox  (lookup  t2 (list  '(1 . 2) '(one) 1.618 "rope" 1 ))   ) 'match (error "Error: Mismatch:" 141))
(if (equal? #f (lookup  t2 (list  2 "rope" ))   ) 'match (error "Error: Mismatch:" 142))
(if (equal? #f (lookup  t1 (list  "rope" 6 1.618 'owl 1.4142 ))   ) 'match (error "Error: Mismatch:" 143))
(if (equal? #f (lookup  t2 (list  "twine" 7 ))   ) 'match (error "Error: Mismatch:" 144))
(if (equal? #f (lookup  t1 (list  1.7321 '(1 . 2) 'cow 1.4142 ))   ) 'match (error "Error: Mismatch:" 145))
(if (equal? #f (lookup  t2 (list  1 "cord" ))   ) 'match (error "Error: Mismatch:" 146))
(if (equal? assoc  (lookup  t1 (list  6 ))   ) 'match (error "Error: Mismatch:" 147))
(if (equal? #f (lookup  t1 (list  sin 2.2361 '(1 . 2) 'pig ))   ) 'match (error "Error: Mismatch:" 148))
(if (equal? 1.618  (lookup  t2 (list  'cow "cord" '(1 . 2) ))   ) 'match (error "Error: Mismatch:" 149))
(if (equal? '()  (lookup  t1 (list  list cdr car 1.4142 sin ))   ) 'match (error "Error: Mismatch:" 150))
(if (equal? #f (lookup  t2 (list  5 2 3.1416 1 "rope" ))   ) 'match (error "Error: Mismatch:" 151))
(if (equal? #f (lookup  t2 (list  'eel "rope" cdr '(romeo juliet) ))   ) 'match (error "Error: Mismatch:" 152))
(if (equal? 4  (lookup  t2 (list  "cord" 6 "rope" ))   ) 'match (error "Error: Mismatch:" 153))
(if (equal? #f (lookup  t1 (list  2 '(larry moe curly) ))   ) 'match (error "Error: Mismatch:" 154))
(if (equal? 3.1416  (lookup  t1 (list  #t ))   ) 'match (error "Error: Mismatch:" 155))
(if (equal? #f (lookup  t2 (list  'jay 1.7321 2 car ))   ) 'match (error "Error: Mismatch:" 156))
(if (equal? #f (lookup  t1 (list  assoc '() 3.1416 cdr ))   ) 'match (error "Error: Mismatch:" 157))
(if (equal? '(a . b)  (lookup  t1 (list  1.618 'cow 6 '(romeo juliet) ))   ) 'match (error "Error: Mismatch:" 158))
(if (equal? 2  (lookup  t2 (list  assoc '(romeo juliet) sin 5 ))   ) 'match (error "Error: Mismatch:" 159))
(if (equal? cdr  (lookup  t2 (list  '(larry moe curly) car '(a . b) 'jay ))   ) 'match (error "Error: Mismatch:" 160))
(if (equal? #f (lookup  t2 (list  list 'eel ))   ) 'match (error "Error: Mismatch:" 161))
(if (equal? #f (lookup  t1 (list  3.1416 3 1.618 'fox 2.2361 ))   ) 'match (error "Error: Mismatch:" 162))
(if (equal? 1  (lookup  t1 (list  assoc '(a . b) 2 ))   ) 'match (error "Error: Mismatch:" 163))
(if (equal? '()  (lookup  t1 (list  3 ))   ) 'match (error "Error: Mismatch:" 164))
(if (equal? #f (lookup  t1 (list  2 ))   ) 'match (error "Error: Mismatch:" 165))
(if (equal? 1.7321  (lookup  t2 (list  'cow #t 'cat '(1 . 2) ))   ) 'match (error "Error: Mismatch:" 166))
(if (equal? #f (lookup  t1 (list  '() 'jay ))   ) 'match (error "Error: Mismatch:" 167))
(if (equal? car  (lookup  t1 (list  1.7321 '(1 . 2) 'cat 4 'eel ))   ) 'match (error "Error: Mismatch:" 168))
(if (equal? "yarn"  (lookup  t2 (list  2 '(romeo juliet) #t 1.7321 'cat ))   ) 'match (error "Error: Mismatch:" 169))
(if (equal? #f (lookup  t2 (list  3 car ))   ) 'match (error "Error: Mismatch:" 170))
(if (equal? '(larry moe curly)  (lookup  t1 (list  2.2361 ))   ) 'match (error "Error: Mismatch:" 171))
(if (equal? 'jay  (lookup  t1 (list  'dog ))   ) 'match (error "Error: Mismatch:" 172))
(if (equal? assoc  (lookup  t2 (list  1.618 1.4142 'cow "yarn" ))   ) 'match (error "Error: Mismatch:" 173))
(if (equal? 'owl  (lookup  t1 (list  #t 1.4142 '() list '(larry moe curly) ))   ) 'match (error "Error: Mismatch:" 174))
(if (equal? 5  (lookup  t2 (list  7 '() ))   ) 'match (error "Error: Mismatch:" 175))
(if (equal? #f (lookup  t1 (list  'jay 'cat 3 ))   ) 'match (error "Error: Mismatch:" 176))
(if (equal? 7  (lookup  t2 (list  1.618 ))   ) 'match (error "Error: Mismatch:" 177))
(if (equal? 6  (lookup  t2 (list  'jay "yarn" '(romeo juliet) 'cow assoc ))   ) 'match (error "Error: Mismatch:" 178))
(if (equal? '(romeo juliet)  (lookup  t2 (list  7 1.7321 list ))   ) 'match (error "Error: Mismatch:" 179))
(if (equal? "rope"  (lookup  t1 (list  'jay ))   ) 'match (error "Error: Mismatch:" 180))
(if (equal? 3.1416  (lookup  t1 (list  #t ))   ) 'match (error "Error: Mismatch:" 181))
(if (equal? list  (lookup  t2 (list  cdr ))   ) 'match (error "Error: Mismatch:" 182))
(if (equal? #f (lookup  t2 (list  7 "yarn" ))   ) 'match (error "Error: Mismatch:" 183))
(if (equal? 7  (lookup  t1 (list  1.7321 ))   ) 'match (error "Error: Mismatch:" 184))
(if (equal? sin  (lookup  t2 (list  cdr 2.2361 2 ))   ) 'match (error "Error: Mismatch:" 185))
(if (equal? #f (lookup  t2 (list  "twine" 7 2 "yarn" ))   ) 'match (error "Error: Mismatch:" 186))
(if (equal? 4  (lookup  t1 (list  'owl 'fox ))   ) 'match (error "Error: Mismatch:" 187))
(if (equal? #f (lookup  t2 (list  "twine" ))   ) 'match (error "Error: Mismatch:" 188))
(if (equal? 'jay  (lookup  t2 (list  'cat 7 2.2361 sin 1.4142 ))   ) 'match (error "Error: Mismatch:" 189))
(if (equal? 1.7321  (lookup  t1 (list  "yarn" 'cow list ))   ) 'match (error "Error: Mismatch:" 190))
(if (equal? '(1 . 2)  (lookup  t2 (list  3.1416 '(one) '(larry moe curly) 'eel "rope" ))   ) 'match (error "Error: Mismatch:" 191))
(if (equal? #f (lookup  t1 (list  '(1 . 2) sin 1.4142 ))   ) 'match (error "Error: Mismatch:" 192))
(if (equal? list  (lookup  t1 (list  'pig 'eel 3 1.618 ))   ) 'match (error "Error: Mismatch:" 193))
(if (equal? 'owl  (lookup  t2 (list  '() 1 2.2361 "yarn" 6 ))   ) 'match (error "Error: Mismatch:" 194))
(if (equal? car  (lookup  t2 (list  2 "yarn" 6 ))   ) 'match (error "Error: Mismatch:" 195))
(if (equal? #f (lookup  t1 (list  '(1 . 2) '(a . b) 7 ))   ) 'match (error "Error: Mismatch:" 196))
(if (equal? "yarn"  (lookup  t1 (list  'eel ))   ) 'match (error "Error: Mismatch:" 197))
(if (equal? '()  (lookup  t1 (list  3 ))   ) 'match (error "Error: Mismatch:" 198))
(if (equal? #f (lookup  t2 (list  '(a . b) 6 3.1416 1.618 ))   ) 'match (error "Error: Mismatch:" 199))
(if (equal? '()  (lookup  t1 (list  3 ))   ) 'match (error "Error: Mismatch:" 200))
(if (equal? list  (lookup  t2 (list  cdr ))   ) 'match (error "Error: Mismatch:" 201))
(if (equal? #f (lookup  t1 (list  1.618 1.4142 'fox list ))   ) 'match (error "Error: Mismatch:" 202))
(if (equal? assoc  (lookup  t1 (list  4 list 'jay cdr "twine" ))   ) 'match (error "Error: Mismatch:" 203))
(if (equal? 5  (lookup  t1 (list  sin "cord" '() ))   ) 'match (error "Error: Mismatch:" 204))
(if (equal? #f (lookup  t1 (list  5 'dog ))   ) 'match (error "Error: Mismatch:" 205))
(if (equal? #f (lookup  t1 (list  'fox 1.7321 'pig ))   ) 'match (error "Error: Mismatch:" 206))
(if (equal? 3  (lookup  t1 (list  car '(romeo juliet) "cord" 1.4142 6 ))   ) 'match (error "Error: Mismatch:" 207))
(if (equal? '(a . b)  (lookup  t2 (list  '(1 . 2) '(romeo juliet) ))   ) 'match (error "Error: Mismatch:" 208))
(if (equal? 1.7321  (lookup  t2 (list  sin '(larry moe curly) '(one) '(a . b) 'pig ))   ) 'match (error "Error: Mismatch:" 209))
(if (equal? #f (lookup  t2 (list  'pig ))   ) 'match (error "Error: Mismatch:" 210))
(if (equal? 1.4142  (lookup  t2 (list  #t ))   ) 'match (error "Error: Mismatch:" 211))
(if (equal? #f (lookup  t2 (list  'jay ))   ) 'match (error "Error: Mismatch:" 212))
(if (equal? 'dog  (lookup  t1 (list  3 'cat 4 ))   ) 'match (error "Error: Mismatch:" 213))
(if (equal? #t  (lookup  t2 (list  'cow ))   ) 'match (error "Error: Mismatch:" 214))
(if (equal? 'cat  (lookup  t1 (list  cdr 1.618 '(larry moe curly) "rope" 5 ))   ) 'match (error "Error: Mismatch:" 215))
(if (equal? #f (lookup  t1 (list  'owl assoc 6 ))   ) 'match (error "Error: Mismatch:" 216))
(if (equal? #f (lookup  t1 (list  'dog '(one) car ))   ) 'match (error "Error: Mismatch:" 217))
(if (equal? "rope"  (lookup  t1 (list  'jay ))   ) 'match (error "Error: Mismatch:" 218))
(if (equal? 3.1416  (lookup  t2 (list  'jay 7 'cat ))   ) 'match (error "Error: Mismatch:" 219))
(if (equal? 'cat  (lookup  t2 (list  2 'eel 'fox ))   ) 'match (error "Error: Mismatch:" 220))
(if (equal? 'cow  (lookup  t2 (list  "rope" '(one) ))   ) 'match (error "Error: Mismatch:" 221))
(if (equal? 3  (lookup  t1 (list  "cord" 2 1.7321 assoc "yarn" ))   ) 'match (error "Error: Mismatch:" 222))
(if (equal? #f (lookup  t1 (list  car 4 ))   ) 'match (error "Error: Mismatch:" 223))
(if (equal? #f (lookup  t2 (list  '(a . b) 1.618 "yarn" 6 ))   ) 'match (error "Error: Mismatch:" 224))
(if (equal? #f (lookup  t1 (list  1 1.7321 ))   ) 'match (error "Error: Mismatch:" 225))
(if (equal? 4  (lookup  t2 (list  3 7 ))   ) 'match (error "Error: Mismatch:" 226))
(if (equal? '(larry moe curly)  (lookup  t2 (list  "yarn" list 'owl '() 'jay ))   ) 'match (error "Error: Mismatch:" 227))
(if (equal? 'cow  (lookup  t2 (list  car cdr list '(one) 2.2361 ))   ) 'match (error "Error: Mismatch:" 228))
(if (equal? 'eel  (lookup  t2 (list  '(a . b) "twine" '(romeo juliet) 1.4142 list ))   ) 'match (error "Error: Mismatch:" 229))
(if (equal? 2  (lookup  t1 (list  list 7 car 'cow ))   ) 'match (error "Error: Mismatch:" 230))
(if (equal? 'cow  (lookup  t1 (list  '(a . b) 'eel 4 ))   ) 'match (error "Error: Mismatch:" 231))
(if (equal? 1.618  (lookup  t1 (list  'dog 'jay cdr 6 ))   ) 'match (error "Error: Mismatch:" 232))
(if (equal? #f (lookup  t2 (list  6 ))   ) 'match (error "Error: Mismatch:" 233))
(if (equal? #f (lookup  t2 (list  assoc ))   ) 'match (error "Error: Mismatch:" 234))
(if (equal? sin  (lookup  t1 (list  #t list 1.7321 7 'jay ))   ) 'match (error "Error: Mismatch:" 235))
(if (equal? #f (lookup  t1 (list  car assoc '() ))   ) 'match (error "Error: Mismatch:" 236))
(if (equal? sin  (lookup  t2 (list  "cord" ))   ) 'match (error "Error: Mismatch:" 237))
(if (equal? 2  (lookup  t2 (list  '() ))   ) 'match (error "Error: Mismatch:" 238))
(if (equal? #f (lookup  t1 (list  3 '(1 . 2) ))   ) 'match (error "Error: Mismatch:" 239))
(if (equal? 5  (lookup  t2 (list  'jay 'eel cdr '(one) ))   ) 'match (error "Error: Mismatch:" 240))
(if (equal? 'cow  (lookup  t2 (list  '(a . b) '(1 . 2) 'eel ))   ) 'match (error "Error: Mismatch:" 241))
(if (equal? cdr  (lookup  t1 (list  "rope" 2.2361 'cow #t ))   ) 'match (error "Error: Mismatch:" 242))
(if (equal? 'owl  (lookup  t1 (list  "twine" cdr ))   ) 'match (error "Error: Mismatch:" 243))
(if (equal? 'jay  (lookup  t2 (list  3 #t 5 '(one) 4 ))   ) 'match (error "Error: Mismatch:" 244))
(if (equal? 2  (lookup  t2 (list  '(larry moe curly) ))   ) 'match (error "Error: Mismatch:" 245))
(if (equal? #f (lookup  t1 (list  assoc '(larry moe curly) 1.618 'pig 'jay ))   ) 'match (error "Error: Mismatch:" 246))
(if (equal? 3.1416  (lookup  t1 (list  '() 'cow 'pig 1 ))   ) 'match (error "Error: Mismatch:" 247))
(if (equal? #f (lookup  t1 (list  1.4142 3.1416 ))   ) 'match (error "Error: Mismatch:" 248))
(if (equal? 1.618  (lookup  t1 (list  "cord" 1.4142 1.7321 ))   ) 'match (error "Error: Mismatch:" 249))
(if (equal? "twine"  (lookup  t2 (list  '(romeo juliet) 'dog 'owl 2 '(a . b) ))   ) 'match (error "Error: Mismatch:" 250))
(if (equal? #f (lookup  t1 (list  '() '(one) ))   ) 'match (error "Error: Mismatch:" 251))
(if (equal? #f (lookup  t2 (list  3 5 ))   ) 'match (error "Error: Mismatch:" 252))
(if (equal? #f (lookup  t2 (list  sin car 4 "cord" ))   ) 'match (error "Error: Mismatch:" 253))
(if (equal? #f (lookup  t2 (list  '() '(larry moe curly) ))   ) 'match (error "Error: Mismatch:" 254))
(if (equal? #f (lookup  t2 (list  6 1.7321 ))   ) 'match (error "Error: Mismatch:" 255))
(if (equal? #f (lookup  t2 (list  '(romeo juliet) ))   ) 'match (error "Error: Mismatch:" 256))
(if (equal? '(one)  (lookup  t2 (list  '(larry moe curly) 'cat 2.2361 "yarn" '(a . b) ))   ) 'match (error "Error: Mismatch:" 257))
(if (equal? '(larry moe curly)  (lookup  t2 (list  assoc 'eel '(one) ))   ) 'match (error "Error: Mismatch:" 258))
(if (equal? #f (lookup  t1 (list  #t '(a . b) ))   ) 'match (error "Error: Mismatch:" 259))
(if (equal? 'pig  (lookup  t1 (list  7 1.618 4 2 ))   ) 'match (error "Error: Mismatch:" 260))
(if (equal? 1  (lookup  t1 (list  '(a . b) ))   ) 'match (error "Error: Mismatch:" 261))
(if (equal? #f (lookup  t2 (list  sin 5 "rope" "cord" 'pig ))   ) 'match (error "Error: Mismatch:" 262))
(if (equal? #f (lookup  t2 (list  car ))   ) 'match (error "Error: Mismatch:" 263))
(if (equal? #t  (lookup  t1 (list  list 1.7321 "yarn" 'cow ))   ) 'match (error "Error: Mismatch:" 264))
(if (equal? #f (lookup  t2 (list  'cow cdr 'eel 'jay "rope" ))   ) 'match (error "Error: Mismatch:" 265))
(if (equal? #f (lookup  t1 (list  "yarn" "rope" 1.4142 ))   ) 'match (error "Error: Mismatch:" 266))
(if (equal? '(one)  (lookup  t2 (list  'jay cdr ))   ) 'match (error "Error: Mismatch:" 267))
(if (equal? #f (lookup  t1 (list  list '(romeo juliet) ))   ) 'match (error "Error: Mismatch:" 268))
(if (equal? "rope"  (lookup  t1 (list  "twine" 'dog ))   ) 'match (error "Error: Mismatch:" 269))
(if (equal? #f (lookup  t1 (list  3 'eel ))   ) 'match (error "Error: Mismatch:" 270))
(if (equal? #f (lookup  t2 (list  'dog ))   ) 'match (error "Error: Mismatch:" 271))
(if (equal? 2.2361  (lookup  t2 (list  1.4142 ))   ) 'match (error "Error: Mismatch:" 272))
(if (equal? #f (lookup  t2 (list  'eel ))   ) 'match (error "Error: Mismatch:" 273))
(if (equal? cdr  (lookup  t1 (list  1 ))   ) 'match (error "Error: Mismatch:" 274))
(if (equal? cdr  (lookup  t2 (list  assoc 1 ))   ) 'match (error "Error: Mismatch:" 275))
(if (equal? 1  (lookup  t1 (list  list sin 2.2361 1.618 1.4142 ))   ) 'match (error "Error: Mismatch:" 276))
(if (equal? #f (lookup  t2 (list  1.4142 cdr 2 ))   ) 'match (error "Error: Mismatch:" 277))
(if (equal? #f (lookup  t1 (list  'cat 1.618 ))   ) 'match (error "Error: Mismatch:" 278))
(if (equal? #f (lookup  t1 (list  1.618 'owl 3.1416 'cow ))   ) 'match (error "Error: Mismatch:" 279))
(if (equal? 1.7321  (lookup  t1 (list  'jay 6 ))   ) 'match (error "Error: Mismatch:" 280))
(if (equal? 1  (lookup  t1 (list  '(one) ))   ) 'match (error "Error: Mismatch:" 281))
(if (equal? 3  (lookup  t1 (list  1.4142 2.2361 ))   ) 'match (error "Error: Mismatch:" 282))
(if (equal? #f (lookup  t1 (list  "cord" "twine" 'fox 3.1416 ))   ) 'match (error "Error: Mismatch:" 283))
(if (equal? car  (lookup  t2 (list  '(a . b) 1 7 1.4142 ))   ) 'match (error "Error: Mismatch:" 284))
(if (equal? #f (lookup  t1 (list  3 'pig ))   ) 'match (error "Error: Mismatch:" 285))
(if (equal? 3  (lookup  t1 (list  'dog assoc 'cat 1.618 '(larry moe curly) ))   ) 'match (error "Error: Mismatch:" 286))
(if (equal? #t  (lookup  t2 (list  '() '(romeo juliet) '(a . b) 1.7321 ))   ) 'match (error "Error: Mismatch:" 287))
(if (equal? #t  (lookup  t2 (list  'cow ))   ) 'match (error "Error: Mismatch:" 288))
(if (equal? '(1 . 2)  (lookup  t2 (list  3.1416 '() 'pig car 1.7321 ))   ) 'match (error "Error: Mismatch:" 289))
(if (equal? 'cow  (lookup  t1 (list  "twine" 5 ))   ) 'match (error "Error: Mismatch:" 290))
(if (equal? 'dog  (lookup  t1 (list  '() "cord" ))   ) 'match (error "Error: Mismatch:" 291))
(if (equal? #f (lookup  t1 (list  'cow assoc 1.618 'owl 5 ))   ) 'match (error "Error: Mismatch:" 292))
(if (equal? #f (lookup  t2 (list  #t '(a . b) ))   ) 'match (error "Error: Mismatch:" 293))
(if (equal? #f (lookup  t2 (list  'pig ))   ) 'match (error "Error: Mismatch:" 294))
(if (equal? #t  (lookup  t2 (list  'cow ))   ) 'match (error "Error: Mismatch:" 295))
(if (equal? list  (lookup  t2 (list  cdr ))   ) 'match (error "Error: Mismatch:" 296))
(if (equal? 'pig  (lookup  t1 (list  1.4142 ))   ) 'match (error "Error: Mismatch:" 297))
(if (equal? 3  (lookup  t1 (list  assoc 'pig '(1 . 2) '() 2.2361 ))   ) 'match (error "Error: Mismatch:" 298))
(if (equal? 3  (lookup  t2 (list  'eel "cord" ))   ) 'match (error "Error: Mismatch:" 299))
(if (equal? "yarn"  (lookup  t2 (list  'cat '(romeo juliet) ))   ) 'match (error "Error: Mismatch:" 300))
(if (equal? assoc  (lookup  t1 (list  6 ))   ) 'match (error "Error: Mismatch:" 301))
(if (equal? #f (lookup  t2 (list  list 'pig ))   ) 'match (error "Error: Mismatch:" 302))
(if (equal? 5  (lookup  t2 (list  '(romeo juliet) "yarn" ))   ) 'match (error "Error: Mismatch:" 303))
(if (equal? #f (lookup  t2 (list  '(romeo juliet) 'eel ))   ) 'match (error "Error: Mismatch:" 304))
(if (equal? #f (lookup  t2 (list  car 2 "rope" ))   ) 'match (error "Error: Mismatch:" 305))
(if (equal? #t  (lookup  t1 (list  2.2361 'eel ))   ) 'match (error "Error: Mismatch:" 306))
(if (equal? #f (lookup  t1 (list  "yarn" ))   ) 'match (error "Error: Mismatch:" 307))
(if (equal? 'pig  (lookup  t1 (list  '(1 . 2) ))   ) 'match (error "Error: Mismatch:" 308))
(if (equal? #f (lookup  t2 (list  '(a . b) 'dog '(1 . 2) ))   ) 'match (error "Error: Mismatch:" 309))
(if (equal? #f (lookup  t2 (list  list assoc 'cow 2.2361 ))   ) 'match (error "Error: Mismatch:" 310))
(if (equal? #f (lookup  t2 (list  "rope" list ))   ) 'match (error "Error: Mismatch:" 311))
(if (equal? #f (lookup  t2 (list  '(1 . 2) '() 2.2361 '(one) assoc ))   ) 'match (error "Error: Mismatch:" 312))
(if (equal? 'dog  (lookup  t2 (list  '(one) 'cow ))   ) 'match (error "Error: Mismatch:" 313))
(if (equal? #f (lookup  t1 (list  1 '() ))   ) 'match (error "Error: Mismatch:" 314))
(if (equal? 7  (lookup  t1 (list  1.7321 ))   ) 'match (error "Error: Mismatch:" 315))
(if (equal? 4  (lookup  t1 (list  1.618 5 list '(romeo juliet) 7 ))   ) 'match (error "Error: Mismatch:" 316))
(if (equal? #f (lookup  t1 (list  'dog "twine" 1 '(1 . 2) ))   ) 'match (error "Error: Mismatch:" 317))
(if (equal? #f (lookup  t1 (list  5 2 sin #t car ))   ) 'match (error "Error: Mismatch:" 318))
(if (equal? 1  (lookup  t1 (list  '(a . b) ))   ) 'match (error "Error: Mismatch:" 319))
(if (equal? 2.2361  (lookup  t2 (list  1.4142 ))   ) 'match (error "Error: Mismatch:" 320))
(if (equal? #f (lookup  t1 (list  2 3 "cord" 1.618 ))   ) 'match (error "Error: Mismatch:" 321))
(if (equal? 6  (lookup  t1 (list  4 ))   ) 'match (error "Error: Mismatch:" 322))
(if (equal? sin  (lookup  t2 (list  1.7321 '(a . b) 4 '() 1.4142 ))   ) 'match (error "Error: Mismatch:" 323))
(if (equal? #f (lookup  t2 (list  2 '(one) 'pig 2.2361 ))   ) 'match (error "Error: Mismatch:" 324))
(if (equal? 7  (lookup  t1 (list  5 ))   ) 'match (error "Error: Mismatch:" 325))
(if (equal? list  (lookup  t1 (list  2 5 cdr ))   ) 'match (error "Error: Mismatch:" 326))
(if (equal? #f (lookup  t1 (list  'fox "twine" '(a . b) ))   ) 'match (error "Error: Mismatch:" 327))
(if (equal? 'pig  (lookup  t2 (list  "yarn" 3 1.4142 ))   ) 'match (error "Error: Mismatch:" 328))
(if (equal? #f (lookup  t2 (list  3.1416 ))   ) 'match (error "Error: Mismatch:" 329))
(if (equal? 'eel  (lookup  t1 (list  6 #t '(romeo juliet) ))   ) 'match (error "Error: Mismatch:" 330))
(if (equal? #f (lookup  t1 (list  '(romeo juliet) ))   ) 'match (error "Error: Mismatch:" 331))
(if (equal? 2.2361  (lookup  t2 (list  1.4142 ))   ) 'match (error "Error: Mismatch:" 332))
(if (equal? #f (lookup  t2 (list  3.1416 1 ))   ) 'match (error "Error: Mismatch:" 333))
(if (equal? #f (lookup  t1 (list  "rope" 4 7 list ))   ) 'match (error "Error: Mismatch:" 334))
(if (equal? '(1 . 2)  (lookup  t1 (list  car 'fox ))   ) 'match (error "Error: Mismatch:" 335))
(if (equal? #f (lookup  t1 (list  sin 7 'jay 3 ))   ) 'match (error "Error: Mismatch:" 336))
(if (equal? 'pig  (lookup  t2 (list  "yarn" 'eel 'jay '(larry moe curly) 'dog ))   ) 'match (error "Error: Mismatch:" 337))
(if (equal? #f (lookup  t2 (list  '(romeo juliet) 'fox "cord" ))   ) 'match (error "Error: Mismatch:" 338))
(if (equal? 7  (lookup  t1 (list  5 ))   ) 'match (error "Error: Mismatch:" 339))
(if (equal? cdr  (lookup  t2 (list  1.7321 4 'fox 'cat '(one) ))   ) 'match (error "Error: Mismatch:" 340))
(if (equal? '(larry moe curly)  (lookup  t1 (list  3 '() 3.1416 ))   ) 'match (error "Error: Mismatch:" 341))
(if (equal? #f (lookup  t1 (list  car 1.7321 '(one) 6 ))   ) 'match (error "Error: Mismatch:" 342))
(if (equal? '(larry moe curly)  (lookup  t2 (list  "cord" 4 assoc ))   ) 'match (error "Error: Mismatch:" 343))
(if (equal? #f (lookup  t2 (list  '(larry moe curly) 3 ))   ) 'match (error "Error: Mismatch:" 344))
(if (equal? #f (lookup  t1 (list  '(larry moe curly) '(one) 'cat 1.618 ))   ) 'match (error "Error: Mismatch:" 345))
(if (equal? 7  (lookup  t2 (list  1.618 ))   ) 'match (error "Error: Mismatch:" 346))
(if (equal? #f (lookup  t1 (list  2.2361 "yarn" '(1 . 2) 4 'cow ))   ) 'match (error "Error: Mismatch:" 347))
(if (equal? 7  (lookup  t1 (list  'fox assoc 1.7321 '(larry moe curly) ))   ) 'match (error "Error: Mismatch:" 348))
(if (equal? cdr  (lookup  t1 (list  '(one) '(larry moe curly) ))   ) 'match (error "Error: Mismatch:" 349))
(if (equal? #f (lookup  t2 (list  2 ))   ) 'match (error "Error: Mismatch:" 350))
(if (equal? #f (lookup  t2 (list  '(larry moe curly) "yarn" 1.618 ))   ) 'match (error "Error: Mismatch:" 351))
(if (equal? #f (lookup  t1 (list  'owl 'eel ))   ) 'match (error "Error: Mismatch:" 352))
(if (equal? #f (lookup  t2 (list  7 "yarn" 'cow 3 ))   ) 'match (error "Error: Mismatch:" 353))
(if (equal? 1  (lookup  t1 (list  '(a . b) ))   ) 'match (error "Error: Mismatch:" 354))
(if (equal? #f (lookup  t2 (list  'cow 'cat car 'dog ))   ) 'match (error "Error: Mismatch:" 355))
(if (equal? #f (lookup  t1 (list  'owl 1.618 1.7321 ))   ) 'match (error "Error: Mismatch:" 356))
(if (equal? #f (lookup  t1 (list  car ))   ) 'match (error "Error: Mismatch:" 357))
(if (equal? 1  (lookup  t1 (list  '(a . b) ))   ) 'match (error "Error: Mismatch:" 358))
(if (equal? #f (lookup  t1 (list  #t 'dog '(larry moe curly) "rope" ))   ) 'match (error "Error: Mismatch:" 359))
(if (equal? 1.4142  (lookup  t1 (list  1 3 #t 1.618 ))   ) 'match (error "Error: Mismatch:" 360))
(if (equal? list  (lookup  t1 (list  cdr 'fox 'dog '(one) ))   ) 'match (error "Error: Mismatch:" 361))
(if (equal? #f (lookup  t1 (list  'pig 7 car ))   ) 'match (error "Error: Mismatch:" 362))
(if (equal? 1.618  (lookup  t1 (list  2.2361 'fox 3 'cat ))   ) 'match (error "Error: Mismatch:" 363))
(if (equal? #f (lookup  t1 (list  '(larry moe curly) '(1 . 2) list ))   ) 'match (error "Error: Mismatch:" 364))
(if (equal? car  (lookup  t1 (list  'pig ))   ) 'match (error "Error: Mismatch:" 365))
(if (equal? #f (lookup  t2 (list  '(romeo juliet) 'cat 5 3 1.4142 ))   ) 'match (error "Error: Mismatch:" 366))
(if (equal? 'pig  (lookup  t1 (list  list ))   ) 'match (error "Error: Mismatch:" 367))
(if (equal? cdr  (lookup  t2 (list  'cat 3 'pig 'owl 4 ))   ) 'match (error "Error: Mismatch:" 368))
(if (equal? list  (lookup  t2 (list  'cow 1.618 '(a . b) ))   ) 'match (error "Error: Mismatch:" 369))
(if (equal? #f (lookup  t1 (list  1.7321 7 cdr ))   ) 'match (error "Error: Mismatch:" 370))
(if (equal? 6  (lookup  t2 (list  'cat ))   ) 'match (error "Error: Mismatch:" 371))
(if (equal? #t  (lookup  t1 (list  '(1 . 2) '(romeo juliet) 'dog ))   ) 'match (error "Error: Mismatch:" 372))
(if (equal? car  (lookup  t1 (list  3.1416 #t ))   ) 'match (error "Error: Mismatch:" 373))
(if (equal? #f (lookup  t2 (list  7 ))   ) 'match (error "Error: Mismatch:" 374))
(if (equal? #f (lookup  t1 (list  'fox 5 7 'cow 1 ))   ) 'match (error "Error: Mismatch:" 375))
(if (equal? #f (lookup  t2 (list  car ))   ) 'match (error "Error: Mismatch:" 376))
(if (equal? #f (lookup  t1 (list  '(1 . 2) 'owl 'cat '(larry moe curly) ))   ) 'match (error "Error: Mismatch:" 377))
(if (equal? 'jay  (lookup  t1 (list  "rope" 'cat ))   ) 'match (error "Error: Mismatch:" 378))
(if (equal? #f (lookup  t1 (list  2.2361 "yarn" 4 1.618 ))   ) 'match (error "Error: Mismatch:" 379))
(if (equal? 1.4142  (lookup  t2 (list  list #t "cord" ))   ) 'match (error "Error: Mismatch:" 380))
(if (equal? 7  (lookup  t2 (list  'fox ))   ) 'match (error "Error: Mismatch:" 381))
(if (equal? 2  (lookup  t2 (list  'jay "cord" ))   ) 'match (error "Error: Mismatch:" 382))
(if (equal? #f (lookup  t1 (list  "cord" assoc car 3.1416 ))   ) 'match (error "Error: Mismatch:" 383))
(if (equal? #f (lookup  t1 (list  'fox 'cat ))   ) 'match (error "Error: Mismatch:" 384))
(if (equal? #f (lookup  t2 (list  car sin ))   ) 'match (error "Error: Mismatch:" 385))
(if (equal? #f (lookup  t2 (list  'jay assoc ))   ) 'match (error "Error: Mismatch:" 386))
(if (equal? #f (lookup  t2 (list  list "cord" '(one) 3.1416 'pig ))   ) 'match (error "Error: Mismatch:" 387))
(if (equal? "yarn"  (lookup  t2 (list  4 'dog "rope" ))   ) 'match (error "Error: Mismatch:" 388))
(if (equal? #f (lookup  t2 (list  "twine" 1.7321 ))   ) 'match (error "Error: Mismatch:" 389))
(if (equal? #t  (lookup  t2 (list  'cow ))   ) 'match (error "Error: Mismatch:" 390))
(if (equal? 2.2361  (lookup  t1 (list  'jay list '(a . b) '(larry moe curly) ))   ) 'match (error "Error: Mismatch:" 391))
(if (equal? 1  (lookup  t1 (list  '(one) ))   ) 'match (error "Error: Mismatch:" 392))
(if (equal? #f (lookup  t2 (list  'cat 'eel "cord" '(larry moe curly) 2 ))   ) 'match (error "Error: Mismatch:" 393))
(if (equal? #f (lookup  t2 (list  "yarn" ))   ) 'match (error "Error: Mismatch:" 394))
(if (equal? #f (lookup  t1 (list  3 6 2.2361 ))   ) 'match (error "Error: Mismatch:" 395))
(if (equal? #f (lookup  t1 (list  sin "twine" ))   ) 'match (error "Error: Mismatch:" 396))
(if (equal? #f (lookup  t1 (list  sin 1.618 "yarn" ))   ) 'match (error "Error: Mismatch:" 397))
(if (equal? #f (lookup  t1 (list  assoc list '(a . b) 1.7321 "rope" ))   ) 'match (error "Error: Mismatch:" 398))
(if (equal? #f (lookup  t1 (list  'eel '(larry moe curly) 2 ))   ) 'match (error "Error: Mismatch:" 399))
(if (equal? #f (lookup  t1 (list  7 ))   ) 'match (error "Error: Mismatch:" 400))