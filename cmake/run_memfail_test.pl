#!/usr/bin/env perl
# SPDX-License-Identifier: Unlicense
# Run the upstream allocation-failure workload without configdata.pm.
use strict;
use warnings;
use File::Temp qw(tempfile);
my ($program, $fixture, $all) = @ARGV;
die "Usage: $0 program fixture [--all]\n" unless defined $fixture;
my ($fh, $log) = tempfile(UNLINK => 1);
close $fh;
# List-form pipe invocation preserves paths and does not invoke a shell.
open my $saved_stderr, '>&', \*STDERR or die "dup stderr: $!";
open STDERR, '>', $log or die "open log: $!";
my $result = system($program, 'count', $fixture);
open STDERR, '>&', $saved_stderr or die "restore stderr: $!";
open my $count_log, '<', $log or die "read log: $!";
local $/;
my $counts = <$count_log>;
close $count_log;
die "Allocation count run failed:\n$counts" if $result != 0;
my ($skip, $count) = $counts =~ /skip:\s*(\d+)\s+count\s+(\d+)/;
die "No allocation counts found:\n$counts" unless defined $count && $count > 0;
my @indices = defined($all) && $all eq '--all'
    ? (0 .. $count - 1) : (0, int($count / 2), $count - 1);
for my $index (@indices) {
    local $ENV{OPENSSL_MALLOC_FAILURES} = "$skip\@0;$index\@0;1\@100;0\@0";
    print "Injecting allocation failure $index of $count\n";
    system($program, 'run', $fixture) == 0
        or die "Allocation failure test failed at $index\n";
}
