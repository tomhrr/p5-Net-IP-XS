#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS qw(ip_iptobin);

my $r1  = Net::IP::XS->new('0.0.0.0');
my $r2  = Net::IP::XS->new('0.0.0.1');
my $r3  = Net::IP::XS->new('10.1.2.3');
my $r4  = Net::IP::XS->new('20.5.6.7');
my $r5  = Net::IP::XS->new('50.12.32.12');
my $r6  = Net::IP::XS->new('150.55.0.100');
my $r7  = Net::IP::XS->new('240.0.0.128');
my $r8  = Net::IP::XS->new('245.200.200.200');
my $r9  = Net::IP::XS->new('255.255.255.254');
my $r10 = Net::IP::XS->new('255.255.255.255');

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
$count ||= 400;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($b, $e) = @{$entry};
            Net::IP::ip_range_to_prefix($b, $e, 4);
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($b, $e) = @{$entry};
            Net::IP::XS::ip_range_to_prefix($b, $e, 4);
        }
    }
} else {
    die "invalid type $type";
}

1;
