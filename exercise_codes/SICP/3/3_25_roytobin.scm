; #! /bin/s9

; Exercise 3.25 SICP 1st & 2nd Ed
; Generalizing one- and two-dimensional tables, show how to implement a table
; in which values are stored under an arbitrary number of keys and different val-
; ues may be stored under different numbers of keys.  The lookup and insert!
; procedures should take as input a list of keys used to access the table.
;
(define (make-table)
    ; I choose to return #f in the case of a failed lookup.  FYI, SICP 1st
    ; Edition examples return nil.  I note that regardless of the sentinel chosen
    ; for the unsuccessful lookup case, it follows that the sentinel can not then be
    ; stored in the table as an actual datum, for it will be indistinguishable from
    ; a failed lookup.
    ;
    ;(define st-uninitialized '()) ; another not unreasonable choice besides '() is #f
    (define st-uninitialized #f) ; another not unreasonable choice besides '() is #f
    (define (st-beget key) (list key st-uninitialized))

  (let ((root-table (st-beget '*table*)))

    ; st- (SubTree) is the prefix (name space) for local helper procedures.
    (define (st-value-of st)         (cadr st))
    (define (st-findkey st key)      (assoc key (cddr st)))
    (define (st-set-value! st value) (set-car! (cdr st) value) value)
    (define (st-add-subtree st subor)
	(set-cdr! (cdr st) (cons subor (cddr st)))
	subor
    )
    ; Return the subordinate (child) subtree matching the given key.
    ; Otherwise beget a new subtree object, graft it in, and return it.
    ;
    (define (st-branch st key)
      (let ((record (st-findkey st key)))
	  (if record
	      record
	      (st-add-subtree st (st-beget key))))
    )
    (define (st-insert st klist value)
	(if (null? klist)
	    (st-set-value! st value)
	    (st-insert (st-branch st (car klist))  (cdr klist)  value))
    )
    (define (st-lookup st klist)
	(if (null? klist)
	    (st-value-of st)
	    (let ((record (st-findkey st (car klist))))
		(if (not record)
		    st-uninitialized
		    (st-lookup record (cdr klist)))))
    )
    (define (insert klist value) (st-insert root-table klist value))
    (define (lookup klist)       (st-lookup root-table klist))
    (define (dispatch m)
        (cond ((eq? m 'lookup) lookup)
	      ((eq? m 'insert) insert)
	      (else (error "Unknown request -- NTABLE" m)))
    )
    dispatch))
(define (insert! nt klist val) ((nt 'insert) klist val))
(define (lookup  nt klist)     ((nt 'lookup) klist))