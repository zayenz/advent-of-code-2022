include "globals.mzn";

% Input
array[int, 1..2] of Choice: games;

% Data
enum Choice = { Rock, Paper, Scissors };

Choice: A = Rock;
Choice: B = Paper;
Choice: C = Scissors;
Choice: X = Rock;
Choice: Y = Paper;
Choice: Z = Scissors;

set of int: Games = index_set_1of2(games);

function int: choice_value(Choice: mine) =
    if mine = Rock then
        1
    elseif mine = Paper then
        2
    else
        3
    endif;
        
function int: outcome_value(Choice: other, Choice: mine) = 
   if other = mine then
       3
   elseif (mine = Rock /\ other = Scissors) \/ 
          (mine = Paper /\ other = Rock) \/ 
          (mine = Scissors /\ other = Paper) then
       6
   else
       0
   endif;

function int: game_value(Choice: other, Choice: mine) = 
    choice_value(mine) + outcome_value(other, mine);

array[Games] of int: game_values = [game_value(games[g, 1], games[g, 2]) | g in Games];

int: checksum = sum(game_values);

% Variables

% Constraints

% Solve and output
solve satisfy;

output [
  "checksum: ", show(checksum), "\n",
];
