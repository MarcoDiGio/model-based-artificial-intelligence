include "globals.mzn";

% problem inputs

set of int: P;
int: W;
int: G;
int: S = card(P) div G;

% X 
array[1..W, 1..G] of var set of P: X;

% did not find the equivalent of D(X) = {...}
% so i fixed this with a constraint
constraint forall(w in 1..W, g in 1..G)(
    card(X[w, g]) == S
); 

% weekly partition
constraint forall(w in 1..W)(
    all_disjoint([ X[w, g] | g in 1..G ])
);

% maximum sociality
constraint forall(p1 in 1..card(P)-1, p2 in p1+1..card(P))(
    sum(w in 1..W, g in 1..G)(
        bool2int(p1 in X[w, g] /\ p2 in X[w, g])
    ) <= 1
);

% lex order
constraint symmetry_breaking_constraint(
    forall(w in 1..W, g in 1..G-1)(
        min(X[w,g]) < min(X[w,g+1])
    )
);

% pinning
constraint symmetry_breaking_constraint( 
    forall(g in 1..G)(
        X[1,g] == ((g-1)*S+1)..(g*S)
    )
);

solve satisfy;

output [
    "Settimana \(w), Gruppo \(g): \(X[w,g])\n" | w in 1..W, g in 1..G
];
