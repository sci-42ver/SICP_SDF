;; Use `sed -i -f ~/SICP_SDF/lecs/6.001_spring_2007_recitation/codes/rec13/format.sed *.scm;for i in $(find . -name "*.scm"); do vim -c "execute 'normal gg=G' | update | quitall" $i;done` to format.
(cd "~/SICP_SDF/lecs/6.001_spring_2007_recitation/codes/rec17")
(load "objsys.scm")
(load "objtypes.scm")
(load "setup.scm")

(setup 'your-name)
(show me)
(define (newline-show obj)
  (newline)
  (show obj))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 1
;; person-part
(newline-show #@18)
;; container-part which has `things:       ()`
;; See sample-implementation.scm, here we should get person-part -> ... -> thing part
; (newline-show #[compound-procedure 26 handler])
(newline-show #@26)
(newline-show #@34)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 2
;; birthplace of avatar -> person
(newline-show #@19)
(newline-show #@46)

; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 3
;; > about the values of the location variables in thing and mobile-thing.
;; IMHO it means what I take?
;; sample-implementation.scm thinks thing as avatar.
;; > after moving from the birthplace of the avatar, ...
;; IMHO this is more appropriate.
(ask (ask me 'location) 'name)
(ask me 'look-around)
(ask me 'go 'up)

;; same as 1
;; Here only the 2nd have #@55 for location others have #@19 for birthplace/location.
(newline-show #@18)
;; 'CHANGE-LOCATION is only done in mobile-thing which is called by avatar due to order.
(newline-show #@26)
(newline-show #@34)

; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 4
;; > Does the value of the self variable ever change?
;; by seeing the code, this arg is just passed along. So same.

;; (avatar person mobile-thing thing named-object root container)
;; their self -> #@13 (see the first `(show me)`)
;; person
(newline-show #@18)
;; mobile-thing
(newline-show #@26)
;; container
(newline-show #@27)
;; thing from mobile-thing
(newline-show #@34)
;; named-object 
(newline-show #@40)
;; root
(newline-show #@66)