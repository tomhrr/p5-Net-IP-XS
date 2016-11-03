#!/usr/bin/env perl

use warnings;
use strict;

use Test::More tests => 9;

use Net::IP::XS qw(ip_normal_range);

my @data = (
    ['0.0.0.0'       => ['0.0.0.0 - 0.0.0.0']],
    ['0.0.0.0 + 255' => ['0.0.0.0 - 0.0.0.255']],
    ['0.0.0.0 + 16777215' => ['0.0.0.0 - 0.255.255.255']],
    ['0.0.0.0 + 16777216' => ['0.0.0.0 - 1.0.0.0']],
    ['0.0.0.0 + 4294967295' => ['0.0.0.0 - 255.255.255.255']],
    ['0.0.0.0 + 4294967296' => [undef]],
    [':: + 340282366920938463463374607431768211455' =>
                        ['0000:0000:0000:0000:0000:0000:0000:0000 - '.
                         'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff']],
    [':: + 340282366920938463463374607431768211456' => [ undef ] ],
    [':: + 333333340282366920938463463374607431768211456' => [ undef ] ],
);

for my $entry (@data) {
    my ($arg, $res) = @{$entry};
    my @res_t = ip_normal_range($arg);
    is_deeply(\@res_t, $res, "Got normal range for $arg");
}

1;
