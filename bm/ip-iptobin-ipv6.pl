#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS qw(ip_expand_address);

my @entries =
    map { ip_expand_address($_, 6) }
        ('::',
         '1234:1234:1234:1234:1234:1234:1234:1234',
         'abcd:abcd:1234:abcd::',
         'abcd:abcd:1234::abcd',
         'abcd:abcd::1234:abcd',
         'abcd::abcd:1234:abcd',
         'ffff:ffff::ffff:ffff:ffff:ffff',
         '1234:ffff::ffff:67bc:ffff:ffff',
         '2000:1600::',
         '2001:1234:1234::');

my ($type, $count) = @ARGV;
$count ||= 150000;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            Net::IP::ip_iptobin($entry, 6);
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            Net::IP::XS::ip_iptobin($entry, 6);
        }
    }
} else {
    die "invalid type $type";
}

1;
