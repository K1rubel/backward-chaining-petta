; !(import! &self ../backward-chaining/forward-chaining-pln)
(= (syllo-deduction $goal $kb (S $k) $ev)
    (let ($LinkType $A $C) $goal
            (match $kb (Sentence (($LinkType $B $C) $stv-bc) $ev-bc)
                (if (and (SyllogisticRuleGuard $LinkType)
                         (StampDisjoint $ev $ev-bc))
                        (let* (($next-ev (StampConcat $ev $ev-bc))
                                ($_ (println! (next ev $next-ev)))
                              ;; Recurse to prove the missing link A -> B
                                ((Sentence (($LinkType $A $B) $stv-ab) $ev-premise) (pln-bc $kb ($LinkType $A $B) $k $next-ev))
                                ; (Sentence ((Inheritance rain slippery) (stv 0.46 0.84)) (21231)))
                                ($stv-a (getNodeSTV $kb $A))
                                ($_ (println! (sstv aaa $stv-a)))
                                ($stv-b (getNodeSTV $kb $B)) 
                                ($_ (println! (sstv bbb $stv-b)))
                                ($stv-c (getNodeSTV $kb $C)) 
                                ($_ (println! (sstv ccc $stv-c)))
                                ($stv-goal (Truth_Deduction $stv-a $stv-b $stv-c $stv-ab $stv-bc))
                                ($_ (println! (stv goal ssstttvvv $stv-goal)))
                                ($evidence-list (StampConcat $next-ev $ev-premise))
                                ($_ (add-atom $kb (Sentence ($goal $stv-goal) $evidence-list))))
                                
                                (Sentence ($goal $stv-goal) $evidence-list)
                            )
                        (empty)))))                 

(= (getNodeSTV $kb $node)
   (let $res (collapse (match $kb (Sentence ($node $tv) $_) $tv))
      (if (== $res ())
          (stv 0.5 0.0) ;; Complete ignorance default
          (car-atom $res))))                        

; !(bind! &kb (new-space))
; !(add-atom &kb (Sentence ((Inheritance rain fall) (stv 0.4 0.52))  (1)))                        
; !(add-atom &kb (Sentence ((Inheritance rain fall) (stv 0.4 0.52))  (1)))                        
; !(add-atom &kb (Sentence ((Inheritance slippery fall) (stv 0.45 0.752))  (2)))         
; !(add-atom &kb (Sentence (rain (stv 0.9 0.8)) (3)))               
; !(add-atom &kb (Sentence (slippery (stv 0.7 0.8)) (4)))               
; !(add-atom &kb (Sentence (fall (stv 0.6 0.6)) (5)))               


; !(syllo-deduction (Inheritance rain fall) &kb (S (S Z)) ())
; !(match &kb (Sentence ((Inheritance $x $y) $stv) $ev) (Sentence ((Inheritance $x $y) $stv) $ev))