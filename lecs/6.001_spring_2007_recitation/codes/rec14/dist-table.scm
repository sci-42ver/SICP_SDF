(load "tree-ops.scm")

(define (make-symmetric! table)
  (let ((newtable (tree-map identity table)))
    (define (inner rows)
      (if (null? rows)
          newtable
          (begin (add-back! (car rows))
                 (inner (cdr rows)))))
    ;; forward is one row.
    (define (add-back! forward) ; done by add-assoc!
      (let ((from (car forward)))
        (define (inner todists)
          (if (null? todists)
              #t
              (let ((to (caar todists))
                    (dist (cadar todists)))
                (add-assoc! to from dist)
                (inner (cdr todists)))))
        (inner (cdr forward))))
    (define (add-assoc! from to dist)
      (let ((row (assq from newtable)))
        (if row
            (set-cdr! row
                      (cons (list to dist) (cdr row)))
            (set! newtable
                  (cons 
                   (list from
                         (list to dist))
                   newtable)))))
    (inner table)))