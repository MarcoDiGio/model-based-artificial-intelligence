= CNF

$forall$ X $forall$ C Studente(X) $and$ Corso(C) $and$ (Ansioso(X) 
$or not$ HaStudiato(X, C)) $=> not$ Supera(X, C)

$not$ Studente(X) $or not$ Corso(C) $or$ ($not$ Ansioso(X) $and$ HaStudiato(X, C)) $or not$ Supera(X, C)

$not$ Studente(X) $or not$ Corso(C) $or not$ Supera(X, C) $or$ ($not$ Ansioso(X) $and$ HaStudiato(X, C))

($not$ Studente(X) $or not$ Corso(C) $or not$ Supera(X, C) $or not$ Ansioso(X)) $and$
($not$ Studente(X) $or not$ Corso(C) $or not$ Supera(X, C) $or$ HaStudiato(X, C))

= Inferenza A

$exists$ s Studente(s) $and$ Ansioso(s)

$exists$ s $exists$ c Studente(s) $and$ Corso(c) $and$ HaStudiato(s, c)

$alpha$ = $forall$ x $forall$ y Studente(x) $and$ Corso(y) $=> not$ Supera(x, y)

$not alpha$ = $exists$ x $exists$ y Studente(x) $and$ Corso(y) $and$ Supera(x, y)

KB#sub[CNF] = {

$not$ Studente(X) $or not$ Corso(C) $or not$ Supera(X, C) $or not$ Ansioso(X)),

$not$ Studente(X) $or not$ Corso(C) $or not$ Supera(X, C) $or$ HaStudiato(X, C)),

Studente(s1),

Ansioso(s1),

Studente(s2),

Corso(c1),

HaStudiato(s2, c1),

}

Si nota subito che KB $and not alpha$ è soddisfacibile, in quanto non ci sono informazioni
sufficienti per inferire $alpha$. Raggiungiamo quindi il punto fisso:

1. ($not$ Studente(X) $or not$ Corso(C) $or not$ Supera(X, C) $or not$ Ansioso(X)) $and$ Studente(s2)
$models$ ($not$ Corso(C) $or not$ Supera(s2, C) $or not$ Ansioso(s2))
2. ($not$ Corso(C) $or not$ Supera(s2, C) $or not$ Ansioso(s2)) $and$ Corso(c1)
$models$ ($not$ Supera(s2, C) $or not$ Ansioso(s2))
4. ($not$ Studente(X) $or not$ Corso(C) $or not$ Supera(X, C) $or not$ Ansioso(X)) $and$ Studente(s2)
$models$ ($not$ Corso(C) $or not$ Supera(s2, C) $or not$ Ansioso(s2))
5. ($not$ Corso(C) $or not$ Supera(s2, C) $or not$ Ansioso(s2)) $and$ Ansioso(s2)
$models not$ Corso(C) $or not$ Supera(s2, C)

Nessuna inferenza successiva può generare la clausola vuota, di conseguenza $alpha$ non è conseguenza
logica di KB. Questo poiché non è possibile generare le clausole $not$ HaStudiato(s2, C),
Supera(s2, C), Ansioso(s2), Supera(s1, C), HaStudiato(s1, C).

= Inferenza B

$exists$ X Studente(X) $and not$ Ansioso(X)

$forall$ X Studente(X) $=> exists$ y Corso(y) $and$ HaStudiato(X, y)

$equiv not$ Studente(X) $or$ (Corso(S1(X)) $and$ HaStudiato(X, S1(X))

$equiv$ ($not$ Studente(X) $or$ Corso(S1(X))) $and$ ($not$ Studente(X) $or$ HaStudiato(X, S1(X))

KB#sub[CNF] = {

$not$ Studente(X) $or not$ Corso(C) $or not$ Supera(X, C) $or not$ Ansioso(X)),

$not$ Studente(X) $or not$ Corso(C) $or not$ Supera(X, C) $or$ HaStudiato(X, C)),

Studente(s1),

$not$ Ansioso(s1),

$not$ Studente(X) $or$ Corso(S1(X)),

$not$ Studente(X) $or$ HaStudiato(X, S1(X))

}

