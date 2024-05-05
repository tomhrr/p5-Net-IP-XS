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

my @entries =
    map { [ $_->ip(), $_->prefixlen() ] }
        ($r1, $r2, $r3, $r4, $r5,
         $r6, $r7, $r8, $r9, $r10);

my ($type, $count) = @ARGV;
$count ||= 200000;

if ($type eq 'net-ip') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($ip, $len) = @{$entry};
            Net::IP::ip_compress_v4_prefix($ip, $len);
        }
    }
} elsif ($type eq 'net-ip-xs') {
    for (1..$count) {
        for my $entry (@entries) {
            my ($ip, $len) = @{$entry};
            Net::IP::XS::ip_compress_v4_prefix($ip, $len);
        }
    }
} else {
    die "invalid type $type";
}

1;
