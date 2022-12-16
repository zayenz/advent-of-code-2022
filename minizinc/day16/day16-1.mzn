include "globals.mzn";

% Input
enum Nodes;
Nodes: first_node;

array[Nodes] of int: flow;
array[Nodes] of set of Nodes: connections;

set of int: Minutes = 1..30;
set of int: Steps = Minutes diff {1};

% Data

enum Action = {Move, Open};

% Variables
array[Nodes, Minutes] of var bool: open;
array[Minutes] of var Nodes: position;
array[Steps] of var Action: action;

array[Minutes] of var int: current_flow = array1d(Minutes, [
    sum(node in Nodes) (
        open[node, minute] * flow[node]
    )
  | minute in Minutes
]);


% Constraints

% Initial state
constraint position[1] = first_node /\
    forall (node in Nodes) (
      open[node, 1] = false
    );

% Steps
constraint forall (step in Steps) (
    if action[step] = Open then
        open[position[step], step] = true /\
        forall (node in Nodes where node != position[step]) (
            open[node, step] = open[node, step-1]
        ) /\
        position[step] = position[step-1]
    else
        forall (node in Nodes) (
          open[node, step] = open[node, step-1] 
        ) /\
        position[step] in connections[position[step-1]]
    endif
);

var int: checksum = sum(current_flow);



% Solve and output
solve maximize checksum;

output 
[
  "Minute \(m): Position \(position[m]), Open valves: \({n | n in Nodes where open[n, m]})\n"
  | m in Minutes
] ++
[
  "checksum: ", show(checksum), "\n",
];
