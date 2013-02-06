package Kayako::Class::KnowledgebaseAttachment;
use strict;
use warnings;
use Class::Accessor "antlers";
use MIME::Base64::Perl;

 has id => ( is => 'ro');
 has kbarticleid => ( is => 'ro');
 has filename => ( is => 'ro');
 has filesize => ( is => 'ro');
 has filetype => ( is => 'ro');
 has dateline => ( is => 'ro');
 has contents => ( is => 'ro');
 
 sub contents {
 	my $self = shift;
 	
 	return decode_base64($self->{'contents'});
 }
 
sub contents_base64 {
 	my $self = shift;
 	
 	return $self->{'contents'};
 }
1;