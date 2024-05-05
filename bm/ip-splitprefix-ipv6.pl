#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS;

my @entries = (
    '2000::/24',
    '2000::/16',
    '2000::/8',
    '2000::/7',
    '1234:1234:1234::1234:4567:7643/128',
    'abcd:abcd:abc::/64',
    '1200:b0:c:def:123:123:123::/112',
    '1234:2345:2345::/48',
    'a:b:c::/48',
    'a:b:d:c::/64',
);

my ($type, $count) = @ARGV;
$count ||= 100000;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            Net::IP::ip_splitprefix($entry);
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            Net::IP::XS::ip_splitprefix($entry);
        }
    }
} else {
    die "invalid type $type";
}

1;
