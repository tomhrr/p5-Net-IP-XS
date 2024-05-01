#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS;

my @entries = (
    [0, 4],
    [8, 4],
    [16, 4],
    [24, 4],
    [32, 4],
    [0, 6],
    [32, 6],
    [64, 6],
    [91, 6],
    [128, 6],
);

my ($type, $count) = @ARGV;
$count ||= 400000;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($len, $version) = @{$entry};
            Net::IP::ip_get_mask($len, $version);
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($len, $version) = @{$entry};
            Net::IP::XS::ip_get_mask($len, $version);
        }
    }
} else {
    die "invalid type $type";
}

1;
