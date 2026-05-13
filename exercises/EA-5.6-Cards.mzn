include "alldifferent.mzn";

int: k; 
int: n;

int: total_cards = k * n;

array [1..k, 1..n] of var 1..total_cards: pos;

constraint alldifferent([pos[c, v] | c in 1..k, v in 1..n]);
constraint forall(v in 1..n, c in 1..k-1)(
    pos[c+1, v] - pos[c, v] == v+1
);

solve satisfy;

array[1..total_cards] of var 1..n: sequence;

constraint forall(v in 1..n, c in 1..k)(
    sequence[pos[c,v]] == v
);

output [
    show(sequence), "\n"
];
