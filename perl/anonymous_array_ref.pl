#!/usr/bin/perl
use warnings;
use strict;

my $ar = [1..5];

# loop over the array elements
for(@$ar){
   print("$_  "); # 1 2 3 4 5
}

print("\n");
