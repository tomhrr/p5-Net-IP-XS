#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS qw(ip_iptobin);

my $r1  = Net::IP::XS->new('1000::/16');
my $r2  = Net::IP::XS->new('1001::/16');
my $r3  = Net::IP::XS->new('3000:0000::/31');
my $r4  = Net::IP::XS->new('3000:0002::/31');
my $r5  = Net::IP::XS->new('4000:0000::/17');
my $r6  = Net::IP::XS->new('4000:8000::/17');
my $r7  = Net::IP::XS->new('abab::');
my $r8  = Net::IP::XS->new('abab::1');
my $r9  = Net::IP::XS->new('ffff:ffff:ffff:ffff:ffff:ffff:ffff:fffe');
my $r10  = Net::IP::XS->new('ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff');

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
$count ||= 500;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($b1, $e1, $b2, $e2) = @{$entry};
            Net::IP::ip_aggregate($b1, $e1, $b2, $e2, 6);
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($b1, $e1, $b2, $e2) = @{$entry};
            Net::IP::XS::ip_aggregate($b1, $e1, $b2, $e2, 6);
        }
    }
} else {
    die "invalid type $type";
}

1;
