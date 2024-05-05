#!/usr/bin/perl

use warnings;
use strict;

use Net::IP;
use Net::IP::XS;

my $r1  = Net::IP::XS->new('1.0.0.0/24');
my $r2  = Net::IP::XS->new('1.8.0.0/16');
my $r3  = Net::IP::XS->new('1.0.0.0/8');
my $r4  = Net::IP::XS->new('2.0.0.0/7');
my $r5  = Net::IP::XS->new('200.1.2.0/24');
my $r6  = Net::IP::XS->new('103.128.0.0/16');
my $r7  = Net::IP::XS->new('16.2.64.0/24');
my $r8  = Net::IP::XS->new('55.2.32.0/24');
my $r9  = Net::IP::XS->new('255.2.16.0/24');
my $r10 = Net::IP::XS->new('255.2.16.0/32');

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
    $r10->prefix().',/32'
);

my ($type, $count) = @ARGV;
$count ||= 25000;

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
