;;;;;;;;;;;;;;;;;; Debug floating precision problem. See 1_24_debug.scm
;; (trace fast-prime?)
; (fast-prime? 10000000019. 1)
#|
1 ]=> (fast-prime? 10000000019. 1)
[Entering #[compound-procedure 44 fast-prime?]
          Args: 10000000019.
          1]
[Entering #[compound-procedure 45 try-it]
          Args: 7777182819]
[#f
 <== #[compound-procedure 45 try-it]
 Args: 7777182819]
[#f
 <== #[compound-procedure 44 fast-prime?]
 Args: 10000000019.
 1]
;Value: #f

But https://www.dcode.fr/modular-exponentiation shows 7777182819^10000000019 mod 10000000019 = 7777182819
|#
; (fast-prime? 10000000019 1)

(define (try-it a n)
  (define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder (square (expmod base (/ exp 2) m))
                      m))
          (else
            (remainder (* base (expmod base (- exp 1) m))
                       m))))
  ; (newline)
  ; (display "try ")
  ; (display a)
  (trace expmod)
  (= (expmod a n n) a))
(try-it 7777182819 10000000019)
#|
[1
 <== #[compound-procedure 81 expmod]
 Args: 7777182819
 0
 10000000019]
[7777182819
 <== #[compound-procedure 81 expmod]
 Args: 7777182819
 1
 10000000019]
[5228099049
 <== #[compound-procedure 81 expmod]
 Args: 7777182819
 2
 10000000019]
[4221967142
 <== #[compound-procedure 81 expmod]
 Args: 7777182819
 4
 10000000019]
[4260135795
 <== #[compound-procedure 81 expmod]
 Args: 7777182819
 8
 10000000019]
[8530381909
 <== #[compound-procedure 81 expmod]
 Args: 7777182819
 9
 10000000019]
[5136395078
 <== #[compound-procedure 81 expmod]
 Args: 7777182819                                                                                                                                                                         
 18
 10000000019]
[7175772838
 <== #[compound-procedure 81 expmod]
 Args: 7777182819
 36
 10000000019]
|#
; Here floating will has error accumulated
(try-it 7777182819 10000000019.)
#|
[1
 <== #[compound-procedure 82 expmod]
 Args: 7777182819
 0.
 10000000019.]
[7777182819.
 <== #[compound-procedure 82 expmod]
 Args: 7777182819
 1.
 10000000019.]
[5228099488.
 <== #[compound-procedure 82 expmod]
 Args: 7777182819
 2.
 10000000019.]
[4493115140.
 <== #[compound-procedure 82 expmod]
 Args: 7777182819
 4.
 10000000019.]
[2939862754.
 <== #[compound-procedure 82 expmod]
 Args: 7777182819
 8.
 10000000019.]
[7185510121.
 <== #[compound-procedure 82 expmod]
 Args: 7777182819
 9.
 10000000019.]
[893483080.
 <== #[compound-procedure 82 expmod]
 Args: 7777182819                                                                                                                                                                         
 18.
 10000000019.]
[2729493517.
 <== #[compound-procedure 82 expmod]
 Args: 7777182819
 36.
 10000000019.]
|#

(* 7777182819. 7777182819)
(* 7777182819 7777182819)
#|
(* 7777182819. 7777182819)
;Value: 6.048457260014879e19

1 ]=> (* 7777182819 7777182819)
;Value: 60484572600148786761
|#


(try-it 15113154690916739054 100000000000000000000)
