include "globals.mzn";

% Input
enum Nodes;
Nodes: first_node;

array[Nodes] of int: flow;
array[Nodes] of set of Nodes: connections;

set of int: Minutes = 1..26;
set of int: Steps = Minutes diff {1};

% Data

enum Action = {Move, Open};
enum Person = {Me, Elephant};
function Person: other(Person: person) = 
    if person = Me then Elephant else Me endif;

% Variables
array[Nodes, Minutes] of var bool: open;
array[Minutes, Person] of var Nodes: position;
array[Steps, Person] of var Action: action;

array[Minutes] of var int: current_flow = array1d(Minutes, [
    sum(node in Nodes) (
        open[node, minute] * flow[node]
    )
  | minute in Minutes
]);


% Constraints

% Initial state
constraint position[1, Me] = first_node /\
    position[1, Elephant] = first_node /\
    forall (node in Nodes) (
      open[node, 1] = false
    );

% Steps
constraint forall (step in Steps, person in Person) (
    if action[step, person] = Open then
        open[position[step, person], step] = true /\
        forall (node in Nodes where 
                  (node != position[step, Me] /\ 
                  node != position[step, Elephant])) (
            open[node, step] = open[node, step-1]
        ) /\
        position[step, person] = position[step-1, person]
    else
        forall (node in Nodes where node != position[step, other(person)]) (
          open[node, step] = open[node, step-1] 
        ) /\
        position[step, person] in connections[position[step-1, person]]
    endif 
) /\
    forall (step in Steps, node in Nodes) (
        if (action[step, Me] = Open /\ position[step, Me] = node) \/ 
           (action[step, Elephant] = Open /\ position[step, Elephant] = node)
        then
            open[node, step] = true        
        else
            open[node, step] = open[node, step-1]            
        endif
);

var int: checksum = sum(current_flow);



% Solve and output
solve :: int_search([ 
    [action[s, p], position[s, p]][i] 
  | s in Steps, p in Person, i in 1..2
], input_order, indomain_max)
maximize checksum;

output 
[
  "Minute \(m): Position me=\(position[m, Me]), elephant=\(position[m, Elephant]), Open valves: \({n | n in Nodes where open[n, m]})\n"
  | m in Minutes
] ++
[
  "checksum: ", show(checksum), "\n",
];
