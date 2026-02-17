(= (inversion $kb $goal (S $k) $ev)
    (let (Inheritance $A $B) $goal
      (match $kb (Sentence ((Inheritance $B $A) $stv-inverse) $ev-inverse) 
            (if (StampDisjoint $ev $ev-inverse)
                  (let* (($stv-a (getNodeSTV $kb $A))
                        ($tv-goal (Truth_inversion $stv-a $stv-inverse))
                        ($ev-final (StampConcat $ev $ev-inverse))
                        ($_ (add-atom $kb (Sentence ($goal $tv-goal) $ev-final))))
            
                        (Sentence ($goal $tv-goal) $ev-final))
                  (empty)))))

;; Testing inversion rules
; !(bind! &kb (new-space))
; !(add-atom &kb (Sentence ((Inheritance animal cat) (stv 0.6 0.7)) (1)))

; !(add-atom &kb (Sentence (cat (stv 0.7 0.8)) (2)))


; !(inversion &kb (Inheritance cat animal) (S (S Z)) ())            
; !(inversion &kb (Inheritance cat animal) (S (S Z)) ())            