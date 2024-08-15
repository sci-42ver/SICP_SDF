;; a
(define (get-record employee-name personnel-file)
  ((get 'get-record-variant (division personnel-file)) employee-name personnel-file))
(define (make-personnel-file division file)
  (cons division file))

;; b
(define (get-salary employee-name personnel-file)
  (let ((employee-record (get-record employee-name personnel-file)))
    ((get 'get-info-variant (key employee-record)) 'salary employee-record)))
;; Here I assume key uniquely decides the extraction procedure.
;; See wiki we better use division as the type which can be inserted when get-record.
(define (make-record key . infos)
  (cons key infos))

;; c
(define (find-employee-record employee-name division-files)
  ;; See repo better use filter and map.
  (cond 
    ((null? division-files) #f)
    ;; same as palatin's.
    (else
      (or (get-record employee-name (car division-files)) 
          (find-employee-record employee-name (cdr division-files))))))

;; d if using one old division structure, then just do as what it did formerly.
;; otherwise use put to add related procedures.