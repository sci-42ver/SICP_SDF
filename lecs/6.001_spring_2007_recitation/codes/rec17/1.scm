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
;; person
(newline-show #[compound-procedure 17 handler])
;; container-part which has `things:       ()`
(newline-show #[compound-procedure 26 handler])

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 2
(newline-show #[compound-procedure 18 handler])
(newline-show #[compound-procedure 38 handler])

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 3
;; > about the values of the location variables in thing and mobile-thing.
;; IMHO it means what I take?

;; Emm... the random result has changed when run here.
(load "warmup-6.scm")
(newline-show me)
;; place
(newline-show #[compound-procedure 53 handler])
;; container-part
(newline-show #[compound-procedure 59 handler])
;; thing1 (spell) -> `name:         boil-spell`.
(newline-show #[compound-procedure 70 handler])
;; location -> #[compound-procedure 53 handler]
;; mobile-part
(newline-show #[compound-procedure 75 handler])
;; thing
(newline-show #[compound-procedure 83 handler])

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 4
;; > Does the value of the self variable ever change?
;; by seeing the code, this arg is just passed along. So same.

;; (avatar person mobile-thing thing named-object root container)
;; their self -> (instance #[compound-procedure 47 handler])
;; person
(newline-show #[compound-procedure 52 handler])
;; mobile-thing
(newline-show #[compound-procedure 96 handler])
;; container
(newline-show #[compound-procedure 97 handler])
;; thing
(newline-show #[compound-procedure 104 handler])
;; named-object 
(newline-show #[compound-procedure 116 handler])
;; root
(newline-show #[compound-procedure 121 handler])