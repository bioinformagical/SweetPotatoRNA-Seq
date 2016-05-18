#!/usr/bin/perl                                                                                    
#2011-09-07 -mfc- script for extracting matching sequences from PE .fq files where some sequences have been removed                                                                                  

use strict;
use warnings;
use Getopt::Long;


my $pe1_in = "PE1 file";
my $pe2_in = "PE2 file";
my @prefix;
my $pe1_out;
my $pe2_out;

my $l1;
my $l2;
my $l3;
my $l4;

my %name1;
my %name2;

my $help;

my $input = GetOptions(
        "pe1=s" => \$pe1_in,
        "pe2=s" => \$pe2_in,
    "help" =>\$help);

if ($help){
        print "\n\nUsage: perl PE_match.pl --pe1 PE1_input_filename.fq --pe2 PE2_input_filename.fq\n\n";
	exit;
}

@prefix = split (/.fastq/,$pe1_in);
$pe1_out = join ('',$prefix[0],"_matched.fq");
@prefix = split (/.fastq/,$pe2_in);
$pe2_out = join ('',$prefix[0],"_matched.fq");

open IN1a, "<$pe1_in" or die "\n\nCannot open $pe1_in\n\nDid you specify the input files properly?\n\nUsage: perl PE_match.pl --pe1 PE1_input_filename.fq --pe2 PE2_input_filename.fq\n\n";
open IN1b, "<$pe1_in" or die "\n\nCannot open $pe1_in\nDid you specify the input files properly?\n\nUsage: perl PE_match.pl --pe1 PE1_input_filename.fq --pe2 PE2_input_filename.fq\n\n";
open IN2, "<$pe2_in" or die "\n\nCannot open $pe2_in\nDid you specify the input files properly?\n\nUsage: perl PE_match.pl --pe1 PE1_input_filename.fq --pe2 PE2_input_filename.fq\n\n";
open OUT1, ">$pe1_out" or die "\n\nCannot open output $pe1_out\n";
open OUT2, ">$pe2_out" or die "\n\nCannot open output $pe2_out\n";

while($l1=<IN1a>){
    $l2=<IN1a>;$l3=<IN1a>;$l4=<IN1a>;
    my @a = split(" ",$l1);
    $name1{$a[0]}=1;
}

while($l1=<IN2>){
    $l2=<IN2>;$l3=<IN2>;$l4=<IN2>;
    my @a = split(" ",$l1);
    if($name1{$a[0]}){
	print OUT2 $l1,$l2,$l3,$l4;
	$name2{$a[0]}=1;
    }
}
while($l1=<IN1b>){
    $l2=<IN1b>;$l3=<IN1b>;$l4=<IN1b>;
    my @a = split(" ",$l1);
    if($name2{$a[0]}){
	print OUT1 $l1,$l2,$l3,$l4;
    }
}



close(IN1a);
close(IN1b);
close(IN2);
close(OUT1);
close(OUT2);
