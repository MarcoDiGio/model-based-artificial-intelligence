= PDDL: Water Buckets, modelling

La modellazione del problema richiesto richiede di dover definire gli operatori di minimo,
di somma e di sottrazione. Queste operazioni risultano cruciali nella modellazione del problema.

Vengono definiti i seguenti simboli di predicato e funzione:

$ cal(F) = { "0/0", "1/0", "2/0", "3/0", "4/0", "5/0", "6/0", "7/0", "8/0", "9/0", "10/0" } $

$ cal(P) = { "Secchio/1", "CapacitaAttuale/2", "CapacitaTotale/2", "+/3", "-/3", "min/3" } $

Dove i significati intuitivi sono:

== Simboli di funzione $cal(F)$

$0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10$: rappresentano le quantità numeriche, espresse in litri, ammesse nel modello.

== Simboli di predicato $cal(P)$

- $"Secchio"(s)$: vero sse $s$ è un secchio.

- $"CapacitaAttuale"(s, x)$: vero sse il secchio $s$ contiene attualmente $x$ litri d'acqua.

- $"CapacitaTotale"(s, x)$: vero sse la capacità massima del secchio $s$ è pari a $x$ litri.

- "+"$(i, j, z)$: vero sse la somma di $i$ e $j$ è pari a $z$.

- "-"$(i, j, z)$: vero sse la differenza tra $i$ e $j$ è pari a $z$, con $i >= j$.

- "min"$(i, j, z)$: vero sse $z$ è il minimo tra $i$ e $j$.

== Definizione delle relazioni aritmetiche

Le relazioni aritmetiche vengono rappresentate mediante fatti inseriti nello stato iniziale. Le espressioni seguenti rappresentano una notazione compatta per indicare le congiunzioni dei fatti corrispondenti.

=== Somma

Vengono considerate tutte le tuple $(i, j, z)$ tali che $i, j, z in [0..10]$ e $i+j=z$.

$
limits(and)_(i, j, z in [0..10] and i + j = z) ("+"(i, j, z))
$

Il risultato della somma viene limitato all'intervallo dei valori rappresentabili, ovvero $[0..10]$.

=== Sottrazione

Vengono considerate tutte le tuple $(i, j, z)$ tali che $i, j, z in [0..10]$, $i >= j$ e $i-j=z$.

$
limits(and)_(i, j, z in [0..10] and i >= j and i - j = z) ("-"(i, j, z))
$

In questo modo, vengono rappresentate soltanto le sottrazioni con risultato non negativo.

=== Minimo

La relazione di minimo viene definita considerando due casi distinti, successivamente uniti nello stato iniziale.

Nel primo caso, se $i <= j$, il minimo è $i$:

$
limits(and)_(i, j in [0..10] and i <= j) ("min"(i, j, i))
$

Nel secondo caso, se $j < i$, il minimo è $j$:

$
limits(and)_(i, j in [0..10] and j < i) ("min"(i, j, j))
$

Le due definizioni, considerate congiuntamente, descrivono la relazione di minimo per tutte le coppie di valori dell'intervallo considerato.

== Azioni

=== versaAcquaInSecchio$("ss", "sd", l, "cs", "cd", "cmd", "res_sub", "res_sum", "fcs")$

L'azione rappresenta il travaso d'acqua dal secchio sorgente $"ss"$ al secchio destinazione $"sd"$.

- *pre-condizioni:*
$
"Secchio"("ss") and "Secchio"("sd") and "ss" != "sd" and \
"CapacitaAttuale"("ss", "cs") and "CapacitaAttuale"("sd", "cd") and \
"CapacitaTotale"("sd", "cmd") and \
"-"("cmd", "cd", "res_sub") and "min"("res_sub", "cs", l) and \
"+"("cd", l, "res_sum") and "-"("cs", l, "fcs") and l != 0
$
- *Effetti*:
$
  not "CapacitaAttuale"("sd", "cd") and not "CapacitaAttuale"("ss", "cs") and \
  "CapacitaAttuale"("sd", "res_sum") and "CapacitaAttuale"("ss", "fcs")
$

Dove:
- $"ss"$ rappresenta il secchio sorgente.
- $"sd"$ rappresenta il secchio destinazione.
- $"cs"$ rappresenta la quantità d'acqua inizialmente presente nel secchio sorgente.
- $"cd"$ rappresenta la quantità d'acqua inizialmente presente nel secchio destinazione.
- $"cmd"$ rappresenta la capacità massima del secchio destinazione.
- $"res_sub"$ rappresenta lo spazio ancora disponibile nel secchio destinazione.
- $l$ rappresenta la quantità d'acqua da versare, determinata dal minimo tra lo spazio disponibile nel secchio destinazione e la quantità d'acqua presente nel secchio sorgente.
- $"res_sum"$ rappresenta la quantità d'acqua presente nel secchio destinazione dopo il travaso.
- $"fcs"$ rappresenta la quantità d'acqua residua nel secchio sorgente dopo il travaso.

La precondizione $"-"("cmd", "cd", "res_sub")$ calcola lo spazio ancora disponibile nel secchio destinazione, mentre $"min"("res_sub", "cs", l)$ individua la quantità d'acqua da versare. Le relazioni di somma e sottrazione permettono di determinare le quantità d'acqua presenti nei due secchi dopo il travaso.

La condizione $"ss" != "sd"$ impone che i secchi sorgente e destinazione siano distinti. La condizione $l != 0$ esclude i travasi che non comportano alcun movimento d'acqua.

Gli effetti eliminano le quantità d'acqua precedentemente associate ai due secchi e inseriscono le rispettive quantità aggiornate.

== Stato iniziale

Si considerino tre secchi $A$, $B$ e $C$, con capacità massime rispettivamente pari a $5$, $8$ e $10$ litri, contenenti inizialmente $4$, $6$ e $5$ litri d'acqua.

Lo stato iniziale del problema è definito dalla seguente congiunzione di predicati:

$
"Secchio"(A) and "Secchio"(B) and "Secchio"(C) and \
"CapacitaTotale"(A, 5) and "CapacitaTotale"(B, 8) and "CapacitaTotale"(C, 10) and \
"CapacitaAttuale"(A, 4) and "CapacitaAttuale"(B, 6) and "CapacitaAttuale"(C, 5) and \
limits(and)_(i, j, z in [0..10] and i + j = z) ("+"(i, j, z)) and \
limits(and)_(i, j, z in [0..10] and i >= j and i - j = z) ("-"(i, j, z)) and \
limits(and)_(i, j in [0..10] and i <= j) ("min"(i, j, i)) and \
limits(and)_(i, j in [0..10] and j < i) ("min"(i, j, j))
$

== Stato obiettivo

L'obiettivo è raggiungere una configurazione nella quale tutti e tre i secchi contengano esattamente $5$ litri d'acqua.

$
"CapacitaAttuale"(A, 5) and \
"CapacitaAttuale"(B, 5) and \
"CapacitaAttuale"(C, 5)
$