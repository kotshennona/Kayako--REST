package Kayako::Class::KnowledgebaseArticle;
use strict;
use warnings;
use Class::Accessor "antlers";
use Kayako::Class::KnowledgebaseAttachment;

kbarticleid => ( is => 'ro' );
contents => ( is => 'ro' );
contentstext => ( is => 'ro' );
categories => ( is => 'ro' );
creator => ( is => 'ro' );
creatorid => ( is => 'ro' );
author => ( is => 'ro' );
email => ( is => 'ro' );
subject => ( is => 'ro' );
isedited => ( is => 'ro' );
editeddateline => ( is => 'ro' );
editedstaffid => ( is => 'ro' );
views => ( is => 'ro' );
isfeatured => ( is => 'ro' );
allowcomments => ( is => 'ro' );
totalcomments => ( is => 'ro' );
hasattachments => ( is => 'ro' );
#attachments => ( is => 'ro' );
attachment => ( is => 'ro' );
dateline => ( is => 'ro' );
articlestatus => ( is => 'ro' );
articlerating => ( is => 'ro' );
ratinghits => ( is => 'ro' );
ratingcount => ( is => 'ro' );

sub attachments {
	my $self = shift;
	my @attachments =();
	
	if (!$self->{'attachments'}){
		return undef;
			}
	elsif (ref $self->{'attachments'} eq 'HASH' ){
		push (@attachments,$self->{'id'});
		}
	elsif (ref $self->{'attachments'} eq 'ARRAY' ){
		foreach my $ele (@{$self->{'attachments'}}){
			push (@attachments,$ele->{'id'});
			}
		}	
		
	if (wantarray) {
		return @attachments;
			}
	else {
		return join (',', @attachments);
		
		}
}

sub id {
	my $self = shift;
	return $self->{'customfieldid'};
}
1;