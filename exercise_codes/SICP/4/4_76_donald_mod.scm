(cd "~/SICP_SDF/exercise_codes/SICP/book-codes")
(load "ch4-query.scm")

(define (second-conjunct exps) (cadr exps))
(define (dependent? exp1 exp2)
  (or (eq? (type exp2) 'not) ; as one demo, only consider not filter.
    ;; var created by make-new-variable or query-syntax-process
    (not 
      (null? 
        (filter-map 
          (lambda (op) 
            (and (var? op) (member op exp2)))
          exp1
          )))
    ))

(define (new-conjoin conjuncts frame-stream) 
  (if (empty-conjunction? conjuncts) 
      frame-stream
      ;; mod
      (let ((first (first-conjunct conjuncts))
            (second (second-conjunct conjuncts)))
        (if (dependent? first second)
          (new-conjoin (rest-conjuncts conjuncts) 
                      (qeval first))
          (merge-delayed (qeval first
                      frame-stream) 
              ;; must delay it since first-conjunct may return the-empty-stream, then we can exit earlier.
              (delay (new-conjoin (rest-conjuncts conjuncts) 
                            frame-stream)))))
      ))
(define (merge s1 s2)
  ;; will short circuit when s1 is null.
  (cond ((or (stream-null? s1) (stream-null? s2)) the-empty-stream) ; mod
        (else
          ;; Here implies interleave, so no need for writing one new wrapper as nopnopnoop does.
          (stream-flatmap (lambda (frame1) 
                            (stream-flatmap (lambda (frame2) 
                                              (merge-frame frame1 frame2)) 
                                            s2)) 
                          s1))))
(define (merge-frame f1 f2) 
  (if (null? f1) 
      (singleton-stream f2) 
      (let ((b1 (car f1))) 
        (let ((b2 (assoc (car b1) f2))) 
          (if b2 
              (if (equal? (cdr b1) (cdr b2)) 
                  (merge-frame (cdr f1) f2) 
                  the-empty-stream) 
              (merge-frame (cdr f1) (cons b1 f2))))))) 

(put 'and 'qeval conjoin)

(query-driver-loop)

;; test from book
(and (job ?person (computer programmer))
     (address ?person ?where))
; (and (job (fect cy d) (computer programmer)) (address (fect cy d) (cambridge (ames street) 3)))
; (and (job (hacker alyssa p) (computer programmer)) (address (hacker alyssa p) (cambridge (mass ave) 78)))

;; test from poly
(and (append-to-form (1 2) (3 4) ?x) 
    (append-to-form (1) ?y ?x))
; (and (append-to-form (1 2) (3 4) (1 2 3 4)) (append-to-form (1) (2 3 4) (1 2 3 4)))

;; test same var
(assert! (rule (reverse () ())))
(assert! (rule (reverse (?x . ?y) ?z) 
          (and (reverse ?y ?v) 
                (append-to-form ?v (?x) ?z))))
;; infinite loop since (append-to-form ?v (?x) ?z) must use ?v from the former.
;; If not, then (append-to-form ?v (?x) ?z) will have ?v and ?z unknown, so infinite cases (Just think it with maths).
;; Otherwise, only ?z is unknown based on induction which can be decided by the former 2.
(reverse (1 2 3) ?x)
; (reverse (1 2 3) (3 2 1))

;; test not
(and (supervisor ?x (Bitdiddle Ben))
     (not (job ?x (computer programmer))))
; (and (supervisor (tweakit lem e) (bitdiddle ben)) (not (job (tweakit lem e) (computer programmer))))