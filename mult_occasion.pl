#!/usr/bin/perl -w
use strict;

my $raw = ">chr1:566921..567171
TGTTATGTCTATCCAGGTGATTCTGACCAATCAGCAGATGAGCACGACTCTGTTCGCCAC
GGTGACGCTGCGCTGTGATTACTCCACCTCCGCTCAGCTGCAGAATGTTCTGGTCACCTG
GGTTTACAAGTCCTTCTGCAAAGACCCTGTTCTGGACTACTACTCTGCAGGTGATGCTCC
TGAGTGTGTGTGCGTGCGTGTGTGTGTGTGTGTGTGTGCGTGTGTGCGCGCGTGCTGGTT
TATAGTTAGAC
>chr1:2058632..2058882
CTCCTCCGCCAGGGGTCGCTGTTTTCCTCGCGGTTTTTCTCTTTCTCCCTGTAGTGCGGG
TGTTGGAGGCTGGAGGCGGTGTTTTATTGTATGAAATCAGTTCGGGATCAGTCCTACAGT
CATGGCGTCCGGGAAGACGGTGGCTTTCCGCGCTATCCGCGAATAAGCGCCGAAAAACCC
GTTTCACGCCACTTCAGCCGCCGCGCCGCGCGTTTTTTTCCAGCGGAATATCATTTAAAG
ACACCCTCGCG";
my (
    @line,
    $rawlen,
    $seq,
    );
@line = split /\n/, $raw;

$rawlen = 5;
$seq = "";
my $s1 = scalar(@line);
for (my $j = 0; $j < $s1; $j++){
    if ($line[$j] =~ /chr/){
        my $colon = index ($line[$j], ':');
        my $divide = index $line[$j], '..';
        my $end = length ($line[$j]) - 1;
        my $chr = substr $line[$j], 4, ($colon - 4);
        my $strt = substr $line[$j], ($colon + 1), $divide - $colon + 1;
        my $stop = substr $line[$j], $divide + 2, $end;
    }
    else{
        #for (my $k = 1; $k < $rawlen + 1; $k++){
            $seq = $seq.$line[$j];
        #}
    }
}
my $motif = "TTA";

my @motifcenter;
my $x =0;
my $center = index $seq, $motif, $x;
while ($center != -1){
    $center = index $seq, $motif, $x;
    unless ($center == -1){
        push @motifcenter, $center;
        $x = $center +1;
    }
    
}