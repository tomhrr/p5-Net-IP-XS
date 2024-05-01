#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS;

my @entries = (
    [0, 4],
    [1, 4],
    [262401, 4],
    [134482193, 4],
    [2147516416, 4],
    [2155905088, 4],
    [2147483648, 4],
    [1428460105, 4],
    [3618946637, 4],
    [4294967295, 4],
);

my ($type, $count) = @ARGV;
$count ||= 2000;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($binstr, $version) = @{$entry};
            Net::IP::ip_bintoint($binstr, $version);
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($binstr, $version) = @{$entry};
            Net::IP::XS::ip_bintoint($binstr, $version);
        }
    }
} else {
    die "invalid type $type";
}

1;
