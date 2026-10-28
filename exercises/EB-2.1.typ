= PDDL, Torre di Hanoi

$cal(F) = { "d1/0", "d2/0", "d3/0", "d4/0", "A/0", "B/0", "C/0" }$

$cal(P) = { "Asse/1", "Disco/1", "Affiorante/1", "Su/2", "SuAsse/2", "Vuoto/1", "PiuGrande/2" }$

Dove i significati intuitivi sono:

== Simboli di funzione $cal(F)$
- $d_1, d_2, d_3, d_4$: rappresentano i quattro dischi del puzzle.
- $A, B, C$: rappresentano i tre assi verticali della piattaforma.

== Simboli di predicato $cal(P)$
- $"Asse"(x)$: vero sse $x$ è uno dei tre assi verticali della piattaforma.
- $"Disco"(x)$: vero sse $x$ è uno dei dischi del puzzle.
- $"Affiorante"(x)$: vero sse non vi è alcun disco posto sopra al disco $x$.
- $"Su"(x, y)$: vero sse il disco $x$ poggia direttamente sopra il disco $y$.
- $"SuAsse"(x, y)$: vero sse il disco $x$ poggia direttamente sulla base dell'asse $y$.
- $"Vuoto"(x)$: vero sse l'asse $x$ è completamente privo di dischi.
- $"PiuGrande"(x, y)$: vero sse il disco $x$ è più grande del disco $y$.

== Stato iniziale

Lo stato iniziale del problema è definito dalla seguente congiunzione di predicati:

$
"Asse"(A) and "Asse"(B) and "Asse"(C) and \
"Disco"(d_1) and "Disco"(d_2) and "Disco"(d_3) and "Disco"(d_4) and \
"PiuGrande"(d_1, d_2) and "PiuGrande"(d_1, d_3) and "PiuGrande"(d_1, d_4) and \
"PiuGrande"(d_2, d_3) and "PiuGrande"(d_2, d_4) and "PiuGrande"(d_3, d_4) and \
"Su"(d_4, d_3) and "Su"(d_3, d_2) and "Su"(d_2, d_1) and "SuAsse"(d_1, A) and \
"Affiorante"(d_4) and "Vuoto"(B) and "Vuoto"(C)
$

== Stato obiettivo

Lo stato obiettivo del problema è definito dalla seguente congiunzione di predicati:

$
"Su"(d_4, d_3) and "Su"(d_3, d_2) and "Su"(d_2, d_1) and "SuAsse"(d_1, B) and \
"Vuoto"(A) and "Vuoto"(C)
$

== Azioni

=== SpostaDiscoSuDisco(dsot, ds, dd)
- *pre-condizioni:* $"Disco"(d_("sot")) and "Disco"(d_s) and "Disco"(d_d) and "Affiorante"(d_s) and "Affiorante"(d_d) and "Su"(d_s, d_("sot")) and "PiuGrande"(d_d, d_s)$
- *effetti:* $"Affiorante"(d_("sot")) and not "Affiorante"(d_d) and not "Su"(d_s, d_("sot")) and "Su"(d_s, d_d)$

=== SpostaDiscoSuAsse(dsot, ds, ad)
- *pre-condizioni:* $"Disco"(d_("sot")) and "Disco"(d_s) and "Asse"(a_d) and "Vuoto"(a_d) and "Affiorante"(d_s) and "Su"(d_s, d_("sot"))$
- *effetti:* $"Affiorante"(d_("sot")) and not "Su"(d_s, d_("sot")) and "SuAsse"(d_s, a_d) and not "Vuoto"(a_d)$

=== SpostaUltimoDiscoSuAsse(ds, as, ad)
- *pre-condizioni:* $"Disco"(d_s) and "Asse"(a_s) and "Asse"(a_d) and "SuAsse"(d_s, a_s) and "Vuoto"(a_d) and "Affiorante"(d_s)$
- *effetti:* $"Vuoto"(a_s) and not "Vuoto"(a_d) and not "SuAsse"(d_s, a_s) and "SuAsse"(d_s, a_d)$

=== SpostaUltimoDiscoSuDisco(ds, dd, as)
- *pre-condizioni:* $"Disco"(d_s) and "Disco"(d_d) and "Asse"(a_s) and "SuAsse"(d_s, a_s) and "Affiorante"(d_d) and "Affiorante"(d_s) and "PiuGrande"(d_d, d_s)$
- *effetti:* $"Vuoto"(a_s) and not "SuAsse"(d_s, a_s) and not "Affiorante"(d_d) and "Su"(d_s, d_d)$