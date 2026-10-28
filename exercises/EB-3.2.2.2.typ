= Reti Bayesiane: I Rossi, Inferenza

Data la rete Bayesiana, si vuole calcolare la probabilità che la variabile
$F$ abbia il valore True dopo aver osservato che $L = "true"$ e $A = "false"$.

La formula della distribuzione di probabilità congiunta per
la rete bayesiana è la seguente:

$ P(F, L, I, C, A) = P(L | F) dot P(F) dot P(A | C) dot P(C | F, I) dot P(I) $

In modo compatto, si fa summing-out delle variabili nascoste $C$ e $I$
utilizzando le seguenti tabelle:

#show table: set text(size: 8pt)

#table(
  columns: (auto, 1fr, 1fr, 1fr, 1fr, auto),
  align: center + horizon,
  table.header[
    *$F$*
  ][
    *$C = "T", I = "T"$*
  ][
    *$C = "T", I = "F"$*
  ][
    *$C = "F", I = "T"$*
  ][
    *$C = "F", I = "F"$*
  ][
    *Somma*
  ],

  [*T*],
  [$0.15 dot 0.6 dot 0.01 dot 0.99 dot 0.3$ \ $= 0.0002673$],
  [$0.15 dot 0.6 dot 0.99 dot 0.9 dot 0.3$ \ $= 0.024057$],
  [$0.15 dot 0.6 dot 0.01 dot 0.01 dot 0.99$ \ $= 0.00000891$],
  [$0.15 dot 0.6 dot 0.99 dot 0.1 dot 0.99$ \ $= 0.0088209$],
  [*$0.03315411$*],

  [*F*],
  [$0.85 dot 0.05 dot 0.01 dot 0.97 dot 0.3$ \ $= 0.000123675$],
  [$0.85 dot 0.05 dot 0.99 dot 0.3 dot 0.3$ \ $= 0.00378675$],
  [$0.85 dot 0.05 dot 0.01 dot 0.03 dot 0.99$ \ $= 0.0000126225$],
  [$0.85 dot 0.05 dot 0.99 dot 0.7 dot 0.99$ \ $= 0.029157975$],
  [*$0.0330810225$*],
)

Ogni prodotto ha la forma
$P(F) dot P(L = T | F) dot P(I) dot P(C | F, I) dot P(A = F | C)$.

Normalizzando con $alpha = 1 / (0.03315411 + 0.0330810225)$:

$ P(F = T | L = T, A = F) = 0.03315411 / 0.0662351325 approx 0.5006 $

$ P(F = F | L = T, A = F) = 0.0330810225 / 0.0662351325 approx 0.4994 $