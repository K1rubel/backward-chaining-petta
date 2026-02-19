!(import! &self ./utilities/forward-chaining-pln)
!(import! &self ./utilities/helpers)
!(import! &self ./lookup)
!(import! &self ./modus-ponens)
!(import! &self ./syllogisitic-deduction)
!(import! &self ./inversion)
!(import! &self ./tests/game-data)
;; Base case
(= (pln-bc $kb $goal Z $ev)
   (step-lookup $kb $goal))

   
(= (pln-bc $kb $goal (S $k) $ev)
   ;; setup direct lookup for the goal sentence 
   (let $direct-lookup (collapse 
         (match $kb (Sentence ($goal $stv) $stamp) 
            (Sentence ($goal $stv) $stamp)))
         (if (!= $direct-lookup ())
               (superpose $direct-lookup) ;; to stay consistent with the logic below which is a superposition of all the possible 
               (superpose 
                     (
                        ; (step-lookup $kb $goal)
                        (modus-ponens $kb $goal (S $k) $ev)
                        (syllo-deduction $kb $goal (S $k) $ev)
                        (inversion $kb $goal (S $k) $ev)
                     )))))


;; I didnt see the use of a revision rule here since all the different paths that lead to the goal get collected in one stamp tuple, it's of no use the user
;; So instead it is better to just select the best out of the paths found so far                  
(= (bc-drive $kb $goal $stamp)
   (let $result 
         (collapse (let (Sentence ($goal ($stv $s $c)) $evidence) (pln-bc $kb $goal (S (S (S Z))) $stamp)
            (if (< $c 0.1)
               (empty)
               (Sentence ($goal ($stv $s $c)) $evidence))))
            (if (!= $result ())
               (let $sorted (sorT $result) (car-atom $sorted))
               (empty))))            
                              
;; Collect all results from all strategies   
;; testing direct lookup

!(bind! &kb (new-space))

; !(add-atom &kb (Sentence (rain (stv 0.5 0.8)) (12)))
; !(add-atom &kb (Sentence (rain (stv 0.5 0.8)) (12)))

; !(pln-bc &kb rain (S (S (S Z))) ())

; ;; Tesing modus-ponens

; !(bind! &kb (new-space))

!(add-atom &kb (Sentence ((Implication dog bite) (stv 0.6 0.6)) (1)))
!(add-atom &kb (Sentence ((Implication cat bite) (stv 0.7 0.7)) (3)))

!(add-atom &kb (Sentence (dog (stv 0.7 0.98)) (32)))
!(add-atom &kb (Sentence (cat (stv 0.6 0.99)) (33)))
; !(add-atom &kb (Sentence (animal (stv 0.7 0.7)) (3345)))

; !(pln-bc &kb  bite (S (S Z)) ())
; !(bc-drive &kb bite ())
; !(pln-bc &kb dog Z ())
; !(match &kb ($_ (bite $stv) $v) ($_ (bite $stv) $v))

; !(add-atom &kb (Sentence ((Inheritance slippery fall) (stv 0.45 0.752))  (2)))         
; !(add-atom &kb (Sentence ((Inheritance rain slippery) (stv 0.7 0.8))  (545)))         
; !(add-atom &kb (Sentence (rain (stv 0.9 0.8)) (3)))               
; !(add-atom &kb (Sentence (slippery (stv 0.7 0.8)) (4)))               
; !(add-atom &kb (Sentence (fall (stv 0.5 0.3)) (5)))   

; !(add-atom &kb (Sentence (animal (stv 0.6 0.7)) (1435)))
; !(add-atom &kb (Sentence ((Inheritance animal cat) (stv 0.6 0.7)) (1)))

; ; !(pln-bc &kb (Inheritance cat animal) (S (S Z)) ())   

; ; !(pln-bc &kb (Inheritance rain fall) (S (S Z)) ())

; ; !(match &self (Sentence ((Board (Row E (Col O X)) (Rows (Row E (Col X E)) (Row X (Col O E)))) $stv) $ev) $ev)
; ; !(pln-bc &self 
; ;       (Board (Row E (Col O X)) (Rows (Row E (Col X E)) (Row X (Col O E))))
; ;       Z ())
; !(pln-bc &self 
;       (GameWin X)
;       (S (S Z)) ())

; !(bc-drive &self 
;       (GameWin X)
;     ())

;; Testing inference via inversion -- 

; !(add-atom &kb (Sentence ((Inheritance tigers cats) (stv 0.6 0.78)) (1)))
; !(add-atom &kb (Sentence (cats (stv 0.63 0.832)) (12)))

; !(pln-bc &kb (Inheritance cats tigers) (S (S (S Z))) ())
; !(inversion &kb (Inheritance cats tigers) (S (S Z)) ())       
; !(bc-drive &kb (Inheritance cats tigers) ()) 

; !(revision 
; (
;    (Sentence ((GameWin X) (stv 0.09200000000000001 0.15003)) (557 130))

; (Sentence ((GameWin X) (stv 0.09200000000000001 0.15003)) (537 46))
; (Sentence ((GameWin X) (stv 0.027200000000000002 0.025010000999999997)) (534 46 536 46))
; (Sentence ((GameWin X) (stv 0.027200000000000002 0.025010000999999997)) (554 130 556 130))
; (Sentence ((GameWin X) (stv 0.09200000000000001 0.15003)) (573 250))
; (Sentence ((GameWin X) (stv 0.027200000000000002 0.025010000999999997)) (570 250 572 250))
; (Sentence ((GameWin X) (stv 0.09200000000000001 0.15003)) (597 406))
; (Sentence ((GameWin X) (stv 0.027200000000000002 0.025010000999999997)) (594 406 596 406))))

; !(stampDisjoint (StampDisjoint (537 46) (534 46 536 46)))

