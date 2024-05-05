#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS qw(ip_iptobin);

my $r1  = Net::IP::XS->new('0.0.0.0/8');
my $r2  = Net::IP::XS->new('1.0.0.0/8');
my $r3  = Net::IP::XS->new('10.0.0.0/23');
my $r4  = Net::IP::XS->new('10.0.2.0/23');
my $r5  = Net::IP::XS->new('15.0.0.0/9');
my $r6  = Net::IP::XS->new('15.128.0.0/9');
my $r7  = Net::IP::XS->new('240.0.0.0');
my $r8  = Net::IP::XS->new('240.0.0.1');
my $r9  = Net::IP::XS->new('255.255.255.254');
my $r10 = Net::IP::XS->new('255.255.255.255');

my @entries = (
    [$r1->binip(), $r1->last_bin(), $r2->binip(), $r2->last_bin()],
    [$r3->binip(), $r3->last_bin(), $r4->binip(), $r4->last_bin()],
    [$r5->binip(), $r5->last_bin(), $r6->binip(), $r6->last_bin()],
    [$r7->binip(), $r7->last_bin(), $r8->binip(), $r8->last_bin()],
    [$r9->binip(), $r9->last_bin(), $r10->binip(), $r10->last_bin()],
    [$r1->binip(), $r1->last_bin(), $r3->binip(), $r3->last_bin()],
    [$r3->binip(), $r3->last_bin(), $r6->binip(), $r6->last_bin()],
    [$r5->binip(), $r5->last_bin(), $r1->binip(), $r8->last_bin()],
    [$r7->binip(), $r7->last_bin(), $r2->binip(), $r9->last_bin()],
    [$r9->binip(), $r9->last_bin(), $r3->binip(), $r10->last_bin()],
);

my ($type, $count) = @ARGV;
$count ||= 3000;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($b1, $e1, $b2, $e2) = @{$entry};
            Net::IP::ip_aggregate($b1, $e1, $b2, $e2, 4);
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($b1, $e1, $b2, $e2) = @{$entry};
            Net::IP::XS::ip_aggregate($b1, $e1, $b2, $e2, 4);
        }
    }
} else {
    die "invalid type $type";
}

1;
