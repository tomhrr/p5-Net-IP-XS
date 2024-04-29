#!/usr/bin/perl

use warnings;
use strict;

use blib;
use Net::IP;
use Net::IP::XS;

my @entries = qw(
    ::
    1::
    ::1
    1234:5678:09AB:CDEF:1234:5678:09AB:CDEF
    qwer
    1234:5678:09AB::5678:09AB:CDEF
    123:567:09A:CDE:123:567:09A:CDE
    123:567:09A:CDE:123:567::CDE
    123:567:09A:CDE:123:567::CDG
    123::567:09A:CDE:123:567:::CDE
    AAAA:BBBB:CCCC::
    ::CCCC:BBBB:AAAA
    asdf
);

if ($ARGV[0] eq '--net-ip') {
    for (1..100000) {
        for my $entry (@entries) {
            Net::IP::ip_is_ipv6($entry);
        }
    }
} elsif ($ARGV[0] eq '--net-ip-xs') {
    for (1..100000) {
        for my $entry (@entries) {
            Net::IP::XS::ip_is_ipv6($entry);
        }
    }
}

1;
