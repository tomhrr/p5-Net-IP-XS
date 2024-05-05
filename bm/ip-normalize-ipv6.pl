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
    $r1->prefix(),
    $r2->ip().'-'.$r2->last_ip(),
    $r3->ip(),
    $r4->prefix(),
    $r5->ip().'-'.$r5->last_ip(),
    $r6->ip(),
    $r7->prefix(),
    $r8->ip().'-'.$r8->last_ip(),
    $r9->ip(),
    $r10->prefix().',/64'
);

my ($type, $count) = @ARGV;
$count ||= 15000;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            Net::IP::ip_normalize($entry);
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            Net::IP::XS::ip_normalize($entry);
        }
    }
} else {
    die "invalid type $type";
}

1;
