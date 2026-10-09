= Frase iniziale

I cani da caccia abbaiano di notte. Chi possiede gatti non può avere topi in
casa. Chi ha il sonno leggero non può possedere nessun animale che abbaia
di notte. Aldo possiede un gatto oppure un cane da caccia.

= Modellazione FOL

$cal(P)$ = { CaneDaCaccia/1, Gatto/1, AbbaiaDiNotte/1, Possiede/2, TopiInCasa/1, SonnoLeggero/1 }

$cal(F)$ = { Aldo/0 }

KB#sub[FOL] = {

CaneDaCaccia(x) $=>$ AbbaiaDiNotte(x)

Gatto(x) $and$ Possiede(x, y) $=> not$ TopiInCasa(y)

SonnoLeggero(x) $=> not$ AbbaiaDiNotte(y) $and$ Possiede(x, y)

Possiede(Aldo, y) $and$ (CaneDaCaccia(y) $or$ Gatto(y))

}

= Interpretazione M

$cal(D)$ = { Pippo, Tom }

C = CaneDaCaccia(Pippo)

G = Gatto(Tom)

S = SonnoLeggero(Aldo)

P = Possiede(Tom, Aldo)

= Interpretazione I

$cal(D)$ = { Pippo, Tom }

C = CaneDaCaccia(Pippo)

G = Gatto(Tom)

S = SonnoLeggero(Aldo)

P = Possiede(Pippo, Aldo)
