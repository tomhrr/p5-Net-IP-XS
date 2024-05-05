#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS qw(ip_iptobin);

my $r1  = Net::IP::XS->new('1.0.0.0/24');
my $r2  = Net::IP::XS->new('1.0.0.0/16');
my $r3  = Net::IP::XS->new('1.0.0.0/8');
my $r4  = Net::IP::XS->new('2.0.0.0/7');
my $r5  = Net::IP::XS->new('200.1.2.0/24');
my $r6  = Net::IP::XS->new('103.128.0.0/9');
my $r7  = Net::IP::XS->new('16.2.64.0/18');
my $r8  = Net::IP::XS->new('55.2.32.0/19');
my $r9  = Net::IP::XS->new('255.2.16.0/20');
my $r10 = Net::IP::XS->new('255.2.16.0/32');

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
$count ||= 80000;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($b, $e) = @{$entry};
            Net::IP::ip_get_prefix_length($b, $e);
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($b, $e) = @{$entry};
            Net::IP::XS::ip_get_prefix_length($b, $e);
        }
    }
} else {
    die "invalid type $type";
}

1;
