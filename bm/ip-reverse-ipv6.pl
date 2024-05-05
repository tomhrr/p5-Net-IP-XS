#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS;

my $r1  = Net::IP::XS->new('2000::/24');
my $r2  = Net::IP::XS->new('2000::/16');
my $r3  = Net::IP::XS->new('2000::/8');
my $r4  = Net::IP::XS->new('2000::/7');
my $r5  = Net::IP::XS->new('1234:1234:1234::1234:4567:7643/128');
my $r6  = Net::IP::XS->new('abcd:abcd:abc::/64');
my $r7  = Net::IP::XS->new('1200:b0:c:def:123:123:123::/112');
my $r8  = Net::IP::XS->new('1234:2345:2345::/48');
my $r9  = Net::IP::XS->new('a:b:c::/48');
my $r10 = Net::IP::XS->new('a:b:d:c::/64');

my @entries = (
    [$r1->ip(),  $r1->prefixlen()],
    [$r2->ip(),  $r2->prefixlen()],
    [$r3->ip(),  $r3->prefixlen()],
    [$r4->ip(),  $r4->prefixlen()],
    [$r5->ip(),  $r5->prefixlen()],
    [$r6->ip(),  $r6->prefixlen()],
    [$r7->ip(),  $r7->prefixlen()],
    [$r8->ip(),  $r8->prefixlen()],
    [$r9->ip(),  $r9->prefixlen()],
    [$r10->ip(), $r10->prefixlen()],
);

my ($type, $count) = @ARGV;
$count ||= 20000;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($ip, $len) = @{$entry};
            Net::IP::ip_reverse($ip, $len, 6);
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($ip, $len) = @{$entry};
            Net::IP::XS::ip_reverse($ip, $len, 6);
        }
    }
} else {
    die "invalid type $type";
}

1;
