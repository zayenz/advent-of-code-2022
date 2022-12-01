include "globals.mzn";

% Input
array[int, int] of int: x;

% Data

array[int] of int: sums = [sum(x[i, ..]) | i in index_set_1of2(x)];

int: checksum = max(sums);

% Variables

% Constraints

% Solve and output
solve satisfy;

output [
%  "x:        ", show(x), "\n",
  "checksum: ", show(checksum), "\n",
];
