include "alldifferent.mzn";

int: nq;

array[1..nq] of var 1..nq: queens;

constraint alldifferent(queens);
constraint alldifferent([ queens[i] + i | i in 1..nq ]);
constraint alldifferent([ queens[i] - i | i in 1..nq ]);

solve satisfy;

output [ "Queens: \(queens)\n" ];