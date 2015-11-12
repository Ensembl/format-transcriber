=pod

=head1 LICENSE

Copyright [1999-2015] Wellcome Trust Sanger Institute and the EMBL-European Bioinformatics Institute

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


=head1 NAME

Bio::FormatTranscriber::Parser::GFF3 - A line-based parser devoted to GFF3

=cut

package Bio::FormatTranscriber::Parser::GFF3;

use strict;
use warnings;

use base qw/Bio::EnsEMBL::IO::Parser::GFF3/;

=head1 SYNOPSIS

  use Bio::FormatTranscriber::Parser::GFF3;

  my $parser = Bio::FormatTranscriber::Parser::GFF3->open('myfile.gff3');

  while(my $rec = $parser->next()) {
    # Do things
  }

=head1 DESCRIPTION

Parse a GFF3 file, inherited since the default Bio::EnsEMBL::IO::Parser::GFF3
doesn't maintain metadata and comment order when parsing.

=head1 DEPENDENCIES
L<Bio::EnsEMBL::IO> is needed as the basis for this parser

=head1 METHODS

=cut

sub open {
    my ($caller, $filename, @other_args) = @_;
    my $class = ref($caller) || $caller;

    my $self = $class->SUPER::open($filename, @other_args);

    return $self;
}

=head2 set_metadata_callback

    Description: Sets the callback to use when encountering metadata tags
    Returntype:  Scalar

=cut

sub set_metadata_callback {
    my $self = shift;
    my $method = shift;

    if( ref($method) ne 'CODE' ) {
	return 0;
    }

    $self->{read_metadata_callback} = $method;

    return 1;
}

=head2 clear_metadata_callback

    Description: Removes the read_metadata user callback if it was set
    Returntype:  Void

=cut

sub clear_metadata_callback {
    my $self = shift;

    if(defined($self->{read_metadata_callback})) {
	delete $self->{read_metadata_callback};
    }
}

=head2 read_metadata

  Description: Overloaded read_metadata that passes to the user provided callback
               if it's been set, otherwise calls the default from the parent class
  Returntype:  Void

=cut

sub read_metadata {
    my $self = shift;
    my $line = $self->{'current_block'};

    if( $self->{read_metadata_callback} && ref($self->{read_metadata_callback}) eq 'CODE') {
	$self->{read_metadata_callback}->($line);
    } else {
	$self->SUPER::read_metadata();
    }
}

1;
