#!perl

use warnings;
use strict;

use Net::IP::XS;

use Storable qw(freeze thaw);
use File::Temp qw(tempfile);
my (undef, $ft) = tempfile();

use Test::More tests => 12;
use Scalar::Util qw(blessed);

{
    my $ip = Net::IP::XS->new('::/0');
    is($ip->size(), 
    '340282366920938463463374607431768211456', 
    "Got size for IP address");
    my $serial = freeze($ip);
    open my $fh, '>', $ft or die $!;
    print $fh $serial;
    close $fh;
    undef $ip;
    undef $serial;

    open $fh, '<', $ft or die $!;
    my $con = do { local $/; <$fh> };
    close $fh;
    $ip = thaw($con);
    ok(exists $ip->{'xs_v6_ip0'}, 'First number is present');
    isa_ok($ip->{'xs_v6_ip0'}, 'Net::IP::XS::N128', 
        'First number has correct class');
    ok(exists $ip->{'xs_v6_ip1'}, 'Second number is present');
    isa_ok($ip->{'xs_v6_ip1'}, 'Net::IP::XS::N128', 
        'Second number has correct class');
    is($ip->size(), 
    '340282366920938463463374607431768211456', 
    "Got size for IP address");
    undef $ip;
    ok(1, "Completed serial-deserial process for IPv6 without issues");
}

{
    my $ip = Net::IP::XS->new('::/0');
    is($ip->size(), 
    '340282366920938463463374607431768211456', 
    "Got size for IP address");
    my $serial = freeze($ip);
    open my $fh, '>', $ft or die $!;
    print $fh $serial;
    close $fh;
    undef $ip;
    undef $serial;

    open $fh, '<', $ft or die $!;
    my $con = do { local $/; <$fh> };
    close $fh;

    {
        no warnings;
        no strict 'refs';
        *{'Net::IP::XS::set_ipv6_n128s'} = sub { 0 };
    }

    $ip = eval { thaw($con) };
    ok($@, 'Died when unable to set IPv6 N128 integers');
}

{
    my $ip = Net::IP::XS->new('0.0.0.0/0');
    is($ip->size(), 
       '4294967296',
       "Got size for IP address");
    my $serial = freeze($ip);
    open my $fh, '>', $ft or die $!;
    print $fh $serial;
    close $fh;
    undef $ip;
    undef $serial;

    open $fh, '<', $ft or die $!;
    my $con = do { local $/; <$fh> };
    close $fh;
    $ip = thaw($con);
    is($ip->size(), 
       '4294967296',
       "Got size for IP address");
    undef $ip;
    ok(1, "Completed serial-deserial process for IPv4 without issues");
}

1;
