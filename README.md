# Parsing (MP)TOPCOM triangulations

This repository contains several scripts for parsing the output of TOPCOM[^1] or
mptopcom[^2] to use it in e.g. polymake[^3], Julia[^4] or Oscar.jl[^5].

## Sample usage
```
julia julia/parse_triangulations.jl test_input/D4xD2.dat test_input/mptopcom.out.xz
julia julia/parse_triangulations_oscar.jl test_input/D4xD2.dat test_input/mptopcom.out.xz
polymake --script polymake/parse_triangulations.pl test_input/D4xD2.dat test_input/mptopcom.out.xz
```
For convenience we also provide a script computing the rays of the secondary
cones of the triangulations in the output file up to group action. A sample
call is
```
polymake --script polymake/rays_of_sec_cones.pl test_input/D4xD2.dat test_input/mptopcom.out.xz
```

## Encoding triangulations
Both TOPCOM and mptopcom use the same encoding for a triangulation. An examples
output line of TOPCOM containing a triangulation is
```
T[526]:=[526->15,7:{{0,1,2,3,4,5,10},{4,9,10,11,12,13,14},{1,2,3,4,5,9,10},{2,3,5,6,7,9,11},{3,5,6,7,8,9,11},{3,5,7,8,9,11,13},{3,5,7,9,10,11,13},{3,4,9,10,11,12,13},{2,3,4,9,10,11,12},{1,2,3,4,9,10,11},{1,2,3,5,6,9,11},{2,3,5,7,9,10,11},{1,2,3,5,9,10,11},{3,7,9,10,11,12,13},{2,3,7,9,10,11,12}}];
```
This output is slightly different for mptopcom, but the triangulation is always
the part in the curly braces. A triangulation is given as a set of index sets
on the vertices. To be precise:
```
{{0,1,2,3,4,5,10},{4,9,10,11,12,13,14},{1,2,3,4,5,9,10},{2,3,5,6,7,9,11},{3,5,6,7,8,9,11},{3,5,7,8,9,11,13},{3,5,7,9,10,11,13},{3,4,9,10,11,12,13},{2,3,4,9,10,11,12},{1,2,3,4,9,10,11},{1,2,3,5,6,9,11},{2,3,5,7,9,10,11},{1,2,3,5,9,10,11},{3,7,9,10,11,12,13},{2,3,7,9,10,11,12}}
```
is the triangulation,
```
{0,1,2,3,4,5,10}
```
is a simplex of the triangulation and is to be interpreted as the simplex
formed by the convex hull of the 0th, 1st, 2nd, 3rd, 4th, 5th, and 10th input
point.

## Input files for the scripts
All scripts here assume that the input is given in two files:
* **input.dat** The input file of TOPCOM or mptopcom. The format is the same in
  both cases. This file is parsed by the scripts as well, as the output of
  TOPCOM or mptopcom only makes sense in conjunction with the correct input.
  Things that can go wrong otherwise include: The points could have a different
  order if they are being (re-)computed or a different group may be used.
* **output.xz** The output of TOPCOM or mptopcom produced from `input.dat`.
  Since the output may be very large, we assume that it is compressed.

[^1]: [TOPCOM](https://www.wm.uni-bayreuth.de/de/team/rambau_joerg/TOPCOM/index.html)
[^2]: [mptopcom](https://polymake.org/mptopcom)
[^3]: [polymake](https://polymake.org)
[^4]: [Julia](https://julialang.org/)
[^5]: [Oscar.jl](https://github.com/oscar-system/Oscar.jl)
