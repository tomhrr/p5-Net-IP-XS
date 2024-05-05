#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS qw(ip_iptobin);

my @entries = (
    [ip_iptobin('::',  6), 0],
    [ip_iptobin('::',  6), 24],
    [ip_iptobin('::1', 6), 127],
    [ip_iptobin('::1', 6), 128],
    [ip_iptobin('1000:1234:4567:', 6), 48],
    [ip_iptobin('1000::', 6), 16],
    [ip_iptobin('8000::', 6), 1],
    [ip_iptobin('1234:1234:1234:1234:1234:1234:1234:1234', 6), 127],
    [ip_iptobin('1234:1234:1234:1234:1234:1234:1234:1234', 6), 128],
    [ip_iptobin('ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff', 6), 126],
);

my ($type, $count) = @ARGV;
$count ||= 200000;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($bin_ip, $len) = @{$entry};
            Net::IP::ip_check_prefix($bin_ip, $len, 6);
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($bin_ip, $len) = @{$entry};
            Net::IP::XS::ip_check_prefix($bin_ip, $len, 6);
        }
    }
} else {
    die "invalid type $type";
}

1;
