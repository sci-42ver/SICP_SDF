(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

;; b
(rule (meeting-time ?person ?day-and-time)
      ;; IMHO ot first is better.
      (or (meeting whole-company ?day-and-time)
        (and (job ?person (?division . ?rest))
          (meeting ?division ?day-and-time)
          )))

;; lacks "what meetings"
;; Also see alan's.
(... (Wednesday . ?hour))
