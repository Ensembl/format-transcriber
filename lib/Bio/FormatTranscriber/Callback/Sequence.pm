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

=cut


=head1 CONTACT

  Please email comments or questions to the public Ensembl
  developers list at <http://lists.ensembl.org/mailman/listinfo/dev>.
  Questions may also be sent to the Ensembl help desk at
  <http://www.ensembl.org/Help/Contact>.

=cut

=head1 NAME

Bio::FormatTranscriber::Callback

=head1 SYNOPSIS

  use Bio::FormatTranscriber::Callback::Sequence;

  $callback_obj = Bio::FormatTranscriber::Callback::Sequence->new($init_params);

  $callback_obj->run($params);

=head1 DESCRIPTION

A generic callback object meant for testing purposes, for sequence type formats. It
simply dumps any parameters given to it in the initialization and run call. 

=cut

package Bio::FormatTranscriber::Callback::Sequence;

use base qw/Bio::FormatTranscriber::Callback/;

use strict;
use warnings;
use Carp;

use Data::Dumper;

use Bio::EnsEMBL::Utils::Argument qw(rearrange);
use Bio::EnsEMBL::Utils::Exception qw(throw);

sub new {
    my $class = shift;

    print "Recieved seq init parameters:\n";
    print Dumper @_;

    return $class->SUPER::new(@_);
}

sub run {
    my $self = shift;
    my $params = shift;

    print "Params received:";
    print Dumper $params;

    my $value = 'unknown_seq';
    if(ref $params eq 'HASH') {
	$value = $params->{sequence}
	if($params->{sequence});
    } elsif(ref $params eq 'ARRAY') {
	$value = shift @$params
	    if(@$params);
    } else {
	$value = $params
	    if($params);
    }

    return substr $value, 0, 20;
}

1;
