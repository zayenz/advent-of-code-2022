# Advent of Code 2022 solutions

This repository contains some solutions to the [Advent of Code 2022](http://adventofcode.com/2022) 
advent calendar.

The solutions are written in the [MiniZinc](https://www.minizinc.org/)
modelling language. As this is not a language that is made for general
programming, the input data is processed beforehand into suitable
format. The code is located in the **minizinc/** folder, and the file
**minizinc/advent-of-code-2022.mzp** is a project file that includes all
the solutions.

## Warning

MiniZinc is as mentioned not a normal general purpose programming
language, and thus the solutions are solved with the features that
are available. The solutions should not be viewed as good MiniZinc
code at all; they are written to solve the problem at hand and
as a way to have fun.

## Coding in MiniZinc

While MiniZinc is a modelling language foremost, it does have a pure
functional part that can be used for general computations. Some
notable limits on using MiniZinc for computation are
* No higher order functions (so no map, filter, fold)
* Limited data-types (values (ints, floats, and enums) and
  multi-dimensional arrays of values or sets of values)
* Only declarative construction of data.
* No tail recursion and no garbage collection.

These limits are usually not that bad when writing a model, but get
problematic as soon as any large amount of data needs to be processed.

Some very nice parts when using MinZinc for coding are
* Set and array comprehensions
* Generator exprssions with where clauses
* Set operations and relations
* Enum definitions
* Enum array indexing

In general, using enums for indexing into arrays is a very powerful
technique similar to newtypes in for example Haskell, as it also gives
good type-safety which is very useful when juggling several array
indices.


## Highlights and comments

TBW
