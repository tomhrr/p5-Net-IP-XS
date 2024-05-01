#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS;

my @entries = qw(
    0.0.0.-1
    0.0.0.0
    0.0.0.1
    asdf
    255.255.255.255
    255.255.255.256
    1.2.3.4
    203.119.101.45
    103.0.4.4
    50.51.52.53
);

my ($type, $count) = @ARGV;
$count ||= 200000;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            Net::IP::ip_is_ipv4($entry);
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            Net::IP::XS::ip_is_ipv4($entry);
        }
    }
} else {
    die "invalid type $type";
}

1;
