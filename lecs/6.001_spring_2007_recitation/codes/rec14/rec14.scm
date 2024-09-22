;; https://web.archive.org/web/20071221030700/https://people.csail.mit.edu/psz/6001/search.html
(define distances
  '((Boston (New-York 215) (Chicago 976))
    (New-York (Pittsburgh 376) (Washington 236) (Chicago 818))
    (Washington (Atlanta 641) (Nashville 708) (Chicago 696)
                (Orlando 686) (Pittsburgh 231))
    (Orlando (Miami 201) (Atlanta 461) (New-Orleans 634))
    (Atlanta (Chicago 715) (New-Orleans 518) (Nashville 250))
    (New-Orleans (Dallas 495) (Phoenix 1553) (Denver 1292))
    (Nashville (New-Orleans 549) (Chicago 442) (Dallas 706) (Denver 1205) (Chicago 442))
    (Dallas (Phoenix 1015) (Denver 797))
    (Denver (Salt-Lake-City 497) (Phoenix 904))
    (Chicago (Dallas 936) (Denver 1017))
    (Phoenix (Los-Angeles 379) (San-Francisco 806) (Salt-Lake-City 646))
    (Salt-Lake-City (San-Francisco 730) (Seattle 924) (Los-Angeles 704))
    (San-Francisco (Los-Angeles 377) (Seattle 786))
    (Pittsburgh (Chicago 468))))

(define (make-search-state where path traveled)
  (list where path traveled))
(define where car)
(define path cadr)
(define cost caddr)

(define (next-states state)
  (let* ((here (where state))
         (places-to-go (assq here distances)))
    (newline)
    (display state)
    (map (lambda (destination)
           (make-search-state (car destination)
                              (cons here
                                    (path state))
                              (+ (cadr destination) 
                                 (cost state))))
         (if places-to-go
             (cdr places-to-go)
             '())))) 

(define (search start-state done? successors merge)
  (define (inner queue)
    (and (not (null? queue))
         (let ((current (car queue)))
           (if (done? current)
               current
               (inner (merge (successors current)
                             (cdr queue)))))))
  ; (trace inner)
  ; (trace merge)
  (inner (list start-state)))

(define (depth-first-search start-state done? successors)
  (search start-state done? successors append)) 

(define (breadth-first-search start-state done? successors)
  (search start-state done? successors 
          (lambda (new old) (append old new))))

(define (best-first-search start-state done? successors better?)
  ;; The successors predicate MUST produce a list ordered by better?
  (define (priority-merge new old)
    (cond ((and (null? new) (null? old)) '())
          ((null? new) old)
          ((null? old) new)
          ((better? (car new) (car old))
           (cons (car new) (priority-merge (cdr new) old)))
          (else 
           (cons (car old) (priority-merge new (cdr old))))))
  (search start-state done? successors priority-merge))

(depth-first-search (make-search-state 'Boston '() 0) 
                    (lambda (state)
                      (eq? (where state) 'Los-Angeles))
                    next-states)

;; added
(define (shorter? state1 state2)
  (< (cost state1) (cost state2)))
(best-first-search (make-search-state 'Boston '() 0)
                    (lambda (state)
                      (eq? (where state) 'Los-Angeles))
                    ;; See comment of best-first-search
                    (lambda (state) (sort (next-states state) shorter?))
                    shorter?)

;; > Breadth and best-first searches also explored this useless path, but because both prefer shorter paths (in either steps or distance), they eventually find a solution better than the infinite path back and forth.
(load "dist-table.scm")
(define symmetric-distances (make-symmetric! distances))
(define (next-states state distances)
  (let* ((here (where state))
         (places-to-go (assq here distances)))
    (newline)
    (display state)
    (map (lambda (destination)
           (make-search-state (car destination)
                              (cons here
                                    (path state))
                              (+ (cadr destination) 
                                 (cost state))))
         (if places-to-go
             (cdr places-to-go)
             '()))))
; (best-first-search (make-search-state 'Boston '() 0)
;                     (lambda (state)
;                       (eq? (where state) 'Los-Angeles))
;                     ;; See comment of best-first-search
;                     (lambda (state) (sort (next-states state symmetric-distances) shorter?))
;                     shorter?)

(breadth-first-search (make-search-state 'Boston '() 0)
                        (lambda (state)
                          (eq? (where state) 'Los-Angeles))
                        (lambda (state) (next-states state symmetric-distances)))