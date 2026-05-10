% define nc as the numbers of colors
int: nc = 3;
% define n_nodes as the numbers of nodes
int: n_nodes = 3;
set of int: nodes = 1..n_nodes;
% define color matrix (n_nodes x n_nodes)
array[nodes, nodes] of var 1..nc: col;

% adj matrix (example)
array[nodes, nodes] of bool: adj_matrix = [|
  false, true, true|
  true, false, true|
  true, true, false| 
|];

% we have a triangle if, for every i, j, k
% adj_matrix[i][j] AND adj_matrix[i][k] AND adj_matrix[j][k]
% we choose non-deterministically the nodes and check if triangle
constraint forall(i in nodes, j in nodes, k in nodes) (
  (adj_matrix[i, j] /\ adj_matrix[i, k] /\ adj_matrix[j, k]) -> (col[i, j] != col[i, k] \/ col[i, k] != col[j, k] \/ col[i, j] != col[j, k])
);

% we have by track that C[i][j] = C[j][i] (non-direct graph)
constraint forall(i in nodes, j in nodes) (
  col[i, j] == col[j, i]
);

% helps the solver to be faster
% default color for not-triangles arc is 1
constraint forall(i in nodes, j in nodes) (
  not adj_matrix[i, j] -> col[i, j] == 1
);

solve satisfy;

output [
  "Arc (\(i),\(j)): Color \(col[i,j])\n"
  | i, j in nodes where i < j /\ adj_matrix[i,j]
];
