#!/usr/bin/perl

use warnings;
use strict;

use JSON::XS qw(encode_json);

# Performance counter stats for 'perl bm/ip-is-ipv6.pl --net-ip-xs':
#
#            249.34 msec task-clock                #    0.998 CPUs utilized
#                 1      context-switches          #    0.004 K/sec
#                 0      cpu-migrations            #    0.000 K/sec
#             2,307      page-faults               #    0.009 M/sec
#       894,836,326      cycles                    #    3.589 GHz
#     2,238,652,546      instructions              #    2.50  insn per cycle
#       505,347,045      branches                  # 2026.730 M/sec
#         3,707,232      branch-misses             #    0.73% of all branches
#
#       0.249933484 seconds time elapsed
#
#       0.249950000 seconds user
#       0.000000000 seconds sys

sub parse_output
{
    my @output = @_;

    chomp for @output;
    my %data;
    for my $line (@output) {
        if (my ($cycles) = ($line =~ /\s([\d,]+)\s+cycles/)) {
            $data{'cycles'} = $cycles;
        } elsif (my ($instr) = ($line =~ /\s([\d,]+)\s+instructions/)) {
            $data{'instructions'} = $instr;
        } elsif (my ($branches) = ($line =~ /\s([\d,]+)\s+branches/)) {
            $data{'branches'} = $branches;
        } elsif (my ($branch_misses) = ($line =~ /\s([\d,]+)\s+branch-misses/)) {
            $data{'branchmisses'} = $branch_misses;
        } elsif (my ($msec) = ($line =~ /\s([\d,\.]+)\s+msec\s+task-clock/)) {
            $data{'msec'} = $msec;
        }
    }
    for my $key (keys %data) {
        $data{$key} =~ s/,//g;
    }

    return \%data;
}

my ($script_name, $iterations) = @ARGV;

my @net_ip_output    = `sudo perf stat --all-user taskset -c 0 nice -n -20 perl $script_name net-ip    $iterations 2>&1`;
my @net_ip_xs_output = `sudo perf stat --all-user taskset -c 0 nice -n -20 perl $script_name net-ip-xs $iterations 2>&1`;
my $net_ip_data      = parse_output(@net_ip_output);
my $net_ip_xs_data   = parse_output(@net_ip_xs_output);

my $final_data = {
    'name'       => $script_name,
    'iterations' => $iterations,
    'net-ip'     => $net_ip_data,
    'net-ip-xs'  => $net_ip_xs_data,
};

print encode_json($final_data);

1;
