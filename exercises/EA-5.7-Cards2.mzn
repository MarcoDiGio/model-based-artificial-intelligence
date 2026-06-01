include "alldifferent.mzn";

% problem inputs
int: N;
int: M;
int: D;
array [1..N] of int: C;

% X
var 2..N-1: M1;
var 2..N-1: M2;
var 2..N-1: M3;
array [1..N] of var 1..N: P;

constraint alldifferent(P);

% disjoint intervals
constraint forall(i in 1..N-1)(
    ((i < M1) -> (C[P[i]] < C[P[i+1]])) 
    /\
    ((i >= M1 /\ i < M2) -> (C[P[i]] > C[P[i+1]]))
    /\
    ((i >= M2 /\ i < M3) -> (C[P[i]] < C[P[i+1]]))
    /\
    ((i >= M3) -> (C[P[i]] > C[P[i+1]]))
);

constraint M1 < M2 /\ M2 < M3;

constraint (M3 - M1) == D;

solve satisfy;

output [
    "Max 1 (M1): \(M1), Min 2 (M2): \(M2), Max 3 (M3): \(M3)\n",
    "Cards: \( [C[P[i]] | i in 1..N] )\n"
];
