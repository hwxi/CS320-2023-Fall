1. Answer: False  
   Reasoning: A BNF rule (aka. production) has a *non-terminal* symbol as its left-hand side.
2. Answer: False  
   Reasoning: A grammar is ambiguous if and only if it generates a sentence with two or more *parse trees*. Even unambiguous grammars may have more than 1 distinct derivations such as left-most derivation and right-most derivation. 
3. Answer: (3)  
   Reasoning: Starting symbol `<S>` has only a single production headed by terminal symbol `a` followed by non-terminal `<A>`. This means that we can rule out (1) and (2) immediately as they allow for strings not starting with `a`. Next, non-terminal `<A>` has two productions which are both headed by terminal symbol `c`. This means that whatever production we choose, our string will always have at least 1 `c` inside. This rules out (2) which allows for strings without `c`. So the only answer is (3).
4. Answer: (4) 
   Reasoning: Similarly to problem 3. the starting symbol `<S>` has only a single production headed by terminal symbol `b` followed by non-terminal `<B>`. This means that we can rule out (1) and (2) as they allow for the empty string. Next, both productions of non-terminal `<B>` start with `b` so there must be at least 2 `b` symbols in a recognized string. This means we can rule out (3) which only guarantees 1 `b`. The remaining answer is (4) which ensures 2 `b`.

5. 
```
<expr> = <expr> * <expr>
       = <term> * <expr>
       = <val> * <expr>
       = 1 * <expr>
       = 1 * <term> + <expr>
       = 1 * <val> + <expr>
       = 1 * 2 + <expr>
       = 1 * 2 + <term>
       = 1 * 2 + <val>
       = 1 * 2 + 0
```

6. 
```
            <exp>
            /   \
        <ter> - <exp>
        /    \     \
    <ter> / <val>  <val>
    /  \       \     |
<con> * <ter>   1    1
  |       |
  c     <con>
          |
          d
```