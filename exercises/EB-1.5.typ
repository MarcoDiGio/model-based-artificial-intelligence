= Frase Iniziale

Tiziana, Michela e Julie sono membri del club “Amici delle Alpi”. Ogni
membro del club che non è uno sciatore è un rocciatore. Ai rocciatori non
piace la pioggia e chiunque a cui non piace la neve non è uno sciatore. A
Michela non piace qualunque cosa che piace a Tiziana, e piace qualunque
cosa che non piace a Tiziana. A Tiziana piacciono sia la pioggia che la neve.

= Domanda 1

$cal(P)$ = { MC/1, S/1, R/1, PP/1, PN/1 }

$cal(F)$ = { Tiziana/0, Michela/0, Julie/0 }

KB#sub[FOL] = {

  MC(Tiziana),

  MC(Michela),

  MC(Julie),

  $not$ S(x) $=>$ R(x),

  R(x) $=> not$ PP(x),

  $not$ PN(x) $=> not$ S(x),

  PN(Tiziana) $=> not$ PN(Michela),

  PP(Tiziana) $=> not$ PP(Michela),

  $not$ PN(Tiziana)

}

= Domanda 2

KB#sub[CNF] = {

  MC(Tiziana),

  MC(Michela),

  MC(Julie),

  S(x) $or$ R(x),

  $not$ R(x) $or not$ PP(x),

  PN(x) $or not$ S(x),

  $not$ PN(Tiziana) $or not$ PN(Michela),

  $not$ PP(Tiziana) $or not$ PP(Michela),

  PN(Tiziana),

  PP(Tiziana)

}

$alpha$ = $exists$ x MC(x) $and$ R(x) $and not$ S(x)

$not alpha$ = $forall$ x $not$ MC(x) $or not$ R(x) $or$ S(x)

Bisogna dimostrare che KB $and not alpha$ genera la clausola vuota.

1. PN(Tiziana) $and$ ($not$ PN(Tiziana) $or not$ PN(Michela)) $models not$ PN(Michela))
2. PP(Tiziana) $and$ ($not$ PP(Tiziana) $or not$ PP(Michela)) $models not$ PP(Michela))
3. $not$ PN(Michela) $and$ (PN(x) $or not$ S(x)) $models not$ S(Michela)
4. $not$ S(Michela) $and$ (S(x) $or$ R(x)) $models$ R(Michela)
5. ($not$ MC(x) $or not$ R(x) $or$ S(x)) $and$ MC(Michela) $models not$ R(Michela) $or$ S(Michela)
6. ($not$ R(Michela) $or$ S(Michela)) $and$ R(Michela) $models$ S(Michela)
7. S(Michela) $and not$ S(Michela) $models □$

= Domanda 3

KB#sub[CNF] = {

  MC(Tiziana),

  MC(Michela),

  MC(Julie),

  S(x) $or$ R(x),

  $not$ R(x) $or not$ PP(x),

  PN(x) $or not$ S(x),

  PN(Tiziana),

  PP(Tiziana)

}

$alpha$ = $exists$ x MC(x) $and$ R(x) $and not$ S(x)

$not alpha$ = $forall$ x $not$ MC(x) $or not$ R(x) $or$ S(x)

Bisogna dimostrare che KB $and not alpha$ arriva al punto fisso senza generare la clausola vuota.

1. MC(Tiziana) $and$ (MC(x) $or not$ R(x) $or$ S(x)) $models not$ R(Tiziana) $or$ S(Tiziana)
2. PP(Tiziana) $and$ ($not$ R(x) $or not$ PP(x)) $models not$ R(Tiziana)
3. $not$ R(Tiziana) $and$ (S(x) $or$ P(x)) $models$ S(Tiziana)

Tuttavia, non raggiungiamo la clausola vuota e non possiamo fare
nuove inferenze significative. Pertanto, KB $and not alpha$ è
soddisfacibile e quindi $alpha$ non è conseguenza logica di KB.

= Domanda 4

Questo è il codice per la domanda 2:

```txt
set(print_substitutions).

set(restrict_denials). % these 4 commands are optional
clear(back_demod). % together they produce a concise, readable proof
set(para_from_small).
assign(eq_defs,pass).

formulas(assumptions).

MC(Tiziana).
MC(Michela).
MC(Julie).
S(x) | R(x).
-R(x) | -PP(x).
PN(x) | -S(x).
PN(Tiziana).
PP(Tiziana).
-PN(Tiziana) | -PN(Michela).
-PP(Tiziana) | -PP(Michela).

end_of_list.

formulas(goals).

exists x (MC(x) & R(x) & -S(x)).

end_of_list.
```

Questo è il codice per la domanda 3:

```txt
set(print_substitutions).

set(restrict_denials). % these 4 commands are optional
clear(back_demod). % together they produce a concise, readable proof
set(para_from_small).
assign(eq_defs,pass).

formulas(assumptions).

MC(Tiziana).
MC(Michela).
MC(Julie).
S(x) | R(x).
-R(x) | -PP(x).
PN(x) | -S(x).
PN(Tiziana).
PP(Tiziana).

end_of_list.

formulas(goals).

exists x (MC(x) & R(x) & -S(x)).

end_of_list.
```