$alpha$ = $forall$ X Studente(X) $=> exists$ C Corso(C) $and$ Supera(X, C)

$not alpha$ = $not$ $forall$ X [$not$ Studente(X) $or exists$ [C Corso(C) $and$ Supera(X, C)]]

$equiv exists$ X Studente(X) $and forall$ C [$not$ Corso(C) $or not$ Supera(X, C)]

$equiv$ Studente(s2) $and$ [$not$ Corso(C) $or not$ Supera(s2, C)]

KB#sub[CNF] $and not alpha$ = {

$not$ Studente(X) $or not$ Corso(C) $or not$ Supera(X, C) $or not$ Ansioso(X)),

$not$ Studente(X) $or not$ Corso(C) $or not$ Supera(X, C) $or$ HaStudiato(X, C)),

Studente(s1),

$not$ Ansioso(s1),

$not$ Studente(X) $or$ Corso(S1(X)),

$not$ Studente(X) $or$ HaStudiato(X, S1(X))

Studente(s2)

$not$ Corso(C) $or not$ Supera(s2, C)

}

Anche in questo caso, KB $and not alpha$ non ha abbastanza informazioni per generare la
clausola vuota. Arriviamo quindi al punto fisso.

1. Studente(s1) $and$ [$not$ Studente(X) $or not$ Corso(C) $or not$ Supera(X, C) $or not$ Ansioso(X))]
$models$ $not$ Corso(C) $or not$ Supera(s1, C) $or not$ Ansioso(s1)
2. Studente(s1) $and$ [$not$ Studente(X) $or not$ Corso(C) $or not$ Supera(X, C) $or$ HaStudiato(X, C))]
$models$ $not$ Corso(C) $or not$ Supera(s1, C) $or$ HaStudiato(s1, C))
3. Studente(s1) $or$ [$not$ Studente(X) $or$ Corso(S1(X))]
$models$ Corso(S1(s1))
4. Studente(s1) $or$ [$not$ Studente(X) $or$ HaStudiato(X, S1(X))]
$models$ HaStudiato(s1, S1(s1))
5. Corso(S1(s1)) $and$ [$not$ Corso(C) $or not$ Supera(s1, C) $or not$ Ansioso(s1)]
$models$ $not$ Supera(s1, S1(s1)) $or not$ Ansioso(s1)
6. Studente(s2) $and$ [$not$ Studente(X) $or not$ Corso(C) $or not$ Supera(X, C) $or not$ Ansioso(X))]
$models$ $not$ Corso(C) $or not$ Supera(s2, C) $or not$ Ansioso(s2)

Siccome non possiamo inferire per s1 le clausole Ansioso(s1) e Supera(s1, C) e $not$ HaStudiato(s1, C)
e per s2 non possiamo inferire le clausole $not$ HaStudiato(s2, C) e Supera(s2, C) e Ansioso(s2), non
è possibile generare la clausola vuota. Di conseguenza, KB $and not alpha$ risulta soddisfacibile, e
di conseguenza, dunque non è possibile inferire $alpha$ da KB.

= Prover9

```txt
set(print_substitutions). % show the substitutions into variables in the proof

set(restrict_denials).
clear(back_demod).
set(para_from_small).
assign(eq_defs,pass).

formulas(assumptions).

-S(x) | -C(x) | -SU(x, c) | -A(x).
-S(x) | -C(x) | -SU(x, c) | -HS(x, c).  
S(s1).
A(s1).
S(s2).
C(c1).
HS(s2, c1).

end_of_list.

formulas(goals).

exists x exists y (Studente(x) & Corso(y) & Supera(x,y)).

end_of_list.
```

```
set(print_substitutions).

set(restrict_denials).
clear(back_demod).
set(para_from_small).
assign(eq_defs,pass).

formulas(assumptions).

-S(x) | -C(x) | -SU(x, c) | -A(x).
-S(x) | -C(x) | -SU(x, c) | -HS(x, c).  
S(s1).
-A(s1).
-S(x) | C(S1(x)).
S(s2).
-C(c) | -SU(s2, c).

end_of_list.

formulas(goals).

exists x exists y (Studente(x) & Corso(y) & Supera(x,y)).

end_of_list.
```
