#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS;

my @entries = (
    ['00000000000000000000000000000000', 0, 4],
    ['00000000000000000000000000000001', 1, 4],
    ['00000000000001000000000100000001', 16, 4],
    ['00001000000001000000100100010001', 32, 4],
    ['10000000000000001000000000000000', 12, 4],
    ['10000000100000001000000001000000', 4, 4],
    ['10000000000000000000000000000000', 8, 4],
    ['01010101001001001001001001001001', 24, 4],
    ['11010111101101001011111001001101', 22, 4],
    ['11111111111111111111111111111111', 20, 4],
);

my ($type, $count) = @ARGV;
$count ||= 200000;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($binstr, $len, $version) = @{$entry};
            Net::IP::ip_last_address_bin($binstr, $len, $version);
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($binstr, $len, $version) = @{$entry};
            Net::IP::XS::ip_last_address_bin($binstr, $len, $version);
        }
    }
} else {
    die "invalid type $type";
}

1;
