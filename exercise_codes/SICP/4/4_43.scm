; (define fathers '(Moore Downing Hall Sir-Barnacle Parker))
; (define daughters '(Gabrielle Lorna Rosalind Melissa Mary-Ann))
; (define minimal-father-daughter-relation '((Sir-Barnacle Melissa)))
; (define father-daughter-relation (append minimal-father-daughter-relation '((Moore Mary-Ann))))

(cd "~/SICP_SDF/exercise_codes/SICP/4")
(load "amb-lib.scm")
(driver-loop)

;; always add this
(define (require p)
  (if (not p) (amb)))

(define (all-possible-daughters)
  (amb 'Gabrielle 'Lorna 'Rosalind 'Melissa 'Mary-Ann))
;; No Parker's yacht
;; But Gabrielle's father can't be Parker, so that's fine.
(define father-yacht-relation '((Moore Lorna) (Hall Rosalind) (Sir-Barnacle Gabrielle) (Downing Melissa)))
;; i.e. ((lorna moore) (rosalind hall) (gabrielle sir-barnacle) (melissa downing) (mary-ann parker)) with reversed pairs and additional implicit (mary-ann parker).

;; > Gabrielle's father owns the yacht that is named after Dr. Parker's daughter.
;; means Gabrielle's father is not Parker.
;;; Similar to wiki xdavidliu's but the latter 
;; 1. all use require to choose daughter including "(Sir-Barnacle-daughter 'Melissa)".
;; 2. uses memq for each restriction which is more elegant and also avoids the renaming error when paste.
;;; Here we have require for (requirements):
;; 1. no duplicate daughters in 5 pairs.
;; 2. > named his yacht after a daughter of one of the *others*
;; 3. > Gabrielle's father owns the yacht that is named after Dr. Parker's daughter.
(define (get-father-daughter-relation)
  (let ((Sir-Barnacle-daughter 'Melissa))
    (let ((Moore-daughter (all-possible-daughters)))
      ; (require (eq? Moore-daughter 'Mary-Ann))
      ;; > if we are not told that Mary Ann's last name is Moore.
      (require (not (memq Moore-daughter (list 'Lorna Sir-Barnacle-daughter))))
      (let ((Hall-daughter (all-possible-daughters)))
        (require (not (memq Hall-daughter (list 'Rosalind Sir-Barnacle-daughter Moore-daughter))))
        (let ((Downing-daughter (all-possible-daughters)))
          (require (not (memq Downing-daughter (list 'Melissa Sir-Barnacle-daughter Moore-daughter Hall-daughter))))
          ; (let ((Parker-daughter (all-possible-daughters)))
          ;   (require (not (eq? Parker-daughter 'Gabrielle)))
          ;   )
          ;; ensure "Gabrielle-father" can be found.
          ;; Here ** and * can be combined as xdavidliu modification does. But IMHO as notes say, xdavidliu's original version is better with less redundant checkings.
          (require (memq 'Gabrielle (list Moore-daughter Hall-daughter Downing-daughter))) ;*
          (let ((Gabrielle-father 
                  (cadr (assq 'Gabrielle
                              (list 
                                (list Sir-Barnacle-daughter 'Sir-Barnacle)
                                (list Moore-daughter 'Moore)
                                (list Hall-daughter 'Hall)
                                (list Downing-daughter 'Downing)
                                )))))
            (let ((Parker-daughter (cadr (assq Gabrielle-father father-yacht-relation))))
              ;; 0. correction added based on wiki SteeleDynamics's.
              ;; 0.a. better to add mar as xdavidliu does.
              ; (require (not (memq Parker-daughter (list Sir-Barnacle-daughter Moore-daughter Hall-daughter Downing-daughter)))) ;**
              (require (not (memq Parker-daughter (list 'Mary-Ann Sir-Barnacle-daughter Moore-daughter Hall-daughter Downing-daughter))))
              ; (list Moore-daughter Downing-daughter Hall-daughter Sir-Barnacle-daughter Parker-daughter)
              ;; same as wiki SteeleDynamics's to help viewing and checking.
              (list 
                (list Moore-daughter 'Moore) 
                (list Downing-daughter 'Downing) 
                (list Hall-daughter 'Hall) 
                (list Sir-Barnacle-daughter 'Sir-Barnacle)
                (list Parker-daughter 'Parker))
              )
            )
          )
        )))
  )

(get-father-daughter-relation)
;; with complete conditions
; (mary-ann lorna gabrielle melissa rosalind)

;; > if we are not told that Mary Ann's last name is Moore.
; ((gabrielle moore) (rosalind downing) (mary-ann hall) (melissa sir-barnacle) (lorna parker))
try-again
try-again
; try-again
; ;;; Amb-Eval value:
; ((mary-ann moore) (lorna downing) (gabrielle hall) (melissa sir-barnacle) (rosalind parker))

; ;;; Amb-Eval input:
; try-again
; ;;; There are no more values of

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; error1
; ;;; Amb-Eval value:
; (gabrielle mary-ann lorna melissa lorna)
;; or with the detailed output
; ((gabrielle moore) (rosalind downing) (lorna hall) (melissa sir-barnacle) (lorna parker))
;; This has duplicate lorna if not with the above correction.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; post-checking
; ((gabrielle moore) (mary-ann downing) (rosalind hall) (melissa sir-barnacle) (lorna parker))
;; compare it with father-yacht-relation with reversed pairs to ensure "named his yacht after a daughter of one of *the others*"
; ((lorna moore) (rosalind hall) (gabrielle sir-barnacle) (melissa downing) (mary-ann parker))
;; But here (rosalind hall) is the duplicate due to the above renaming error.

;; If so, then ensure (melissa sir-barnacle) dauther-father relation is met.
;; Then (gabrielle moore) -(lorna moore)> lorna -(lorna parker)> parker.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; xdavidliu's
(define (yacht)
  (define gab 'gabrielle)
  (define lor 'lorna)
  (define ros 'rosalind)
  (define mel 'melissa)
  (define mar 'mary-ann)
  (let ((barnacle (amb gab lor ros mel mar)))
    (require (eq? barnacle mel))
    (let ((moore (amb gab lor ros mel mar)))
      (require (eq? moore mar))    
      (let ((hall (amb gab lor ros mel mar)))
        (require (not (memq hall (list barnacle moore ros)))) 
        (let ((downing (amb gab lor ros mel mar)))
          (require (not (memq downing (list barnacle moore hall mel))))
          (let ((parker (amb gab lor ros mel mar)))
            (require (not (memq parker
                                (list barnacle moore hall downing mar)
                                ;; modified
                                ; (list barnacle moore hall downing gab)
                                )))
            ;; father->yacht
            (let ((yacht-names
                    (list (list barnacle gab)
                          (list moore lor)
                          (list hall ros)
                          (list downing mel)
                          (list parker mar))))
              ;; (cadr (assq gab yacht-names)) gets gab's father's yacht.
              (require (eq? parker (cadr (assq gab yacht-names))))
              (list (list 'barnacle barnacle)
                    (list 'moore moore)
                    (list 'hall hall)
                    (list 'downing downing)
                    (list 'parker parker)))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SteeleDynamics
(define (distinct? items) 
  (cond ((null? items) true) 
        ((null? (cdr items)) true) 
        ((member (car items) (cdr items)) false) 
        (else (distinct? (cdr items)))))
(define (daughters2)
  ;; candidate fathers
  (let ((gabrielle (amb 'downing 'hall 'moore 'parker)) 
        (lorna (amb 'downing 'hall 'hood 'parker))
        (mary (amb 'downing 'hall 'moore 'hood))
        (melissa 'hood) 
        (rosalind (amb 'downing 'hood 'moore 'parker))
        ) 
    ;; returns the father of the daughter named same as father's yacht.
    (define (yacht-of father) 
      (cond ((eq? father 'downing) melissa) 
            ((eq? father 'hall) rosalind) 
            ((eq? father 'hood) gabrielle) 
            ((eq? father 'moore) lorna) 
            (else mary))) 
    (require (eq? 'parker (yacht-of gabrielle)))

    (require (distinct? (list gabrielle lorna mary melissa rosalind))) 
    (list (list 'gabrielle gabrielle) 
          (list 'lorna lorna) 
          (list 'mary mary) 
          (list 'melissa melissa) 
          (list 'rosalind rosalind))))
(daughters2)
try-again
try-again
try-again

; ;;; Amb-Eval input:
; (daughters2)
; ;;; Starting a new problem 
; ;;; Amb-Eval value:
; ((gabrielle hall) (lorna downing) (mary moore) (melissa hood) (rosalind parker))

; ;;; Amb-Eval input:
; try-again
; ;;; Amb-Eval value:
; ((gabrielle moore) (lorna parker) (mary hall) (melissa hood) (rosalind downing))

; ;;; Amb-Eval input:
; try-again
; ;;; There are no more values of
; (daughters2)
