#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS;

my @entries = qw(
    ::
    1::
    1234:5678:09AB:CDEF:1234:5678:09AB:CDEF
    qwer
    1234:5678:09AB::5678:09AB:CDEF
    255.255.255.256
    1.2.3.4
    203.119.101.45
    103.0.4.4
    asdf
);

my ($type, $count) = @ARGV;
$count ||= 100000;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            Net::IP::ip_get_version($entry);
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            Net::IP::XS::ip_get_version($entry);
        }
    }
} else {
    die "invalid type $type";
}

1;
