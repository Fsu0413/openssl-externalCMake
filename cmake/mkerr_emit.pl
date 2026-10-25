#! /usr/bin/env perl
# SPDX-License-Identifier: Unlicense
#
# Emit one OpenSSL 4.1+ error header / C file (as named in
# crypto/err/openssl.ec) using util/mkerr.pl -internal -emit.
#
# mkerr.pl loads configdata.pm only for @disablables / @disablables_int, to
# decide whether a public header gets an OPENSSL_NO_<LIB> guard.  We never
# generate configdata.pm, so provide those two lists from Configure itself.

use strict;
use warnings;
use Cwd qw(abs_path);
use File::Basename qw(dirname);
use File::Path qw(make_path);

die "usage: $0 <openssl_src_dir> <file-from-openssl.ec> <output>\n" unless @ARGV == 3;

my ($src, $emit, $out) = @ARGV;
$src = abs_path($src);
make_path(dirname($out));
$out = abs_path(dirname($out)) . "/" . (split m|/|, $out)[-1];

open my $cfh, "<", "$src/Configure" or die "Can't read $src/Configure: $!\n";
my $configure = do { local $/; <$cfh> };
close $cfh;
my ($block) = $configure =~ /(^my \@tls = .*?^my \@disablables_int = qw\(.*?\);)/ms
    or die "Can't find the disablables lists in $src/Configure\n";
my @lists = eval "$block; (\\\@disablables, \\\@disablables_int)";
die "Can't evaluate the disablables lists from Configure: $@\n" if $@;

{
    no warnings 'once';
    @configdata::disablables = @{$lists[0]};
    @configdata::disablables_int = @{$lists[1]};
}
$INC{'configdata.pm'} = __FILE__;

my $tmp = "$out.tmp$$";
open STDOUT, ">", $tmp or die "Can't write $tmp: $!\n";

# mkerr.pl ends with exit(), so finish writing the output from an END block.
END {
    if (defined $tmp && -e $tmp) {
        close STDOUT;
        if ($? == 0) {
            rename $tmp, $out or die "Can't rename $tmp to $out: $!\n";
        } else {
            unlink $tmp;
        }
    }
}

chdir $src or die "Can't chdir to $src: $!\n";
@ARGV = ('-internal', '-conf', 'crypto/err/openssl.ec', '-emit', $emit);
unless (my $ret = do "$src/util/mkerr.pl") {
    die "Can't run $src/util/mkerr.pl: $@\n" if $@;
}
exit 0;
