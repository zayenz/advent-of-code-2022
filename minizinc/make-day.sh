#!/bin/bash

mkdir $1

cat << EOF > $1/$1-1.mzn
include "globals.mzn";

% Input
int: nx;
array[X] of int: x;

% Data
set of int: X = 1..nx;

int: checksum = 0;

% Variables

% Constraints

% Solve and output
solve satisfy;

output [
  "x:        ", show(x), "\n",
  "checksum: ", show(checksum), "\n",
];
EOF

cat << EOF > $1/$1-input.dzn
nx = 0;
x = [];
EOF

cat << EOF > $1/$1-test.dzn
nx = 0;
x = [];
EOF
