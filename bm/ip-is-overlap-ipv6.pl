#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS qw(ip_iptobin);

my $rall  = Net::IP::XS->new('::/0');
my $rhalf = Net::IP::XS->new('::/1');
my $r1    = Net::IP::XS->new('2000::/32');
my $r2    = Net::IP::XS->new('2000:1::/32');
my $r3    = Net::IP::XS->new('4000::-B000::');
my $r4    = Net::IP::XS->new('8abc:1234:db83:9003::/64');
my $r5    = Net::IP::XS->new('8abc:1234:db83:9003:1000::-8abc:1234:db83:A000::');
my $r6    = Net::IP::XS->new('2000:1234:abcd:1234:abcd:1234::/112');
my $r7    = Net::IP::XS->new('2000:1234:abcd:1234:abcd:1234:1::/112');

my @entries = (
    [$rhalf->binip(), $rhalf->last_bin(),
     $r3->binip(),    $r3->last_bin()],
    [$r1->binip(),    $r1->last_bin(),
     $r2->binip(),    $r2->last_bin()],
    [$r1->binip(),    $r1->last_bin(),
     $rall->binip(),  $rall->last_bin()],
    [$rall->binip(),  $rall->last_bin(),
     $r1->binip(),    $r1->last_bin()],
    [$r4->binip(),    $r4->last_bin(),
     $r5->binip(),    $r5->last_bin()],
    [$r6->binip(),    $r6->last_bin(),
     $r7->binip(),    $r7->last_bin()],
    [$r6->binip(),    $r6->last_bin(),
     $r6->binip(),    $r6->last_bin()],
    [$r6->binip(),    $r6->last_bin(),
     $r6->binip(),    $r6->last_bin()],
    [$r1->binip(),    $r1->last_bin(),
     $r2->binip(),    $r2->last_bin()],
    [$r2->binip(),    $r2->last_bin(),
     $r1->binip(),    $r1->last_bin()],
);

my ($type, $count) = @ARGV;
$count ||= 10000;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($b1, $e1, $b2, $e2) = @{$entry};
            Net::IP::ip_is_overlap($b1, $e1, $b2, $e2);
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($b1, $e1, $b2, $e2) = @{$entry};
            Net::IP::XS::ip_is_overlap($b1, $e1, $b2, $e2);
        }
    }
} else {
    die "invalid type $type";
}

1;
