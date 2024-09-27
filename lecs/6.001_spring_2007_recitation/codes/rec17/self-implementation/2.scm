(cd "~/SICP_SDF/lecs/6.001_spring_2007_recitation/codes/rec17")
(load "objsys.scm")
(load "objtypes.scm")
(load "setup.scm")

(load "self-implementation/exercise-lib.scm")

(setup 'foo)
(ask me 'look-around)
(ask me 'take (thing-named 'boil-spell))
;; > Demonstrate them working on some test cases.
(ask me 'HAS-A 'spell)
(ask me 'HAS-A-THING-NAMED 'slug-spell)
(ask me 'HAS-A-THING-NAMED 'boil-spell)
