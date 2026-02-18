
(= (round $x $n) (py-call (builtins.round $x $n)))

;; revision rule for atoms of the same sentence but with different stamps
(= (revision $sentences) 
    (let* ((((Sentence ($goal $stv1st) $ev1st) $rest) (decons-atom  $sentences))
            (((stv $combined-c $combined-s) $evidences) 
                (foldl-atom $rest ($stv1st $ev1st) ($init-stv $ev-acc) 
                (Sentence ($g $stv) $ev) (if (StampDisjoint $ev-acc $ev)
                                             ((Truth_Revision $init-stv $stv) (StampConcat $ev $ev-acc))
                                             ($stv1st $ev1st)))))
        (Sentence ($goal (stv (round $combined-c 3) (round $combined-s 3))) $evidences)))        

(= (getNodeSTV $kb $node)
   (let $res (collapse (match $kb (Sentence ($node $tv) $_) $tv))
      (if (== $res ())
          (stv 0.5 0.0) ;; Complete ignorance default
          (car-atom $res))))  

;; an alternative definition of getNodeSTV, rather than just a straight look up for the goal in the atomspace
;; calls back the main backward chainer inference engine to look fo the goal   
; (= (getNodeSTV $kb $node) 
;     (let $result (collapse (pln-bc $kb $node (S (S (S Z))) ())) ;; look for the atom with depth of 3
;         (if (!= $result ())
;             (getStv (revision $result))
;             (stv 0.5 0))))        

; (= (getStv (Sentence ($atom $stv) $stamp)) $stv)                
; (= (getStamp (Sentence ($atom $stv) $stamp)) $stamp)  