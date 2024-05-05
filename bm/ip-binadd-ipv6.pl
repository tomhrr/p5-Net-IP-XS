#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS qw(ip_iptobin);

my $r1  = Net::IP::XS->new('2000::/16');
my $r2  = Net::IP::XS->new('4000::/128');
my $r3  = Net::IP::XS->new('8000::/1');
my $r4  = Net::IP::XS->new('8000::/15');
my $r5  = Net::IP::XS->new('2001:3200::/32');
my $r6  = Net::IP::XS->new('1234:1234:1234::/48');
my $r7  = Net::IP::XS->new('abcd:abcd:abcd:abcd::/64');
my $r8  = Net::IP::XS->new('1:2:3:4::/64');
my $r9  = Net::IP::XS->new('1:5:a:b::/96');
my $r10 = Net::IP::XS->new('abcd::/30');

my @entries = (
    [$r1->binip(),  $r1->last_bin()],
    [$r2->binip(),  $r2->last_bin()],
    [$r3->binip(),  $r3->last_bin()],
    [$r4->binip(),  $r4->last_bin()],
    [$r5->binip(),  $r5->last_bin()],
    [$r6->binip(),  $r6->last_bin()],
    [$r7->binip(),  $r7->last_bin()],
    [$r8->binip(),  $r8->last_bin()],
    [$r9->binip(),  $r9->last_bin()],
    [$r10->binip(), $r10->last_bin()],
);

my ($type, $count) = @ARGV;
$count ||= 5000;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($b, $e) = @{$entry};
            Net::IP::ip_binadd($b, $e);
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($b, $e) = @{$entry};
            Net::IP::XS::ip_binadd($b, $e);
        }
    }
} else {
    die "invalid type $type";
}

1;
