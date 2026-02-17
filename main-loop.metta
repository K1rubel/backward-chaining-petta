!(import! &self ../backward-chaining/forward-chaining-pln)
!(import! &self ./lookup)
!(import! &self ./modus-ponens)
!(import! &self ./syllogisitic-deduction)
!(import! &self ./inversion)

;; Base case
(= (pln-bc $kb $goal Z $ev)
   (step-lookup $kb $goal))

(= (pln-bc $kb $goal (S $k) $ev)
   ;; Collect all results from all strategies
   (superpose 
      (
         (step-lookup $kb $goal)
         (modus-ponens $kb $goal (S $k) $ev)
         (syllo-deduction $kb $goal (S $k) $ev)
         (inversion $kb $goal (S $k) $ev)
      )))

; !(bind! &space (new-space))

; !(add-atom &space (a 12))
; !(add-atom &space (b 12))
; !(add-atom &space (c 13))
; !(add-atom &space (d 13))

; (= (getAtoms3 $kb) (match $kb ($x 13) $x))
; (= (getAtoms2 $kb) (match $kb ($x 12) $x))
; (= (getAtoms4 $kb) (match $kb ($x $X 23) $X))
; !(superpose ((getAtoms3 &space) (getAtoms2 &space) (getAtoms4 &space)))

;; Tesing modus-ponens

!(bind! &kb (new-space))

!(add-atom &kb (Sentence ((Implication dog bite) (stv 0.6 0.6)) (1)))
!(add-atom &kb (Sentence ((Implication cat bite) (stv 0.7 0.7)) (3)))

!(add-atom &kb (Sentence (dog (stv 0.7 0.98)) (32)))
!(add-atom &kb (Sentence (cat (stv 0.6 0.99)) (33)))
!(add-atom &kb (Sentence (animal (stv 0.7 0.7)) (3345)))

!(pln-bc &kb  bite (S  Z) ())
; ; !(pln-bc &kb dog Z ())
; !(match &kb ($_ (bite $stv) $v) ($_ (bite $stv) $v))

; !(add-atom &kb (Sentence ((Inheritance slippery fall) (stv 0.45 0.752))  (2)))         
; !(add-atom &kb (Sentence ((Inheritance rain slippery) (stv 0.7 0.8))  (545)))         
; !(add-atom &kb (Sentence (rain (stv 0.9 0.8)) (3)))               
; !(add-atom &kb (Sentence (slippery (stv 0.7 0.8)) (4)))               
; !(add-atom &kb (Sentence (fall (stv 0.5 0.3)) (5)))   

!(add-atom &kb (Sentence (animal (stv 0.6 0.7)) (1435)))
!(add-atom &kb (Sentence ((Inheritance animal cat) (stv 0.6 0.7)) (1)))

; !(pln-bc &kb (Inheritance cat animal) (S (S Z)) ())   

; !(pln-bc &kb (Inheritance rain fall) (S (S Z)) ())
