#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS;

my @entries = (
    '0.0.0',
    '1.2',
    '10.0.0.0',
    '12.34.45',
    '50',
    '103',
    '103.255.255.255',
    '203.255.255',
    '240.0.0',
    '255.255.255.255',
);

my ($type, $count) = @ARGV;
$count ||= 120000;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            Net::IP::ip_expand_address($entry, 4);
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            Net::IP::XS::ip_expand_address($entry, 4);
        }
    }
} else {
    die "invalid type $type";
}

1;
