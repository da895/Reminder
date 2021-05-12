#!/usr/bin/perl
use warnings;
use strict;

my $address = { "building" => 1000, 
                "street" => "ABC street", 
                "city"   => "Headquarter",
                "state" => "CA", 
                "zipcode" => 95134,
                "country" => "USA" 
              };

print $address->{building},"\n";
print $address->{street},"\n";
