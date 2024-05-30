###############################################################################
###############################################################################
# parsing_triangulations.jl
#
# This file parses output of TOPCOM or mptopcom into Julia. Additionally it
# also reads the input file from TOPCOM or mptopcom to make sure that one works
# with the same points and group as TOPCOM or mptopcom.
#
# Usage:
# julia parsing_triangulations.jl DAT_FILE XZ_FILE
#
# Since output from TOPCOM or mptopcom can be very large it is assumed to be
# given in a compressed form.
#
# Examples:
# julia parsing_triangulations.jl D4xD2.dat points2triangs.out.xz
# julia parsing_triangulations.jl D4xD2.dat mptopcom1.out.xz
# julia parsing_triangulations.jl D4xD2.dat mptopcom.out.xz
#
# The example files are in the folder `test_input` of this git.
#
# This script is meant to be extended. It simply counts the number of
# triangulations in this state.
###############################################################################
###############################################################################
using JSON

@assert length(ARGS) == 2 "Usage: parse_triangulations.jl DAT_FILE XZ_FILE"
dat_file, xz_file = ARGS
entire = read(dat_file, String)
m = match(r"(\[\D*\[.*\]\D*\])\D*(\[\D*\[.*\]\D*\])"s, entire)
points = m.captures[1]
group = m.captures[2]
points = convert(Vector{Vector}, JSON.parse(points))
group = convert(Vector{Vector{Int}}, JSON.parse(group))

i = 1
open(`xzcat $xz_file`, "r") do io
    while !eof(io)
        line = readline(io)
        m = match(r"{{.*}}", line)
        triang = replace(m.match, "{" => "[")
        triang = replace(triang, "}" => "]")
        triang = convert(Vector{Vector{Int}}, JSON.parse(triang))
        println("$i: $triang")
        global i += 1
    end
end
println("Found $(i-1) triangulations in $xz_file")
