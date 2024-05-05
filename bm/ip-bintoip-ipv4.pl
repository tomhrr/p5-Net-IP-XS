#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS;

my @entries = (
    ['00000000000000000000000000000000', 4],
    ['00000000000000000000000000000001', 4],
    ['00000000000001000000000100000001', 4],
    ['00001000000001000000100100010001', 4],
    ['10000000000000001000000000000000', 4],
    ['10000000100000001000000001000000', 4],
    ['10000000000000000000000000000000', 4],
    ['01010101001001001001001001001001', 4],
    ['11010111101101001011111001001101', 4],
    ['11111111111111111111111111111111', 4],
);

my ($type, $count) = @ARGV;
$count ||= 200000;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($binstr, $version) = @{$entry};
            Net::IP::ip_bintoip($binstr, $version);
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($binstr, $version) = @{$entry};
            Net::IP::XS::ip_bintoip($binstr, $version);
        }
    }
} else {
    die "invalid type $type";
}

1;
