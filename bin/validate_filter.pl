#!/usr/bin/env perl

# Copyright [1999-2015] Wellcome Trust Sanger Institute and the EMBL-European Bioinformatics Institute
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#      http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


=head1 NAME

format_transcriber - 

=head1 SYNOPSIS

validate_filter.pl -options

=head1 DESCRIPTION


=cut

use strict;
use warnings;
use Getopt::Long qw(:config no_ignore_case);

use Bio::FormatTranscriber;

my $config_file;
my $format;
my @filters;

get_options();

# Allow both multiple options and comma seaprated lists
@filters = split(/,/,join(',',@filters));

my $ft = Bio::FormatTranscriber->new(-config => $config_file, -format => $format, -filters => \@filters);

my $processor = $ft->get_processor();

$processor->validate_filters();

sub get_options {
    my $help;

    GetOptions(
	"config=s"               => \$config_file,
	"format=s"               => \$format,
	"filters=s"              => \@filters,
	"help"                   => \$help,
	);
    
    if ($help) {
	exec('perldoc', $0);
    }

}