#!/usr/bin/env perl

use strict;
use warnings;

my (
    $file_directory,
    $input_fasta,
    $seq,
    $output_bed,
    $output_text,
    );
$output_bed ='C:\Users\LUTHER\Desktop\data\bedTest.txt';
$input_fasta ='C:\Users\LUTHER\Desktop\data\HighH2AF_LossMe_Bed.fa';
$output_text = 'C:\Users\LUTHER\Desktop\data\txtTest.txt';
my @files = ($file_directory, $input_fasta, $output_bed, $output_text,);

#unless (scalar(@ARGV) == 4){
#    if (scalar(@ARGV)<3){
#        print "not enough files"
#    };
#}
#for (my $i=0; $i < scalar(@ARGV);){
#    $files[$i]=$ARGV[$i];
#}
#open files
open my $input, "<", $input_fasta
    or die "unable to open $input_fasta";
open my $bed_out, ">", $output_bed
    or die "cannot create bed file";
open my $text_out, ">", $output_text
    or die "cannot create text file";
my(
    @atb,
    $mcount,
    $tline,
    $numfastaline,
    $chr,
    $strt,
    $stop,
    $bin,
    $num_obs,
    $fastaevery,
    $seq_raw,
    $center,
    @listcenters,
    @fasta,
    $motif,
);
print "new attempt\n";
$motif = 'TGACGTCA';
$mcount = 0;
$tline = 0;
#determine sequence length

while (my $line = <$input>){
    if ($line =~ /chr/){
        $mcount++;
    }
    push @fasta, $line;
    $tline++;
}
$fastaevery =$tline/$mcount;
$numfastaline=($tline/$mcount)-1;
my (
    $i,
    $head,
    @info,
    $seq_count,
    );
$seq_count = 0;
#@info = ($chr, $strt, $stop, $bin, $num_obs, @centers);
for ($i=0; $i < $tline; $i+=6){
    $seq_raw = "";
    @listcenters = ();
    chomp ($fasta[$i]);
    my $colon = index $fasta[$i], ":";
    my $divide = index $fasta[$i], "..";
    my $end = length($fasta[$i])-1;
    $chr = substr $fasta[$i], 4, $colon-4;        
    $strt = substr $fasta[$i], $colon+1, $divide-($colon+1);
    $stop = substr $fasta[$i], $divide+2, $end;
    for (my $j = 1; $j < $numfastaline+1; $j++){
        $seq_raw = $seq_raw.$fasta[$i+$j];
        chomp $seq_raw;
    }
    if ($seq_raw =~ /$motif/){
        $bin = 1;
        my $offset = 0;
        $num_obs = 1;
        while ($offset < length $seq_raw){
            $center = index $seq_raw, $motif, $offset;
            push @listcenters, $center + 1;
            $offset = $center + 1;
            }
        }
    else {
        $bin = 0;
        @listcenters = ("0\n");
        $num_obs = 0;
    }
    print join "\n", @listcenters;
    $num_obs = scalar @listcenters;
        #print $text_out "$center\n";        
        $seq_count++;
        #@atb = ($chr, $strt, $stop, $bin, $center);
    #print join("\t",@atb), "\n";
}
print "\n\n", "Total number of regions: $mcount\n";
print "Number of seq containing test: $seq_count";
