(cd "~/SICP_SDF/exercise_codes/SICP")
(load "lib.scm")

(cd "~/SICP_SDF/lecs/6.001_spring_2007_recitation/codes/rec17")
(load "objsys.scm")
(load "objtypes.scm")
(load "setup.scm")

(setup 'foo)
(ask (ask me 'location) 'name)
(ask me 'look-around)

(ask screen 'DEITY-MODE #f)
; (ask me 'go 'west)
(ask me 'go 'north)
(ask me 'look-around)
;; > Walk the avatar to a room that has an unowned object.
(ask me 'take (thing-named 'boil-spell))
;; > only to drop it somewhere else.
(ask me 'go 'north)
(ask me 'drop (thing-named 'boil-spell))

;; > Show a transcript of this session
;; just run `scheme --interactive --eval '(load "warmup-6.scm")'`.