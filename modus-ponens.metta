(= (modus-ponens $kb $goal (S $k) $ev)
   ;; 1. Find all matching Rules
   (match $kb (Sentence ((Implication $premise $goal) $stv) $goal-ev)
      (if (StampDisjoint $ev $goal-ev)
          (let* (($next-ev (StampConcat $ev $goal-ev))
               ;   ($_ (println! (in modus ponens next evidence stamp $next-ev and $k and the premise $premise)))
                 ((Sentence ($premise $stv-premise) $premise-ev) (pln-bc $kb $premise $k $_))
               ;   ($_ (println! (out the recursion)))
                 ($combined-stv (Truth_ModusPonens $stv $stv-premise))
                 ($evidence-list (StampConcat $premise-ev $next-ev))
                 ($_ (add-atom $kb (Sentence ($goal $combined-stv) $evidence-list))))
                
                (Sentence
                   ($goal $combined-stv) $evidence-list))
         (empty))))

;; Testing modus-ponens

; !(bind! &kb ())

; !(add-atom &kb (Sentence ((Implication dog bite) (stv 0.6 0.6)) (1)))
; !(add-atom &kb (Sentence ((Implication cat bite) (stv 0.7 0.7)) (3)))

; !(bind! &bite-space (new-space))
; !(add-atom &bite-space (Sentence (dog (stv 0.7 0.98)) (32)))
; !(add-atom &bite-space (Sentence (cat (stv 0.6 0.99)) (33)))

; (= (getbites) (match &bite-space $x $x))
; ; !(getbites)
; !(step-modus-ponens &kb bite (S (S Z)) ())