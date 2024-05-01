#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS;

my @entries = (
    [0, 6],
    [79228162532711081671548469249, 6],
    [20789549076745920541695989879406849, 6],
    [10654777044759420498591943850398583057, 6],
    [170143779648513184874767057851898691584, 6],
    [170808398717162787409674889692530638912, 6],
    [170141183500083312998042844551658340352, 6],
    [113174269370433537659203701896015811145, 6],
    [286722492353444171507882671371166465613, 6],
    [340282366920938463463374607431768211455, 6],
);

my ($type, $count) = @ARGV;
$count ||= 1000;

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
