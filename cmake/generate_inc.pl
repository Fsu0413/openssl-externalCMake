#! /usr/bin/env perl
# SPDX-License-Identifier: Unlicense
#
# Generate OpenSSL *.inc files from *.inc.in using OpenSSL::paramnames /
# OpenSSL::Template (same path as util/dofile.pl, without needing configdata).

use strict;
use warnings;
use File::Basename;
use File::Path qw(make_path);
use File::Spec::Functions qw(catfile rel2abs);

die "usage: $0 <openssl_src_dir> <input.inc.in> <output.inc>\n" unless @ARGV == 3;

my ($src, $in, $out) = @ARGV;
$src = rel2abs($src);
$in  = rel2abs($in);
$out = rel2abs($out);

my $util_perl = catfile($src, 'util', 'perl');
my $text_template = catfile($src, 'external', 'perl', 'Text-Template-1.56', 'lib');

unshift @INC, $util_perl, $text_template;

require OpenSSL::fallback;
OpenSSL::fallback->import(catfile($src, 'external', 'perl', 'MODULES.txt'));
require OpenSSL::Template;
OpenSSL::Template->import();

my $template = OpenSSL::Template->new(TYPE => 'FILE', SOURCE => $in)
    or die "Cannot open template $in: $OpenSSL::Template::ERROR\n";

my $result = $template->fill_in(
    HASH => {
        # Minimal stubs if a template ever references them
        config => {},
        target => {},
        disabled => {},
    },
    OUTPUT => undef,
);

die "Template fill failed for $in: $OpenSSL::Template::ERROR\n"
    unless defined $result;

my $outdir = dirname($out);
make_path($outdir) unless -d $outdir;

open my $fh, '>', $out or die "Cannot write $out: $!\n";
print $fh $result;
close $fh;
