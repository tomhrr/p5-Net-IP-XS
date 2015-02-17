#!perl

use strict;
use warnings;

use Test::More;
use Net::IP::XS;

if (eval 'use threads; 1') {
    {
        my $ip = Net::IP::XS->new('::1');
        threads->create(sub {});
        $_->join for threads->list;
    }
    ok('Did not crash.');
}
else {
    plan skip_all => 'Non-threaded Perl cannot test threads.';
}

done_testing();