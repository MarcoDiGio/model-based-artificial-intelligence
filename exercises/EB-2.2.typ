= PDDL, Domino

Per modellare il problema richiesto, bisogna tenere conto dell'orientamento delle tessere, 
della disponibilità di una tessera, dell'ultima tessera nella sequenza e, infine, dei valori 
per la parte sinistra della tessera e per la parte destra della tessera.

Vengono definiti i seguenti simboli di predicato e funzione:

$cal(F) = { "1/0", "2/0", "3/0", "4/0", "5/0", "6/0" }$

$cal(P) = { "Tessera/1", "x/2", "y/2", "R180/1", "Vuota/0", "Disponibile/1", "Ultima/1", "Dopo/2" }$

Dove i significati intuitivi sono:

== Simboli di funzione $cal(F)$
- $0, 1, 2, 3, 4, 5, 6$: rappresentano i valori presenti sulle facce delle tessere.

== Simboli di predicato $cal(P)$
- $"Tessera"(t)$: vero sse $t$ è una tessera.
- $"x"(t, v)$: vero sse la parte sinistra della tessera $t$ ha valore $v$.
- $"y"(t, v)$: vero sse la parte destra della tessera $t$ ha valore $v$.
- $"R180"(t)$: vero sse la tessera $t$ è ruotata di 180 gradi.
- $"Vuota"()$: vero sse la sequenza è vuota.
- $"Disponibile"(t)$: vero sse la tessera $t$ è disponibile per essere inserita.
- $"Ultima"(t)$: vero sse la tessera $t$ è l'ultima tessera della sequenza.
- $"Dopo"(t_s, t_p)$: vero sse la tessera $t_s$ è posizionata subito dopo la tessera $t_p$.

== Azioni

=== aggiungiASequenzaVuota(t)
- *pre-condizioni:* $"Vuota"() and "Tessera"(t) and "Disponibile"(t)$
- *effetti:* $not"Vuota"() and "Ultima"(t) and not"Disponibile"(t)$

=== aggiungiRuotASequenzaVuota(t)
- *pre-condizioni:* $"Vuota"() and "Tessera"(t) and "Disponibile"(t)$
- *effetti:* $not"Vuota"() and "Ultima"(t) and not"Disponibile"(t) and "R180"(t)$

=== aggiungiASequenza($t_p$, $t_s$, v)
- *pre-condizioni:* $or.big_(i=1)^6 (v = i) and "Tessera"(t_s) and "Ultima"(t_p) and "Disponibile"(t_s) and ((not"R180"(t_p) and "x"(t_s, v) and "y"(t_p, v)) or ("R180"(t_p) and "x"(t_s, v) and "x"(t_p, v)))$
- *effetti:* $not"Ultima"(t_p) and "Ultima"(t_s) and not"Disponibile"(t_s) and "Dopo"(t_s, t_p)$

=== aggiungiRuotASequenza($t_s$, $t_p$, v)
- *pre-condizioni:* $or.big_(i=1)^6 (v = i) and "Disponibile"(t_s) and "Tessera"(t_s) and "Ultima"(t_p) and ((not"R180"(t_p) and "y"(t_p, v) and "y"(t_s, v)) or ("R180"(t_p) and "x"(t_p, v) and "y"(t_s, v)))$
- *effetti:* $not"Ultima"(t_p) and "Ultima"(t_s) and not"Disponibile"(t_s) and "Dopo"(t_s, t_p) and "R180"(t_s)$

== Stato iniziale

Si considerino le seguenti tessere:

$ lr(<1, 2>), lr(<1, 2>), lr(<1, 3>), lr(<3, 1>), lr(<2, 4>), lr(<2, 5>) $

A ciascuna tessera viene assegnato un identificatore distinto: $T_1, T_2, T_3, T_4, T_5, T_6$.

Lo stato iniziale del problema è definito dalla seguente congiunzione di predicati:

$
"Tessera"(T_1) and "Tessera"(T_2) and "Tessera"(T_3) and "Tessera"(T_4) and "Tessera"(T_5) and "Tessera"(T_6) and \
"x"(T_1, 1) and "y"(T_1, 2) and "x"(T_2, 1) and "y"(T_2, 2) and "x"(T_3, 1) and "y"(T_3, 3) and \
"x"(T_4, 3) and "y"(T_4, 1) and "x"(T_5, 2) and "y"(T_5, 4) and "x"(T_6, 2) and "y"(T_6, 5) and \
"Disponibile"(T_1) and "Disponibile"(T_2) and "Disponibile"(T_3) and "Disponibile"(T_4) and "Disponibile"(T_5) and "Disponibile"(T_6) and \
"Vuota"()
$

== Stato obiettivo

L'obiettivo è utilizzare tutte le tessere nella sequenza del Domino. In altre parole, tutte le tessere devono risultare non disponibili:

$
forall t "Tessera"(t) => not"Disponibile"(t)
$