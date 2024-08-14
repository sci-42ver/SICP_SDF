'3
'x
''x
(quote (3 4))
('+ 3 4)
(if '(= x 0) 7 8)
(eq? 'x 'X) ; #t
(eq? (list 1 2) (list 1 2))
(equal? (list 1 2) (list 1 2))
(let ((a (list 1 2))) (eq? a a)) ; why #t -> see https://standards.scheme.org/corrected-r7rs/r7rs-Z-H-8.html#TAG:__tex2page_index_314 although only one example without detailed reasons.