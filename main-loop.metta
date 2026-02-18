!(import! &self ./utilities/forward-chaining-pln)
!(import! &self ./utilities/helpers)
!(import! &self ./lookup)
!(import! &self ./modus-ponens)
!(import! &self ./syllogisitic-deduction)
!(import! &self ./inversion)
; !(import! &self ./tests/game-data)
;; Base case
(= (pln-bc $kb $goal Z $ev)
   (step-lookup $kb $goal))

   
(= (pln-bc $kb $goal (S $k) $ev)
   ;; setup direct lookup for the goal sentence 
   (match $kb (Sentence ($g $stv) $stamp) 
               (if (= $g $goal)
                  (Sentence ($goal $stv) $stamp)
                  (superpose 
                     (
                        ; (step-lookup $kb $goal)
                        (modus-ponens $kb $goal (S $k) $ev)
                        (syllo-deduction $kb $goal (S $k) $ev)
                        (inversion $kb $goal (S $k) $ev)
                     )))))

(= (bc-drive $kb $goal $stamp)
   (let $result 
         (collapse (pln-bc $kb $goal (S (S (S Z))) $stamp))
         (if (!= $result ())
            (revision $result)
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
; ; !(pln-bc &self 
; ;       (GameWin X)
; ;       (S (S Z)) ())


;; Testing inference via inversion -- 

!(add-atom &kb (Sentence ((Inheritance tigers cats) (stv 0.6 0.78)) (1)))
!(add-atom &kb (Sentence (cats (stv 0.63 0.832)) (12)))

; !(pln-bc &kb (Inheritance cats tigers) (S (S (S Z))) ())
; !(inversion &kb (Inheritance cats tigers) (S (S Z)) ())       
; !(bc-drive &kb (Inheritance cats tigers) ()) 