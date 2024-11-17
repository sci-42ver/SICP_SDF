;; https://hipster.home.xs4all.nl/lib/scheme/gauche/define-syntax-primer.txt

;; orig
(define-syntax sreverse
   (syntax-rules ()
     ((sreverse thing) (sreverse "top" thing ("done")))

     ((sreverse "top" () (tag . more))
      (sreverse tag () . more))

     ((sreverse "top" ((headcar . headcdr) . tail) kont)
      (sreverse "top" tail ("after-tail" (headcar . headcdr) kont)))

     ((sreverse "after-tail" new-tail head kont)
      (sreverse "top" head ("after-head" new-tail kont)))

     ((sreverse "after-head" () new-tail (tag . more))
      (sreverse tag new-tail . more))

     ((sreverse "after-head" new-head (new-tail ...) (tag . more))
      (sreverse tag (new-tail ... new-head) . more))

     ((sreverse "top" (head . tail) kont)
      (sreverse "top" tail ("after-tail2" head kont)))

     ((sreverse "after-tail2" () head (tag . more))
      (sreverse tag (head) . more))

     ((sreverse "after-tail2" (new-tail ...) head (tag . more))
      (sreverse tag (new-tail ... head) . more))

     ((sreverse "done" value)
      'value)))
(sreverse (1 (2 3) (4 (halt)) 6 7))
; (7 6 ((halt) 4) (3 2) 1)
;; The following ; ...'s correspond to pattern
(sreverse "top" (1 (2 3) (4 (halt)) 6 7) ("done"))
(sreverse "top" ((2 3) (4 (halt)) 6 7) ("after-tail2" 1 ("done")))
(sreverse "top" ((4 (halt)) 6 7) ("after-tail" (2 3) ("after-tail2" 1 ("done"))))
(sreverse "top" (6 7) ("after-tail" (4 (halt)) ("after-tail" (2 3) ("after-tail2" 1 ("done")))))
(sreverse "top" (7) ("after-tail2" 6 ("after-tail" (4 (halt)) ("after-tail" (2 3) ("after-tail2" 1 ("done"))))))
(sreverse "top" () ("after-tail2" 7 ("after-tail2" 6 ("after-tail" (4 (halt)) ("after-tail" (2 3) ("after-tail2" 1 ("done")))))))
; (sreverse "top" () (tag . more))
(sreverse "after-tail2" () 7 ("after-tail2" 6 ("after-tail" (4 (halt)) ("after-tail" (2 3) ("after-tail2" 1 ("done"))))))
; (sreverse tag (head) . more)
(sreverse "after-tail2" (7) 6 ("after-tail" (4 (halt)) ("after-tail" (2 3) ("after-tail2" 1 ("done")))))
; (sreverse tag (new-tail ... head) . more)
(sreverse "after-tail" (7 6) (4 (halt)) ("after-tail" (2 3) ("after-tail2" 1 ("done"))))
; (sreverse "after-tail" new-tail head kont)
;; think about the sublist and reverse it with starting tag "top"
(sreverse "top" (4 (halt)) ("after-head" (7 6) ("after-tail" (2 3) ("after-tail2" 1 ("done")))))
; (sreverse "top" (head . tail) kont)
(sreverse "top" ((halt)) ("after-tail2" 4 ("after-head" (7 6) ("after-tail" (2 3) ("after-tail2" 1 ("done"))))))
; (sreverse "top" ((headcar . headcdr) . tail) kont)
(sreverse "top" () ("after-tail" (halt) ("after-tail2" 4 ("after-head" (7 6) ("after-tail" (2 3) ("after-tail2" 1 ("done")))))))
; (sreverse "top" () (tag . more))
(sreverse "after-tail" () (halt) ("after-tail2" 4 ("after-head" (7 6) ("after-tail" (2 3) ("after-tail2" 1 ("done"))))))
; (sreverse "after-tail" new-tail head kont)
(sreverse "top" (halt) ("after-head" () ("after-tail2" 4 ("after-head" (7 6) ("after-tail" (2 3) ("after-tail2" 1 ("done")))))))
;; Now if we use the following only additional (sreverse "top" (halt . tail) kont)
;; just return it as the quote.
(sreverse "top" (halt) ("after-head" () ("after-tail2" 4 ("after-head" (7 6) ("after-tail" (2 3) ("after-tail2" 1 ("done")))))))

(define-syntax sreverse
   (syntax-rules ()
     ((sreverse thing) (sreverse "top" thing ("done")))

     ((sreverse "top" () (tag . more))
      (sreverse tag () . more))

     ((sreverse "top" ((headcar . headcdr) . tail) kont)
      (sreverse "top" tail ("after-tail" (headcar . headcdr) kont)))

     ((sreverse "after-tail" new-tail head kont)
      (sreverse "top" head ("after-head" new-tail kont)))

     ((sreverse "after-head" () new-tail (tag . more))
      (sreverse tag new-tail . more))

     ((sreverse "after-head" new-head (new-tail ...) (tag . more))
      (sreverse tag (new-tail ... new-head) . more))

     ((sreverse "top" (halt . tail) kont)
      '(sreverse "top" (halt . tail) kont))

     ((sreverse "top" (head . tail) kont)
      (sreverse "top" tail ("after-tail2" head kont)))

     ((sreverse "after-tail2" () head (tag . more))
      (sreverse tag (head) . more))

     ((sreverse "after-tail2" (new-tail ...) head (tag . more))
      (sreverse tag (new-tail ... head) . more))

     ((sreverse "done" value)
      'value)))

(sreverse (1 (2 3) (4 (halt)) 6 7))
;; See txt link "literal" context
;; > Essentially, they will be treated as if they were *constants*
;; if not use halt as literal, then (sreverse "top" (halt . tail) kont) will match *before* (head . tail).
; (sreverse "top" (1 (2 3) (4 (halt)) 6 7) ("done"))
;; If used as literal, then only match "halt", so "(sreverse "top" (head . tail) kont)" will still be matched
; (sreverse "top" (halt) ("after-head" () ("after-tail2" 4 ("after-head" (7 6) ("after-tail" (2 3) ("after-tail2" 1 ("done")))))))

;; > The patterns are ordered from most-specific to     most-general to ensure that the later matches do not `shadow' the     earlier ones.
;; IMHO this shadow doesn't mean overwrite since "The template associated with the first matching pattern is the one used for the rewrite."
;; It just means the inner variable is normally more specific https://en.wikipedia.org/wiki/Variable_shadowing.

;; > then only if the macro user     hasn't shadowed it.
;; i.e. not use it for more specific usage?