include "alldifferent.mzn";

int: nq;

array[1..nq] of var 1..nq: queens;

constraint alldifferent(queens);
constraint forall(i, j in 1..nq where i < j) (
    abs(queens[i] - queens[j]) != j - i
);

solve satisfy;

output [ "Queens: \(queens)\n" ];