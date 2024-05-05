#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS;

my @entries = (
    '1.0.0.0/24',
    '1.8.0.0/16',
    '1.0.0.0/8',
    '2.0.0.0/7',
    '200.1.2.0/24',
    '103.128.0.0/16',
    '16.2.64.0/24',
    '55.2.32.0/24',
    '255.2.16.0/24',
    '255.2.16.0/32',
);

my ($type, $count) = @ARGV;
$count ||= 100000;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            Net::IP::ip_splitprefix($entry);
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            Net::IP::XS::ip_splitprefix($entry);
        }
    }
} else {
    die "invalid type $type";
}

1;
