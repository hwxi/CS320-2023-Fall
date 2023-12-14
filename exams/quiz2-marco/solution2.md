1. Answer: True
2. Answer: False  
   Reasoning: Formal grammars describe the *syntax* (aka. appearance) of a programming language and do not describe the behavior of a language. Operational semantics are usually presented using derivation rules.
3. Answer: (3) and (4)
   Reasoning: (3) cannot be derived because evaluation of the right-hand side of `add` requires the the left-hand side to already be an integer. (4) cannot be derived because it requires 2 steps of evaluation while the relation used in this choice is the single-step relation.
4. Answer: (2)
   Reasoning: `eq (add (2, 3), 2)` is able to evaluate successfully in 2 steps to `false` and will not raise an error.
   
5. 
```
                                                         2 ∈ Z     3 ∈ Z
                                                        ------------------Add-Success
                                                         add (2, 3) => 5
-------------------------------------------Multi-Base   -----------------------------------Add-Left
add (add (2, 3), 1) =>0 add (add (2, 3), 1)              add (add (2, 3), 1) => add (5, 1)               5 ∈ Z     1 ∈ Z
-------------------------------------------------------------------------------------------Multi-Ind    -----------------Add-Success
add (add (2, 3), 1) =>1 add (5, 1)                                                                       add (5, 1) => 6
-------------------------------------------------------------------------------------------------------------------------Multi-Ind
add (add (2, 3), 1) =>2 6
```

6. 
``` 
                                                                          2, 3 ∈ Z     2 ≠ 3
                                                                         --------------------Eq-False
                                                                          eq (2, 3) => false
-----------------------------------------------------------Multi-Base    ------------------------------------------------------Add-Left
add (eq (2, 3), eq (3, 3)) =>0 add (eq (2, 3), eq (3, 3))                 add (eq (2, 3), eq (3, 3)) => add (false, eq (3, 3))               false ∈ B
-------------------------------------------------------------------------------------------------------------------------------Multi-Ind    ---------------------------------Add-Left-Error
add (eq (2, 3), eq (3, 3)) =>1 add (false, eq (3, 3))                                                                                        add (false, eq (3, 3)) => error
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------Multi-Ind
add (eq (2, 3), eq (3, 3)) =>2 error
```