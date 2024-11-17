;; [LISTOF X] -> ( -> X u 'you-fell-off-the-end)
(define (generate-one-element-at-a-time lst)
  ;; Both internal functions are closures over lst

  ;; Internal variable/Function which passes the current element in a list
  ;; to its return argument (which is a continuation), or passes an end-of-list marker 
  ;; if no more elements are left. On each step the function name is 
  ;; rebound to a continuation which points back into the function body,
  ;; while return is rebound to whatever continuation the caller specifies.
  (define (control-state return)
    (for-each 
      (lambda (element)
        ;; IGNORE: IMHO this return is just local, 
        ;; this version (call-with-current-continuation resume-here1)
        ;; will does (set! return cont2) where cont2 is the location before (call-with-current-continuation resume-here1).
        ;; Then we do next (... (return element2))))).
        (set! return (call-with-current-continuation
                       (lambda (resume-here)
                         ;; Grab the current continuation
                         (set! control-state resume-here)
                         (return element)))) ;; (return element) evaluates to next return
        ;; this version (call-with-current-continuation resume-here1)
        ;; just does (lambda (element) cont2) and then use the *old* return. (see call-cc-complex.scm for possible problems with this)
        ;; This works for the original wikipedia version since return doesn't change...
        ;; Use manual different returns to see the difference.
        ; (call-with-current-continuation
        ;                (lambda (resume-here)
        ;                  ;; Grab the current continuation
        ;                  (set! control-state resume-here)
        ;                  (return element)))
        )
      lst)
    (return 'you-fell-off-the-end))

  ;; (-> X u 'you-fell-off-the-end)
  ;; This is the actual generator, producing one item from a-list at a time.
  (define (generator)
    (call-with-current-continuation control-state))
  ; (define (generator)
  ;   (map 
  ;     ;; Here the 1st (return element) gets to the "idx-1" corresponding loc.
  ;     ;; Then (call-with-current-continuation resume-here1) use the old return stored in env to again back to "idx-1".
  ;     ;; So infinite loop.
  ;     (lambda (idx) (display idx) (call-with-current-continuation control-state))
  ;     '("idx-1" "idx-2")))

  ;; Return the generator 
  generator)

(define generate-digit
  (generate-one-element-at-a-time '(0 1 2)))

(generate-digit) ;; 0
;;; The following 1st means the above (generate-digit) outputing 0.
;; Here resume-here seems to just operate the next element instead of doing the 1st (set! control-state resume-here).
;; > The continuation represents an entire (default) *future* for the computation.
;; So here since we have finished the 1st call/cc, then the future is just the 2nd call/cc and later.
;; In a nutshell, here
;; (call-with-current-continuation control-state*) (* means modified before)
;; -> (call-with-current-continuation ... (return element2))) (i.e. control-state* location)
;;; IGNORE the above if feeling lengthy and unhelpful. See https://stackoverflow.com/a/13338881/21294350 where ";  ^---------------cont1" can give one straightforward way for what is done here.
(generate-digit) ;; 1
(generate-digit) ;; 2
(generate-digit) ;; you-fell-off-the-end
