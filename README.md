# Parsing (MP)TOPCOM triangulations

This repository contains several scripts for parsing the output of TOPCOM[^1] or
mptopcom[^2] to use it in e.g. polymake[^3], Julia[^4] or Oscar.jl[^5].

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
