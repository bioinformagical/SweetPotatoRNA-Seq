#!/usr/bin/perl

use strict;
use warnings;

open FH1,$ARGV[0] or die "\n can not open file $ARGV[0]\n";  ## first pair
open FH2,$ARGV[1] or die "\n can not open file $ARGV[1]\n";  ## second pair
my($str1,$str2,$tempStr);
my($n1,$n2);
$n1 = 0;
$n2 = 0;
print " Validating $ARGV[0] and $ARGV[1] \n";
my(@a1,@a2);

	while($str1 = <FH1>){
	$tempStr = <FH1>;
	$tempStr = <FH1>;
	$tempStr = <FH1>;
	++$n1;
	
	$str2 = <FH2>;
	$tempStr = <FH2>;
	$tempStr = <FH2>;
	$tempStr = <FH2>;
	++$n2;

	$str1 =~ s/\n//;
	$str1 =~ s/\r//;
	$str2 =~ s/\n//;
	$str2 =~ s/\r//;


	@a1 = split(/\s+/,$str1);
	@a2 = split(/\s+/,$str2);

	$str1 = $a1[0];
	$str2 = $a2[0];

	$str1 =~ s/(\/\d)$//;
	$str2 =~ s/(\/\d)$//;

		if($str1 ne $str2){
		die "Read pairs not found for $str1 and $str2, mate-pair files are not ordered\n";
		}
	}  ## while(<FH1>) ends
close FH1;
close FH2;

print "Total validated mates: $n1 and $n2: Read-pairs are properly ordered\n";

