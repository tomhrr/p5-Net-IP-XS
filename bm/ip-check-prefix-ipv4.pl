#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS qw(ip_iptobin);

my @entries = (
    [ip_iptobin('0.0.0.0',         4), 0],
    [ip_iptobin('0.0.0.0',         4), 24],
    [ip_iptobin('0.0.0.1',         4), 25],
    [ip_iptobin('0.0.0.0',         4), 32],
    [ip_iptobin('10.0.2.0',        4), 22],
    [ip_iptobin('126.0.0.0',       4), 7],
    [ip_iptobin('126.54.255.1',    4), 31],
    [ip_iptobin('126.54.255.1',    4), 32],
    [ip_iptobin('103.0.128.0',     4), 17],
    [ip_iptobin('255.255.255.255', 4), 30],
);

my ($type, $count) = @ARGV;
$count ||= 200000;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($bin_ip, $len) = @{$entry};
            Net::IP::ip_check_prefix($bin_ip, $len, 4);
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($bin_ip, $len) = @{$entry};
            Net::IP::XS::ip_check_prefix($bin_ip, $len, 4);
        }
    }
} else {
    die "invalid type $type";
}

1;
