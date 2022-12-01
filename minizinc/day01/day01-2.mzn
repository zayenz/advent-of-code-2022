include "globals.mzn";

% Input
array[int, int] of int: x;

% Data
int: inputs = max(index_set_1of2(x));
array[int] of int: sums = [sum(x[i, ..]) | i in 1..inputs];
array[int] of int: ordered_sums = sort(sums);
int: checksum = sum(ordered_sums[inputs-2..inputs]);

% Variables

% Constraints

% Solve and output
solve satisfy;

output [
%  "x:        ", show(x), "\n",
  "checksum: ", show(checksum), "\n",
];
