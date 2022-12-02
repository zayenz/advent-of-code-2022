% Input
array[int, 1..2] of Choice: games;

% Data
enum Choice = { Rock, Paper, Scissors, Win, Lose, Draw };

Choice: A = Rock;
Choice: B = Paper;
Choice: C = Scissors;
Choice: X = Lose;
Choice: Y = Draw;
Choice: Z = Win;

set of int: Games = index_set_1of2(games);

%array[Choice, Choice] of opt Choice: guide = 
%[|            Rock:   Paper:  Scissors:   Win:      Lose:     Draw: 
% | Rock:      <>,     <>,     <>,         Paper,    Scissors, Rock
% | Paper:     <>,     <>,     <>,         Scissors, Rock,     Paper
% | Scissors:  <>,     <>,     <>,         Rock,     Paper,    Scissors
% | Win:       <>,     <>,     <>,         <>,       <>,       <>
% | Lose:      <>,     <>,     <>,         <>,       <>,       <>
% | Draw:      <>,     <>,     <>,         <>,       <>,       <>
% |]; 

array[Choice, Choice] of opt Choice: guide = 
[|   <>,     <>,     <>,         Paper,    Scissors, Rock
 |   <>,     <>,     <>,         Scissors, Rock,     Paper
 |   <>,     <>,     <>,         Rock,     Paper,    Scissors
 |   <>,     <>,     <>,         <>,       <>,       <>
 |   <>,     <>,     <>,         <>,       <>,       <>
 |   <>,     <>,     <>,         <>,       <>,       <>
 |]; 

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

function int: game_value(Choice: other, Choice: guide_value) = 
    let {
      Choice: mine = deopt(guide[other, guide_value])
    } in
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
