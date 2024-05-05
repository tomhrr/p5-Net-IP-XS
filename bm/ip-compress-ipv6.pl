#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS;

my @entries = (
    '2000:0000:0000:0000:0000:0000:0000:0000',
    '0001:0000:0000:0000:0000:0003:0004:0005',
    '0001:0003:0004:0000:0000:0000:0000:0005',
    '2000:1234:0000:0000:0000:0000:0000:0000',
    '0000:0000:0000:0000:0000:0000:0000:0001',
    '0001:0000:0000:0000:0000:0000:0000:0000',
    '0000:0000:0000:0000:0000:0000:0000:0000',
    '1234:1234:1234:1234:1234:1234:1234:1234',
    '0123:0123:0123:0123:0123:0123:0123:0123',
    '1234:1234:1234:1234:0000:5678:5678:5687',
);

my ($type, $count) = @ARGV;
$count ||= 200000;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            my $res = Net::IP::ip_compress_address($entry, 6);
            print "$res\n";
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            my $res = Net::IP::XS::ip_compress_address($entry, 6);
            print "$res\n";
        }
    }
} else {
    die "invalid type $type";
}

1;
