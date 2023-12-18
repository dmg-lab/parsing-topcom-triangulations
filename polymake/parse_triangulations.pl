use strict;
use warnings;

###############################################################################
###############################################################################
# parsing_triangulations.pl
#
# This file parses output of TOPCOM or mptopcom into polymake. Additionally it
# also reads the input file from TOPCOM or mptopcom to make sure that one works
# with the same points and group as TOPCOM or mptopcom.
#
# Usage:
# polymake --script parsing_triangulations.pl DAT_FILE XZ_FILE
#
# Since output from TOPCOM or mptopcom can be very large it is assumed to be
# given in a compressed form.
#
# Examples:
# polymake --script parsing_triangulations.pl D4xD2.dat points2triangs.out.xz
# polymake --script parsing_triangulations.pl D4xD2.dat mptopcom1.out.xz
# polymake --script parsing_triangulations.pl D4xD2.dat mptopcom.out.xz
#
# The example files are in the folder `test_input` of this git.
#
# This script is meant to be extended. It simply counts the number of
# triangulations in this state.
###############################################################################
###############################################################################


use application 'polytope';
die "usage: parse_triangulations.pl DAT_FILE XZ_FILE\n" unless scalar(@ARGV)==2;

my ($dat_file, $xz_file) = @ARGV;
die "File $dat_file does not exist\n" unless -e $dat_file;
die "File $xz_file does not exist\n" unless -e $xz_file;

# Read input file from TOPCOM or mptopcom
my $entire = `cat $dat_file`;
my ($points, $group) = $entire =~ m/(\[\D*\[.*\]\D*\])\D*(\[\D*\[.*\]\D*\])/s;
# Parse points and group.
$points = new Matrix(eval $points);
$group = new Array<Array<Int>>(eval $group);
print "Points are:\n$points\n";
print "Group generators are:\n$group\n";

# Open compressed triangulations file
open my $TDATA,  "xzcat $xz_file|" or die "cannot read $xz_file";
my $counter = 0;
foreach my $line (<$TDATA>) {
   chomp $line;
   $line =~ s/^.*(\{\{.*\}\}).*/$1/;
   $line =~ s/\{/\[/g; $line =~ s/\}/\]/g;
   # Parse triangulation
   my $T = new Array<Set>(eval($line));
   # Turn into polymake object
   my $P = new fan::SubdivisionOfPoints(POINTS=>$points, MAXIMAL_CELLS=>$T);
   $counter++;
}
close($TDATA);
print "Found $counter triangulations in $xz_file.\n";



