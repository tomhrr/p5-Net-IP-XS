#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS qw(ip_iptobin);

my @entries = (
    [ip_iptobin('0.0.0.0', 4),     ip_iptobin('127.255.255.255', 4),
     ip_iptobin('126.0.0.0', 4),   ip_iptobin('128.255.255.255', 4)],
    [ip_iptobin('1.0.0.0', 4),     ip_iptobin('1.255.255.255', 4),
     ip_iptobin('2.0.0.0', 4),     ip_iptobin('2.255.255.255', 4)],
    [ip_iptobin('100.0.0.0', 4),   ip_iptobin('100.255.255.255', 4),
     ip_iptobin('50.0.0.0', 4),    ip_iptobin('150.255.255.255', 4)],
    [ip_iptobin('50.0.0.0', 4),    ip_iptobin('150.255.255.255', 4),
     ip_iptobin('100.0.0.0', 4),   ip_iptobin('100.255.255.255', 4)],
    [ip_iptobin('120.0.1.0', 4),   ip_iptobin('120.0.1.255', 4),
     ip_iptobin('120.0.1.128', 4), ip_iptobin('120.0.2.127', 4)],
    [ip_iptobin('240.0.25.0', 4),  ip_iptobin('240.0.25.255', 4),
     ip_iptobin('240.0.26.0', 4),  ip_iptobin('240.0.26.255', 4)],
    [ip_iptobin('100.0.200.0', 4), ip_iptobin('100.0.215.255', 4),
     ip_iptobin('100.0.200.0', 4), ip_iptobin('100.0.215.255', 4)],
    [ip_iptobin('100.0.200.0', 4), ip_iptobin('100.0.215.255', 4),
     ip_iptobin('100.0.200.0', 4), ip_iptobin('100.0.215.255', 4)],
    [ip_iptobin('1.0.0.0', 4),     ip_iptobin('1.255.255.255', 4),
     ip_iptobin('2.0.0.0', 4),     ip_iptobin('2.255.255.255', 4)],
    [ip_iptobin('240.0.25.0', 4),  ip_iptobin('240.0.25.255', 4),
     ip_iptobin('240.0.26.0', 4),  ip_iptobin('240.0.26.255', 4)],
);

my ($type, $count) = @ARGV;
$count ||= 20000;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($b1, $e1, $b2, $e2) = @{$entry};
            Net::IP::ip_is_overlap($b1, $e1, $b2, $e2);
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($b1, $e1, $b2, $e2) = @{$entry};
            Net::IP::XS::ip_is_overlap($b1, $e1, $b2, $e2);
        }
    }
} else {
    die "invalid type $type";
}

1;
