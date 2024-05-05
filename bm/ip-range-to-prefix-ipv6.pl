#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS qw(ip_iptobin);

my $r1  = Net::IP::XS->new('::');
my $r2  = Net::IP::XS->new('::1');
my $r3  = Net::IP::XS->new('1234:5678::');
my $r4  = Net::IP::XS->new('2234:1234:1234:2345:4567:5678:6789:6789');
my $r5  = Net::IP::XS->new('8abe:3bd2:1dab:93ba:5092:abfe:45ff:1234');
my $r6  = Net::IP::XS->new('a123:a123:a123:a123::');
my $r7  = Net::IP::XS->new('b123:a123:a123:a123::');
my $r8  = Net::IP::XS->new('c123:a123:a123:a123::');
my $r9  = Net::IP::XS->new('ffff:ffff:ffff:ffff:ffff:ffff:ffff:fffe');
my $r10 = Net::IP::XS->new('ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff');

my @entries = (
    [$r1->binip(),  $r10->binip()],
    [$r1->binip(),  $r9->binip()],
    [$r1->binip(),  $r2->binip()],
    [$r2->binip(),  $r9->binip()],
    [$r2->binip(),  $r10->binip()],
    [$r3->binip(),  $r4->binip()],
    [$r5->binip(),  $r6->binip()],
    [$r7->binip(),  $r8->binip()],
    [$r3->binip(),  $r6->binip()],
    [$r6->binip(),  $r8->binip()],
);

my ($type, $count) = @ARGV;
$count ||= 75;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($b, $e) = @{$entry};
            Net::IP::ip_range_to_prefix($b, $e, 6);
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($b, $e) = @{$entry};
            Net::IP::XS::ip_range_to_prefix($b, $e, 6);
        }
    }
} else {
    die "invalid type $type";
}

1;
