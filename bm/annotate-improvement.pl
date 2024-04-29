#!/usr/bin/perl

use warnings;
use strict;

use JSON::XS qw(decode_json encode_json);

my @output_lines = <>;
chomp for @output_lines;
my $output = join '', @output_lines;
my $data = decode_json($output);

my $net_ip    = $data->{'net-ip'};
my $net_ip_xs = $data->{'net-ip-xs'};

my %improvement =
    map { my $net_ip_value    = $net_ip->{$_};
          my $net_ip_xs_value = $net_ip_xs->{$_};
          my $multiplier      = $net_ip_value / $net_ip_xs_value;
          $_ => $multiplier }
        keys %{$net_ip};

$data->{'improvement'} = \%improvement;

print encode_json($data);

1;
