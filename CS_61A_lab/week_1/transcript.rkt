#lang racket
(require mzlib/transcr) ; https://lists.racket-lang.org/users/archive/2008-June/025117.html
(transcript-on "lab1")
 ; This starts the transcript file.
; (load "pigl.scm")
(require "./pigl_file.rkt")
 ; This reads in the file you created earlier.
(pigl 'scheme)
 ; Try out your program.

(require racket/trace)
; Feel free to try more test cases here!
(trace pigl) ; failure https://github.com/racket/racket/issues/4330#issuecomment-1172973091
 ; This is a debugging aid. Watch what happens
(pigl 'scheme)
 ; when you run a traced procedure.
(transcript-off)
(exit)